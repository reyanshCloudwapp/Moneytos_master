import 'package:moneytos/screens/dashboardScreen/dashboard.dart';
import 'package:moneytos/screens/transfers_scheduled_screens/sheduled_trnsferScreen.dart';
import 'package:moneytos/screens/transfers_scheduled_screens/transfer_shedule_openedbottom.dart';
import 'package:moneytos/services/s_Api/s_ModelClass/ScheduleTransferResponse.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../model/usermodel.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';

class TransferSheduledScreen extends StatefulWidget {
  const TransferSheduledScreen({Key? key}) : super(key: key);

  @override
  State<TransferSheduledScreen> createState() => _TransferSheduledScreenState();
}

class _TransferSheduledScreenState extends State<TransferSheduledScreen> {
  List<UserDataModel> userlist = [];
  bool _enabled = true;
  ScheduleTransferResponse scheduleTransferResponse =
      ScheduleTransferResponse();
  var scrollcontroller = ScrollController();
  bool isLoading = false;
  int page = 1;
  String doucument_status = '';
  List<ScheduleData> scheduledatalist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollcontroller.addListener(pagination);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scheduleTransferListapi(context, 1));
    getprofiledata();
  }

  Future<bool> _willPopCallback() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
      (Route<dynamic> route) => false,
    );
    return true; // return true if the route to be popped
  }

  void Update() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scheduleTransferListapi(context, page));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: MyColors.light_primarycolor2,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            backgroundColor: MyColors.light_primarycolor2,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.light_primarycolor2,
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            centerTitle: true,
            flexibleSpace: Container(
              padding: const EdgeInsets.fromLTRB(23, 40, 20, 0),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    //  margin: EdgeInsets.only(left: 22),
                    // height: 25,
                    // width: 25,
                    margin: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        'assets/images/leftarrow.svg',
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                  wSizedBox2,
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      MyString.transfers_scheduled,
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                  )
                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        bottomSheet: Container(
          // color: MyColors.whiteColor,
          height: 140,
          decoration: const BoxDecoration(
            color: MyColors.whiteColor,
            /*gradient: LinearGradient(
           begin: Alignment.center,
           end: Alignment.bottomCenter,
           //  stops: [0.0, 1.0],
           colors: [
             MyColors.lightblueColor
                 .withOpacity(0.01),
             MyColors.lightblueColor
                 .withOpacity(0.01),
           ],
         ),*/
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          child: GestureDetector(
            onTap: () {
              doucument_status == 'Approved'
                  ? pushNewScreen(
                      context,
                      screen: const SheduledTransferScreen(),
                      withNavBar: false,
                    )
                  : verifyDialog(context, '', doucument_status);
            },
            child: Container(
              width: 160,
              padding: EdgeInsets.only(
                bottom: 25,
                left: size.width / 8,
                right: size.width / 8,
              ),
              child: Material(
                elevation: 2,
                shadowColor: MyColors.lightblueColor.withOpacity(0.10),
                //shadowColor: MyColors.lightblueColor.withOpacity(0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      //  stops: [0.0, 1.0],
                      colors: [
                        MyColors.shedule_color.withOpacity(0.75),
                        MyColors.shedule_color.withOpacity(0.75),
                      ],
                    ),
                    //    border: Border.all(color: bordercolor,width: 1.4)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/white_calender.svg',
                        color: MyColors.whiteColor,
                      ),
                      wSizedBox1,
                      const Text(
                        MyString.schedule_New_Transfer,
                        style: TextStyle(
                          fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                          color: MyColors.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: size.height * 0.3,
              color: MyColors.light_primarycolor2,
            ),
            Container(
              height: size.height,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: MyColors.whiteColor,
              ),
              child: _enabled == true
                  ? Utility.shrimmerVerticalListLoader(
                      100,
                      MediaQuery.of(context).size.width,
                    )
                  : SingleChildScrollView(
                      controller: scrollcontroller,
                      child: Column(
                        children: [
                          hSizedBox3,
                          scheduleTransferResponse.status == true
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: scheduledatalist.length,
                                  itemBuilder: (context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        transferbottomsheet(
                                          scheduledatalist[index],
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 15,
                                        ),
                                        child: CustomCardList(
                                          scheduledatalist[index],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  height: size.height / 1.5,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'No Data',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                          hSizedBox5,
                          hSizedBox5,
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  CustomCardList(ScheduleData scheduleTransfer) {
    return Material(
      elevation: 30,
      shadowColor: MyColors.lightblueColor.withOpacity(0.10),
      color: MyColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*   CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          MyColors.lightblueColor.withOpacity(0.10),
                      child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Image.asset("assets/logo/female_profile.jpg",fit: BoxFit.cover,height: 100,width: 100,))
                         */ /* Text(
                        "R",
                        style: TextStyle(
                            color: MyColors.lightblueColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            fontFamily:
                                "assets/fonts/raleway/Raleway-Bold.ttf"),
                      )*/ /*
                      ),
                    ),*/

                CircleAvatar(
                  radius: 25,
                  backgroundColor: MyColors.divider_color,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FadeInImage(
                      height: 156,
                      width: 149,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        scheduleTransfer.recipientImage.toString(),
                      ),
                      placeholder:
                          const AssetImage('assets/logo/progress_image.png'),
                      placeholderFit: BoxFit.scaleDown,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            scheduleTransfer.recipientName
                                .toString()[0]
                                .toUpperCase(),
                            style: const TextStyle(
                              color: MyColors.shedule_color,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                wSizedBox1,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scheduleTransfer.recipientName.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        fontWeight: FontWeight.w500,
                        color: MyColors.blackColor,
                      ),
                    ),
                    hSizedBox,
                    Column(
                      children: [
                        Text(
                          Utility.DatefomatToYYYYMMTOMMDD(
                            scheduleTransfer.scheduleDate.toString(),
                          ),
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            color: MyColors.blackColor.withOpacity(0.50),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    hSizedBox1,
                    Row(
                      children: [
                        SizedBox(
                          height: 26,
                          width: 26,
                          child: CircleAvatar(
                            backgroundColor: MyColors.lightblueColor4,
                            child: Text(
                              scheduleTransfer.paymentDone.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                                fontWeight: FontWeight.w500,
                                color: MyColors.blackColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Payments Done',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                            color: MyColors.blackColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scheduleTransfer.sendAmount.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily:
                                'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.2,
                            color: MyColors.color_3F84E5,
                          ),
                        ),
                        wSizedBox,
                        Text(
                          scheduleTransfer.sendingCurrency.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                            fontWeight: FontWeight.w600,
                            color: MyColors.lightblueColor,
                          ),
                        ),
                      ],
                    ),
                    hSizedBox1,
                    Material(
                      elevation: 30,
                      shadowColor: MyColors.lightblueColor.withOpacity(0.10),
                      color: MyColors.lightblueColor4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(7),
                        child: Text(
                          scheduleTransfer.scheduleType.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  transferbottomsheet(ScheduleData scheduleTransfer) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // anchorPoint: Offset(20.0, 30.0),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.82,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TransferSheduleBottom(
              schedule_id: scheduleTransfer.id.toString(),
              Oncallback: Update,
            ),
          ),
        );
      },
    );
  }

  void pagination() {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (scheduleTransferResponse.data!.scheduleTransfer!.data!.length == 10)) {
      setState(() {
        isLoading = true;
        if (isLoading) {
          page += 1;
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => scheduleTransferListapi(context, page),
          );
        }

        //add api for load the more data according to new page
      });
    }
  }

  Future<void> scheduleTransferListapi(BuildContext context, int page) async {
    // CustomLoader.ProgressloadingDialog6(context, true);
    _enabled = true;
    SharedPreferences p = await SharedPreferences.getInstance();
    scheduledatalist.clear();
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse('${Apiservices.scheduleTransferListapi}?page=$page'),
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
      // CustomLoader.ProgressloadingDialog6(context, false);
      _enabled = false;
      scheduleTransferResponse =
          ScheduleTransferResponse.fromJson(jsonResponse);
      // scheduledatalist = scheduleTransferResponse.data!.scheduleTransfer!.data!;
      for (int i = 0;
          i < scheduleTransferResponse.data!.scheduleTransfer!.data!.length;
          i++) {
        scheduledatalist
            .add(scheduleTransferResponse.data!.scheduleTransfer!.data![i]);
      }
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      _enabled = false;
      // CustomLoader.ProgressloadingDialog6(context, false);
      // scheduleTransferResponse.data!.scheduleTransfer!.data!.clear();
      //  show_custom_toast(msg: "Register Failed");
    }
    setState(() {});
    return;
  }

  getprofiledata() async {
    userlist.clear();

    await Webservices.profileRequest(context, userlist);
    debugPrint(userlist.length.toString());

    doucument_status =
        userlist.isNotEmpty ? userlist[0].documentStatus.toString() : '';
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
}
