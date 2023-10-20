import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/customHomecardui.dart';
import 'package:moneytos/view/dash_settingscreen/setting_forgot_pin/setting_forgot_pinCode_screen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/sheduled_successfully_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constance/customLoader/customLoader.dart';
import '../../model/customlists/customLists.dart';
import '../../s_Api/AllApi/ApiService.dart';
import 'dart:convert' as convert;

import '../../s_Api/s_utils/Utility.dart';

class TransferPinCodeScreen extends StatefulWidget {
  Function Oncallback;
  TransferPinCodeScreen({Key? key, required this.Oncallback}) : super(key: key);

  @override
  _TransferPinCodeScreenState createState() => _TransferPinCodeScreenState();
}

class _TransferPinCodeScreenState extends State<TransferPinCodeScreen> {
  /// create number list
  List<int> firstlist = [1, 2, 3];
  List<int> secondlist = [4, 5, 6];
  List<int> thirdlist = [7, 8, 9];

  int pinlength = 4;
  String pinEntered ="";
  String workingpin = "1234";
  String alert = "";
  bool isforgot = false;


  numberClicked(int item){


    if(pinEntered.length < pinlength){
      pinEntered = pinEntered + item.toString();
      print("object${pinEntered}");
      print("jbbjfdj");
      if(pinEntered.length == pinlength){
        chkpinRequest(context,pinEntered);

      }
      // alert =(pinEntered == workingpin) ? "Good luck" : "Incorrect please try again";
    }
    setState(() {});
  }
  // numberClicked(int item){
  //   pinEntered = pinEntered + item.toString();
  //   print("object${pinEntered}");
  //   if(pinEntered.length == pinlength){
  //     chkpinRequest(context,pinEntered);
  //
  //   }
  //   setState(() {});
  // }

  backSpace(){
    if(pinEntered.isNotEmpty){
      pinEntered = pinEntered.substring(0,pinEntered.length -1);
      alert = "";
      print("pinentered..${pinEntered}");
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
     // color: MyColors.whiteColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox2,

            /// Setup New Pin Code
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: const Text(
                MyString.enetr_pin_code,
                style: TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
              ),
            ),

            /// please enter your pin

            hSizedBox1,
            Container(
              width: size.width*0.7,
              // padding: EdgeInsets.only(left: 30,right: 30),
              alignment: Alignment.center,
              child: Text(
                MyString.please_enter_your_pin_code_to_proceed_transaction,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.20),
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),

            hSizedBox4,
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.circle_fill,
                    color: pinEntered.isNotEmpty?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                    size: 9,
                  ),
                  wSizedBox1,
                  Icon(
                    CupertinoIcons.circle_fill,
                    color:pinEntered.length >= 2 ?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                    size: 9,
                  ),
                  wSizedBox1,
                  Icon(
                    CupertinoIcons.circle_fill,
                    color:pinEntered.length >= 3?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                    size: 9,
                  ),
                  wSizedBox1,
                  Icon(
                    CupertinoIcons.circle_fill,
                    color: pinEntered.length >= 4?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                    size: 9,
                  ),
                  // wSizedBox1,
                  // Icon(
                  //   CupertinoIcons.circle_fill,
                  //   color:pinEntered.length >= 5?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                  //   size: 9,
                  // ),
                  // wSizedBox1,
                  // Icon(
                  //   CupertinoIcons.circle_fill,
                  //   color:pinEntered.length == 6?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                  //   size: 9,
                  // ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: Text(alert,style: TextStyle(color: (pinEntered == workingpin)? MyColors.greenColor:MyColors.red,fontSize: 13),),
            ),

            /// number ui

            hSizedBox3,
            //numberButton(1),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: firstlist.map((e) {
                  return Container(
                     // padding: EdgeInsets.symmetric( vertical: 10),
                      child: numberButton(e));
                }).toList(),
              ),
            ),

            hSizedBox3,

            /// number button2
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: secondlist.map((e) {
                return Container(
                 //   padding: EdgeInsets.symmetric( vertical: 10),
                    child: numberButton(e));
              }).toList(),
            ),

            hSizedBox3,

            /// number button3
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: thirdlist.map((e) {
                return Container(
                  //  padding: EdgeInsets.symmetric( vertical: 15),
                    child: numberButton(e));
              }).toList(),
            ),

            hSizedBox3,

            /// number button4
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only( top: 15),
                    child: InkWell(
                      onTap: () {
                        backSpace();
                      },
                      child: Container(
                        width: 50,
                        alignment: Alignment.topLeft,
                        child: SvgPicture.asset(
                          "a_assets/icons/close_square.svg",
                          height: 25,
                          width: 25,
                        ),
                      ),
                      //Icon(CupertinoIcons.clear_fill,color: MyColors.blackColor,)
                    ),
                  ),

                  Padding(padding: const EdgeInsets.only( top: 15),child:Container(
                    width: 50,
                    child:  numberButton(0),
                  )),

                  //    (pinEntered != workingpin && pinEntered.length == pinlength) ?

                  isforgot == true?
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){

                      pushNewScreen(
                        context,
                        screen: const SettingForgotPinCodeScreen(),
                        withNavBar: false,
                      );

                    },
                    child: Container(
                      // height: 20,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only( top: 22),
                      child: const Text("Forgot!",style: TextStyle(color: MyColors.lightblueColor,fontSize: 12,fontWeight: FontWeight.w500),),
                    ),
                  )
                      : Container(width: 50,)
                ]
            ),
            hSizedBox4,

            Visibility(
              visible: alert=="Incorrect please try again"?true:false,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  // Navigator.pop(context);
                  // pushNewScreen(
                  //   context,
                  //   screen: SheduledSuccessfullyScreen(),
                  //   withNavBar: false,
                  // );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            MyColors.red.withOpacity(0.50),
                            MyColors.red.withOpacity(0.90),
                          ]
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SvgPicture.asset("a_assets/icons/exclametary_icon.svg"),
                      wSizedBox1,
                      Container(
                        child: const Text("the pin you entered is wrong",style: TextStyle(color: MyColors.whiteColor,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontSize: 14,fontWeight: FontWeight.w600),),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //(pinEntered != workingpin && pinEntered.length == pinlength) ?
           // Container():
            /*GestureDetector(
              onTap: (){
                isforgot = true;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton2(btnname:MyString.submit,bg_color: MyColors.lightblueColor,bordercolor: MyColors.lightblueColor,),
              ),
            ),*/
            hSizedBox4,
          ],
        ),
      ),
    );
  }

  numberButton(int item) {
    alert = "";
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          numberClicked(item);
        },
        child: Container(
          alignment: Alignment.topCenter,
          width: 80,
          height: 50,
          child: Text(
            item.toString(),
            style: const TextStyle(
                color: MyColors.blackColor,
                fontWeight: FontWeight.w800,
                fontSize: 20,
                fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),
          ),
        ),
      ),
    );
  }
  Future<void> chkpinRequest(BuildContext context,String chk_pin
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['pin'] = chk_pin;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.chkpinURL),
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
      // Fluttertoast.showToast(msg: jsonResponse["message"]);
      CustomLoader.ProgressloadingDialog(context, false);
      // confirfationDialog(context);
      alert ="Good luck";
      Navigator.pop(context);
      this.widget.Oncallback();

    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
      alert ="Incorrect please try again";
      pinEntered = "";
    }
    setState(() { });
    return;
  }
}
