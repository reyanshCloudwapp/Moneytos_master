import 'dart:ui';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/chartscreen/chart_screens.dart';
import 'package:moneytos/view/dash_recipentScreen/dash_recepentScreen.dart';
import 'package:moneytos/view/dash_settingscreen/dash_settingScreen.dart';
import 'package:moneytos/view/home/home.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constance/customLoader/customLoader.dart';
import '../../model/usermodel.dart';
import '../../model/userprefences.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/S_ApiResponse/commonsettinglistResponse.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';
import 'dart:convert' as convert;

import '../home_history_screens/home_historyScreen.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';

class DashboardScreen extends StatefulWidget {
  int currentpage_index;
  bool islogout = false;

  DashboardScreen({Key? key, this.currentpage_index = 0, this.islogout = false})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String doucument_status = "";
  PersistentTabController? controller;
  int pageindex = 0;
  List<UserDataModel> userlist = [];
  bool load = false;
  bool islogout = false;
  var year = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //controller = PersistentTabController(initialIndex: 0);

  bool chartload = false;

  getchartRecipientApi() async {
    chartdatalist.clear();
    chartRecipientDatlist.clear();
    setState(() {
      chartload = true;
    });
    await Webservices.ChartRecipientRequest(
      context,
      chartdatalist,
      chartRecipientDatlist,
      txnGraphDatalist,
      year.toString(),
    );

    setState(() {
      chartload = false;
    });
  }

  Future<void> commonsettingApi(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response =
        await http.get(Uri.parse(Apiservices.commonsettingURL), headers: {
      "X-CLIENT": AllApiService.x_client,
      "content-type": "application/json",
    });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CommonsettinglistResponse commonsettinglistResponse =
          CommonsettinglistResponse.fromJson(jsonResponse);
      for (var commondata in commonsettinglistResponse.data!.commonData!) {
        if (commondata.slugName == "niumapi_url") {
          Apiservices.nium_base_url = commondata.slugValue.toString();
        }
        if (commondata.slugName == "nium_client_id") {
          Apiservices.x_client_id = commondata.slugValue.toString();
        }
        if (commondata.slugName == "niumapi_url_v2") {
          Apiservices.nium_base_url_v2 = commondata.slugValue.toString();
        }
        if (commondata.slugName == "nium_client_key") {
          Apiservices.client_key = commondata.slugValue.toString();
        }
        if (commondata.slugName == "nium_client_secret") {
          Apiservices.client_secret = commondata.slugValue.toString();
        }
        if (commondata.slugName == "nium_source_account") {
          Apiservices.nium_source_account = commondata.slugValue.toString();
        }
        if (commondata.slugName == "nium_identification_number") {
          Apiservices.nium_identification_number =
              commondata.slugValue.toString();
        }
        if (commondata.slugName == "nium_request_id") {
          Apiservices.nium_request_id = commondata.slugValue.toString();
        }
        if (commondata.slugName == "nium_contact_number") {
          Apiservices.nium_contact_number = commondata.slugValue.toString();
        }
        if (commondata.slugName == "nium_identification_type") {
          Apiservices.nium_identification_type =
              commondata.slugValue.toString();
        }
        if (commondata.slugName == "magicpay_url") {
          AllApiService.magicpayBaseUrlBaseUrl =
              commondata.slugValue.toString();
        }
        if (commondata.slugName == "magicpay_basic_auth") {
          AllApiService.client_id = commondata.slugValue.toString();
        }
        if (commondata.slugName == "persona_template_id") {}
        if (commondata.slugName == "persona_inquiry_template_id") {}
        if (commondata.slugName == "persona_url") {}
        if (commondata.slugName == "persona_auth") {}
        if (commondata.slugName == "persona_enviroment") {}
        if (commondata.slugName == "site_schedule_status") {
          print("slug value>>>  " + commondata.slugValue.toString());
          sharedPreferences.setString(
              "site_schedule_status", commondata.slugValue.toString());
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chkStateStatusByIpApi(context);
    getprofiledata();
    pageset();
    controller = PersistentTabController(initialIndex: pageindex);
    setState(() {});
  }

  pageset() {
    pageindex = widget.currentpage_index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // widget.islogout == true ?  Future.delayed(Duration.zero, () => logoutdialog(context)) : null;
    return Scaffold(
      // key: ,
      backgroundColor: MyColors.whiteColor,
      /*  appBar: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.primaryColor,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
      ),*/
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child:
                // PersistentTabView.custom(
                //   context,
                //   controller: controller,
                //   itemCount: _bottomNavList.length,
                //   // This is required in case of custom style! Pass the number of items for the nav bar.
                //   screens: _buildScreens(),
                //   confineInSafeArea: true,
                //   backgroundColor: Colors.white,
                //   handleAndroidBackButtonPress: true,
                //   stateManagement: false,
                //   hideNavigationBarWhenKeyboardShows: true,
                //
                //   /*
                //   onItemSelected: (int) {
                //     setState(
                //         () {}); // This is required to update the nav bar if Android back button is pressed
                //   },
                //
                //    */
                //   customWidget: CustomNavBarWidget(
                //     // Your custom widget goes here
                //     items: _navBarsItems(),
                //     // items: _bottomNavList,
                //     selectedIndex: controller?.index ?? 0,
                //     onItemSelected: (index) {
                //       setState(() {
                //         pageindex = index;
                //         controller?.index =
                //             index; // NOTE: THIS IS CRITICAL!! Don't miss it!
                //       });
                //     },
                //   ),
                // )

                PersistentTabView(
              context,
              controller: controller,
              screens: _buildScreens(),
              items: false ? _bottomNavList : _navBarsItems(),
              confineInSafeArea: true,

              navBarHeight: 75,
              backgroundColor: Colors.white,
              // Default is Colors.white.
              handleAndroidBackButtonPress: true,
              // Default is true.
              resizeToAvoidBottomInset: true,
              // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: false,
              // Default is true.
              hideNavigationBarWhenKeyboardShows: true,
              padding: const NavBarPadding.only(top: 10),
              onItemSelected: (int index) {
                setState(() {
                  chkStateStatusByIpApi(context);
                  if (index == 0) {
                    getprofiledata();
                  }
                  pageindex = index;
                  islogout = false;
                  pageindex == 1 ? getchartRecipientApi() : Container();
                  print("pageindex...${pageindex}${islogout}");
                }); // This is required to update the nav bar if Android back button is pressed
              },

              // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(0.0),
                colorBehindNavBar: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: MyColors.blackColor.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 20),
                ],
                adjustScreenBottomPaddingOnCurve: true,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle
                  .simple, // Choose the nav bar style with this property.
            ),
          ),

          /*  chartload == true ? Container(
            height: MediaQuery.of(context).size.height,
            child:  CustomLoader.ProgressloadingDialog4(context),
          ) : Container()*/
        ],
      ),
    );
  }

  logout() async {
    setState(() {
      load = true;
    });
    await Webservices.logoutRequest(context);

    widget.islogout = false;
    setState(() {
      load = false;
    });
  }

  logoutdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Wanna Exit?'),
            actions: [
              TextButton(
                onPressed: () {
                  widget.islogout = false;
                  setState(() {});
                  //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen(currentpage_index: 3,)));
                }, // passing false
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  logout();
                }, // passing true
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const HomeHistoryScreen(),
      RecipentScreen(backToHome: () {
        setState(() {
          pageindex == 1;
        });
      }),
      Setting_home(
        islogout: islogout,
      )
    ];
  }

  final List<PersistentBottomNavBarItem> _bottomNavList = [
    PersistentBottomNavBarItem(
      contentPadding: 16,
      icon: SvgPicture.asset(
        "a_assets/icons/home_blue_icon.svg",
        // height: 30,
        // width: 30,
        color: MyColors.lightblueColor,
      ),
      title: (MyString.home),
      textStyle: const TextStyle(
        color: MyColors.color_3F84E5,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      activeColorPrimary: MyColors.color_3F84E5,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        "a_assets/icons/bottombar_icon/graph.svg",
        // height: 20,
        // width: 20,
        color: MyColors.lightblueColor,
      ),
      title: (MyString.chart),
      textStyle: const TextStyle(
          color: MyColors.color_3F84E5,
          fontWeight: FontWeight.w600,
          fontSize: 14),
      activeColorPrimary: MyColors.color_3F84E5,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset("a_assets/icons/bottombar_icon/bold_user.svg",
          height: 20, width: 20, color: MyColors.color_3F84E5),
      title: (MyString.recipients),
      textStyle: const TextStyle(
          color: MyColors.color_3F84E5,
          fontWeight: FontWeight.w600,
          fontSize: 14),
      activeColorPrimary: MyColors.color_3F84E5,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset("a_assets/icons/bottombar_icon/setting.svg",
          height: 20, width: 20, color: MyColors.color_3F84E5),
      title: (MyString.setting),
      textStyle: const TextStyle(
          color: MyColors.color_3F84E5,
          fontWeight: FontWeight.w600,
          fontSize: 13.80,
          fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
      activeColorPrimary: MyColors.color_3F84E5,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        contentPadding: 10.0,
        icon: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Transform.scale(
            scale: 1.6,
            child: pageindex == 0
                ? SvgPicture.asset(
                    "a_assets/icons/home_blue_icon.svg",
                    // height: 20,
                    // width: 20,
                    // color: MyColors.lightblueColor,
                  )
                : SvgPicture.asset(
                    "a_assets/icons/home_grey_icon.svg", /*height: 20, width: 20*/
                  ),
          ),
        ),
        title: (MyString.home),
        textStyle: const TextStyle(
            color: MyColors.color_3F84E5,
            fontWeight: FontWeight.w600,
            fontSize: 14),
        activeColorPrimary: MyColors.color_3F84E5,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        contentPadding: 10,
        icon: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Transform.scale(
              scale: 1.6,
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                child: pageindex == 1
                    ? SvgPicture.asset(
                        "a_assets/icons/history_blue_icon.svg",
                        height: 20,
                        width: 20,
                        // color: MyColors.lightblueColor,
                      )
                    : SvgPicture.asset(
                        "a_assets/icons/history_grey_icon.svg",
                        height: 20,
                        width: 20,
                      ),
              )),
        ),
        title: (MyString.history),
        textStyle: const TextStyle(
            color: MyColors.color_3F84E5,
            fontWeight: FontWeight.w600,
            fontSize: 14),
        activeColorPrimary: MyColors.color_3F84E5,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        contentPadding: 10,
        icon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Transform.scale(
              scale: 1.6,
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                child: pageindex == 2
                    ? SvgPicture.asset("a_assets/icons/recipients_blue_icon.svg",
                        height: 20, width: 20)
                    : SvgPicture.asset(
                        "a_assets/icons/recipients_grey_icon.svg",
                        height: 20,
                        width: 20,
                      ),
              )),
        ),
        title: (MyString.recipients),
        textStyle: const TextStyle(
            color: MyColors.color_3F84E5,
            fontWeight: FontWeight.w600,
            fontSize: 14),
        activeColorPrimary: MyColors.color_3F84E5,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        contentPadding: 10,
        icon: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Transform.scale(
              scale: 1.6,
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                child: pageindex == 3
                    ? SvgPicture.asset("a_assets/icons/setting_blue_icon.svg",
                        height: 20, width: 20)
                    : SvgPicture.asset(
                        "a_assets/icons/setting_grey_icon.svg",
                        height: 20,
                        width: 20,
                      ),
              )),
        ),
        title: (MyString.setting),
        textStyle: const TextStyle(
            color: MyColors.color_3F84E5,
            fontWeight: FontWeight.w600,
            fontSize: 13.80,
            fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
        activeColorPrimary: MyColors.color_3F84E5,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  getprofiledata() async {
    userlist.clear();
    await profileRequest(context, userlist);
    print(userlist.length);

    // CustomLoader.ProgressloadingDialog6(context, false);

    // doucument_status = userlist.length > 0 ?userlist[0].documentStatus.toString():"";
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString("referral_id", userlist.length > 0 ?userlist[0].referral_id.toString():"0");
    // sharedPreferences.setString("document_status", doucument_status);

    setState(() {});
  }

  verifyDialog(BuildContext context, String msg, String status) {
    String document_status = status;
    String actual_status = status;
    document_status = document_status == "pending"
        ? "Incomplete"
        : document_status == "completed"
            ? "pending"
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
                    child: SvgPicture.asset("s_asset/images/closesquare.svg"),
                  ),
                ),
                document_status == "Blank"
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Verification status : ${document_status}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  "s_asset/font/raleway/raleway_regular.ttf"),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                actual_status == "expired" ||
                        actual_status == "Rejected" ||
                        actual_status == "declined"
                    ? Column(
                        children: [
                          const Text(
                            "Please re upload verification.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_regular.ttf"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                        25.0, 12.0, 25.0, 12.0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MyColors.darkbtncolor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context, rootNavigator: true);
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
                            child: const Text(
                              "If you want to update verification Click Here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      "s_asset/font/raleway/raleway_regular.ttf"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
                actual_status == "Blank"
                    ? Column(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                        25.0, 12.0, 25.0, 12.0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MyColors.darkbtncolor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context, rootNavigator: true);
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
                            child: const Text(
                              "Verify Your Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      "s_asset/font/raleway/raleway_regular.ttf"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
                document_status == "Incomplete"
                    ? Column(
                        children: [
                          const Text(
                            "Your Verification is incomplete , Please re upload verification.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_regular.ttf"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                        25.0, 12.0, 25.0, 12.0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MyColors.darkbtncolor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context, rootNavigator: true);
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
                            child: const Text(
                              "If you want to update verification Click Here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      "s_asset/font/raleway/raleway_regular.ttf"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
                document_status == "pending"
                    ? const Column(
                        children: [
                          Text(
                            "We will notify you as soon as you’re approved.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_regular.ttf"),
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
        });
  }

  Future<void> profileRequest(
      BuildContext context, List<UserDataModel> userlist) async {
//    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    print("auth ${p.getString("auth")}");

    var request = {};

    print("request ${request}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.profile),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
    if (jsonResponse['status'] == true) {
      // p.setBool("login", true);

      var userdata = jsonResponse['data'];
      var userresponse = userdata['userData'];

      UserDataModel authuser = UserDataModel.fromJson(userresponse);
      print("user... ${authuser.id}");

      p.setString("auth...>>>>>>>>", authuser.authToken.toString());
      p.setString("customer_id", authuser.magicpay_customer_id.toString());
      print("user...>>>>>>>>> ${authuser.authToken.toString()}");
      print(
          "customer_id...>>>>>>>>> ${authuser.magicpay_customer_id.toString()}");

      p.setString("userid", authuser.id.toString());
      userlist.add(authuser);
      doucument_status =
          userlist.isNotEmpty ? userlist[0].documentStatus.toString() : "";
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("referral_id",
          userlist.isNotEmpty ? userlist[0].unique_id.toString() : "0");
      sharedPreferences.setString("document_status", doucument_status);

      UserPreferences().saveUser(authuser);

      print("user...${userlist[0].name}");

      if (doucument_status == "Approved") {
      } else if (doucument_status == "Blank") {
        verifyDialog(context, "", doucument_status);
      } else {
        verifyDialog(context, "", doucument_status);
      }

      // Fluttertoast.showToast(msg: jsonResponse['message']);
      // CustomLoader.ProgressloadingDialog(context, true);
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
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

    var response = await http.get(
        Uri.parse(AllApiService.chkStateStatusByIpURL +
            "?ip=" +
            (await Ipify.ipv4()).toString()),
        // body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      sharedPreferences.setBool("state_verified", true);
      setState(() {});
    } else {
      sharedPreferences.setBool("state_verified", false);
      setState(() {});
    }

    return;
  }
}

/*
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/view/chartscreen/chart_screens.dart';
import 'package:moneytos/view/dash_recipentScreen/dash_recepentScreen.dart';
import 'package:moneytos/view/dash_settingscreen/dash_settingScreen.dart';
import 'package:moneytos/view/home/home.dart';
import 'package:moneytos/view/home/home_demo.dart';
import 'package:moneytos/view/home/homescreenfinal.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
   PersistentTabController? controller;
   int pageindex  = 0;

  //controller = PersistentTabController(initialIndex: 0);

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
    */
/*  appBar: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.primaryColor,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
      ),*/ /*

      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
        ),
        child: PersistentTabView(
          context,
          controller: controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          onItemSelected: (int index) {
            setState(() {
              pageindex = index;
              print("pageindex...${pageindex}");
            }); // This is required to update the nav bar if Android back button is pressed
          },

          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(30.0),
            colorBehindNavBar: Colors.white,
            boxShadow: [
              BoxShadow(color: MyColors.lightblueColor.withOpacity(0.08), spreadRadius: 1),
            ],
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
   List<Widget> _buildScreens() {
     return [
       HomeScreen(),
       ChartScreen(title: '',),
       RecipentScreen(),
       Setting_home()

     ];
   }
   List<PersistentBottomNavBarItem> _navBarsItems() {
     return [
       PersistentBottomNavBarItem(
         contentPadding: 0.1,
         icon: pageindex == 0 ? SvgPicture.asset("a_assets/icons/bottombar_icon/home.svg",height: 20,width: 20,color: MyColors.lightblueColor,)
             :SvgPicture.asset("a_assets/icons/bottombar_icon/bold_home.svg",height: 20,width: 20),

         title: (MyString.home),
         textStyle: TextStyle(color: MyColors.color_3F84E5,fontWeight: FontWeight.w600,fontSize: 14),
         activeColorPrimary:MyColors.color_3F84E5,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon:  pageindex == 1 ?
         SvgPicture.asset("a_assets/icons/bottombar_icon/graph.svg",height: 20,width: 20, color: MyColors.lightblueColor, )
             :
         SvgPicture.asset("a_assets/icons/bottombar_icon/light_graph.svg",height: 20,width: 20,  ),
         title: (MyString.chart),
         textStyle: TextStyle(color: MyColors.color_3F84E5,fontWeight: FontWeight.w600,fontSize: 14),
         activeColorPrimary: MyColors.color_3F84E5,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon:  pageindex == 2 ? SvgPicture.asset("a_assets/icons/bottombar_icon/bold_user.svg",height: 20,width: 20, color: MyColors.color_3F84E5   )
             :
         SvgPicture.asset("a_assets/icons/bottombar_icon/light_user.svg",height: 20,width: 20,  ),
         title: (MyString.recipients),
         textStyle: TextStyle(color: MyColors.color_3F84E5,fontWeight: FontWeight.w600,fontSize: 14),
         activeColorPrimary: MyColors.color_3F84E5,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
       PersistentBottomNavBarItem(
         icon:  pageindex == 3 ? SvgPicture.asset("a_assets/icons/bottombar_icon/setting.svg",height: 20,width: 20, color: MyColors.color_3F84E5 )
             :
         SvgPicture.asset("a_assets/icons/bottombar_icon/light_setting.svg",height: 20,width: 20,  ),
         title: (MyString.setting),
         textStyle: TextStyle(color: MyColors.color_3F84E5,fontWeight: FontWeight.w600,fontSize: 13.80,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
         activeColorPrimary: MyColors.color_3F84E5,
         inactiveColorPrimary: CupertinoColors.systemGrey,
       ),
     ];
   }
}



*/

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem>
      items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 2,
          ),
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary ?? item.activeColorPrimary),
              child: item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title ?? '',
                style: TextStyle(
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  fontSize: 10.0,
                  fontFamily: 'Raleway',
                ),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: MyColors.whiteColor, boxShadow: [
        BoxShadow(
            color: Colors.black12,
            // color: MyColors.blackColor.withOpacity(.2),
            blurRadius: 20,
            spreadRadius: 0,
            offset: Offset(0, -22))
      ]),
      // padding: const EdgeInsets.all(12),
      height: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          return Expanded(
            child: InkWell(
              onTap: () {
                onItemSelected(index);
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: _buildItem(item, selectedIndex == index),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
