import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:moneytos/model/usermodel.dart';
import 'package:moneytos/screens/customScreens/setup_new_pin_code_screen/setup_newpin_Code_screen.dart';
import 'package:moneytos/screens/dash_settingscreen/about_us.dart';
import 'package:moneytos/screens/dash_settingscreen/help_center_screen/help_center_screen.dart';
import 'package:moneytos/screens/dash_settingscreen/legalResorcesScreen.dart';
import 'package:moneytos/screens/dash_settingscreen/manage_payment_method/menage_payment_methodScreen.dart';
import 'package:moneytos/screens/dash_settingscreen/setting_account_setting/notification/notification_screen.dart';
import 'package:moneytos/screens/dash_settingscreen/setting_account_setting/setting_account_setting.dart';
import 'package:moneytos/screens/dash_settingscreen/setting_changePass/setting_changePassword.dart';
import 'package:moneytos/screens/dash_settingscreen/setting_vaerification_screen.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../refer_send_moneynow_screen.dart';
import 'manage_payment_method_detail_screen.dart';

class Setting_home extends StatefulWidget {
  final bool islogout;

  const Setting_home({Key? key, this.islogout = false}) : super(key: key);

  @override
  State<Setting_home> createState() => _Setting_homeState();
}

class _Setting_homeState extends State<Setting_home> {
  ///switch button var
  bool isSwitched_pin = false;
  bool isSwitched_faceId = false;
  bool load = false;
  bool islogout = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getprofiledata();
      islogout = false;
      setState(() {});
    });
  }

  /* @override
  void initState() {
    super.initState();

    onnavigate();
    islogout = false;
    setState(() {
    });
  }*/

  logout() async {
    // setState(() {
    //   load = true;
    // });
    await Webservices.logoutRequest(context);
    islogout = false;
    // setState(() {
    //   load = false;
    //
    // });
    setState(() {});
  }

  List<UserDataModel> userlist = [];

  onnavigate() {
    Timer(const Duration(microseconds: 100), () {
      getprofiledata();
    });
  }

  getprofiledata() async {
    userlist.clear();
    setState(() {
      load = true;
    });
    await Webservices.profileRequest(context, userlist);
    debugPrint(userlist.length as String?);

    setState(() {
      load = false;
    });
    isSwitched_pin = userlist.isNotEmpty
        ? userlist[0].isPinEnabled.toString() == '1'
            ? true
            : false
        : false;
    isSwitched_faceId = userlist.isNotEmpty
        ? userlist[0].is_face_enabled.toString() == '1'
            ? true
            : false
        : false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    var Mysize = MediaQuery.of(context).size;
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.light_primarycolor2,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.light_primarycolor2,
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: 350,
              color: MyColors.light_primarycolor2,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  /* Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        width: 90,
                        height: 90,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:


                            AssetImage("assets/logo/female_profile.jpg",))

                    ),*/
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200.0),
                        child: userlist.isNotEmpty
                            ? FadeInImage(
                                height: 156,
                                width: 149,
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  userlist[0].profileImage.toString(),
                                ),
                                placeholder: const AssetImage(
                                  'assets/logo/progress_image.png',
                                ),
                                placeholderFit: BoxFit.scaleDown,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: MyColors.divider_color,
                                    alignment: Alignment.center,
                                    child: Text(
                                      userlist[0].name == null ||
                                              userlist[0]
                                                  .name
                                                  .toString()
                                                  .isEmpty
                                          ? ''
                                          : userlist[0]
                                              .name
                                              .toString()[0]
                                              .toUpperCase(),
                                      style: const TextStyle(
                                        color: MyColors.shedule_color,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_bold.ttf',
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                      ),
                    ),
                  ),
                  hSizedBox1,
                  Container(
                    margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                    child: Text(
                      userlist.isNotEmpty
                          ? "${userlist[0].name == null || userlist[0].name.toString().isEmpty ? "" : userlist[0].name}"
                          : '',
                      style: const TextStyle(
                        color: MyColors.whiteColor,
                        // fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                    child: Text(
                      userlist.isNotEmpty
                          ? "(${userlist[0].countryCode == null || userlist[0].countryCode.toString().isEmpty ? "" : userlist[0].countryCode})"
                              " ${userlist[0].mobileNumber == null || userlist[0].mobileNumber.toString().isEmpty ? "" : userlist[0].mobileNumber}"
                          : '',
                      style: const TextStyle(
                        color: MyColors.greycolor,
                        //   fontWeight: FontWeight.w300,
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                    child: Text(
                      userlist.isNotEmpty ? ('#${userlist[0].unique_id}') : '',
                      style: const TextStyle(
                        color: MyColors.whiteColor,
                        //fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: MyColors.whiteColor,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: load
                    ? Container(
                        color: Colors.black.withOpacity(0.00),
                        child: const Center(
                          child: GFLoader(
                            type: GFLoaderType.custom,
                            child: Image(
                              image: AssetImage(
                                'assets/logo/progress_image.png',
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    //    userlist.length > 0 ? "(${userlist[0]. == null || userlist[0].countryCode.toString().isEmpty? "124-335-547": userlist[0].countryCode})"+" ${userlist[0].mobileNumber == null || userlist[0].mobileNumber.toString().isEmpty? "124-335-547": userlist[0].mobileNumber}": "(+61) 124-335-547",

                                    'General',
                                    style: TextStyle(
                                      color: MyColors.color_3F84E5,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_medium.ttf',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Setting_Account_setting(),
                                        ),
                                      );
                                      //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Setting_Account_setting()));
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/profile.svg',
                                            color: MyColors.blackColor,
                                            width: 20,
                                            height: 20,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                              20,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: const Text(
                                              'Account Settings',
                                              style: TextStyle(
                                                color: MyColors.color_text,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_bold.ttf',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      /*   documentdetaillist.length > 0 ?   documentdetaillist[0].approvedBy == "1" ?
                                  pushNewScreen(
                                    context,
                                    screen: SettingVerificationSuccessfullyScreen(),
                                    withNavBar: false,
                                  ):*/
                                      pushNewScreen(
                                        context,
                                        screen: const Setting_Verification(),
                                        withNavBar: false,
                                      );
                                      /* :  pushNewScreen(
                                    context,
                                    screen: Setting_Verification(),
                                    withNavBar: false,
                                  );*/
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/verification.svg',
                                            color: MyColors.blackColor,
                                            width: 20,
                                            height: 20,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                              20,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: const Text(
                                              'Verification',
                                              style: TextStyle(
                                                color: MyColors.color_text,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_bold.ttf',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      paymentmethodsRequest(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/Wallet.svg',
                                            color: MyColors.blackColor,
                                            width: 20,
                                            height: 20,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                              16,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: const Text(
                                              'Manage Payment Method',
                                              style: TextStyle(
                                                color: MyColors.color_text,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_bold.ttf',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      pushNewScreen(
                                        context,
                                        screen: const NotificationScreen(),
                                        withNavBar: false,
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/Notification.svg',
                                            color: MyColors.blackColor,
                                            width: 20,
                                            height: 20,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                              20,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: const Text(
                                              'Notifications',
                                              style: TextStyle(
                                                color: MyColors.color_text,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_bold.ttf',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // pushNewScreen(
                                      //   context,
                                      //   screen: LanguageScreen(),
                                      //   withNavBar: false,
                                      // );
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/langiage.svg',
                                            color: MyColors.blackColor,
                                            width: 20,
                                            height: 20,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                              20,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: const Text(
                                              'Language',
                                              style: TextStyle(
                                                color: MyColors.color_text,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_bold.ttf',
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                              10,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: const Text(
                                              '(English US)',
                                              style: TextStyle(
                                                color: MyColors.greycolor,
                                                //   fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_medium.ttf',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Security',
                                      style: TextStyle(
                                        color: MyColors.color_3F84E5,
                                        // fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_medium.ttf',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pushNewScreen(
                                          context,
                                          screen:
                                              const SettingChangePasswordScreen(),
                                          withNavBar: false,
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/Password.svg',
                                              color: MyColors.blackColor,
                                              width: 20,
                                              height: 20,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                20,
                                                0,
                                                0,
                                                0,
                                              ),
                                              child: const Text(
                                                'Change Password',
                                                style: TextStyle(
                                                  color: MyColors.color_text,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'assets/fonts/raleway/raleway_bold.ttf',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/changepass.svg',
                                            color: MyColors.blackColor,
                                            width: 20,
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // pincodeShowbottomsheet(context);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                24,
                                                0,
                                                0,
                                                0,
                                              ),
                                              child: const Text(
                                                'Enable PinCode',
                                                style: TextStyle(
                                                  color: MyColors.color_text,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'assets/fonts/raleway/raleway_bold.ttf',
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Transform.scale(
                                            scale: 0.8,
                                            child: CupertinoSwitch(
                                              value: isSwitched_pin,
                                              activeColor: MyColors
                                                  .lightblueColor
                                                  .withOpacity(0.30),
                                              trackColor: MyColors
                                                  .lightblueColor
                                                  .withOpacity(0.20),
                                              thumbColor: isSwitched_pin == true
                                                  ? MyColors.lightblueColor
                                                  : MyColors.lightblueColor4,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  isSwitched_pin = value;
                                                  if (isSwitched_pin == false) {
                                                    disablepinRequest(
                                                      context,
                                                    );
                                                  }
                                                });
                                                isSwitched_pin == true
                                                    ? pincodeShowbottomsheet(
                                                        context,
                                                      )
                                                    : Container();
                                              },
                                            ),
                                          ),
                                          // Switch(
                                          //   activeColor: MyColors.color_3F84E5
                                          //       .withOpacity(0.20),
                                          //   activeTrackColor: MyColors.color_3F84E5.withOpacity(0.20),
                                          //   thumbColor: MaterialStateColor.resolveWith((states) => MyColors.color_3F84E5.withOpacity(0.20)) ,
                                          //   value: isSwitched_pin,
                                          //   onChanged: (value) {
                                          //     setState(() {
                                          //       isSwitched_pin = value;
                                          //       pincodeShowbottomsheet(context);
                                          //     });
                                          //   },
                                          // ),
                                          /*   Container(
                                        height: 30,
                                        // width: 55,
                                        child: ToggleSwitch(
                                          minWidth: 28.0,
                                          cornerRadius: 20.0,
                                          activeBgColors: [
                                            [
                                              MyColors.color_3F84E5
                                                  .withOpacity(0.20)
                                            ],
                                            [
                                              MyColors.color_3F84E5
                                                  .withOpacity(0.20)
                                            ]
                                          ],
                                          activeFgColor: Colors.white,
                                          inactiveBgColor: MyColors
                                              .color_3F84E5
                                              .withOpacity(0.10),
                                          inactiveFgColor: Colors.white,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: ['', ''],
                                          radiusStyle: true,
                                          onToggle: (index) {},
                                        ),
                                      ),*/
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      margin: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        0,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/enablefaceid.svg',
                                            color: MyColors.blackColor,
                                            width: 20,
                                            height: 20,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                              20,
                                              0,
                                              0,
                                              0,
                                            ),
                                            child: const Text(
                                              'Enable Face ID or Touch ID',
                                              style: TextStyle(
                                                color: MyColors.color_text,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_bold.ttf',
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Transform.scale(
                                            scale: 0.8,
                                            child: CupertinoSwitch(
                                              value: isSwitched_faceId,
                                              activeColor: MyColors
                                                  .lightblueColor
                                                  .withOpacity(0.30),
                                              trackColor: MyColors
                                                  .lightblueColor
                                                  .withOpacity(0.20),
                                              thumbColor: isSwitched_faceId ==
                                                      true
                                                  ? MyColors.lightblueColor
                                                  : MyColors.lightblueColor4,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  isSwitched_faceId = value;
                                                  // WidgetsBinding.instance.addPostFrameCallback((_) =>TransfersApi(context, widget.readyremit_transferId));
                                                  FaceEnableDisableRequest(
                                                    context,
                                                  );
                                                });
                                              },
                                            ),
                                          ),
                                          /*  CupertinoSwitch(
                                        value: isSwitched_pin,
                                        onChanged: (value) {
                                          isSwitched_pin = value;

                                          setState(
                                                () {},
                                          );
                                          isSwitched_pin == true?   pincodeShowbottomsheet(context) : Container();
                                        },
                                        trackColor: MyColors.lightblueColor.withOpacity(0.20),
                                        thumbColor: isSwitched_pin == true? MyColors.lightblueColor:MyColors.lightblueColor.withOpacity(0.30),
                                        activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                                      ),*/

                                          /*    Container(
                                        height: 30,
                                        child: ToggleSwitch(
                                          minWidth: 28.0,
                                          cornerRadius: 20.0,
                                          activeBgColors: [
                                            [
                                              MyColors.color_3F84E5
                                                  .withOpacity(0.20)
                                            ],
                                            [
                                              MyColors.color_3F84E5
                                                  .withOpacity(0.20)
                                            ]
                                          ],
                                          activeFgColor: Colors.white,
                                          inactiveBgColor: MyColors
                                              .color_3F84E5
                                              .withOpacity(0.10),
                                          inactiveFgColor: Colors.white,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: ['', ''],
                                          radiusStyle: true,
                                          onToggle: (index) {},
                                        ),
                                      ),*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'More',
                                      style: TextStyle(
                                        color: MyColors.color_3F84E5,
                                        fontSize: 12,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_medium.ttf',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pushNewScreen(
                                          context,
                                          screen: const ReferSendMoneyScreen(),
                                          withNavBar: false,
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/referearn.svg',
                                              color: MyColors.blackColor,
                                              width: 20,
                                              height: 20,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                20,
                                                0,
                                                0,
                                                0,
                                              ),
                                              child: const Text(
                                                'Refer friends',
                                                style: TextStyle(
                                                  color: MyColors.color_text,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pushNewScreen(
                                          context,
                                          screen: const HelpCenterScreen(),
                                          withNavBar: false,
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/helpscnter.svg',
                                              color: MyColors.blackColor,
                                              width: 20,
                                              height: 20,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                20,
                                                0,
                                                0,
                                                0,
                                              ),
                                              child: const Text(
                                                'Help center',
                                                style: TextStyle(
                                                  color: MyColors.color_text,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'assets/fonts/raleway/raleway_bold.ttf',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pushNewScreen(
                                          context,
                                          screen: const LegalResourcesScreen(),
                                          withNavBar: false,
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/legalresource.svg',
                                              color: MyColors.blackColor,
                                              width: 20,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                20,
                                                0,
                                                0,
                                                0,
                                              ),
                                              child: const Text(
                                                'Legal',
                                                style: TextStyle(
                                                  color: MyColors.color_text,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'assets/fonts/raleway/raleway_bold.ttf',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pushNewScreen(
                                          context,
                                          screen: const AboutUsScreen(),
                                          withNavBar: false,
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/aboutus.svg',
                                              color: MyColors.blackColor,
                                              width: 20,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                20,
                                                0,
                                                0,
                                                0,
                                              ),
                                              child: const Text(
                                                'FAQs',
                                                style: TextStyle(
                                                  color: MyColors.color_text,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'assets/fonts/raleway/raleway_bold.ttf',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              hSizedBox,
                              GestureDetector(
                                onTap: () {
                                  islogout = true;
                                  setState(() {});
                                  // logout();
                                  // logoutdialog(context);
                                },
                                child: Container(
                                  height: 50,
                                  margin:
                                      const EdgeInsets.fromLTRB(00, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/logout.svg',
                                        width: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          20,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: const Text(
                                          'Logout',
                                          style: TextStyle(
                                            color: MyColors.color_ED5565,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_bold.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              hSizedBox4,
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            islogout == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        islogout = false;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.30),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: loagoutbody(),
                      ),
                    ),
                  )
                : Container()

            /* load == true ? Container(
                color: MyColors.primaryColor.withOpacity(0.60),
                child: Center(
                  child: CircularProgressIndicator(color: MyColors.lightblueColor,),
                ),
              ) : Container()*/
          ],
        ),
      ),
    );
  }

  loagoutbody() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Wrap(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Text(
                'Are You sure you want to logout?',
                style: TextStyle(
                  color: MyColors.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: MyColors.whiteColor,
                      backgroundColor: MyColors.lightblueColor,
                    ),
                    onPressed: () {
                      debugPrint('jkgjkdf$islogout');
                      islogout = false;
                      setState(() {
                        debugPrint('jkgjkdf$islogout');
                      });
                    }, // passing false
                    child: const Text('No'),
                  ),
                  wSizedBox2,
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: MyColors.whiteColor,
                      backgroundColor: MyColors.lightblueColor,
                    ),
                    onPressed: () {
                      debugPrint('jkgjkdf$islogout');

                      logout();
                    }, // passing true
                    child: const Text('Yes'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
                Navigator.pop(context);
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
      },
    ).then((exit) {
      if (exit == null) return;

      if (exit) {
        // user pressed Yes button
        logout();
      } else {
        // user pressed No button
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> pincodeShowbottomsheet(BuildContext context) {
    isSwitched_pin = false;
    void Update() {
      isSwitched_pin = true;
      debugPrint('Update pin status>>> ');
      setState(() {});
    }

    return showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: MyColors.whiteColor,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: MyColors.whiteColor,
          ),
          child: SetupNewPinCodeScreen(
            Oncallback: Update,
          ),
        );
      },
    );
  }

  Future<void> FaceEnableDisableRequest(
    BuildContext context,
  ) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.isFaceEnableDisableURL),
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
      // Fluttertoast.showToast(msg: jsonResponse["message"]);
      // CustomLoader.ProgressloadingDialog(context, false);
      // confirfationDialog(context);
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      // CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  Future<void> paymentmethodsRequest(BuildContext context) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(AllApiService.magicpayPaymentMethods),
      // body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        // "Authorization": AllApiService.client_id,
      },
    );

    if (response.statusCode == 200) {
      CustomLoader.ProgressloadingDialog6(context, false);
      // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // debugPrint("nsklvnsf>> "+jsonResponse.toString());
      List<dynamic> viewdebitcardlist = json.decode(response.body);
      debugPrint(
        'viewdebitcardlist.length.length>>> ${viewdebitcardlist.length}',
      );

      /// old condition
      // viewdebitcardlist.length >= 0
      true
          ? pushNewScreen(
              context,
              screen: const ManageSelectPaymentMethodScreen(
                selectedMethodScreen: 0,
              ),
              withNavBar: false,
            )
          : pushNewScreen(
              context,
              screen: const ManagePaymentMethodScreen(isMfs: false),
              withNavBar: false,
            );
    } else {
      CustomLoader.ProgressloadingDialog6(context, false);
      pushNewScreen(
        context,
        screen: const ManagePaymentMethodScreen(isMfs: false),
        withNavBar: false,
      );
    }

    setState(() {});
    // }
    return;
  }

  Future<void> disablepinRequest(BuildContext context) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['is_pin_enabled'] = '0';
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.updateNotificatinsURL),
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
      // Fluttertoast.showToast(msg: jsonResponse["message"]);
      // CustomLoader.ProgressloadingDialog(context, false);
      // confirfationDialog(context);
      isSwitched_pin = false;
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      // CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    setState(() {});
    return;
  }
}
