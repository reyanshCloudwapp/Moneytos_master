import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/loginscreen2.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constance/customLoader/customLoader.dart';
import '../../model/usermodel.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';
import '../../services/webservices.dart';
import 'dart:convert' as convert;

import 'LoginVerificatrionDetailScreen.dart';

class LoginOtpVerifyScreen extends StatefulWidget{

  String MobileNumber;
  String CountryCode;
  String Password;
  String devicetype;
  String deviceId;
  String fcm_token;
  String ipaddress;
  LoginOtpVerifyScreen(this.MobileNumber,this.CountryCode,this.Password,this.devicetype,this.deviceId,this.fcm_token,this.ipaddress);

  @override
  State<LoginOtpVerifyScreen> createState() => _LoginOtpVerifyScreenState();
}

class _LoginOtpVerifyScreenState extends State<LoginOtpVerifyScreen> {
  String otp = "";
  final formKey = GlobalKey<FormState>();
  final _otpFocus = FocusNode();
  @override
  void initState() {
    super.initState();


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [
        KeyboardActionsItem(
            focusNode: _otpFocus,
            onTapAction: () async {
              FocusManager.instance.primaryFocus?.unfocus();

              // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));
            }),
      ],
    );
  }

  @override
    Widget build(BuildContext context) {
      var size = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(190),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.light_primarycolor2,
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.color_03153B,

              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("s_asset/images/bgimage.png",),
                    fit: BoxFit.cover
                ),
              ),
              child: Column(
                children: [

                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 20,left: 20),
                    child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("a_assets/icons/arrow_back.svg")
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(top: 50.0,left: 0.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset('a_assets/images/logo.svg',fit: BoxFit.cover,))),
                ],
              ),
            ),
          ),
        ),
        body: KeyboardActions(
          autoScroll: false,
          config: _buildKeyboardActionsConfig(context),
          child: Stack(
            children: [
              Container(
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  //color: MyColors.primaryColor,
                    image: DecorationImage(
                        image: AssetImage("s_asset/images/bgimage.png",),
                        fit: BoxFit.cover
                    )
                ),
              ),
              // Image.asset('assets/images/map.png',fit: BoxFit.cover,),

              Container(

                // color: MyColors.whiteColor,
                margin: EdgeInsets.only(top: 20.0),
                height: size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  color:MyColors.whiteColor ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 50.0,left: 20.0,right: 20.0),
                    child: SingleChildScrollView(
                      child: Column(


                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Align(
                              alignment: Alignment.center,
                              child: Text("Verify",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w600,color: MyColors.blackColor,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)),

                          Padding(
                            padding:  EdgeInsets.only(top:22.0),
                            child:
                            Align(
                                alignment: Alignment.center,
                                child: Text("Please enter the verification code\n sent to your phone number",textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: MyColors.blackColor.withOpacity(0.70),fontFamily: "s_asset/font/raleway/raleway_bold.ttf",),)),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(top:40.0,left: 20.0,right: 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                // OtpTextField(
                                //   numberOfFields: 4,
                                //   fieldWidth: 60.0,
                                //   disabledBorderColor:Colors.white,
                                //   cursorColor: MyColors.whiteColor,
                                //   textStyle: TextStyle(color: MyColors.blackColor,fontSize: 26,fontWeight: FontWeight.w500),
                                //   borderColor: Colors.white,
                                //   focusedBorderColor: MyColors.lightblueColor,
                                //  // styles: otpTextStyles,
                                //   showFieldAsBox: true,
                                //   borderRadius: BorderRadius.all(Radius.circular(14)),
                                //   borderWidth: 1.0,
                                //
                                //   //runs when a code is typed in
                                //   onCodeChanged: (String code) {
                                //     setState(() {
                                //       otp = code.toString();
                                //     });
                                //     //handle validation or checks here if necessary
                                //   },
                                //   //runs when every textfield is filled
                                //   onSubmit: (String verificationCode) {
                                //     setState(() {
                                //       otp = verificationCode.toString();
                                //     });
                                //   },
                                // ),

                                Form(
                                  key: formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 15),
                                    child: PinCodeTextField(
                                      focusNode: _otpFocus,
                                      appContext: context,
                                      pastedTextStyle: TextStyle(
                                        color: Colors.green.shade600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      length: 4,
                                      obscureText: false,
                                      obscuringCharacter: '*',
                                      blinkWhenObscuring: true,
                                      animationType: AnimationType.fade,
                                      validator: (v) {

                                      },
                                      pinTheme: PinTheme(
                                        activeColor: MyColors.light_primarycolor2,
                                        selectedFillColor: MyColors.whiteColor,
                                        selectedColor: MyColors.light_primarycolor2,

                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(5),
                                        fieldHeight: 50,
                                        fieldWidth: 50,
                                        activeFillColor: Colors.white,
                                        inactiveColor: Colors.white,
                                        inactiveFillColor: Colors.white,
                                      ),
                                      cursorColor: MyColors.light_primarycolor2,
                                      animationDuration: const Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      // errorAnimationController: errorController,
                                      // controller: textEditingController,
                                      keyboardType: TextInputType.number,
                                      boxShadows: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        )
                                      ],
                                      onCompleted: (v) {
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          print("current Text???${value}");
                                          otp = value;
                                        });
                                      },
                                      beforeTextPaste: (text) {
                                        return true;
                                      },
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding:  EdgeInsets.only(top:30,left: 18.0,right: 18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                     //  InkWell(
                                     // // resendOtp(context,countryCodeget,mobileNumber);
                                     //
                                     //      child: Text("Expired after "+secondsRemaining.toString()+"s",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: MyColors.blackColor),)),
                                      InkWell(
                                        onTap: (){
                                          resendOTP(context);
                                        },

                                          child: Text("Resend", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: MyColors.lightblueColor,),)),
                                    ],
                                  ),
                                ),


                             Padding(
                                  padding:  EdgeInsets.only(top:80.0),
                                  child: Align(

                                    alignment: Alignment.center,
                                    child:   ElevatedButton(
                                      child: Text('Submit'),
                                      onPressed: () {

                                        if(otp.length < 4){
                                          // Fluttertoast.showToast(msg: "Please enter valid otp");
                                          Utility.dialogError(context, "Please enter valid otp");
                                        }else {
                                          OTPVerifyRequest(context);
                                        }


                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: MyColors.lightblueColor,
                                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 17),

                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(16.0))
                                          ),
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),

      );
    }

  Future<void> resendOTP(BuildContext context,) async {
    CustomLoader.ProgressloadingDialog(context, true);
    print("Countrycode...${widget.CountryCode.replaceAll("+", "")}");
    SharedPreferences p = await SharedPreferences.getInstance();
    var token = p.getString("token");
    var request = {};
    request['mobile_number'] = widget.MobileNumber;
    request['country_code'] = widget.CountryCode.replaceAll("+", "");
    request['password'] = widget.Password;
    request['timezone'] = "Asia/Kolkata";
    request['device_type'] = widget.devicetype;
    request['device_id'] = widget.deviceId;
    request['fcm_token'] = widget.fcm_token;
    request['client_ip'] = widget.ipaddress;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Apiservices.sendLoginOtp),
        body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": "e0271afd8a3b8257af70deacee4",
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
    if (jsonResponse['status'] == true) {
      print("dfhdfjhdf");
      CustomLoader.ProgressloadingDialog(context, false);
      Utility.showFlutterToast( jsonResponse['message']);
    } else {
      CustomLoader.ProgressloadingDialog(context, false);
      Utility.dialogError(context, jsonResponse['message']);
    }
    return;
  }
  Future<void> OTPVerifyRequest(BuildContext context
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var token = p.getString("token");

    var request = {};

    request['mobile_number'] = widget.MobileNumber;
    request['country_code'] = widget.CountryCode.replaceAll("+", "");
    request['password'] = widget.Password;
    request['timezone'] = "Asia/Kolkata";
    request['device_type'] = widget.devicetype;
    request['device_id'] = widget.deviceId;
    request['fcm_token'] = widget.fcm_token;
    request['client_ip'] = widget.ipaddress;
    request['otp'] = otp;


    // otpo
    // print("request ${request}");
    // print("request url ${Apiservices.login}");
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Apiservices.login),
        body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": "e0271afd8a3b8257af70deacee4",
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
    if (jsonResponse['status'] == true) {
      print("dfhdfjhdf");
      var userdata = jsonResponse['data'];
      print("userdata ${userdata}");
      var users = userdata['userData'];
      print("user....${users['auth_token']}");
      UserDataModel authuser = UserDataModel.fromJson(users);
      print("authuser...${authuser}");
      print("user... ${authuser.id}");
      print("user... ${authuser.authToken}");
      p.setBool("login", true);
      p.setString("auth", authuser.authToken.toString());
      p.setString("userid", authuser.id.toString());
      p.setString("mobileVerify", authuser.mobileVerify.toString());
      p.setString("emailVerified", authuser.emailVerified.toString());
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      // p.getString("emailVerified") == "1" ?
      CustomLoader.ProgressloadingDialog(context, false);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
      // if(authuser.stepsecstatus=="1"){
      //   Navigator.of(context, rootNavigator: true)
      //       .pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (BuildContext context) {
      //         return  DashboardScreen();
      //       },
      //     ),
      //         (_) => false,
      //   );
      // }else{
      //   Navigator.of(context, rootNavigator: true)
      //       .pushAndRemoveUntil(
      //     MaterialPageRoute(
      //       builder: (BuildContext context) {
      //         return  LoginVerificatrionDetailScreen();
      //       },
      //     ),
      //         (_) => false,
      //   );
      // }

      Navigator.of(context, rootNavigator: true)
          .pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return  DashboardScreen();
          },
        ),
            (_) => false,
      );


    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      CustomLoader.ProgressloadingDialog(context, false);
      Utility.dialogError(context, jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

}