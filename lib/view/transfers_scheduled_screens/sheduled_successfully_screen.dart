import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/s_Api/S_ApiResponse/GetStatusResponse.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/transfers_scheduled_screens/sheduled_trnsferScreen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transfers_scheduled_screen.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constance/myStrings/myString.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/s_utils/Utility.dart';
import 'dart:convert' as convert;

class SheduledSuccessfullyScreen extends StatefulWidget {
  String amount;
  SheduledSuccessfullyScreen({Key? key,required this.amount}) : super(key: key);

  @override
  State<SheduledSuccessfullyScreen> createState() => _SheduledSuccessfullyScreenState();
}


class _SheduledSuccessfullyScreenState extends State<SheduledSuccessfullyScreen> {
  String u_phone_number = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pref();
    setState(() {

    });
  }
  Future<void> pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    u_phone_number = sharedPreferences.getString("u_phone_number").toString();
    try{
      u_phone_number = u_phone_number.substring(u_phone_number.length-3,u_phone_number.length);
    }catch(ex){
      u_phone_number = "";
    }
    print("u_phone_number>>> "+u_phone_number);
    setState(() {

    });

  }
  Future<bool> _willPopCallback() async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        DashboardScreen()), (Route<dynamic> route) => false);
    return true; // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.whiteColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                hSizedBox5,

                Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("a_assets/logo/success_img.svg")
                ),
                hSizedBox4,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.amount,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),
                      ),
                    ),
                    wSizedBox,
                    Container(
                      padding: EdgeInsets.only(bottom: 3),
                      alignment: Alignment.center,
                      child: Text(
                        MyString.usd,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
                      ),
                    ),

                  ],
                ),

                hSizedBox4,

                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.sheduled_successfully,
                    style: TextStyle(
                        color: MyColors.greenColor2,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                  ),
                ),

                hSizedBox2,

                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "We will send SMS to Recipient Phone Number **${u_phone_number} with Transfer update, and you can track progress from history page",
                    // MyString.sheduled_successfully_des,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.80),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                  ),
                ),
                hSizedBox2,

                GestureDetector(
                  onTap: (){
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        DashboardScreen()), (Route<dynamic> route) => false);
                    setState(() {

                    });
                  },
                  child: Container(
                    width: 250,
                    child: CustomButton2(btnname: MyString.back_to_home,bordercolor: MyColors.lightblueColor,bg_color: MyColors.lightblueColor,),
                  ),
                ),

                hSizedBox2,
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => TransferSheduledScreen()));
                  },
                  child: Container(
                    width: 250,
                    child: CustomButton(btnname: MyString.go_to_sheduled_transfer,bordercolor: MyColors.lightblueColor,bg_color: MyColors.lightblueColor,textcolor:MyColors.lightblueColor,fontsize: 16 ,),
                  ),
                ),

                hSizedBox3
              ],
            ),
          ),
        ),
      ),
    );
  }
}
