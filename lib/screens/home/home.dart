import 'dart:async';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moneytos/screens/dash_recipentScreen/select_recipient_screen/select_new_recipient_screen.dart';
import 'package:moneytos/screens/home_history/transfer_bottomsheet.dart';
import 'package:moneytos/screens/notificationScreen/home_notificationScreen.dart';
import 'package:moneytos/screens/transfers_scheduled_screens/transfers_scheduled_screen.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/GetTokenResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/LatestTransferResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/commonsettinglistResponse.dart';
import 'package:moneytos/services/s_Api/S_Request/CreateCustomerRequest.dart';
import 'package:moneytos/services/s_Api/s_ModelClass/ScheduleTransferResponse.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:upgrader/upgrader.dart';

import '../../model/home_exchangerate_response.dart';
import '../../model/usermodel.dart';
import '../../model/userprefences.dart';
import '../dash_settingscreen/setting_vaerification_screen.dart';
import '../dashboardScreen/dashboard.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  late Timer _timer;
  int _currentPage = 0;
  int _numberOfPages = 5;
  bool _isVisible = true;

  bool _enabled = true;

  GetTokenResponse getTokenResponse = GetTokenResponse();

  List<UserDataModel> userlist = [];

  String first_name = '';
  String doucument_status = '';
  bool state_verified = false;
  LatestTransferResponse latestTransferResponse = LatestTransferResponse();
  List<TxnSubData> latesttransferList = [];
  List<ExchangeRateData> exchangeRateList = [];

  bool is_check = false;
  String schedule_count = '0';
  String free_transfer_count = '0';
  bool is_load = false;
  String site_schedule_status = '';

  prefData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    doucument_status = sharedPreferences.getString('document_status')!;
    state_verified = sharedPreferences.getBool('state_verified')!;
    site_schedule_status = sharedPreferences.getString('site_schedule_status')!;
    debugPrint('doucument_status>>> $state_verified');

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) =>getTokenApi(context));
    chkStateStatusByIpApi(context);
    mainNotitification();
    clearAllTransactionValue();
    prefData();
    commonsettingApi(context);
    setState(() {});

    getPermissionStatus();
  }

  Future<void> commonsettingApi(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(Apiservices.commonsettingURL),
      headers: {
        'X-CLIENT': AllApiService.x_client,
        'content-type': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CommonsettinglistResponse commonsettinglistResponse =
          CommonsettinglistResponse.fromJson(jsonResponse);
      for (var commondata in commonsettinglistResponse.data!.commonData!) {
        if (commondata.slugName == 'niumapi_url') {
          Apiservices.nium_base_url = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'nium_client_id') {
          Apiservices.x_client_id = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'niumapi_url_v2') {
          Apiservices.nium_base_url_v2 = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'nium_client_key') {
          Apiservices.client_key = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'nium_client_secret') {
          Apiservices.client_secret = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'nium_source_account') {
          Apiservices.nium_source_account = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'nium_identification_number') {
          Apiservices.nium_identification_number =
              commondata.slugValue.toString();
        }
        if (commondata.slugName == 'nium_request_id') {
          Apiservices.nium_request_id = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'nium_contact_number') {
          Apiservices.nium_contact_number = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'nium_identification_type') {
          Apiservices.nium_identification_type =
              commondata.slugValue.toString();
        }
        if (commondata.slugName == 'magicpay_url') {
          AllApiService.magicpayBaseUrlBaseUrl =
              commondata.slugValue.toString();
        }
        if (commondata.slugName == 'magicpay_basic_auth') {
          AllApiService.client_id = commondata.slugValue.toString();
        }
        if (commondata.slugName == 'persona_template_id') {}
        if (commondata.slugName == 'persona_inquiry_template_id') {}
        if (commondata.slugName == 'persona_url') {}
        if (commondata.slugName == 'persona_auth') {}
        if (commondata.slugName == 'persona_enviroment') {}
        if (commondata.slugName == 'site_schedule_status') {
          debugPrint('slug value>>>  ${commondata.slugValue}');
          sharedPreferences.setString(
            'site_schedule_status',
            commondata.slugValue.toString(),
          );
          site_schedule_status = commondata.slugValue.toString();
        }
      }

      // CustomLoader.ProgressloadingDialog6(context, true);

      getTokenApi(context);
      latesttransferApi(context);
      homeExchangeRateApi(context);
      getprofiledata();
      scheduleTransferListapi(context);
    }
    setState(() {});
  }

  getPermissionStatus() async {
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.microphone.request();
  }

  int notificationCount = 0;

  void mainNotitification() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the incoming FCM message here
      // Update the notification count or trigger a UI update
      setState(() {
        notificationCount = notificationCount + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.whiteColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          /*  actions: [
            Container(
              padding: EdgeInsets.only(top: 5,right: 20),
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                "assets/icons/notification.svg",
                height: 30,
                width: 30,
              ),
            ),
          ],*/
        ),
      ),
      body: UpgradeAlert(
        child: is_load == true
            ? const GFLoader(
                type: GFLoaderType.custom,
                child: Image(
                  image: AssetImage('assets/logo/progress_image.png'),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///add notification Icon
                      is_check == true
                          ? InkWell(
                              onTap: () {
                                pushNewScreen(
                                  context,
                                  screen: const Setting_Verification(),
                                  withNavBar: false,
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/notificationblue.svg',
                                            height: 30,
                                            width: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 220,
                                            child: Text(
                                              'Please verify your account first Please upload your verification document',
                                              style: TextStyle(
                                                color: MyColors.blackColor
                                                    .withOpacity(0.80),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.4,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_medium.ttf',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          is_check = false;
                                          setState(() {});
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/clear_red.svg',
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  notificationCount = 0;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const HomeNotificationScreen(),
                                    ),
                                  );
                                  AllApiService.isNotification = '';
                                  setState(() {});
                                },
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 22,
                                          width: 22,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: MyColors.color_ACCEFE,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                          ),
                                          child: Text(
                                            notificationCount.toString(),
                                            style: const TextStyle(
                                              color: MyColors.color_609DF4,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily:
                                                  'assets/fonts/raleway/raleway_semibold.ttf',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: notificationCount > 0
                                                ? Colors.red
                                                : Colors.transparent,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                      // SizedBox(height: 4,),

                      Text(
                        'Hi $first_name',
                        style: const TextStyle(
                          color: MyColors.color_06366F,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      SizedBox(
                        height: 50,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: exchangeRateList.length,
                          scrollDirection: Axis.vertical,
                          onPageChanged: (value) {
                            //When page change, start the controller
                            // _animationController.forward();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return RichText(
                              text: TextSpan(
                                children: <InlineSpan>[
                                  WidgetSpan(
                                    child: SvgPicture.asset(
                                      'assets/images/coin.svg', // Replace with the path to your SVG image asset
                                    ),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(
                                      width:
                                          10.0, // Adjust the width to add space between WidgetSpan and TextSpan
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '1 USD = ${exchangeRateList[index].totalRate.toString()} ${exchangeRateList[index].currency.toString()}',
                                    style: const TextStyle(
                                      color: MyColors.color_06366F,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_bold.ttf',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     children: <InlineSpan>[
                      //       WidgetSpan(
                      //         child: SvgPicture.asset(
                      //           'assets/images/coin.svg', // Replace with the path to your SVG image asset
                      //         ),
                      //       ),
                      //       const WidgetSpan(
                      //         child: SizedBox(
                      //           width:
                      //               10.0, // Adjust the width to add space between WidgetSpan and TextSpan
                      //         ),
                      //       ),
                      //       const TextSpan(
                      //         text: '1 USD = 83.26 INR',
                      //         style: TextStyle(
                      //             color: MyColors.color_06366F,
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.w700,
                      //             fontFamily:
                      //                 "assets/fonts/raleway/raleway_bold.ttf"),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      const SizedBox(
                        height: 42,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              'Recents',
                              style: TextStyle(
                                color: MyColors.color_06366F,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_extrabold.ttf',
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                // pushNewScreen(
                                //   context,
                                //   screen: const HomeHistoryScreen(),
                                //   withNavBar: true,
                                // );
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const DashboardScreen(
                                        currentpage_index: 1,
                                      );
                                    },
                                  ),
                                  (_) => false,
                                );
                              },
                              child: const Text(
                                'See all',
                                style: TextStyle(
                                  color: MyColors.color_609DF4,
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_bold.ttf',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      _enabled == true
                          ? Utility.shrimmerVerticalRecentListLoader(
                              100,
                              MediaQuery.of(context).size.width,
                            )
                          : latestTransferResponse.status == true
                              ? latestTransferResponse
                                      .data!.txnData!.data!.isEmpty
                                  ? Container(
                                      height: 150,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(top: 30),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width / 3,
                                      ),
                                      // height: MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      // alignment: Alignment.center,
                                      child: const Text(
                                        'No Data',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: latesttransferList.length > 2
                                          ? 2
                                          : latesttransferList.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            transferbottomsheet(
                                              latesttransferList[index]
                                                  .readyremitTransferId
                                                  .toString(),
                                              latesttransferList[index],
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: MyColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: MyColors.blackColor
                                                      .withOpacity(.05),
                                                  spreadRadius: 0,
                                                  blurRadius: 30,
                                                )
                                              ],
                                            ),
                                            /*
                                            shadowColor: MyColors.blackColor
                                                .withOpacity(.3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              // Adjust the radius as needed
                                              side: BorderSide(
                                                color: MyColors.blackColor
                                                    .withOpacity(.05),
                                                // Set the border color
                                                width:
                                                    1.0, // Set the border width
                                              ),


                                            ),

                                             */
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 20,
                                                horizontal: 15,
                                              ),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 19.5,
                                                    backgroundColor:
                                                        MyColors.lightblueColor,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        25.0,
                                                      ),
                                                      child: FadeInImage(
                                                        height: 156,
                                                        width: 149,
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                          latesttransferList[
                                                                  index]
                                                              .profileImage
                                                              .toString(),
                                                        ),
                                                        placeholder:
                                                            const AssetImage(
                                                          'assets/logo/progress_image.png',
                                                        ),
                                                        placeholderFit:
                                                            BoxFit.scaleDown,
                                                        imageErrorBuilder: (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Text(
                                                            latesttransferList[
                                                                    index]
                                                                .recipientName
                                                                .toString()[0]
                                                                .toUpperCase(),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          latesttransferList[
                                                                  index]
                                                              .recipientName
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: MyColors
                                                                .color_06366F,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'assets/fonts/raleway/raleway_bold.ttf',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          latesttransferList[
                                                                  index]
                                                              .newCreatedAt
                                                              .toString()
                                                              .toLowerCase(),
                                                          style:
                                                              const TextStyle(
                                                            color: MyColors
                                                                .color_676F85,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'assets/fonts/raleway/raleway_regular.ttf',
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '\$${latesttransferList[index].sendAmount}',
                                                        style: const TextStyle(
                                                          color: MyColors
                                                              .color_1D2D5F,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'assets/fonts/circularstd/circular_std_medium.ttf',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        latesttransferList[
                                                                index]
                                                            .readyremitStatus
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: latesttransferList[
                                                                          index]
                                                                      .readyremitStatus ==
                                                                  'pending'
                                                              ? MyColors
                                                                  .dark_yellow
                                                              : MyColors
                                                                  .greenColor2
                                                                  .withOpacity(
                                                                  0.60,
                                                                ),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              'assets/fonts/raleway/raleway_bold.ttf',
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                              : Container(
                                  height: 150,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 30),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width / 3,
                                  ),
                                  // height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  // alignment: Alignment.center,
                                  child: const Text(
                                    'No Data',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),

                      const SizedBox(
                        height: 24,
                      ),

                      InkWell(
                        onTap: () {
                          if (site_schedule_status.isEmpty) {
                          } else {
                            site_schedule_status == '1'
                                ? doucument_status == 'Approved'
                                    ? pushNewScreen(
                                        context,
                                        screen: const TransferSheduledScreen(),
                                        withNavBar: true,
                                      )
                                    : verifyDialog(
                                        context,
                                        '',
                                        doucument_status,
                                      )
                                : comingsoonDialog(
                                    context,
                                  );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: MyColors.color_C5DFFF,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: MyColors.blackColor.withOpacity(.1),
                                spreadRadius: 0,
                                blurRadius: 25,
                              )
                            ],
                          ),
                          /*
                          margin: const EdgeInsets.all(0),
                          elevation: 25,
                          shadowColor: MyColors.blackColor.withOpacity(.1),
                          color: MyColors.color_C5DFFF,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the radius as needed
                          ),

                           */
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 30,
                              bottom: 30,
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Schedule',
                                  style: TextStyle(
                                    color: MyColors.color_06366F,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_medium.ttf',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.whiteColor,
                                    ),
                                    color: MyColors.whiteColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColors.color_609EF5,
                                      ),
                                      color: MyColors.color_609EF5,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      schedule_count,
                                      style: const TextStyle(
                                        color: MyColors.whiteColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_medium.ttf',
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.color_E4EFFC,
                                    ),
                                    color: MyColors.color_E4EFFC,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/calendar_2.svg',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      InkWell(
                        onTap: () {
                          !state_verified
                              ? Utility().stateDialog(context)
                              : doucument_status == 'Approved'
                                  ? pushNewScreen(
                                      context,
                                      screen: const SelectNewRecipientScreen(),
                                      withNavBar: false,
                                    )
                                  : verifyDialog(context, '', doucument_status);
                        },
                        child: SizedBox(
                          height: 138,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: SvgPicture.asset(
                                    'assets/images/send_money_bg.svg',
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                right: 20,
                                top: 0,
                                bottom: 0,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Free Transfer',
                                              style: TextStyle(
                                                color: MyColors.whiteColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_regular.ttf',
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: MyColors.whiteColor,
                                                ),
                                                color: MyColors.whiteColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 20,
                                                width: 20,
                                                margin: const EdgeInsets.all(
                                                  1,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        MyColors.color_609EF5,
                                                  ),
                                                  color: MyColors.color_609EF5,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  free_transfer_count,
                                                  style: const TextStyle(
                                                    color: MyColors.whiteColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        'assets/fonts/raleway/raleway_medium.ttf',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Send money',
                                          style: TextStyle(
                                            color: MyColors.whiteColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      'assets/images/arrow_up_right.svg',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // SizedBox(height: 100,)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> createcustomersRequest(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    CreateCustomerRequest createCustomerRequest = CreateCustomerRequest();

    if (userlist.isNotEmpty) {
      createCustomerRequest.identifier = userlist[0].id.toString();
      createCustomerRequest.customerNumber = userlist[0].id.toString();
      createCustomerRequest.firstName = userlist[0].name.toString();
      createCustomerRequest.lastName = userlist[0].name.toString();
      createCustomerRequest.email = userlist[0].email.toString();
      createCustomerRequest.website = '';
      createCustomerRequest.phone = userlist[0].mobileNumber.toString();
      createCustomerRequest.alternatePhone =
          userlist[0].mobileNumber.toString();
      CreateCustomerBillingInfo billingInfo = CreateCustomerBillingInfo();
      billingInfo.firstName = userlist[0].name.toString();
      billingInfo.lastName = userlist[0].name.toString();
      billingInfo.street = userlist[0].address.toString();
      billingInfo.street2 = userlist[0].address.toString();
      billingInfo.state = userlist[0].state.toString();
      billingInfo.city = userlist[0].city.toString();
      billingInfo.zip = '';
      billingInfo.country = userlist[0].country.toString();
      billingInfo.phone = userlist[0].mobileNumber.toString();
      createCustomerRequest.billingInfo = billingInfo;
      createCustomerRequest.active = true;
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.createcustomersURL),
      body: jsonEncode(createCustomerRequest),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        // "Authorization": AllApiService.client_id,
      },
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> if$jsonResponse');
      debugPrint("magig pay id>>> if${jsonResponse["id"]}");
      sharedPreferences.setString('customer_id', jsonResponse['id'].toString());
      addMagicpayCustomerIdapi(context, jsonResponse['id'].toString());
    } else {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> else$jsonResponse');

      // Fluttertoast.showToast(msg: jsonResponse["error_details"].toString());
    }
    setState(() {});

    return;
  }

  Future<void> addMagicpayCustomerIdapi(
    BuildContext context,
    String magicpay_customer_id,
  ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['magicpay_customer_id'] = magicpay_customer_id;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.addMagicpayCustomerIdapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint('createMagicpayTxnapi>>>> $jsonResponse');
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      setState(() {});
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      setState(() {});
    }
    return;
  }

  getprofiledata() async {
    userlist.clear();

    await profileRequest(context, userlist);
    debugPrint(userlist.length as String?);

    // CustomLoader.ProgressloadingDialog6(context, false);

    first_name = (userlist.isNotEmpty
        ? "${userlist[0].name == null || userlist[0].name.toString().isEmpty ? "" : userlist[0].name}"
        : '');
    is_check = userlist.isNotEmpty
        ? userlist[0].documentStatus.toString() == 'Blank'
            ? true
            : false
        : false;
    free_transfer_count =
        userlist.isNotEmpty ? userlist[0].free_transation.toString() : '0';
    doucument_status =
        userlist.isNotEmpty ? userlist[0].documentStatus.toString() : '';
    first_name = first_name.split(' ')[0];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      'referral_id',
      userlist.isNotEmpty ? userlist[0].unique_id.toString() : '0',
    );
    sharedPreferences.setString('document_status', doucument_status);
    userlist.isNotEmpty
        ? userlist[0].magicpay_customer_id == ''
            ? createcustomersRequest(context)
            : null
        : null;

    setState(() {});
  }

  verifyDialog(BuildContext context, String msg, String status) {
    String document_status = status;
    String actual_status = status;
    document_status = document_status == 'pending'
        ? 'Incomplete'
        : document_status == 'completed'
            ? 'pending'
            : document_status;

    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset('assets/images/closesquare.svg'),
                ),
              ),
              document_status == 'Blank'
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Verification status : $document_status',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily:
                              'assets/fonts/raleway/raleway_regular.ttf',
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              actual_status == 'expired' ||
                      actual_status == 'Rejected' ||
                      actual_status == 'declined'
                  ? Column(
                      children: [
                        const Text(
                          'Please re upload verification.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              MyColors.darkbtncolor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'If you want to update verification Click Here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              actual_status == 'Blank'
                  ? Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              MyColors.darkbtncolor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'Verify Your Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              document_status == 'Incomplete'
                  ? Column(
                      children: [
                        const Text(
                          'Your Verification is incomplete , Please re upload verification.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              MyColors.darkbtncolor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'If you want to update verification Click Here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              document_status == 'pending'
                  ? const Column(
                      children: [
                        Text(
                          'We will notify you as soon as you’re approved.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  comingsoonDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset('assets/icons/clear_red.svg'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Coming Soon',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'assets/fonts/raleway/raleway_regular.ttf',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> getTokenApi(
    BuildContext context,
  ) async {
    // CustomLoader.ProgressloadingDialog6(context, true);
    // is_load = true;
    var request = {};

    // request['client_id'] = "8i86nj3qmbW3rFWzZyVdpRudJ0XmxAaT";
    // request['client_secret'] = "gSMZhAdUG8azsEXSWgvwJzWqgG8uFeIW0aFxaVnOmb1TOY9KHvRvmwakazbY_EIY";
    // request['audience'] = "https://sandbox-api.readyremit.com";
    // request['grant_type'] = "client_credentials";

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.authenticationapi),
      body: jsonEncode(request),
      headers: {
        'Content-Type': 'application/json',
        'client_key': Apiservices.client_key,
        'client_secret': Apiservices.client_secret,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    // getTokenResponse  = await GetTokenResponse.fromJson(jsonResponse);
    debugPrint("token_auhtToken>>>>>>>>${jsonResponse['token']}");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('auth_Token', jsonResponse['token'].toString());
    // is_load = false;
    // CustomLoader.ProgressloadingDialog6(context, false);
    setState(() {});

    return;
  }

  Future<void> latesttransferApi(
    BuildContext context,
  ) async {
    _enabled = true;
    // Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
    var request = {};

    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.latesttransferapi),
      // body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      latestTransferResponse = LatestTransferResponse.fromJson(jsonResponse);
      latesttransferList = latestTransferResponse.data!.txnData!.data!;

      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);

      latestTransferResponse = LatestTransferResponse.fromJson(jsonResponse);
      setState(() {});
    }
    _enabled = false;
    return;
  }

  Future<void> homeExchangeRateApi(
    BuildContext context,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
    var request = {};

    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(AllApiService.homeExchangeRateURL),
      // body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      HomeExchangerateResponse homeExchangerateResponse =
          HomeExchangerateResponse.fromJson(jsonResponse);
      exchangeRateList = homeExchangerateResponse.data!;
      _numberOfPages = exchangeRateList.length;
      _pageController.addListener(_pageListener);
      _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (_currentPage < _numberOfPages - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);

      setState(() {});
    }
    return;
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    if (_pageController.page == exchangeRateList.length - 1) {
      // When the user scrolls to the last page, jump to the second page to create the illusion of an infinite loop.
      _pageController.jumpToPage(1);
    } else if (_pageController.page == 0) {
      // When the user scrolls to the first page, jump to the second-to-last page.
      _pageController.jumpToPage(exchangeRateList.length - 2);
    }
  }

  Future<void> scheduleTransferListapi(BuildContext context) async {
    SharedPreferences p = await SharedPreferences.getInstance();

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(Apiservices.scheduleTransferListapi),
      // body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      ScheduleTransferResponse scheduleTransferResponse =
          ScheduleTransferResponse.fromJson(jsonResponse);
      schedule_count =
          scheduleTransferResponse.data!.scheduleTransfer!.total.toString();
      setState(() {});
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
      setState(() {});
    }

    return;
  }

  Future<void> profileRequest(
    BuildContext context,
    List<UserDataModel> userlist,
  ) async {
//    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    debugPrint("auth ${p.getString("auth")}");

    var request = {};

    debugPrint('request $request');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.profile),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      // p.setBool("login", true);

      var userdata = jsonResponse['data'];
      var userresponse = userdata['userData'];

      UserDataModel authuser = UserDataModel.fromJson(userresponse);
      debugPrint('user... ${authuser.id}');

      p.setString('auth...>>>>>>>>', authuser.authToken.toString());
      p.setString('customer_id', authuser.magicpay_customer_id.toString());
      debugPrint('user...>>>>>>>>> ${authuser.authToken.toString()}');
      debugPrint(
        'customer_id...>>>>>>>>> ${authuser.magicpay_customer_id.toString()}',
      );

      p.setString('userid', authuser.id.toString());

      UserPreferences().saveUser(authuser);

      userlist.add(authuser);
      debugPrint('user...${userlist[0].name}');

      // Fluttertoast.showToast(msg: jsonResponse['message']);
      // CustomLoader.ProgressloadingDialog(context, true);
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      //CustomLoader.ProgressloadingDialog(context, true);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  transferbottomsheet(String readyremit_transferId, TxnSubData txnSubData) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // anchorPoint: Offset(20.0, 30.0),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.76,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: TransferBottomsheet(
              isMfs: false,
              readyremit_transferId: readyremit_transferId,
              selected_acc_id: txnSubData.senderSendMethodId.toString(),
              selected_payment_type: txnSubData.senderSendMethod.toString(),
              selected_acc_name: txnSubData.recipientName.toString(),
              selected_last4: txnSubData.senderSendMethodLast4digit.toString(),
              txnSubData: txnSubData,
            ),
          ),
        );
      },
    );
  }

  Future<void> chkStateStatusByIpApi(
    BuildContext context,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        '${AllApiService.chkStateStatusByIpURL}?ip=${await Ipify.ipv4()}',
      ),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      sharedPreferences.setBool('state_verified', true);
      state_verified = true;
      setState(() {});
    } else {
      sharedPreferences.setBool('state_verified', false);
      setState(() {});
    }

    return;
  }

  clearAllTransactionValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('dstCurrencyIso3Code', '');
    sharedPreferences.setString('dstCountryIso3Code', '').toString();
    sharedPreferences.setString('sourceCurrencyIso3Code', '').toString();
    sharedPreferences.setString('sendAmount', '').toString();
    sharedPreferences.setString('recipientId', '').toString();
    sharedPreferences.setString('senderId', '').toString();
    sharedPreferences.setString('BankdetailResponse', '').toString();
    sharedPreferences.setString('exchangerate', '').toString();
    sharedPreferences.setString('fees', '').toString();
    sharedPreferences.setString('reasonsending_id', '').toString();
    sharedPreferences.setString('reasonsending_name', '').toString();
    sharedPreferences.setString('u_first_name', '').toString();
    sharedPreferences.setString('u_last_name', '').toString();
    sharedPreferences.setString('u_profile_img', '').toString();
    sharedPreferences.setString('receiveAmount', '').toString();
    sharedPreferences.setString('select_payment_method_status', '').toString();
    sharedPreferences
        .setString('recipientReceiveBankOrMobileNo', '')
        .toString();
    sharedPreferences
        .setString('recipientReceiveBankNameOrOperatorName', '')
        .toString();
    debugPrint('Clear All Data>>>>>>>>> ');
    setState(() {});
  }
}

//old working code

/*
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:moneytos/constance/customLoader/customLoader.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/customHomecardui.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/S_ApiResponse/GetTokenResponse.dart';
import 'package:moneytos/view/dash_recipentScreen/select_recipient_screen/select_new_recipient_screen.dart';
import 'package:moneytos/view/home_history_screens/home_historyScreen.dart';
import 'package:moneytos/view/notificationScreen/home_notificationScreen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transfers_scheduled_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'dart:convert' as convert;
import 'package:intl/intl.dart' show DateFormat;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import '../../model/usermodel.dart';
import '../../model/userprefences.dart';
import '../../s_Api/S_ApiResponse/LatestTransferResponse.dart';
import '../../s_Api/S_ApiResponse/commonsettinglistResponse.dart';
import '../../s_Api/S_Request/CreateCustomerRequest.dart';
import '../../s_Api/s_ModelClass/ScheduleTransferResponse.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';
import '../../services/webservices.dart';
import '../VerificationPage.dart';
import '../dash_settingscreen/manage_payment_method/menage_payment_methodScreen.dart';
import '../dash_settingscreen/setting_vaerification_screen.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';







class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _enabled = true;

  GetTokenResponse getTokenResponse = new GetTokenResponse();

  List<UserDataModel>  userlist= [];


  String first_name = "";
  String doucument_status = "";
  bool state_verified = false;
  LatestTransferResponse latestTransferResponse = new LatestTransferResponse();
  List<TxnSubData>  latesttransferList= [];

  bool is_check = false;
  String schedule_count = "0";
  String free_transfer_count = "0";
  bool is_load = false;
  String site_schedule_status = "";

  prefData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    doucument_status = sharedPreferences.getString("document_status")!;
    state_verified = sharedPreferences.getBool("state_verified")!;
    site_schedule_status = sharedPreferences.getString("site_schedule_status")!;
    debugPrint("doucument_status>>> "+state_verified.toString());

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) =>getTokenApi(context));

    clearAllTransactionValue();
    prefData();
    commonsettingApi(context);
    setState(() {

    });

    getPermissionStatus();

  }

  Future <void> commonsettingApi(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(
        Apiservices.commonsettingURL),
        headers: {
          "X-CLIENT": AllApiService.x_client,
          "content-type": "application/json",
        });

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if(jsonResponse['status'] == true){
      CommonsettinglistResponse commonsettinglistResponse = CommonsettinglistResponse.fromJson(jsonResponse);
      for(var commondata in commonsettinglistResponse.data!.commonData!){
        if(commondata.slugName == "niumapi_url"){

          Apiservices.nium_base_url = commondata.slugValue.toString();

        }if(commondata.slugName == "nium_client_id"){

          Apiservices.x_client_id  = commondata.slugValue.toString();

        }if(commondata.slugName == "niumapi_url_v2"){

          Apiservices.nium_base_url_v2 = commondata.slugValue.toString();

        }if(commondata.slugName == "nium_client_key"){

          Apiservices.client_key = commondata.slugValue.toString();

        }if(commondata.slugName == "nium_client_secret"){

          Apiservices.client_secret = commondata.slugValue.toString();

        }if(commondata.slugName == "nium_source_account"){

          Apiservices.nium_source_account = commondata.slugValue.toString();

        }if(commondata.slugName == "nium_identification_number"){

          Apiservices.nium_identification_number = commondata.slugValue.toString();

        }if(commondata.slugName == "nium_request_id"){

          Apiservices.nium_request_id = commondata.slugValue.toString();

        }if(commondata.slugName == "nium_contact_number"){
          Apiservices.nium_contact_number = commondata.slugValue.toString();

        }if(commondata.slugName == "nium_identification_type"){
          Apiservices.nium_identification_type = commondata.slugValue.toString();


        }if(commondata.slugName == "magicpay_url"){

          AllApiService.magicpayBaseUrlBaseUrl = commondata.slugValue.toString();

        }if(commondata.slugName == "magicpay_basic_auth"){

          AllApiService.client_id = commondata.slugValue.toString();

        }if(commondata.slugName == "persona_template_id"){

        }if(commondata.slugName == "persona_inquiry_template_id"){

        }if(commondata.slugName == "persona_url"){

        }if(commondata.slugName == "persona_auth"){

        }if(commondata.slugName == "persona_enviroment"){

        }if(commondata.slugName == "site_schedule_status"){

          debugPrint("slug value>>>  "+commondata.slugValue.toString());
          sharedPreferences.setString("site_schedule_status", commondata.slugValue.toString());
          site_schedule_status = commondata.slugValue.toString();
        }


      }

      // CustomLoader.ProgressloadingDialog6(context, true);
      chkStateStatusByIpApi(context);
      getTokenApi(context);
      latesttransferApi(context);
      getprofiledata();
      scheduleTransferListapi(context);

    }
    setState(() {

    });




  }

  getPermissionStatus() async {
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.microphone.request();

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.primaryColor,
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          /*  actions: [
            Container(
              padding: EdgeInsets.only(top: 5,right: 20),
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                "assets/icons/notification.svg",
                height: 30,
                width: 30,
              ),
            ),
          ],*/
        ),
      ),
      body:
      UpgradeAlert(
        child: is_load == true
            ?
        GFLoader(
            type: GFLoaderType.custom,
            child: Image(image: AssetImage("assets/logo/progress_image.png"),
            )):SingleChildScrollView(
          // physics: ClampingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.75,
                  decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      image: DecorationImage(
                          image: AssetImage("assets/images/map.png"),
                          fit: BoxFit.cover)),
                ),

                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hSizedBox,
                              // hSizedBox2,

                              ///add notification Icon
                              is_check==true?
                              Container(
                                child: InkWell(
                                  onTap: (){
                                    pushNewScreen(
                                      context,
                                      screen: Setting_Verification(),
                                      withNavBar: false,
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/notificationblue.svg",
                                                height: 30,
                                                width: 30,
                                              ),
                                              SizedBox(width: 10,),
                                              Container(
                                                width: 220,
                                                child: Text("Please verify your account first Please upload your verification document",
                                                  style: TextStyle(
                                                    color: MyColors.blackColor.withOpacity(0.80),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.4,
                                                    fontFamily: "assets/fonts/raleway/raleway_medium.ttf",),
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: (){
                                              is_check = false;
                                              setState(() {});
                                            },
                                            child: SvgPicture.asset(
                                              "assets/icons/clear_red.svg",
                                              height: 30,
                                              width: 30,
                                            ),
                                          ),



                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ):
                              InkWell(
                                onTap: (){
                                  // is_check = true;
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeNotificationScreen()));
                                  AllApiService.isNotification = "";
                                  setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/hm_notification.svg",
                                        height: 30,
                                        width: 30,
                                      ),

                                  AllApiService.isNotification == ""?
                                      Container():
                                      SvgPicture.asset(
                                        "assets/icons/hm_notification_badge.svg",
                                        height: 14,
                                        width: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              hSizedBox,
                              hSizedBox,
                              // hSizedBox,
                              // hSizedBox,
                              // hSizedBox,
                              // hSizedBox,

                              /// name text....
                              Container(
                                margin: EdgeInsets.only(left:20),

                                child: Text("Hi "+first_name,
                                    style: TextStyle(
                                        color: MyColors.whiteColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 36,
                                        letterSpacing: 0.1,
                                        fontStyle: FontStyle.normal,
                                        fontFamily:
                                        "assets/fonts/raleway/raleway_extrabold.ttf")),
                              ),

                              hSizedBox,
                              /// description text....
                              Container(
                                margin: EdgeInsets.only(left:20),
                                child: Text(
                                  MyString.welcome_back,
                                  style: TextStyle(
                                      color: MyColors.whiteColor.withOpacity(
                                          0.50),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      letterSpacing: 0.1,
                                      fontFamily:
                                      "assets/fonts/raleway/raleway_medium.ttf"),
                                ),
                              ),

                              hSizedBox2,
                              // hSizedBox2,

                              /// Card ui....
                              ///
                              // hSizedBox2,
                              Container(
                                //   padding: EdgeInsets.only(),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [

                                    /// left card
                                    Expanded(
                                      flex:1,
                                      child: Container(
                                        height: 195,
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: (){
                                            // !state_verified? Utility().stateDialog(context):
                                            doucument_status=="Approved"?
                                            pushNewScreen(
                                              context,
                                              screen: SelectNewRecipientScreen(),
                                              withNavBar: false,
                                            ):
                                            verifyDialog(context, "", doucument_status);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: MyColors.color_3F84E5,
                                                borderRadius: BorderRadius.circular(
                                                    14)),
                                            //width: size.width * 0.40,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22, vertical: 26),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  child: SvgPicture.asset(
                                                      "assets/icons/send.svg"),
                                                ),

                                                hSizedBox,

                                                /// number ui
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    // alignment: Alignment.topRight,
                                                    height: 28,
                                                    width: 26,
                                                    //padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: MyColors.whiteColor
                                                            .withOpacity(0.60),
                                                        borderRadius:
                                                        BorderRadius.circular(20)),
                                                    child: Center(
                                                        child: Text(
                                                          free_transfer_count,
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .lightblueColor,
                                                              fontSize: 18,
                                                              fontWeight: FontWeight
                                                                  .w700,
                                                              fontFamily:
                                                              "assets/fonts/raleway/raleway_medium.ttf"),
                                                        )),
                                                  ),
                                                ),

                                                hSizedBox1,

                                                /// free transfer....
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    MyString.free_transfer,
                                                    style: TextStyle(
                                                        color: MyColors.whiteColor.withOpacity(0.80),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14,
                                                        letterSpacing: 0.1,
                                                        fontFamily:
                                                        "assets/fonts/raleway/raleway_medium.ttf"),
                                                  ),
                                                ),

                                                /// Send Money....

                                                hSizedBox2,
                                                Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    MyString.send_money,
                                                    style: TextStyle(
                                                        color: MyColors.whiteColor.withOpacity(0.90),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18,
                                                        letterSpacing: 0.52,
                                                        fontFamily:
                                                        "assets/fonts/raleway/raleway_bold.ttf"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    wSizedBox2,

                                    /// right card
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 200,
                                        child: Column(
                                          children: [

                                            /// card 1
                                            GestureDetector(
                                              onTap: (){
                                                if(site_schedule_status.isEmpty){

                                                }else{
                                                  site_schedule_status=="1"?
                                                  doucument_status=="Approved"?
                                                  pushNewScreen(
                                                    context,
                                                    screen: TransferSheduledScreen(),
                                                    withNavBar: true,
                                                  ):
                                                  verifyDialog(context, "", doucument_status):
                                                  comingsoonDialog(context,);
                                                }

                                                // pushNewScreen(
                                                //   context,
                                                //   screen: TransferSheduledScreen(),
                                                //   withNavBar: true,
                                                // );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: MyColors.whiteColor,
                                                    borderRadius:
                                                    BorderRadius.circular(14)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.center,
                                                        end: Alignment.bottomCenter,
                                                        //  stops: [0.0, 1.0],
                                                        colors: [
                                                          MyColors.color_3F84E5
                                                              .withOpacity(0.10),
                                                          MyColors.color_3F84E5
                                                              .withOpacity(0.20),
                                                        ],
                                                      ),
                                                      //color: MyColors.lightblueColor,
                                                      borderRadius:
                                                      BorderRadius.circular(10)),
                                                  //width: size.width * 0.46,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 26, vertical: 16),
                                                  child: Column(
                                                    children: [

                                                      /// number ui
                                                      Container(
                                                        alignment: Alignment.topRight,
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: 28,
                                                          width: 28,
                                                          //padding: EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                              color: MyColors
                                                                  .lightblueColor
                                                                  .withOpacity(0.20),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  100)),
                                                          child: Center(
                                                              child: Text(
                                                                schedule_count,
                                                                style: TextStyle(
                                                                    color:
                                                                    MyColors
                                                                        .lightblueColor,
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight
                                                                        .w500,
                                                                    fontFamily:
                                                                    "assets/fonts/raleway/raleway_medium.ttf"),
                                                              )),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: SvgPicture.asset(
                                                            "assets/icons/calender.svg"),
                                                      ),

                                                      hSizedBox1,
                                                      hSizedBox,

                                                      /// Scheduled....
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          MyString.scheduled,
                                                          style: TextStyle(
                                                              color:
                                                              MyColors.lightblueColor,
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 17,
                                                              letterSpacing: 0.5,
                                                              fontFamily:
                                                              "assets/fonts/raleway/raleway_semibold.ttf"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            hSizedBox1,
                                            hSizedBox,

                                            /// card 2
                                            GestureDetector(
                                              onTap: (){
                                                pushNewScreen(
                                                  context,
                                                  screen: HomeHistoryScreen(),
                                                  withNavBar: true,
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: MyColors.whiteColor,
                                                    borderRadius:
                                                    BorderRadius.circular(13)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.center,
                                                        end: Alignment.bottomCenter,
                                                        //  stops: [0.0, 1.0],
                                                        colors: [
                                                          MyColors.lightblueColor.withOpacity(0.18),
                                                          MyColors.lightblueColor.withOpacity(0.20),
                                                        ],
                                                      ),
                                                      //color: MyColors.lightblueColor,
                                                      borderRadius:
                                                      BorderRadius.circular(14)),
                                                  //   width: size.width * 0.46,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16, vertical: 16),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      /// history....
                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        margin: EdgeInsets.only(left: 10),
                                                        child: Text(
                                                          MyString.history,
                                                          style: TextStyle(
                                                              color:
                                                              MyColors.lightblueColor,
                                                              fontWeight: FontWeight
                                                                  .w600,
                                                              fontSize: 16,
                                                              letterSpacing: 0.1,
                                                              fontFamily:
                                                              "assets/fonts/raleway/raleway_semibold.ttf"),
                                                        ),
                                                      ),

                                                      Container(
                                                        alignment: Alignment.topLeft,
                                                        child: SvgPicture.asset(
                                                            "assets/icons/timer.svg"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),/////
                        // hSizedBox4,
                        is_check==false?hSizedBox4:hSizedBox2,



                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: MyColors.whiteColor,

                              borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft:Radius.circular(25) )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              hSizedBox1,
                              // hSizedBox1,

                              ///Latest Transfers
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.latest_transfers,
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                      fontFamily:
                                      "assets/fonts/raleway/raleway_semibold.ttf"),
                                ),
                              ),

                              Container(

                                padding: EdgeInsets.symmetric(horizontal: 18),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        MyColors.lightblueColor2.withOpacity(
                                            0.02),
                                        MyColors.lightblueColor2.withOpacity(0.06)
                                      ]
                                  ),),
                                child:
                                _enabled == true?Utility.shrimmerHorizontalListLoader(250,180):
                                latestTransferResponse.status == true?
                                latestTransferResponse.data!.txnData!.data!.isEmpty?
                                Container(
                                  height: 300,
                                  margin: EdgeInsets.only(top: 30),
                                  padding: EdgeInsets.symmetric(horizontal: size.width/3,),
                                  // height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  // alignment: Alignment.center,
                                  child: Text("No Data",style: TextStyle(fontSize: 18),),):
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: latesttransferList.map((
                                        TxnSubData latesttransferdata) {
                                      return Container(
                                        alignment: Alignment.topLeft,
                                        //  width: 152,
                                        // width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        child: CustomHomeCardList(
                                          bg_color:
                                          latesttransferdata.readyremitStatus == "pending"
                                              ? MyColors.lightorange.withOpacity(
                                              0.12)
                                              : MyColors.greenColor2.withOpacity(
                                              0.12),
                                          txnSubData: latesttransferdata,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ):
                                Container(
                                  height: 250,
                                  margin: EdgeInsets.only(top: 50),
                                  // height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: size.width/3,),
                                  child: Text("No Data",style: TextStyle(fontSize: 18),),),
                              ),
                              Container(
                                height:30 , decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      MyColors.lightblueColor2.withOpacity(
                                          0.06),
                                      MyColors.lightblueColor2.withOpacity(0.02)
                                    ]
                                ),),
                              )


                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }


  Future<void> createcustomersRequest(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    CreateCustomerRequest createCustomerRequest = new CreateCustomerRequest();

    if(userlist.length>0){
      createCustomerRequest.identifier = userlist[0].id.toString();
      createCustomerRequest.customerNumber = userlist[0].id.toString();
      createCustomerRequest.firstName = userlist[0].name.toString();
      createCustomerRequest.lastName = userlist[0].name.toString();
      createCustomerRequest.email = userlist[0].email.toString();
      createCustomerRequest.website = "";
      createCustomerRequest.phone = userlist[0].mobileNumber.toString();
      createCustomerRequest.alternatePhone = userlist[0].mobileNumber.toString();
      CreateCustomerBillingInfo billingInfo = new CreateCustomerBillingInfo();
      billingInfo.firstName = userlist[0].name.toString();
      billingInfo.lastName = userlist[0].name.toString();
      billingInfo.street = userlist[0].address.toString();
      billingInfo.street2 = userlist[0].address.toString();
      billingInfo.state = userlist[0].state.toString();
      billingInfo.city = userlist[0].city.toString();
      billingInfo.zip = "";
      billingInfo.country = userlist[0].country.toString();
      billingInfo.phone = userlist[0].mobileNumber.toString();
      createCustomerRequest.billingInfo = billingInfo;
      createCustomerRequest.active = true;
    }


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.createcustomersURL),
        body: jsonEncode(createCustomerRequest),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
          // "Authorization": AllApiService.client_id,
        });

    if(response.statusCode==201){
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint("jsonResponse>>> if"+jsonResponse.toString());
      debugPrint("magig pay id>>> if"+jsonResponse["id"].toString());
      sharedPreferences.setString("customer_id", jsonResponse["id"].toString());
      addMagicpayCustomerIdapi(context, jsonResponse["id"].toString());
    }else{
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint("jsonResponse>>> else"+jsonResponse.toString());

      // Fluttertoast.showToast(msg: jsonResponse["error_details"].toString());

    }
    setState(() {});


    return;
  }
  Future <void> addMagicpayCustomerIdapi(BuildContext context,String magicpay_customer_id) async {

    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['magicpay_customer_id'] = magicpay_customer_id;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.addMagicpayCustomerIdapi),
        body: jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint("createMagicpayTxnapi>>>> "+jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      setState(() {

      });
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      setState(() {

      });
    }
    return;
  }


  getprofiledata() async{
    userlist.clear();

    await profileRequest(context, userlist);
    debugPrint(userlist.length);

    // CustomLoader.ProgressloadingDialog6(context, false);

    first_name = (userlist.length > 0 ? "${userlist[0].name == null || userlist[0].name.toString().isEmpty? "": userlist[0].name}" : "");
    is_check = userlist.length > 0 ?userlist[0].documentStatus.toString()=="Blank"? true: false: false;
    free_transfer_count = userlist.length > 0 ?userlist[0].free_transation.toString():"0";
    doucument_status = userlist.length > 0 ?userlist[0].documentStatus.toString():"";
    first_name = first_name.split(" ")[0];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("referral_id", userlist.length > 0 ?userlist[0].unique_id.toString():"0");
    sharedPreferences.setString("document_status", doucument_status);
    userlist.length>0?
    userlist[0].magicpay_customer_id==""?
    createcustomersRequest(context):null:null;

    setState(() {

    });
  }

  verifyDialog(BuildContext context,String msg,String status){
    String document_status = status;
    String actual_status = status;
    document_status = document_status == "pending"?"Incomplete":document_status=="completed"?"pending":document_status ;

    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Column(children: [


              InkWell(
                onTap: (){
                  Navigator.of(context,rootNavigator: true).pop();
                },
                child: Container(
            alignment: Alignment.centerRight,
                  child: SvgPicture.asset("assets/images/closesquare.svg"),
                ),
              ),

              document_status == "Blank"?
                  Container():
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Verification status : ${document_status}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: "assets/fonts/raleway/raleway_regular.ttf"),
                ),
              ),


              SizedBox(height: 20,),

              actual_status == "expired"|| actual_status =="Rejected" || actual_status =="declined"?
              Column(children: [
                Text(
                  "Please re upload verification.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: "assets/fonts/raleway/raleway_regular.ttf"),
                ),


                SizedBox(height: 20,),

                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    Navigator.of(context,rootNavigator: true);
                    pushNewScreen(
                      context,
                      screen: LoginVerificatrionDetailScreen(),
                      withNavBar: false,
                    );
                  },
                  // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0)),
                  // color: MyColors.darkbtncolor,
                  child: Text(
                    "If you want to update verification Click Here"
                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: "assets/fonts/raleway/raleway_regular.ttf"),
                  ),
                ),

                SizedBox(height: 20,),
              ],
              ):Container(),




              actual_status == "Blank"?
              Column(children: [



                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    Navigator.of(context,rootNavigator: true);
                    pushNewScreen(
                      context,
                      screen: LoginVerificatrionDetailScreen(),
                      withNavBar: false,
                    );
                  },
                  // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0)),
                  // color: MyColors.darkbtncolor,
                  child: Text(
                    "Verify Your Account"
                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: "assets/fonts/raleway/raleway_regular.ttf"),
                  ),
                ),

                SizedBox(height: 20,),
              ],
              ):Container(),



              document_status == "Incomplete"?
              Column(children: [
                Text(
                  "Your Verification is incomplete , Please re upload verification.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: "assets/fonts/raleway/raleway_regular.ttf"),
                ),

                SizedBox(height: 20,),


                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    Navigator.of(context,rootNavigator: true);
                    pushNewScreen(
                      context,
                      screen: LoginVerificatrionDetailScreen(),
                      withNavBar: false,
                    );
                  },
                  // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0)),
                  // color: MyColors.darkbtncolor,
                  child: Text(
                    "If you want to update verification Click Here"
                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: "assets/fonts/raleway/raleway_regular.ttf"),
                  ),
                ),

                SizedBox(height: 20,),
              ],
              ):Container(),




              document_status == "pending"?
              Column(children: [
                Text(
                  "We will notify you as soon as you’re approved.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: "assets/fonts/raleway/raleway_regular.ttf"),
                ),


                SizedBox(height: 20,),
              ],
              ):Container(),


            ],),

          );
        });
  }

  comingsoonDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Column(children: [

              InkWell(
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset("assets/icons/clear_red.svg"),
                ),
              ),
              SizedBox(height: 50,),


              Text(
                "Coming Soon",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontFamily: "assets/fonts/raleway/raleway_regular.ttf"),
              ),
              SizedBox(height: 20,),

              SizedBox(height: 50,),

            ],),

          );
        });
  }


  Future <void> getTokenApi(BuildContext context,) async {

    // CustomLoader.ProgressloadingDialog6(context, true);
    // is_load = true;
    var request = {};


    // request['client_id'] = "8i86nj3qmbW3rFWzZyVdpRudJ0XmxAaT";
    // request['client_secret'] = "gSMZhAdUG8azsEXSWgvwJzWqgG8uFeIW0aFxaVnOmb1TOY9KHvRvmwakazbY_EIY";
    // request['audience'] = "https://sandbox-api.readyremit.com";
    // request['grant_type'] = "client_credentials";




    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.authenticationapi),
        body: jsonEncode(request),
        headers: {

          "Content-Type": "application/json",
          "client_key": Apiservices.client_key,
          "client_secret": Apiservices.client_secret,

        });


    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    // getTokenResponse  = await GetTokenResponse.fromJson(jsonResponse);
    debugPrint("token_auhtToken>>>>>>>>"+jsonResponse['token'].toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("auth_Token",jsonResponse['token'].toString());
    // is_load = false;
    // CustomLoader.ProgressloadingDialog6(context, false);
    setState(() {

    });

    return;

  }

  Future <void> latesttransferApi(BuildContext context,) async {

    _enabled = true;
    // Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};

    debugPrint("request ${request}");
    debugPrint("userid ${userid}");
    debugPrint("auth ${auth}");


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.latesttransferapi),
        // body: jsonEncode(request),
        headers: {

          "X-AUTHTOKEN":"${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });


    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      latestTransferResponse  = await LatestTransferResponse.fromJson(jsonResponse);
      latesttransferList = latestTransferResponse.data!.txnData!.data!;


      // Utility.ProgressloadingDialog(context, false);
      setState(() {

      });
    } else {
      // Utility.ProgressloadingDialog(context, false);

      latestTransferResponse  = await LatestTransferResponse.fromJson(jsonResponse);
      setState(() {

      });
    }
    _enabled = false;
    return;
  }

  Future<void> scheduleTransferListapi(BuildContext context
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(Apiservices.scheduleTransferListapi),
        // body: jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });
    debugPrint(response.body);


    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse);
    if (jsonResponse['status'] == true) {
      ScheduleTransferResponse scheduleTransferResponse = await ScheduleTransferResponse.fromJson(jsonResponse);
      schedule_count = scheduleTransferResponse.data!.scheduleTransfer!.total.toString();
      setState((){});
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
      setState((){});
    }

    return;
  }

  Future<void> profileRequest(BuildContext context,List<UserDataModel> userlist
      ) async {
//    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    debugPrint("auth ${p.getString("auth")}");

    var request = {};

    debugPrint("request ${request}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.profile),
        body: jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse);
    if (jsonResponse['status'] == true) {
      // p.setBool("login", true);


      var userdata = jsonResponse['data'];
      var userresponse = userdata['userData'];

      UserDataModel authuser = UserDataModel.fromJson(userresponse);
      debugPrint("user... ${authuser.id}");

      p.setString("auth...>>>>>>>>", authuser.authToken.toString());
      p.setString("customer_id", authuser.magicpay_customer_id.toString());
      debugPrint("user...>>>>>>>>> ${authuser.authToken.toString()}");
      debugPrint("customer_id...>>>>>>>>> ${authuser.magicpay_customer_id.toString()}");

      p.setString("userid", authuser.id.toString());

      UserPreferences().saveUser(authuser);

      userlist.add(authuser);
      debugPrint("user...${userlist[0].name}");

      // Fluttertoast.showToast(msg: jsonResponse['message']);
      // CustomLoader.ProgressloadingDialog(context, true);
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      //CustomLoader.ProgressloadingDialog(context, true);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }
  Future<void> chkStateStatusByIpApi(
      BuildContext context,
      ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(AllApiService.chkStateStatusByIpURL+"?ip="+(await Ipify.ipv4()).toString()),
        // body: jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,
        });

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {

      sharedPreferences.setBool("state_verified", true);
      setState(() {});
    } else {
      sharedPreferences.setBool("state_verified", false
      );
      setState(() {});
    }

    return;
  }


  clearAllTransactionValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("dstCurrencyIso3Code","");
    sharedPreferences.setString("dstCountryIso3Code","").toString();
    sharedPreferences.setString("sourceCurrencyIso3Code","").toString();
    sharedPreferences.setString("sendAmount","").toString();
    sharedPreferences.setString("recipientId","").toString();
    sharedPreferences.setString("senderId","").toString();
    sharedPreferences.setString("BankdetailResponse","").toString();
    sharedPreferences.setString("exchangerate","").toString();
    sharedPreferences.setString("fees","").toString();
    sharedPreferences.setString("reasonsending_id","").toString();
    sharedPreferences.setString("reasonsending_name","").toString();
    sharedPreferences.setString("u_first_name","").toString();
    sharedPreferences.setString("u_last_name","").toString();
    sharedPreferences.setString("u_profile_img","").toString();
    sharedPreferences.setString("receiveAmount","").toString();
    sharedPreferences.setString("select_payment_method_status","").toString();
    sharedPreferences.setString("recipientReceiveBankOrMobileNo","").toString();
    sharedPreferences.setString("recipientReceiveBankNameOrOperatorName","").toString();
    debugPrint("Clear All Data>>>>>>>>> ");
    setState(() {});
  }
}


*/
