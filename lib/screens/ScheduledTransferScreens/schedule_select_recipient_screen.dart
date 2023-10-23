import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'ScheduleRecipientIdemDetailPage.dart';
import 'Scheduled_select_recipentCountry.dart';

class ScheduleSelectRecipientScreen extends StatefulWidget {
  const ScheduleSelectRecipientScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleSelectRecipientScreen> createState() =>
      _ScheduleSelectRecipientScreenState();
}

class _ScheduleSelectRecipientScreenState
    extends State<ScheduleSelectRecipientScreen> {
  AllAddedRecipientsListResponse addedRecipientsListResponse =
      AllAddedRecipientsListResponse();

  List<Recipientlist> recipientList = <Recipientlist>[];
  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => addedAllRecipientsApi(context));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: MyColors.light_primarycolor2,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.light_primarycolor2,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 26),
        decoration: const BoxDecoration(
          color: MyColors.whiteColor,
        ),
        alignment: Alignment.center,
        height: 80,
        padding: const EdgeInsets.only(bottom: 15, top: 15),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/icons/clear_red.svg',
            height: 50,
            width: 50,
          ),
        ),
      ),
      body: Stack(
        children: [
          ///
          Container(
            height: size.height * 0.6,
            decoration: const BoxDecoration(
              color: MyColors.light_primarycolor2,
            ),
          ),

          /// body ui

          Container(
            height: size.height * 0.4,
            decoration: const BoxDecoration(
              color: MyColors.light_primarycolor2,
            ),
            child: Column(
              children: [
                hSizedBox4,
                //  hSizedBox1,
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    MyString.select_recipients,
                    style: TextStyle(
                      color: MyColors.whiteColor.withOpacity(0.86),
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'assets/fonts/raleway/raleway_extrabold.ttf',
                    ),
                  ),
                ),
                hSizedBox1,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.select_from_recipent_below,
                    style: TextStyle(
                      color: MyColors.whiteColor.withOpacity(0.60),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                    ),
                  ),
                ),
                hSizedBox2,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.or,
                    style: TextStyle(
                      color: MyColors.whiteColor.withOpacity(0.86),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'assets/fonts/raleway/raleway_extrabold.ttf',
                    ),
                  ),
                ),
                hSizedBox3,
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: const ScheduledSelectRecipentCountry(),
                      withNavBar: false,
                    );
                    // SelectPaymentMethodScreen
                  },
                  child: Container(
                    width: 210,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        //  stops: [0.0, 1.0],
                        colors: [
                          MyColors.lightblueColor.withOpacity(0.85),
                          MyColors.lightblueColor.withOpacity(0.90),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/add_user.svg',
                          height: 14,
                          width: 14,
                          color: MyColors.whiteColor.withOpacity(0.85),
                        ),
                        wSizedBox1,
                        Text(
                          MyString.new_recipent,
                          style: TextStyle(
                            color: MyColors.whiteColor.withOpacity(0.85),
                            fontSize: 14,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: MyColors.whiteColor,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.whiteColor,
                  ),
                  child: searchRecipient(),
                ),
                isLoad == true
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Utility.shrimmerGridLoader(150, 150),
                      )
                    : recipientList.isEmpty
                        ? Container(
                            height: size.height / 1.5,
                            alignment: Alignment.center,
                            child: const Text(
                              'No Data',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.only(top: 0.0),
                            decoration: BoxDecoration(
                              color: MyColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: size.height,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 0,
                                    ),
                                    /*decoration: BoxDecoration(
                              color: MyColors.lightblueColor.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(30)
                          ),*/
                                    child: Column(
                                      children: [
                                        hSizedBox4,

                                        /// call api open gridview///

                                        GridView(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 20,
                                            bottom: size.height / 2.8,
                                          ),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1 / 0.86,
                                            crossAxisSpacing: 1.1,
                                            mainAxisSpacing: 0.3,
                                          ),
                                          children: List.generate(
                                              recipientList.length, (index) {
                                            return Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 5,
                                              ),
                                              child: Material(
                                                elevation: 0.6,
                                                color: MyColors.whiteColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    sharedPreferences.setString(
                                                      'recpi_id',
                                                      recipientList[index]
                                                          .id
                                                          .toString(),
                                                    );
                                                    sharedPreferences.setString(
                                                      'recpi_userId',
                                                      recipientList[index]
                                                          .userId
                                                          .toString(),
                                                    );
                                                    sharedPreferences.setString(
                                                      'recipientId',
                                                      recipientList[index]
                                                          .recipientId
                                                          .toString(),
                                                    );
                                                    sharedPreferences.setString(
                                                      'iso2',
                                                      recipientList[index]
                                                          .countryIso2Code
                                                          .toString(),
                                                    );
                                                    sharedPreferences.setString(
                                                      'currency',
                                                      recipientList[index]
                                                          .currencyIso3Code
                                                          .toString(),
                                                    );
                                                    sharedPreferences.setString(
                                                      'rec_address',
                                                      recipientList[index]
                                                          .address
                                                          .toString(),
                                                    );
                                                    sharedPreferences.setString(
                                                      'rec_city',
                                                      recipientList[index]
                                                          .city
                                                          .toString(),
                                                    );
                                                    sharedPreferences.setString(
                                                      'postcode',
                                                      recipientList[index]
                                                          .postcode
                                                          .toString(),
                                                    );
                                                    sharedPreferences.setString(
                                                      'relationship',
                                                      recipientList[index]
                                                          .relationship
                                                          .toString(),
                                                    );
                                                    pushNewScreen(
                                                      context,
                                                      screen:
                                                          ScheduleRecipientDetailScreen(
                                                        recipientList[index]
                                                            .firstName
                                                            .toString(),
                                                        recipientList[index]
                                                            .lastName
                                                            .toString(),
                                                        recipientList[index]
                                                            .profileImage
                                                            .toString(),
                                                        recipientList[index]
                                                            .countryIso3Code
                                                            .toString(),
                                                        recipientList[index]
                                                            .phonecode
                                                            .toString(),
                                                        recipientList[index]
                                                            .phoneNumber
                                                            .toString(),
                                                        recipientList[index]
                                                            .countryName
                                                            .toString(),
                                                        recipientList[index]
                                                            .recipientId
                                                            .toString(),
                                                        recipientList[index]
                                                            .currencyIso3Code
                                                            .toString(),
                                                        recipientList[index]
                                                            .countryEmoji
                                                            .toString(),
                                                      ),
                                                      withNavBar: false,
                                                    );
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 0,
                                                      horizontal: 10,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        /*      FadeInImage.memoryNetwork(
                                                    placeholder: kTransparentImage,
                                                    image: '${AllApiService.AllrecipientProImageBaseUrl+recipientList[index].profileImage.toString()}',
                                                  ),*/
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              100,
                                                            ),
                                                            color: MyColors
                                                                .lightblueColor
                                                                .withOpacity(
                                                              0.05,
                                                            ),
                                                          ),
                                                          height: 60,
                                                          width: 60,

                                                          //    backgroundImage: AssetImage("assets/logo/profile_img.png"),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              200,
                                                            ),
                                                            child: FadeInImage(
                                                              height: 200,
                                                              width: 200,
                                                              fit: BoxFit.fill,
                                                              image:
                                                                  NetworkImage(
                                                                recipientList[
                                                                        index]
                                                                    .profileImage
                                                                    .toString(),
                                                              ),
                                                              placeholder:
                                                                  const AssetImage(
                                                                'assets/logo/progress_image.png',
                                                              ),
                                                              placeholderFit:
                                                                  BoxFit
                                                                      .scaleDown,
                                                              imageErrorBuilder:
                                                                  (
                                                                context,
                                                                error,
                                                                stackTrace,
                                                              ) {
                                                                return Container(
                                                                  color: MyColors
                                                                      .divider_color,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    recipientList[
                                                                            index]
                                                                        .firstName
                                                                        .toString()[
                                                                            0]
                                                                        .toUpperCase(),
                                                                    style:
                                                                        const TextStyle(
                                                                      color: MyColors
                                                                          .shedule_color,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontFamily:
                                                                          'assets/fonts/raleway/raleway_bold.ttf',
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          // backgroundImage: NetworkImage(recipientList[index].profileImage.toString()),
                                                        ),
                                                        hSizedBox1,
                                                        hSizedBox,
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            recipientList[index]
                                                                .firstName
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color: MyColors
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'assets/fonts/raleway/raleway_medium.ttf',
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),

                                        /// call api open gridview///

                                        const SizedBox(
                                          height: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                  hSizedBox1,
                                ],
                              ),
                            ),
                          ),
              ],
            ),
          ),

          // isLoad == true?Container(
          //   height: MediaQuery.of(context).size.height,
          //   alignment: Alignment.center,
          //   child: GFLoader(
          //       type: GFLoaderType.custom,
          //       child: Image(image: AssetImage("assets/logo/progress_image.png"),
          //       )),
          // ):Container()
        ],
      ),
    );
  }

  searchRecipient() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: MyColors.lightblueColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: (value) => _searchAllRecipintFilter(value),
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
        ),
        decoration: InputDecoration(
          hintText: ' Search Recipient...',
          border: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.all(22),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              CupertinoIcons.search,
              color: MyColors.blackColor.withOpacity(0.80),
            ),
          ),
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.50),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            letterSpacing: 0.3,
          ),
          //border: InputBorder.none,
        ),

        keyboardType: TextInputType.emailAddress,

        // Only numbers can be entered
      ),
    );
  }

  Future<void> addedAllRecipientsApi(
    BuildContext context,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    isLoad = true;
    setState(() {});
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
      Uri.parse(AllApiService.all_RecipintList_URl),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      addedRecipientsListResponse =
          AllAddedRecipientsListResponse.fromJson(jsonResponse);

      for (int i = 0;
          i < addedRecipientsListResponse.data!.recipientlist!.length;
          i++) {
        recipientList.add(addedRecipientsListResponse.data!.recipientlist![i]);
      }

      // Utility.ProgressloadingDialog(context, false);
      isLoad = false;
      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);
      isLoad = false;
      addedRecipientsListResponse =
          AllAddedRecipientsListResponse.fromJson(jsonResponse);
      setState(() {});
    }
    return;
  }

  void _searchAllRecipintFilter(String enteredKeyword) {
    List<Recipientlist> results = <Recipientlist>[];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = addedRecipientsListResponse.data!.recipientlist!;
    } else {
      results = recipientList
          .where(
            (user) => user.firstName
                .toString()
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      recipientList = results;
    });
  }
}
