import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/createaccount/createaccountscreen.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/loginscreen/loginscreen.dart';
import 'package:moneytos/view/resetpasswordscreen/resetpasswordscreen.dart';
import 'package:moneytos/view/select_bank/selectBank_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constance/customLoader/customLoader.dart';
import 'otpverifyscreen/LoginOtpVerifyScreen.dart';

class LoginScreen2 extends StatefulWidget{

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  String ipaddress = "";

  String fcm_token="123456";

  bool _isObscure = true;
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();


  FocusNode pass_focus = FocusNode();
  FocusNode email_focus = FocusNode();
  FocusNode mobilefocus = FocusNode();

  String slectedcountrCode="+1";
  bool is_phoneborder = false;

  bool load = false;
  bool showpass = false;
  bool ispass = false;
  bool isfocuspass = false;
  bool ismobileerror = false;
  bool ispasserror = false;
  String passerror = "";
  String mobileerror = "";


  Color mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);



  Color emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  Color passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

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


  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [

        KeyboardActionsItem(
            focusNode: mobilefocus,
            onTapAction: (){
              ispasserror = false;
              mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
              mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
              passbordercolor = MyColors.lightblueColor;
              passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
              setState(() {});
            }

        ),
      ],
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pass_focus.unfocus();
    mobilefocus.unfocus();
  }
  logindata() async{
    setState(() {
      load = true;
    });
    await Webservices.loginRequest(context, mobileNumberController.text,slectedcountrCode.toString(), passController.text, devicetype, deviceId.toString(),fcm_token,ipaddress);
    setState(() {
      load = false;
    });

    // Navigator.of(context, rootNavigator: true)
    //     .pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return  LoginOtpVerifyScreen();
    //     },
    //   ),
    //       (_) => false,
    // );
  }
  Future printIps() async {
    // for (var interface in await NetworkInterface.list()) {
    //   print('== Interface: ${interface.name} ==');
    //   for (var addr in interface.addresses) {
    //     print(
    //         '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
    //     ipaddress = interface.addresses.first.address;
    //     setState(() {});
    //   }
    // }


    final ipv4 = await Ipify.ipv4();
    print("ipv4>>>>>> "+ipv4); // 98.207.254.136

    final ipv6 = await Ipify.ipv64();
    print("ipv6>>>>>> "+ipv6); // 98.207.254.136 or 2a00:1450:400f:80d::200e

    final ipv4json = await Ipify.ipv64(format: Format.JSON);
    print("ipv4json>>>>>> "+ipv4json); //{"ip
    ipaddress = ipv4.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this.printIps();
    });
    FCMTOKEN();
    _getdevicetocken();
    print("devicetocken ${deviceId}");
    _getdevicetype();
  }
  void FCMTOKEN() async {

    setState(() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      fcm_token = preferences.getString("fcmtoken").toString();

    });

//you will get token here in the console
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
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
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MyColors.color_03153B,
              image: DecorationImage(
                  image: AssetImage("s_asset/images/bgimage.png",),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
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
            /*  Container(
             height: 200,
             decoration: BoxDecoration(
               color: MyColors.primaryColor,
             ),
           ),
           Image.asset('assets/images/map.png',fit: BoxFit.cover,),*/
            /* Container(
                margin: EdgeInsets.only(top: 50.0,left: 0.0),
                child: Align(
                  alignment: Alignment.center,
                    child: SvgPicture.asset('a_assets/images/logo.svg',fit: BoxFit.cover,))),*/

            Container(

              // color: MyColors.whiteColor,
              margin: EdgeInsets.only(top: 5.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Material(
                color:MyColors.whiteColor ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 40.0,left: 20.0,right: 20.0),
                  child: SingleChildScrollView(
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text("Welcome Back",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500,color: MyColors.blackColor),)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            hSizedBox2,

                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: mobilefillcolor,
                                      //is_phoneborder == true? MyColors.whiteColor : MyColors.lightblueColor.withOpacity(0.03),
                                      border:  Border.all(color: mobilebordercolor,
                                        //is_phoneborder == true? MyColors.lightblueColor.withOpacity(0.90): MyColors.lightblueColor.withOpacity(0.03),
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  margin:  EdgeInsets.fromLTRB(20.0, 42.0, 16.0, 0.0),
                                  child: Row(
                                    children: [

                                      CountryCodePicker(

                                        onChanged: _onCountryChange,
                                        // enabled: false,

                                        initialSelection: 'CA',
                                        // favorite: ['+91','IN'],
                                        showCountryOnly: false,
                                        textStyle: TextStyle(color: MyColors.primaryColor,fontWeight: FontWeight.w300),
                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: false,
                                        showFlag: false,

                                      ),
                                      Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.centerLeft,
                                        width: 200,
                                        child: TextField(
                                          controller: mobileNumberController,
                                          maxLength: 10,
                                          focusNode: mobilefocus,
                                          // keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                                          // inputFormatters: [
                                          //   LengthLimitingTextInputFormatter(10),
                                          // ],
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          textInputAction: TextInputAction.next,
                                          onTap: (){
                                            ispasserror = false;
                                            mobilebordercolor = MyColors.lightblueColor;
                                            mobilefillcolor = MyColors.whiteColor;

                                            passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                            passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                            setState(() {
                                            });
                                          },
                                          style: TextStyle(

                                              color:MyColors.blackColor,
                                              fontSize: 12,
                                              fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                                          ),
                                          decoration: InputDecoration(
                                              hintText: 'Phone Number',
                                              border: InputBorder.none,
                                              fillColor: MyColors.whiteColor,
                                              contentPadding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 12),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            counterText: ''
                                            //border: InputBorder.none,

                                          ),
                                          // maxLength: 10,



                                          // Only numbers can be entered
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                ismobileerror == true ?  Container(
                                  margin:  EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                                  alignment: Alignment.topLeft,
                                  child: Text(mobileerror,style: TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                                    : Container()

                              ],
                            ),
                            /*Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: emailfillcolor,
                                  border: Border.all(color: emailbordercolor,width: 1),
                                  borderRadius: BorderRadius.circular(8)),
                              margin:  EdgeInsets.fromLTRB(20.0, 32.0, 16.0, 0.0),

                              child: TextField(
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                onTap: (){
                                  ispasserror = false;
                                  emailbordercolor = MyColors.lightblueColor;
                                  emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                  passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                  passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                },
                                style: TextStyle(
                                    color:MyColors.blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "a_assets/font/poppins_regular.ttf"

                                ),


                                decoration: InputDecoration(
                                    hintText: 'Full Name',
                                    border: InputBorder.none,
                                    fillColor: MyColors.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),

                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                ),



                                keyboardType: TextInputType.emailAddress,

                                // Only numbers can be entered
                              ),
                            ),*/

                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: passfillcolor,
                                      border: Border.all(color: passbordercolor,width: 1),
                                      borderRadius: BorderRadius.circular(15)),
                                  width: MediaQuery.of(context).size.width,
                                  margin:  EdgeInsets.fromLTRB(20.0, 26.0, 16.0, 0.0),

                                  child: TextField(
                                    controller: passController,
                                    obscureText: _isObscure,
                                    textInputAction: TextInputAction.done,
                                    onTap: (){
                                      ispasserror = false;
                                      mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      passbordercolor = MyColors.lightblueColor;
                                      passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      setState(() {});
                                    },
                                    style: TextStyle(
                                        color:MyColors.blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "a_assets/font/poppins_regular.ttf"

                                    ),

                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure ? Icons.visibility_off : Icons.visibility,color: ispasserror == true ? MyColors.red : MyColors.greycolor,),
                                          onPressed: () {
                                            setState(() {
                                              print(
                                                  "_isObscure >>>>>>>>>>" + _isObscure.toString());
                                              _isObscure = !_isObscure;

                                            });
                                          }),
                                      hintText: 'Password',
                                      border: InputBorder.none,
                                      fillColor: MyColors.whiteColor,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 15),



                                      enabledBorder: OutlineInputBorder(


                                        borderSide: BorderSide(width: 1, color:MyColors.color_FAFAFC),
                                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                                      ),
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                    ),

                                    keyboardType: TextInputType.text,

                                    // Only numbers can be entered
                                  ),
                                ),
                                ispasserror == true ?  Container(
                                  margin:  EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                                  alignment: Alignment.topLeft,
                                  child: Text(passerror,style: TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                                    : Container()
                                /*   new FlutterPwValidator(
                                    controller: passController,
                                    minLength: 6,
                                    uppercaseCharCount: 2,
                                    numericCharCount: 3,
                                    specialCharCount: 1,
                                    width: 400,
                                    height: 150,
                                  onSuccess: () {
                                    print("MATCHED");
                                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                        content: new Text("Password is matched")));
                                  },
                                  onFail: () {
                                    print("NOT MATCHED");
                                  },
                                )*/
                              ],
                            ),

                            Padding(
                              padding:  EdgeInsets.only(right: 18.0,top: 16.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));

                                      },
                                      child: Text("Forgot Password !",style: TextStyle(color: MyColors.color_3F84E5,fontSize:14,fontWeight: FontWeight.w400,fontFamily: "a_assets/font/poppins_regular.ttf" ),))),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(top:60.0),
                              child: Align(

                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  child: Text('Log in'),
                                  onPressed: () {
                                    pass_focus.unfocus();
                                    mobilefocus.unfocus();
                                    RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    //  RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    var passNonNullValue=passController.text??"";
                                    setState(() {});
                                    if (mobileNumberController.text.isEmpty ) {
                                      mobileNumberController.text.isEmpty ?   mobilebordercolor = MyColors.red :  mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      mobileNumberController.text.isEmpty ?   mobilefillcolor = MyColors.red.withOpacity(0.03) : mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      // passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      // passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      // fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
                                      //   passController.text.isEmpty ?   ispasserror = true  : ispasserror =false;
                                      mobileNumberController.text.isEmpty ?   ismobileerror = true  : ismobileerror =false;
                                      mobileNumberController.text.isEmpty ?   mobileerror = "Please enter phone number*" : mobileerror ="";
                                      // passController.text.isEmpty ?   passerror = "Please enter password*" : passerror = "";
                                      setState(() {});
                                      // Fluttertoast.showToast(msg: "Please Enter Your FullName");
                                    }

                                    else if(mobileNumberController.text.length < 10){
                                      mobilebordercolor = MyColors.red ;
                                      mobilefillcolor = MyColors.red.withOpacity(0.03);
                                      ismobileerror = true;
                                      mobileerror = "Please enter valid phone number*";
                                      setState(() {});
                                    }

                                    else if(passController.text.isEmpty ){
                                      mobileNumberController.text.isEmpty ?   mobilebordercolor = MyColors.red :  mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      mobileNumberController.text.isEmpty ?   mobilefillcolor = MyColors.red.withOpacity(0.03) : mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      // fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
                                      passController.text.isEmpty ?   ispasserror = true  : ispasserror =false;
                                      passController.text.isEmpty ?   passerror = "Please enter password*" : passerror = "";

                                      mobileNumberController.text.isEmpty ?   ismobileerror = true  : ismobileerror =false;
                                      mobileNumberController.text.isEmpty ?   mobileerror = "Please enter phone number*" : mobileerror ="";
                                      setState(() {});
                                      // Fluttertoast.showToast(msg: "Please Enter Your FullName");
                                    }
                                    else {
                                      passbordercolor = MyColors.lightblueColor.withOpacity(0.03) ;
                                      passfillcolor = MyColors.lightblueColor.withOpacity(0.03) ;
                                      mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03) ;
                                      mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03) ;
                                      ismobileerror =false;
                                      ispasserror = false;
                                      mobileerror = "";
                                      passerror ="";
                                      setState(() {});
                                      logindata();
                                    }

                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: MyColors.lightblueColor,
                                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),

                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(13.0))
                                      ),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "s_asset/font/maven/mavenpro_bold.ttf",
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 80,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text("Not Registered yet?",style: TextStyle(color: MyColors.color_text,fontSize:14,fontWeight: FontWeight.w400,fontFamily: "a_assets/font/poppins_regular.ttf" ),)),

                            Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreenPage()));

                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.bottomCenter,
                                        //  stops: [0.0, 1.0],
                                        colors: [
                                          MyColors.lightblueColor.withOpacity(0.10),
                                          MyColors.lightblueColor.withOpacity(0.36),
                                        ],
                                      ),
                                      //color: Colors.deepPurple.shade300,
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    padding:  EdgeInsets.only(left: 25, right: 25, bottom: 15,top: 15),
                                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 25,top: 24),
                                    child: Text("Create an Account",style: TextStyle(color: MyColors.color_3F84E5,fontSize:16,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

           /* load == true ? Container(
                color: MyColors.primaryColor.withOpacity(0.50),
                child: Center(
                  child: CustomLoader.gfloader()
                )) :Container()*/


          ],
        ),
      ),

    );
  }

  Future<void> _onCountryChange(CountryCode countryCode ) async {
    //TODO : manipulate the selected country code here
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    slectedcountrCode=countryCode.toString();
    print("New Country selected:>>>>" + slectedcountrCode);
    print("Country ISO code :>>>>" + countryCode.code.toString());
    print("Country name code :>>>>" + countryCode.name.toString());
    print("Country dialCode code :>>>>" + countryCode.dialCode.toString());
    sharedPreferences.setString('CountryISOCode',countryCode.code.toString());
    setState(() {});

  }
}



/*
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/createaccount/createaccountscreen.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/loginscreen/loginscreen.dart';
import 'package:moneytos/view/resetpasswordscreen/resetpasswordscreen.dart';
import 'package:moneytos/view/select_bank/SelectBankScreen2BankDeposit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen2 extends StatefulWidget{

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {

  bool _isObscure = true;
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();


  FocusNode pass_focus = FocusNode();
  FocusNode email_focus = FocusNode();
  FocusNode mobilefocus = FocusNode();

  String slectedcountrCode="+972";
  bool is_phoneborder = false;

  bool load = false;
  bool showpass = false;
  bool ispass = false;
  bool isfocuspass = false;
  bool ismobileerror = false;
  bool ispasserror = false;
  String passerror = "";
  String mobileerror = "";


  Color mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);



  Color emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  Color passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

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


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pass_focus.unfocus();
    mobilefocus.unfocus();
  }
  logindata() async{
    setState(() {
      load = true;
    });
    await Webservices.loginRequest(context, mobileNumberController.text,slectedcountrCode.toString(), passController.text, devicetype, deviceId.toString());

    setState(() {
      load = false;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getdevicetocken();
    print("devicetocken ${deviceId}");
    _getdevicetype();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
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
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MyColors.color_03153B,
              image: DecorationImage(
                  image: AssetImage("s_asset/images/bgimage.png",),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
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
      body: Stack(
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
          */
/*  Container(
           height: 200,
           decoration: BoxDecoration(
             color: MyColors.primaryColor,
           ),
         ),
         Image.asset('assets/images/map.png',fit: BoxFit.cover,),*//*

         */
/* Container(
              margin: EdgeInsets.only(top: 50.0,left: 0.0),
              child: Align(
                alignment: Alignment.center,
                  child: SvgPicture.asset('a_assets/images/logo.svg',fit: BoxFit.cover,))),*//*


          Container(

            // color: MyColors.whiteColor,
            margin: EdgeInsets.only(top: 5.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Material(
              color:MyColors.whiteColor ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 40.0,left: 20.0,right: 20.0),
                child: SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text("Welcome Back",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500,color: MyColors.blackColor),)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          hSizedBox2,

                          Column(
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: mobilefillcolor,
                                    //is_phoneborder == true? MyColors.whiteColor : MyColors.lightblueColor.withOpacity(0.03),
                                    border:  Border.all(color: mobilebordercolor,
                                      //is_phoneborder == true? MyColors.lightblueColor.withOpacity(0.90): MyColors.lightblueColor.withOpacity(0.03),
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                margin:  EdgeInsets.fromLTRB(20.0, 42.0, 16.0, 0.0),
                                child: Row(
                                  children: [

                                    CountryCodePicker(

                                      onChanged: _onCountryChange,
                                      // enabled: false,

                                      initialSelection: 'IN',
                                      // favorite: ['+91','IN'],
                                      showCountryOnly: false,
                                      textStyle: TextStyle(color: MyColors.primaryColor,fontWeight: FontWeight.w300),
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: false,
                                      showFlag: false,

                                    ),
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.centerLeft,
                                      width: 200,
                                      child: TextField(
                                        controller: mobileNumberController,
                                        focusNode: mobilefocus,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        textInputAction: TextInputAction.next,
                                        onTap: (){
                                          ispasserror = false;
                                          mobilebordercolor = MyColors.lightblueColor;
                                          mobilefillcolor = MyColors.whiteColor;

                                          passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                          passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                          setState(() {
                                          });
                                        },
                                        style: TextStyle(

                                            color:MyColors.blackColor,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                                        ),
                                        decoration: InputDecoration(
                                            hintText: 'Phone Number',
                                            border: InputBorder.none,
                                            fillColor: MyColors.whiteColor,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 22.0,vertical: 12),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none
                                          //border: InputBorder.none,

                                        ),
                                        // maxLength: 10,



                                        // Only numbers can be entered
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ismobileerror == true ?  Container(
                                margin:  EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                                alignment: Alignment.topLeft,
                                child: Text(mobileerror,style: TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                                  : Container()

                            ],
                          ),
                          */
/*Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: emailfillcolor,
                                border: Border.all(color: emailbordercolor,width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            margin:  EdgeInsets.fromLTRB(20.0, 32.0, 16.0, 0.0),

                            child: TextField(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              onTap: (){
                                ispasserror = false;
                                emailbordercolor = MyColors.lightblueColor;
                                emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                              },
                              style: TextStyle(
                                  color:MyColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "a_assets/font/poppins_regular.ttf"

                              ),


                              decoration: InputDecoration(
                                  hintText: 'Full Name',
                                  border: InputBorder.none,
                                  fillColor: MyColors.whiteColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),

                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),



                              keyboardType: TextInputType.emailAddress,

                              // Only numbers can be entered
                            ),
                          ),*//*


                          Column(
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: passfillcolor,
                                    border: Border.all(color: passbordercolor,width: 1),
                                    borderRadius: BorderRadius.circular(15)),
                                width: MediaQuery.of(context).size.width,
                                margin:  EdgeInsets.fromLTRB(20.0, 26.0, 16.0, 0.0),

                                child: TextField(
                                  controller: passController,
                                  obscureText: _isObscure,
                                  textInputAction: TextInputAction.done,
                                  onTap: (){
                                    ispasserror = false;
                                   emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                               emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                              passbordercolor = MyColors.lightblueColor;
                               passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                    setState(() {});
                                  },
                                  style: TextStyle(
                                      color:MyColors.blackColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "a_assets/font/poppins_regular.ttf"

                                  ),

                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure ? Icons.visibility_off : Icons.visibility,color: ispasserror == true ? MyColors.red : MyColors.greycolor,),
                                          onPressed: () {
                                            setState(() {
                                              print(
                                                  "_isObscure >>>>>>>>>>" + _isObscure.toString());
                                              _isObscure = !_isObscure;

                                            });
                                          }),
                                      hintText: 'Password',
                                      border: InputBorder.none,
                                      fillColor: MyColors.whiteColor,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 15),



                                    enabledBorder: OutlineInputBorder(


                                      borderSide: BorderSide(width: 1, color:MyColors.color_FAFAFC),
                                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                                    ),
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                  ),

                                  keyboardType: TextInputType.text,

                                  // Only numbers can be entered
                                ),
                              ),
                              ispasserror == true ?  Container(
                                margin:  EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                             alignment: Alignment.topLeft,
                           child: Text(passerror,style: TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                           : Container()
                              */
/*   new FlutterPwValidator(
                                  controller: passController,
                                  minLength: 6,
                                  uppercaseCharCount: 2,
                                  numericCharCount: 3,
                                  specialCharCount: 1,
                                  width: 400,
                                  height: 150,
                                onSuccess: () {
                                  print("MATCHED");
                                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                      content: new Text("Password is matched")));
                                },
                                onFail: () {
                                  print("NOT MATCHED");
                                },
                              )*//*

                            ],
                          ),

                          Padding(
                            padding:  EdgeInsets.only(right: 18.0,top: 16.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordScreen()));

                                  },
                                    child: Text("Forgot Password !",style: TextStyle(color: MyColors.color_3F84E5,fontSize:14,fontWeight: FontWeight.w400,fontFamily: "a_assets/font/poppins_regular.ttf" ),))),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(top:60.0),
                            child: Align(

                              alignment: Alignment.center,
                              child: load == true ? CircularProgressIndicator(color: MyColors.lightblueColor,) : ElevatedButton(
                                child: Text('Sign in'),
                                onPressed: () {
                                  pass_focus.unfocus();
                                  mobilefocus.unfocus();
                                  RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                //  RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  var passNonNullValue=passController.text??"";
                                  setState(() {});
                                  if (mobileNumberController.text.isEmpty ) {
                                    mobileNumberController.text.isEmpty ?   mobilebordercolor = MyColors.red :  mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    mobileNumberController.text.isEmpty ?   mobilefillcolor = MyColors.red.withOpacity(0.03) : mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                    // passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    // passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                    // fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
                                  //   passController.text.isEmpty ?   ispasserror = true  : ispasserror =false;
                                    mobileNumberController.text.isEmpty ?   ismobileerror = true  : ismobileerror =false;
                                    mobileNumberController.text.isEmpty ?   mobileerror = "Please enter mobile number*" : mobileerror ="";
                                   // passController.text.isEmpty ?   passerror = "Please enter password*" : passerror = "";
                                    setState(() {});
                                    // Fluttertoast.showToast(msg: "Please Enter Your FullName");
                                  }

                                  else if(mobileNumberController.text.length < 10){
                                   mobilebordercolor = MyColors.red ;
                                  mobilefillcolor = MyColors.red.withOpacity(0.03);
                                   ismobileerror = true;
                                    mobileerror = "Please valid mobile number*";
                                   setState(() {});
                                  }

                                  else if(passController.text.isEmpty ){
                                    mobileNumberController.text.isEmpty ?   mobilebordercolor = MyColors.red :  mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    mobileNumberController.text.isEmpty ?   mobilefillcolor = MyColors.red.withOpacity(0.03) : mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                    passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                    // fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
                                    passController.text.isEmpty ?   ispasserror = true  : ispasserror =false;
                                    passController.text.isEmpty ?   passerror = "Please enter password*" : passerror = "";

                                    mobileNumberController.text.isEmpty ?   ismobileerror = true  : ismobileerror =false;
                                    mobileNumberController.text.isEmpty ?   mobileerror = "Please enter mobile number*" : mobileerror ="";
                                    setState(() {});
                                    // Fluttertoast.showToast(msg: "Please Enter Your FullName");
                                  }
                                  else if(!regex.hasMatch(passNonNullValue)){
                                    print("bdhjfjhdf");
                                    passbordercolor = MyColors.red ;
                                    passfillcolor = MyColors.red.withOpacity(0.03) ;
                                    ismobileerror =false;
                                    ispasserror = true;
                                    mobileerror = "";
                                    passerror ="Password should contain upper,lower,digit and Special character ";
                                    setState(() {});
                                  }

                                  else {
                                    ismobileerror =false;
                                    ispasserror = false;
                                    mobileerror = "";
                                    passerror ="";
                                    setState(() {});
                                    logindata();
                                  }

                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: MyColors.lightblueColor,
                                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(13.0))
                                    ),
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "s_asset/font/maven/mavenpro_bold.ttf",
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),

                       SizedBox(
                         height: 80,
                       ),
                          Align(
                            alignment: Alignment.center,
                              child: Text("Not Registered yet?",style: TextStyle(color: MyColors.color_text,fontSize:14,fontWeight: FontWeight.w400,fontFamily: "a_assets/font/poppins_regular.ttf" ),)),

                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreenPage()));

                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                                    ],
                                    gradient: LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      //  stops: [0.0, 1.0],
                                      colors: [
                                        MyColors.lightblueColor.withOpacity(0.10),
                                        MyColors.lightblueColor.withOpacity(0.36),
                                      ],
                                    ),
                                    //color: Colors.deepPurple.shade300,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  padding:  EdgeInsets.only(left: 25, right: 25, bottom: 15,top: 15),
                                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 25,top: 24),
                                  child: Text("Create an Account",style: TextStyle(color: MyColors.color_3F84E5,fontSize:16,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),


        ],
      ),

    );
  }

  Future<void> _onCountryChange(CountryCode countryCode ) async {
    //TODO : manipulate the selected country code here
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    slectedcountrCode=countryCode.toString();
    print("New Country selected:>>>>" + slectedcountrCode);
    print("Country ISO code :>>>>" + countryCode.code.toString());
    print("Country name code :>>>>" + countryCode.name.toString());
    print("Country dialCode code :>>>>" + countryCode.dialCode.toString());
    sharedPreferences.setString('CountryISOCode',countryCode.code.toString());
    setState(() {});

  }
}*/
