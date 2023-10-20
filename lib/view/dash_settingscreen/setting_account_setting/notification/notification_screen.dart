import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constance/sizedbox/sizedBox.dart';
import '../../../../s_Api/AllApi/ApiService.dart';
import '../../../../s_Api/S_ApiResponse/AccountSettingResponse.dart';
import '../../../../s_Api/s_utils/Utility.dart';
import '../../../../services/Apiservices.dart';
import 'dart:convert' as convert;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool app_isswitch1 = false;
  bool app_isswitch2 = false;
  bool app_isswitch3 = false;
  bool app_isswitch4 = false;

  bool email_isswitch1 = false;
  bool email_isswitch2 = false;
  bool email_isswitch3 = false;
  bool email_isswitch4 = false;

  String selected_notification_status = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>accountSettingApi(context));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          flexibleSpace:    Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(22, 30, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset("a_assets/icons/arrow_back.svg")
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.notification,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                        "s_asset/font/raleway/raleway_extrabold.ttf"),
                  ),
                ),
                Container(width: 20,)
              ],
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

          /*   Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset("a_assets/icons/arrow_back.svg")
                ),
                      wSizedBox3,
                      wSizedBox3,
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          MyString.notification,
                          style: TextStyle(
                              color: MyColors.whiteColor.withOpacity(0.86),
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily:
                                  "s_asset/font/raleway/Raleway-ExtraBold.ttf"),
                        ),
                      ),
                    ],
                  ),
                ),*/
          hSizedBox3,
          Container(
            // margin: EdgeInsets.only(top: size.height /9),
            child:

              /// body..

              Container(
                margin: EdgeInsets.only(top: 8),
                height: size.height,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(35),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hSizedBox3,

                    /// App notification
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyString.app_notification,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily:
                            "s_asset/font/montserrat/Montserrat-Bold.otf"),
                      ),
                    ),
                    hSizedBox,

                    /// items...

                    ///When logged in through new device
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            MyString.when_logged_in_through_new_device,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: app_isswitch1,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: app_isswitch1 == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                app_isswitch1 = value;
                                selected_notification_status = "is_app_notify_loggedin";

                                updateNotificatinsapi(context, selected_notification_status);
                              });
                            },
                          ),
                        ),

                      ],
                    ),

                    ///Notify me about sales and promotions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            MyString.notify_me_about_salesandpromotions,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: app_isswitch2,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: app_isswitch2 == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                app_isswitch2 = value;
                                selected_notification_status = "is_app_notify_sales_promotions";
                                updateNotificatinsapi(context, selected_notification_status);

                              });
                            },
                          ),
                        ),
                        // Transform.scale(
                        //   scale: 1.2,
                        //   child: Switch(
                        //     inactiveThumbColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     inactiveTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     activeColor: MyColors.color_3F84E5,
                        //     activeTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     // thumbColor: MaterialStateColor.resolveWith((states) => MyColors.color_3F84E5.withOpacity(0.20)) ,
                        //     value: isSwitched_pin,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         isSwitched_pin = value;
                        //         // pincodeShowbottomsheet(context);
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),

                    ///Notify me for referrals
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            MyString.Notify_me_for_referrals,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: app_isswitch3,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: app_isswitch3 == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                app_isswitch3 = value;
                                selected_notification_status = "is_app_notify_refferal";
                                updateNotificatinsapi(context, selected_notification_status);
                              });
                            },
                          ),
                        ),
                        // Transform.scale(
                        //   scale: 1.2,
                        //   child: Switch(
                        //     inactiveThumbColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     inactiveTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     activeColor: MyColors.color_3F84E5,
                        //     activeTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     // thumbColor: MaterialStateColor.resolveWith((states) => MyColors.color_3F84E5.withOpacity(0.20)) ,
                        //     value: isSwitched_pin,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         isSwitched_pin = value;
                        //         // pincodeShowbottomsheet(context);
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),


                    ///Notify me transactions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            MyString.notify_me_transaction,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: app_isswitch4,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: app_isswitch4 == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                app_isswitch4 = value;
                                selected_notification_status = "is_app_notify_txn";
                                updateNotificatinsapi(context, selected_notification_status);
                              });
                            },
                          ),
                        ),
                        // Transform.scale(
                        //   scale: 1.2,
                        //   child: Switch(
                        //     inactiveThumbColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     inactiveTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     activeColor: MyColors.color_3F84E5,
                        //     activeTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     // thumbColor: MaterialStateColor.resolveWith((states) => MyColors.color_3F84E5.withOpacity(0.20)) ,
                        //     value: isSwitched_pin,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         isSwitched_pin = value;
                        //         // pincodeShowbottomsheet(context);
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),

                    hSizedBox4,

                    /// Email notification
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyString.email_notification,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily:
                            "s_asset/font/montserrat/Montserrat-Bold.otf"),
                      ),
                    ),
                    hSizedBox,

                    ///When logged in through new device
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            MyString.when_logged_in_through_new_device,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: email_isswitch1,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: email_isswitch1 == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                email_isswitch1 = value;
                                selected_notification_status = "is_email_notify_loggedin";
                                updateNotificatinsapi(context, selected_notification_status);
                              });
                            },
                          ),
                        ),

                      ],
                    ),

                    ///Notify me about sales and promotions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            MyString.notify_me_about_salesandpromotions,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: email_isswitch2,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: email_isswitch2 == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                email_isswitch2 = value;
                                selected_notification_status = "is_email_notify_sales_promotions";
                                updateNotificatinsapi(context, selected_notification_status);
                              });
                            },
                          ),
                        ),
                        // Transform.scale(
                        //   scale: 1.2,
                        //   child: Switch(
                        //     inactiveThumbColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     inactiveTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     activeColor: MyColors.color_3F84E5,
                        //     activeTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     // thumbColor: MaterialStateColor.resolveWith((states) => MyColors.color_3F84E5.withOpacity(0.20)) ,
                        //     value: isSwitched_pin,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         isSwitched_pin = value;
                        //         // pincodeShowbottomsheet(context);
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),

                    ///Notify me for referrals
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            MyString.Notify_me_for_referrals,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: email_isswitch3,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: email_isswitch3 == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                email_isswitch3 = value;
                                selected_notification_status = "is_email_notify_refferal";
                                updateNotificatinsapi(context, selected_notification_status);
                              });
                            },
                          ),
                        ),
                        // Transform.scale(
                        //   scale: 1.2,
                        //   child: Switch(
                        //     inactiveThumbColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     inactiveTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     activeColor: MyColors.color_3F84E5,
                        //     activeTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     // thumbColor: MaterialStateColor.resolveWith((states) => MyColors.color_3F84E5.withOpacity(0.20)) ,
                        //     value: isSwitched_pin,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         isSwitched_pin = value;
                        //         // pincodeShowbottomsheet(context);
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),


                    ///Notify me transactions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            MyString.notify_me_transaction,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: email_isswitch4,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: email_isswitch4 == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                email_isswitch4 = value;
                                selected_notification_status = "is_email_notify_txn";
                                updateNotificatinsapi(context, selected_notification_status);
                              });
                            },
                          ),
                        ),
                        // Transform.scale(
                        //   scale: 1.2,
                        //   child: Switch(
                        //     inactiveThumbColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     inactiveTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     activeColor: MyColors.color_3F84E5,
                        //     activeTrackColor:
                        //         MyColors.color_3F84E5.withOpacity(0.20),
                        //     // thumbColor: MaterialStateColor.resolveWith((states) => MyColors.color_3F84E5.withOpacity(0.20)) ,
                        //     value: isSwitched_pin,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         isSwitched_pin = value;
                        //         // pincodeShowbottomsheet(context);
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }

  Future <void> updateNotificatinsapi(BuildContext context,String notification_status) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    if(notification_status == "is_app_notify_loggedin"){
      request['is_app_notify_loggedin'] = app_isswitch1?"1":"0";
    }else if(notification_status == "is_app_notify_sales_promotions"){
      request['is_app_notify_sales_promotions'] = app_isswitch2?"1":"0";
    }else if(notification_status == "is_app_notify_refferal"){
      request['is_app_notify_refferal'] = app_isswitch3?"1":"0";
    }else if(notification_status == "is_app_notify_txn"){
      request['is_app_notify_txn'] = app_isswitch4?"1":"0";
    }else if(notification_status == "is_email_notify_loggedin"){
      request['is_email_notify_loggedin'] = email_isswitch1?"1":"0";
    }else if(notification_status == "is_email_notify_refferal"){
      request['is_email_notify_refferal'] = email_isswitch3?"1":"0";
    }else if(notification_status == "is_email_notify_txn"){
      request['is_email_notify_txn'] = email_isswitch4?"1":"0";
    }else if(notification_status == "is_email_notify_sales_promotions"){
      request['is_email_notify_sales_promotions'] = email_isswitch2?"1":"0";
    }












    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.updateNotificatinsapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN":"${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      Utility.ProgressloadingDialog(context, false);
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast( jsonResponse['message']);
      setState(() {});
    }

    return;

  }


  Future <void> accountSettingApi(BuildContext context,) async {

    Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    var userid = p.getString("userid");
    var auth = p.getString("auth");
    var request = {};
    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.accountSetting_URl),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      Utility.ProgressloadingDialog(context, false);
      AccountSettingResponse accountSettingResponse  = await AccountSettingResponse.fromJson(jsonResponse);
      // Utility.showFlutterToast( jsonResponse['message']);
      app_isswitch1 = accountSettingResponse.data!.userData!.isAppNotifyLoggedin == "1"?true:false;
      app_isswitch2 = accountSettingResponse.data!.userData!.isAppNotifySalesPromotions == 1?true:false;
      app_isswitch3 = accountSettingResponse.data!.userData!.isAppNotifyRefferal == "1"?true:false;
      app_isswitch4 = accountSettingResponse.data!.userData!.isAppNotifyTxn == "1"?true:false;

      email_isswitch1 = accountSettingResponse.data!.userData!.isEmailNotifyLoggedin == "1"?true:false;
      email_isswitch2 = accountSettingResponse.data!.userData!.isEmailNotifySalesPromotions == 1?true:false;
      email_isswitch3 = accountSettingResponse.data!.userData!.isEmailNotifyRefferal == "1"?true:false;
      email_isswitch4 = accountSettingResponse.data!.userData!.isEmailNotifyTxn == "1"?true:false;

      // Utility.ProgressloadingDialog(context, false);
      setState(() {

      });
    } else {
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast( jsonResponse['message']);
      //  Utility.ProgressloadingDialog(context, false);



      setState(() {

      });
    }
    return;
  }

}
