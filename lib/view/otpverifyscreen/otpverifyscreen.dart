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
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';
import '../../services/webservices.dart';
import 'dart:convert' as convert;

class OtpVerifyScreen extends StatefulWidget{
  String fullname;
  String lastname;
  String pass;
  String email;
  String mobileno;
  String countrycode;
  String country;
  String city;
  String referralCode;


  OtpVerifyScreen(this.fullname,this.lastname, this.pass,this.email,this.mobileno,this.countrycode,this.country,this.city,this.referralCode);

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {



bool load = false;
String otp = "";
  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;

  String messageTitle = "Empty";
  String notificationAlert = "alert";
  String fcmtoken = "123456";
final formKey = GlobalKey<FormState>();
final _otpFocus = FocusNode();
//  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //FlutterLocalNotificationsPlugin? fltNotification;

  /*void pushFCMtoken() async {
    String? token= await messaging.getToken();
    fcmtoken = token.toString();
    print("fcmtoken>>>>"+fcmtoken.toString());
//you will get token here in the console
  }
*/
  String devicetype = "web";
  String? deviceId ="";
  Future<String?> _getdevicetype() async{
    if (Platform.isIOS) {
      devicetype = "ios";
      setState(() {

      });
      print('is a ios');
    } else if (Platform.isAndroid) {
      devicetype = "android";
      print('is a Andriod}');
      setState(() {

      });
      print("type ${devicetype}");
    } else {
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid){
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    } else {
      var web = await deviceInfo.webBrowserInfo;
      print("webbbbb${web.appCodeName}");
      return web.appCodeName;
      // unique ID on Android
    }
  }

  _getdevicetocken() async{
    deviceId = await _getId();
    print("devuce${deviceId}");

  }


  void FCMTOKEN() async {

    setState(() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      fcmtoken = preferences.getString("fcmtoken").toString();

    });

//you will get token here in the console
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
  void initState() {
    super.initState();

    FCMTOKEN();
    _getdevicetocken();
    print("devicetocken ${deviceId}");
    _getdevicetype();
    // starttimer();

    setState(() {

    });
  }

  verifynumbernumber() async{
    setState(() {
      load = true;
    });
    await Webservices.verifyOtpWithRegister(context, widget.mobileno, widget.countrycode, otp, widget.fullname, widget.lastname, widget.email, widget.pass, widget.country, widget.city, devicetype, deviceId.toString(), fcmtoken,widget.referralCode);

    setState(() {
      load = false;
    });

  }

  void starttimer(){
    timer = Timer.periodic(Duration(seconds: 1,), (_) {
      if (secondsRemaining != 0) {
        setState(() {

          secondsRemaining--;
          print('seconRemainnig---->>>'+secondsRemaining.toString());

        });
      } else {


        setState(() {
          print('Cancel Timing>>><<<<<<<<'+secondsRemaining.toString());
          enableResend = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
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
                                          _resendCode();
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
                                         verifynumbernumber();
                                       }
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));

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

  void _resendCode() {
    //other code here
    setState((){
      // secondsRemaining = 30;
      // enableResend = false;
      // timer.cancel();
      // starttimer();
      ResendOtp(context);
    });
  }

  Future<void> ResendOtp(BuildContext context
      // String device_type,
      // String device_id,String fcm_token
      ) async {
    //  SharedPreferences p = await SharedPreferences.getInstance();
    // var token = p.getString("token");
    // String email
    CustomLoader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = widget.mobileno;
    request['country_code'] = widget.countrycode.replaceAll("+", "");

    // otpo
    print("request ${request}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Apiservices.submitContactNumber),
        body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": "e0271afd8a3b8257af70deacee4",
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
    CustomLoader.ProgressloadingDialog(context, false);
    if (jsonResponse['status'] == true) {
      Utility.showFlutterToast( jsonResponse['message']);
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.dialogError(context, jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }
}