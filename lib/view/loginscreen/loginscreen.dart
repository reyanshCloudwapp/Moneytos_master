import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/createaccount/createaccountscreen.dart';
import 'package:moneytos/view/loginscreen2.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/S_ApiResponse/commonsettinglistResponse.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';
import 'dart:convert' as convert;

import '../createaccount/privacy_n_policy.dart';
import '../createaccount/terms_n_condition.dart';

class LoginScreenPage extends StatefulWidget {
  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  TextEditingController passController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController refferalCodeController = TextEditingController();

  bool showpass = false;
  bool ispass = false;
  
  bool showConfpass = false;
  bool isConfpass = false;

  bool isfullname = false;
  bool isfocusname = false;

  bool islastname = false;
  bool isfocuslastname = false;


  String nameerror = "";
  String lastnameerror = "";
  String emailerror = "";
  String passerror = "";
  String confPasserror= "";

  bool isfocuspass = false;

  bool isemailerror = false;
  bool isfullnameerror = false;
  bool islastnameerror = false;
  bool ispasserror = false;
  bool isconfPasserror= false;




  Color passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color lastnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color confPassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color referralcodebordercolor = MyColors.lightblueColor.withOpacity(0.03);

  Color emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color lastnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color confPassfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color refferalcodefillcolor = MyColors.lightblueColor.withOpacity(0.03);

  String? uppercase_message;
  String? lowercase_message;
  String? number_message;
  String? specialchr_message;

  FocusNode fullname_focus = FocusNode();
  FocusNode lastname_focus = FocusNode();
  FocusNode pass_focus = FocusNode();
  FocusNode email_focus = FocusNode();
  FocusNode passConf_focus = FocusNode();
  FocusNode referralCode_focus = FocusNode();

  bool is_validate = true;
  String validation_str = "";
  String validation_strconfPass = "";
  bool _validate = false;

  //RegExp regex=RegExp(r'^(?=.*[A-Z])(?=.*?[!@#\$&*~])$');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullname_focus.unfocus();
    pass_focus.unfocus();
    email_focus.unfocus();
    passConf_focus.unfocus();
    referralCode_focus.unfocus();
  }

/*  String? passmessage() {
    String? message;
    if (!RegExp(".*[0-9].*").hasMatch(passController.text ?? '')) {
      message ??= '';
      message += 'Input should contain a numeric value 1-9. ';
      setState(() {});
    }
    if (!RegExp('.*[a-z].*').hasMatch(passController.text ?? '')) {
      message ??= '';
      message += 'Input should contain a lowercase letter a-z. ';
      setState(() {});
    }
    if (!RegExp('.*[A-Z].*').hasMatch(passController.text ?? '')) {
      message ??= '';
      message += 'Input should contain an uppercase letter A-Z. ';
      setState(() {});
    }
    return message;
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => commonsettingApi(context));
    // main();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: MyColors.color_03153B,
              image: DecorationImage(
                  image: AssetImage(
                    "s_asset/images/bgimage.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'a_assets/images/logo.svg',
                          fit: BoxFit.cover,
                        ))),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.2,
            decoration: const BoxDecoration(
              color: MyColors.color_03153B,
              image: DecorationImage(
                  image: AssetImage(
                    "s_asset/images/bgimage.png",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            // color: MyColors.whiteColor,
            margin: const EdgeInsets.only(top: 5.0),
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Material(
              color: MyColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 16.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hSizedBox2,
                      const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Getting Started",
                            style: TextStyle(
                                fontSize: 26,
                                color: MyColors.blackColor,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf"),
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          hSizedBox2,

                          /// start//////
                          Form(
                            child: Builder(builder: (context) {
                              return Column(
                                children: [

                                  ///name
                                  /*    Container(
                                    height: 50,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 26),
                                    padding:
                                    EdgeInsets.only(left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      color: MyColors.lightblueColor
                                          .withOpacity(0.02),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                    ),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Full Name",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                              fontFamily:
                                              "s_asset/font/raleway/Raleway-Medium.ttf"),
                                        )),
                                  ),*/

                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: fullnametextfield(
                                                fullNameController,
                                                "First Name",
                                                fullname_focus,
                                                TextInputType.text,
                                                TextInputAction.next,
                                                false,
                                                isfullnameerror),
                                            //fullnamefield(),
                                          ),
                                          Container()
                                        ],
                                      ),
                                      isfullnameerror == true
                                          ? Container(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 20, top: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          nameerror,
                                          style: const TextStyle(
                                              color: MyColors.red,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              fontFamily:
                                              "s_asset/font/raleway/raleway_semibold.ttf"),
                                        ),
                                      )
                                          : Container()
                                    ],
                                  ),
                                  hSizedBox1,

                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: lastnametextfield(
                                                lastNameController,
                                                "Last Name",
                                                lastname_focus,
                                                TextInputType.text,
                                                TextInputAction.next,
                                                false,
                                                islastnameerror),
                                            //fullnamefield(),
                                          ),
                                          Container()
                                        ],
                                      ),
                                      islastnameerror == true
                                          ? Container(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 20, top: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          lastnameerror,
                                          style: const TextStyle(
                                              color: MyColors.red,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              fontFamily:
                                              "s_asset/font/raleway/raleway_semibold.ttf"),
                                        ),
                                      )
                                          : Container()
                                    ],
                                  ),
                                  hSizedBox1,
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            child: emailtextfield(
                                                emailController,
                                                "Email",
                                                email_focus,
                                                TextInputType.text,
                                                TextInputAction.next,
                                                false,
                                                isemailerror),
                                            //fullnamefield(),
                                          ),
                                          Container()
                                        ],
                                      ),
                                      isemailerror == true
                                          ? Container(
                                        padding: const EdgeInsets.only(
                                            left: 25, right: 20, top: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          emailerror,
                                          style: const TextStyle(
                                              color: MyColors.red,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              fontFamily:
                                              "s_asset/font/raleway/raleway_semibold.ttf"),
                                        ),
                                      )
                                          : Container()
                                    ],
                                  ),

                                  /// email
                                  /*   Container(
                                       height: 50,
                                       width: double.infinity,
                                       margin:EdgeInsets.only(left: 20,right: 20,top: 18),
                                       padding:EdgeInsets.only(left: 20,right: 20) ,
                                       decoration: BoxDecoration(
                                         color: MyColors.lightblueColor.withOpacity(0.02),


                                         borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                       ),

                                       child: Align(
                                           alignment: Alignment.centerLeft,
                                           child: Text("Email",textAlign:TextAlign.start,style: TextStyle(fontSize: 12,color:Colors.black38,fontFamily: "s_asset/font/raleway/Raleway-Medium.ttf"),)),

                                     ),*/
                                  // hSizedBox1,
                                  /*  Column(
                                       children: [
                                         Row(
                                           children: [
                                             Container(
                                               child: emailtextfield(emailController,"email@gmail.com",email_focus,TextInputType.emailAddress,TextInputAction.next,false,isemailerror),
                                               //fullnamefield(),
                                             ),
                                             Container()
                                           ],
                                         ),
                                         isemailerror == true  ?  Container(
                                           padding:EdgeInsets.only(left: 25,right: 20,top: 10) ,
                                           alignment:  Alignment.topLeft,
                                           child: Text(emailerror,style: TextStyle(color: MyColors.red,fontWeight: FontWeight.w600,fontSize: 12,fontFamily: "s_asset/font/raleway/Raleway-SemiBold.ttf"),),
                                         ) : Container()
                                       ],
                                     ),*/

                                  /// password
                                  /*  Container(
                                    height: 50,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 8),
                                    padding:
                                    EdgeInsets.only(left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      color: MyColors.lightblueColor
                                          .withOpacity(0.02),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)),
                                    ),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Password",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                              fontFamily:
                                              "s_asset/font/raleway/Raleway-Medium.ttf"),
                                        )),
                                  ),*/
                                  hSizedBox1,

                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          children: [
                                            //passfieald(),
                                            passtextfield(
                                                passController,
                                                "Password",
                                                pass_focus,
                                                TextInputType.text,
                                                TextInputAction.next,
                                                showpass,
                                                ispasserror),
                                            ispasserror == true
                                                ? SvgPicture.asset(
                                                    "a_assets/icons/error_icon.svg")
                                                : Container()
                                          ],
                                        ),
                                        ispasserror == true
                                            ? Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.74,
                                          padding: const EdgeInsets.only(
                                              left: 25,
                                              right: 15,
                                              top: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            validation_str.toString(),
                                            style: const TextStyle(
                                                color: MyColors.red,
                                                fontWeight:
                                                FontWeight.w600,
                                                fontSize: 12,
                                                fontFamily:
                                                "s_asset/font/raleway/raleway_semibold.ttf"),
                                          ),
                                        )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                  hSizedBox1,
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Row(
                                          children: [
                                            //passfieald(),
                                            confPasstextfield(
                                                confPassController,
                                                "Confirm Password",
                                                passConf_focus,
                                                TextInputType.text,
                                                TextInputAction.done,
                                                showConfpass,
                                                isconfPasserror),
                                            isconfPasserror == true
                                                ? Container(
                                              // width: 20,
                                              child: SvgPicture.asset(
                                                  "a_assets/icons/error_icon.svg"),
                                            )
                                                : Container()
                                          ],
                                        ),
                                        isconfPasserror == true
                                            ? Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.74,
                                          padding: const EdgeInsets.only(
                                              left: 25,
                                              right: 15,
                                              top: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            validation_strconfPass.toString(),
                                            style: const TextStyle(
                                                color: MyColors.red,
                                                fontWeight:
                                                FontWeight.w600,
                                                fontSize: 12,
                                                fontFamily:
                                                "s_asset/font/raleway/raleway_semibold.ttf"),
                                          ),
                                        )
                                            : Container()
                                      ],
                                    ),
                                  ),

                                  hSizedBox1,
                              Container(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: [
                              Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.74,
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: refferalcodefillcolor,
                                      //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
                                      borderRadius: BorderRadius.circular(15),
                                      // borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: referralcodebordercolor,
                                          // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
                                          width: 1)),
                                  //width: MediaQuery.of(context).size.width,
                                  child: TextField(
                                    focusNode: referralCode_focus,
                                    controller: refferalCodeController,
                                    // obscureText: absecure,
                                    textInputAction: TextInputAction.done,
                                    onTap: () {
                                      passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      confPassbordercolor=MyColors.lightblueColor.withOpacity(0.03);
                                      confPassfillcolor=MyColors.lightblueColor.withOpacity(0.03);
                                      fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      lastnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                      lastnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                      referralcodebordercolor = MyColors.lightblueColor;
                                      refferalcodefillcolor = MyColors.whiteColor;
                                      nameerror = "";
                                      /*isfocus = !isfocus;*/
                                      setState(() {});
                                    },
                                    style: const TextStyle(
                                        color: MyColors.blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                                    decoration: InputDecoration(
                                      hintText: "Referral Code",
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      fillColor: MyColors.whiteColor,



                                      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                                      hintStyle: TextStyle(
                                          color: MyColors.blackColor.withOpacity(0.50),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                                          letterSpacing: 0.3),
                                      //border: InputBorder.none,
                                    ),

                                    keyboardType: TextInputType.text,

                                    // Only numbers can be entered
                                  ),
                                ),
                                ]
                                  )])),


                                  Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        child: const Text(
                                          'Getting Started',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily:
                                              "s_asset/font/maven/mavenpro_bold.ttf"),
                                        ),
                                        onPressed: () {

                                          String pass = passController.text;
                                          String confPass = confPassController.text;


                                          validation_str = "";
                                          validation_strconfPass = "";
                                          is_validate = true;

                                          RegExp regex = RegExp(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                          var passNonNullValue =
                                              passController.text ?? "";

                                          if (fullNameController.text.trim().isEmpty) {
                                            fullNameController.text.trim().isEmpty
                                                ? fullnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.trim().isEmpty
                                                ? lastnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.trim().isEmpty
                                                ? lastnamefillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : lastnamefillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            emailController.text.trim().isEmpty
                                                ? emailbordercolor =
                                                MyColors.red
                                                : emailbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            emailController.text.trim().isEmpty
                                                ? emailfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : emailfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            fullNameController.text.trim().isEmpty
                                                ? fullnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().isEmpty
                                                ? passbordercolor = MyColors.red
                                                : passbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().isEmpty
                                                ? passfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : passfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);

                                            confPassController.text.trim().isEmpty
                                                ? confPassbordercolor = MyColors.red
                                                : confPassbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            confPassController.text.trim().isEmpty
                                                ? confPassfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : confPassfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);


                                            fullNameController.text.trim().isEmpty
                                                ? isfullnameerror = true
                                                : isfullnameerror = false;
                                            lastNameController.text.trim().isEmpty
                                                ? islastnameerror = true
                                                : islastnameerror = false;
                                            passController.text.trim().isEmpty
                                                ? ispasserror = true
                                                : ispasserror = false;
                                            emailController.text.trim().isEmpty
                                                ? isemailerror = true
                                                : isemailerror = false;
                                            confPassController.text.trim().isEmpty
                                                ? isconfPasserror= true
                                                : isconfPasserror = false;

                                            fullNameController.text.trim().isEmpty
                                                ? nameerror = "Please fill first name"
                                                : nameerror = "";
                                            lastNameController.text.trim().isEmpty
                                                ? lastnameerror = "Please fill last name"
                                                : lastnameerror = "";
                                            emailController.text.trim().isEmpty
                                                ? emailerror = "Please fill email"
                                                : emailerror = "";

                                            passController.text.trim().isEmpty
                                                ?  validation_str =
                                            'Please fill password'
                                                : passerror = "";

                                            validation_strconfPass =
                                            'Please fill Confirm password';


                                            setState(() {});
                                          }

                                          else if (lastNameController.text.trim().isEmpty) {
                                            fullNameController.text.trim().isEmpty
                                                ? fullnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.trim().isEmpty
                                                ? lastnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.trim().isEmpty
                                                ? lastnamefillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : lastnamefillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            emailController.text.trim().isEmpty
                                                ? emailbordercolor =
                                                MyColors.red
                                                : emailbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            emailController.text.trim().isEmpty
                                                ? emailfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : emailfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            fullNameController.text.trim().isEmpty
                                                ? fullnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.trim().isEmpty
                                                ? lastnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().isEmpty
                                                ? passbordercolor = MyColors.red
                                                : passbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().isEmpty
                                                ? passfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : passfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);

                                            confPassController.text.trim().isEmpty
                                                ? confPassbordercolor = MyColors.red
                                                : confPassbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            confPassController.text.trim().isEmpty
                                                ? confPassfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : confPassfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);


                                            fullNameController.text.trim().isEmpty
                                                ? isfullnameerror = true
                                                : isfullnameerror = false;
                                            lastNameController.text.trim().isEmpty
                                                ? islastnameerror = true
                                                : islastnameerror = false;
                                            passController.text.trim().isEmpty
                                                ? ispasserror = true
                                                : ispasserror = false;
                                            emailController.text.trim().isEmpty
                                                ? isemailerror = true
                                                : isemailerror = false;
                                            confPassController.text.trim().isEmpty
                                                ? isconfPasserror= true
                                                : isconfPasserror = false;

                                            fullNameController.text.trim().isEmpty
                                                ? nameerror = "Please fill first name"
                                                : nameerror = "";
                                            lastNameController.text.trim().isEmpty
                                                ? lastnameerror = "Please fill last name"
                                                : lastnameerror = "";
                                            emailController.text.trim().isEmpty
                                                ? emailerror = "Please fill email"
                                                : emailerror = "";

                                            passController.text.trim().isEmpty
                                                ?  validation_str =
                                            'Please fill password'
                                                : passerror = "";

                                            validation_strconfPass =
                                            'Please fill Confirm password';


                                            setState(() {});
                                          }

                                          else if (emailController.text.trim().isEmpty) {
                                            fullNameController.text.trim().isEmpty
                                                ? fullnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            fullNameController.text.trim().isEmpty
                                                ? fullnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);

                                            lastNameController.text.trim().isEmpty
                                                ? lastnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.trim().isEmpty
                                                ? lastnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);

                                            emailController.text.trim().isEmpty
                                                ? emailbordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            emailController.text.trim().isEmpty
                                                ? emailfillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);


                                            passController.text.trim().isEmpty
                                                ? passbordercolor = MyColors.red
                                                : passbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().isEmpty
                                                ? passfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : passfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);


                                            fullNameController.text.trim().isEmpty
                                                ? isfullnameerror = true
                                                : isfullnameerror = false;
                                            lastNameController.text.trim().isEmpty
                                                ? islastnameerror = true
                                                : islastnameerror = false;
                                            passController.text.trim().isEmpty
                                                ? ispasserror = true
                                                : ispasserror = false;
                                            emailController.text.trim().isEmpty
                                                ? isemailerror = true
                                                : isemailerror = false;
                                            /*confPassController.text.isEmpty
                                                ? isconfPasserror= true
                                                : isconfPasserror = false;
*/
                                            fullNameController.text.trim().isEmpty
                                                ? nameerror = "Please fill first name"
                                                : nameerror = "";
                                            lastNameController.text.trim().isEmpty
                                                ? lastnameerror = "Please fill last name"
                                                : lastnameerror = "";
                                            emailController.text.trim().isEmpty
                                                ? emailerror = "Please fill email"
                                                : emailerror = "";

                                            passController.text.trim().isEmpty
                                                ?  validation_str =
                                            'Please fill password'
                                                : passerror = "";





                                             confPassController.text.trim().isEmpty
                                                ? validation_strconfPass =
                                            "Plesse fill Confirm password"
                                                : validation_strconfPass = "";

                                            setState(() {});
                                          }


                                          else if (passController.text.trim().isEmpty) {
                                            fullNameController.text.isEmpty
                                                ? fullnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            fullNameController.text.trim().isEmpty
                                                ? fullnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);

                                            lastNameController.text.isEmpty
                                                ? lastnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.trim().isEmpty
                                                ? lastnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().isEmpty
                                                ? passbordercolor = MyColors.red
                                                : passbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().isEmpty
                                                ? passfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : passfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);

                                            fullNameController.text.trim().isEmpty
                                                ? isfullnameerror = true
                                                : isfullnameerror = false;
                                            lastNameController.text.trim().isEmpty
                                                ? islastnameerror = true
                                                : islastnameerror = false;
                                            passController.text.trim().isEmpty
                                                ? ispasserror = true
                                                : ispasserror = false;
                                            emailController.text.trim().isEmpty
                                                ? isemailerror = true
                                                : isemailerror = false;
                                          /*  confPassController.text.isEmpty
                                                ? isconfPasserror= true
                                                : isconfPasserror = false;*/

                                            fullNameController.text.trim().isEmpty
                                                ? nameerror = "Please fill first name"
                                                : nameerror = "";
                                            lastNameController.text.trim().isEmpty
                                                ? lastnameerror = "Please fill last name"
                                                : lastnameerror = "";
                                            emailController.text.trim().isEmpty
                                                ? emailerror = "Please fill email"
                                                : emailerror = "";

                                            passController.text.trim().isEmpty
                                                ?  validation_str =
                                            'Please fill password'
                                                : passerror = "";
                                            confPassController.text.trim().isEmpty
                                                ? validation_strconfPass =
                                            "Plesse fill Confirm password"
                                                : validation_strconfPass = "";

                                            setState(() {});
                                          }


                                          else if (passController.text.trim().length<6) {
                                            fullNameController.text.isEmpty
                                                ? fullnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            fullNameController.text.trim().isEmpty
                                                ? fullnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.isEmpty
                                                ? lastnamebordercolor =
                                                MyColors.red
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            lastNameController.text.trim().isEmpty
                                                ? lastnamefillcolor = MyColors
                                                .red
                                                .withOpacity(0.03)
                                                : MyColors.lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().length<6
                                                ? passbordercolor = MyColors.red
                                                : passbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            passController.text.trim().length<6
                                                ? passfillcolor = MyColors.red
                                                .withOpacity(0.03)
                                                : passfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);

                                            fullNameController.text.trim().isEmpty
                                                ? isfullnameerror = true
                                                : isfullnameerror = false;
                                            lastNameController.text.trim().isEmpty
                                                ? islastnameerror = true
                                                : islastnameerror = false;
                                            passController.text.trim().length<6
                                                ? ispasserror = true
                                                : ispasserror = false;
                                            emailController.text.trim().isEmpty
                                                ? isemailerror = true
                                                : isemailerror = false;
                                          /*  confPassController.text.isEmpty
                                                ? isconfPasserror= true
                                                : isconfPasserror = false;*/

                                            fullNameController.text.trim().isEmpty
                                                ? nameerror = "Please fill name"
                                                : nameerror = "";
                                            lastNameController.text.trim().isEmpty
                                                ? lastnameerror = "Please fill last name"
                                                : lastnameerror = "";
                                            emailController.text.trim().isEmpty
                                                ? emailerror = "Please fill email"
                                                : emailerror = "";

                                            passController.text.trim().length<6
                                                ?  validation_str =
                                            'Password must contain a minimum of six characters'
                                                : passerror = "";
                                            confPassController.text.trim().isEmpty
                                                ? validation_strconfPass =
                                            "Plesse fill Confirm password"
                                                : validation_strconfPass = "";

                                            setState(() {});
                                          }

                                          else {
                                            if (!RegExp('.*[A-Z].*').hasMatch(
                                                passController.text.trim() ?? '')) {
                                              validation_str = validation_strconfPass= 'Input should contain an (uppercase) ';
                                              is_validate = false;
                                              setState(() {});
                                            }
                                            if (!RegExp('.*[a-z].*').hasMatch(
                                                passController.text.trim() ?? '')) {
                                              if (is_validate) {
                                                validation_str =
                                                "Input should contain a (lowercase)";
                                                setState(() {});
                                              }
                                              else {
                                                validation_str =
                                                    validation_str + " , " +
                                                        "a (lowercase)";
                                                setState(() {});
                                              }
                                              is_validate = false;
                                              ispasserror = true;

                                              setState(() {});
                                            }
                                            if (!RegExp('.[!@#\$&*~].*')
                                                .hasMatch(
                                                passController.text.trim() ?? '')) {
                                              if (is_validate) {
                                                validation_str =
                                                "Input should contain a (special character)";
                                                setState(() {});
                                              }
                                              else {
                                                validation_str =
                                                    validation_str + "," +
                                                        "(special character)";
                                                setState(() {});
                                              }
                                              is_validate = false;
                                              ispasserror = true;
                                              setState(() {});
                                            }
                                            if (!RegExp(".*[0-9].*").hasMatch(
                                                passController.text.trim() ?? '')) {
                                              if (is_validate) {
                                                validation_str =
                                                "Input should contain a (Number)";
                                                setState(() {});
                                              }
                                              else {
                                                validation_str =
                                                    validation_str + "," +
                                                        "a (Number)";
                                                setState(() {});
                                              }
                                              is_validate = false;

                                              setState(() {});
                                            }

                                            if (is_validate) {
                                             if (confPassController.text.trim().isEmpty){
                                              fullNameController.text.trim().isEmpty
                                                  ? fullnamebordercolor =
                                                  MyColors.red
                                                  : MyColors.lightblueColor
                                                  .withOpacity(0.03);
                                              fullNameController.text.trim().isEmpty
                                                  ? fullnamefillcolor = MyColors
                                                  .red
                                                  .withOpacity(0.03)
                                                  : MyColors.lightblueColor
                                                  .withOpacity(0.03);
                                              lastNameController.text.trim().isEmpty
                                                  ? lastnamebordercolor =
                                                  MyColors.red
                                                  : MyColors.lightblueColor
                                                  .withOpacity(0.03);
                                              lastNameController.text.trim().isEmpty
                                                  ? lastnamefillcolor = MyColors
                                                  .red
                                                  .withOpacity(0.03)
                                                  : MyColors.lightblueColor
                                                  .withOpacity(0.03);
                                              passController.text.trim().isEmpty
                                                  ? passbordercolor = MyColors.red
                                                  : passbordercolor = MyColors
                                                  .lightblueColor
                                                  .withOpacity(0.03);
                                              passController.text.trim().isEmpty
                                                  ? passfillcolor = MyColors.red
                                                  .withOpacity(0.03)
                                                  : passfillcolor = MyColors
                                                  .lightblueColor
                                                  .withOpacity(0.03);
                                              fullNameController.text.trim().isEmpty
                                                  ? isfullnameerror = true
                                                  : isfullnameerror = false;
                                              passController.text.trim().isEmpty
                                                  ? ispasserror = true
                                                  : ispasserror = false;
                                              emailController.text.trim().isEmpty
                                                  ? isemailerror = true
                                                  : isemailerror = false;
                                              confPassController.text.trim().isEmpty
                                                  ? isconfPasserror= true
                                                  : isconfPasserror = false;

                                              fullNameController.text.trim().isEmpty
                                                  ? nameerror = "Please fill first name"
                                                  : nameerror = "";
                                              emailController.text.trim().isEmpty
                                                  ? emailerror = "Please fill email"
                                                  : emailerror = "";

                                              passController.text.trim().isEmpty
                                                  ?  validation_str =
                                              'Please fill password'
                                                  : passerror = "";

                                              validation_strconfPass =
                                              "Plesse fill Confirm password";

                                              setState(() {});

                                              // Fluttertoast.showToast(msg: "Enter Confirm Password ");
                                            }
                                            else if(confPassController.text.trim()!=passController.text.trim()){
                                              confPassbordercolor = MyColors.red;
                                              confPassfillcolor = MyColors.red.withOpacity(0.03);
                                             /* isconfPasserror = false;
                                              isconfPasserror = true ;
                                              confPasserror = "Not match password*";*/
                                              validation_strconfPass = "Password & confirm password must be same";
                                              isconfPasserror= true;

                                              setState(() {});
                                            }
                                             else{
                                               fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);

                                               fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                               lastnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);

                                               lastnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                               emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);

                                               emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                               passbordercolor = MyColors.lightblueColor.withOpacity(0.03);

                                               passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                               confPassbordercolor = MyColors.lightblueColor.withOpacity(0.03);


                                               confPassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                               isfullnameerror = false;
                                               islastnameerror = false;

                                               isemailerror= false;
                                               ispasserror = false;

                                               isconfPasserror=false;

                                               setState(() {

                                               });
                                               chkEmailAndRefferalCodeapi(context, emailController.text,refferalCodeController.text);

                                             }
                                                      }
                                            else {
                                              fullNameController.text.trim().isEmpty
                                                  ? fullnamebordercolor =
                                                  MyColors.red
                                                  : MyColors.lightblueColor
                                                  .withOpacity(0.03);

                                              fullNameController.text.trim().isEmpty
                                                  ? fullnamefillcolor = MyColors
                                                  .red
                                                  .withOpacity(0.03)
                                                  : MyColors.lightblueColor
                                                  .withOpacity(0.03);

                                              emailController.text.trim().isEmpty
                                                  ? emailbordercolor = MyColors
                                                  .red
                                                  .withOpacity(0.03)
                                                  : MyColors.lightblueColor
                                                  .withOpacity(0.03);

                                              emailController.text.trim().isEmpty
                                                  ? emailfillcolor = MyColors
                                                  .red
                                                  .withOpacity(0.03)
                                                  : MyColors.lightblueColor
                                                  .withOpacity(0.03);

                                              passbordercolor = MyColors.red;

                                              passfillcolor = MyColors.red
                                                  .withOpacity(0.03);

                                              fullNameController.text.trim().isEmpty
                                                  ? isfullnameerror = true
                                                  : isfullnameerror = false;

                                              ispasserror = true;

                                              print(
                                                  "dknsjkgl" + validation_str);
                                            }
                                          }
                                          //  }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: MyColors.lightblueColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50, vertical: 14),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(16.0))),
                                            textStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),

                          /// end
                          hSizedBox2,
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  const Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "By clicking Get Started, you accept our ",
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontSize: 13,
                                            fontFamily:
                                            "s_asset/font/raleway/raleway_semibold.ttf"),
                                      ),


                                    ],
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrivacyPolicyScreen()));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const TermsNConditionScreen()));
                                          },
                                          child: const Text(
                                            "Terms and Conditions",
                                            style: TextStyle(
                                                color: MyColors.lightblueColor,
                                                fontSize: 13,
                                                fontFamily:
                                                "s_asset/font/raleway/raleway_semibold.ttf"),
                                          ),
                                        ),
                                        const Text(
                                          " and ",
                                          style: TextStyle(
                                              color: MyColors.color_text,
                                              fontSize: 13,
                                              fontFamily:
                                              "s_asset/font/raleway/raleway_semibold.ttf"),
                                        ),
                                        const Text(
                                          "Privacy Policy",
                                          style: TextStyle(
                                              color: MyColors.lightblueColor,
                                              fontSize: 13,
                                              fontFamily:
                                              "s_asset/font/raleway/raleway_semibold.ttf"),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen2()));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0, 4),
                                          blurRadius: 5.0)
                                    ],
                                    gradient: LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      //  stops: [0.0, 1.0],
                                      colors: [
                                        MyColors.lightblueColor
                                            .withOpacity(0.10),
                                        MyColors.lightblueColor
                                            .withOpacity(0.36),
                                      ],
                                    ),
                                    //color: Colors.deepPurple.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, bottom: 16, top: 16),
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 0, top: 50),
                                  child: const Text(
                                    "Log in",
                                    style: TextStyle(
                                        color: MyColors.color_3F84E5,
                                        fontSize: 16,
                                        fontFamily:
                                        "s_asset/font/raleway/raleway_bold.ttf"),
                                  )),
                            ),
                          ),
                          hSizedBox4
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

  passtextfield(TextEditingController controller,
      String hinttext,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction,
      bool absecure,
      bool ispasserrorvar) {
    return Container(
      height: 50,
      width: ispasserrorvar == true ? MediaQuery
          .of(context)
          .size
          .width * 0.7 : MediaQuery
          .of(context)
          .size
          .width * 0.74,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: passfillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: passbordercolor,
              // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
              width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: _isObscure,
        textInputAction: textInputAction,
        onTap: () {
          confPassbordercolor=MyColors.lightblueColor.withOpacity(0.03);
          confPassfillcolor=MyColors.lightblueColor.withOpacity(0.03);
          fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.02);
          fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          referralcodebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          refferalcodefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          passbordercolor = MyColors.lightblueColor;
          passfillcolor = MyColors.whiteColor;
          passerror = "";
          ispasserror = false;
          /*isfocus = !isfocus;*/
          setState(() {});
        },
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color:
                //ispasserror == true ? MyColors.red :
                MyColors.greycolor,
              ),
              onPressed: () {
                setState(() {
                  print("_isObscure >>>>>>>>>>" + _isObscure.toString());
                  _isObscure = !_isObscure;
                });
              }),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }
  
  
  
  
  confPasstextfield(TextEditingController controller,
      String hinttext,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction,
      bool absecureCon,
      bool ispasserrorCon) {
    return Container(
      height: 50,
      width: isconfPasserror == true ? MediaQuery
          .of(context)
          .size
          .width * 0.7 : MediaQuery
          .of(context)
          .size
          .width * 0.74,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: confPassfillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: confPassbordercolor,
              // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
              width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: _isObscure2,
        textInputAction: textInputAction,
        onTap: () {
          fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.02);
          fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          referralcodebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          refferalcodefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
         /* passfillcolor = MyColors.whiteColor;
          passerror = "";
          ispasserror = false;*/
          
          confPassbordercolor=MyColors.lightblueColor;
          confPassfillcolor=MyColors.whiteColor;
          confPasserror="";
          isconfPasserror=false;
          
          
          /*isfocus = !isfocus;*/
          setState(() {});
        },
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          suffixIcon: IconButton(
              icon: Icon(
                _isObscure2 ? Icons.visibility_off : Icons.visibility,
                color:
                //ispasserror == true ? MyColors.red :
                MyColors.greycolor,
              ),
              onPressed: () {
                setState(() {
                  print("_isObscure >>>>>>>>>>" + _isObscure2.toString());
                  _isObscure2 = !_isObscure2;
                });
              }),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }



  fullnametextfield(TextEditingController controller,
      String hinttext,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction,
      bool absecure,
      bool ispasserror) {
    return Container(
      height: 50,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.74,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: fullnamefillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: fullnamebordercolor,
              // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
              width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: absecure,
        textInputAction: textInputAction,
        onTap: () {
          passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          confPassbordercolor=MyColors.lightblueColor.withOpacity(0.03);
          confPassfillcolor=MyColors.lightblueColor.withOpacity(0.03);
          referralcodebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          refferalcodefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          fullnamebordercolor = MyColors.lightblueColor;
          fullnamefillcolor = MyColors.whiteColor;
          nameerror = "";
          /*isfocus = !isfocus;*/
          setState(() {});
        },
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,



          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  lastnametextfield(TextEditingController controller,
      String hinttext,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction,
      bool absecure,
      bool ispasserror) {
    return Container(
      height: 50,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.74,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: lastnamefillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: lastnamebordercolor,
              // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
              width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: absecure,
        textInputAction: textInputAction,
        onTap: () {
          passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          confPassbordercolor=MyColors.lightblueColor.withOpacity(0.03);
          confPassfillcolor=MyColors.lightblueColor.withOpacity(0.03);
          referralcodebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          refferalcodefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamebordercolor = MyColors.lightblueColor;
          lastnamefillcolor = MyColors.whiteColor;
          lastnameerror = "";
          /*isfocus = !isfocus;*/
          setState(() {});
        },
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,



          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  emailtextfield(TextEditingController controller,
      String hinttext,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction,
      bool absecure,
      bool ispasserror) {
    return Container(
      height: 50,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.74,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: emailfillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: emailbordercolor,
              // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
              width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: absecure,
        textInputAction: textInputAction,
        onTap: () {
          confPassbordercolor=MyColors.lightblueColor.withOpacity(0.03);
          confPassfillcolor=MyColors.lightblueColor.withOpacity(0.03);
          passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          referralcodebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          refferalcodefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          lastnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor;
          emailfillcolor = MyColors.whiteColor;
          emailerror = "";
          /*isfocus = !isfocus;*/
          setState(() {});
        },
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  Future <void> commonsettingApi(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Utility.ProgressloadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(
        Apiservices.commonsettingURL),
        headers: {
          "X-CLIENT": AllApiService.x_client,
          "content-type": "application/json",
        });

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    Utility.ProgressloadingDialog(context, false);
      if(jsonResponse['status'] == true){
        CommonsettinglistResponse commonsettinglistResponse = CommonsettinglistResponse.fromJson(jsonResponse);
        for(var commondata in commonsettinglistResponse.data!.commonData!){
          if(commondata.slugName == "niumapi_url"){

            Apiservices.nium_base_url = commondata.slugValue.toString();

          }if(commondata.slugName == "nium_client_id"){

            Apiservices.x_client_id  = commondata.slugValue.toString();

          }if(commondata.slugName == "niumapi_url_v2"){

            Apiservices.nium_base_url_v2 = commondata.slugValue.toString();

          }if(commondata.slugName == "nium_client_key"){

            Apiservices.client_key = commondata.slugValue.toString();

          }if(commondata.slugName == "nium_client_secret"){

            Apiservices.client_secret = commondata.slugValue.toString();

          }if(commondata.slugName == "nium_source_account"){

            Apiservices.nium_source_account = commondata.slugValue.toString();

          }if(commondata.slugName == "nium_identification_number"){

            Apiservices.nium_identification_number = commondata.slugValue.toString();

          }if(commondata.slugName == "nium_request_id"){

            Apiservices.nium_request_id = commondata.slugValue.toString();

          }if(commondata.slugName == "nium_contact_number"){
            Apiservices.nium_contact_number = commondata.slugValue.toString();

          }if(commondata.slugName == "nium_identification_type"){
            Apiservices.nium_identification_type = commondata.slugValue.toString();


          }if(commondata.slugName == "magicpay_url"){

            AllApiService.magicpayBaseUrlBaseUrl = commondata.slugValue.toString();

          }if(commondata.slugName == "magicpay_basic_auth"){

            AllApiService.client_id = commondata.slugValue.toString();

          }if(commondata.slugName == "persona_template_id"){

          }if(commondata.slugName == "persona_inquiry_template_id"){

          }if(commondata.slugName == "persona_url"){

          }if(commondata.slugName == "persona_auth"){

          }if(commondata.slugName == "persona_enviroment"){

          }if(commondata.slugName == "site_schedule_status"){

            print("slug value>>>  "+commondata.slugValue.toString());
            sharedPreferences.setString("site_schedule_status", commondata.slugValue.toString());
          }
        }
      }
      setState(() {

      });




  }

  Future <void> chkEmailAndRefferalCodeapi(BuildContext context,String email,String referral_id) async {
    selectCountryList.clear();
    Utility.ProgressloadingDialog(context, true);
    var request = {};
    request['email'] = email;
    if(referral_id.isNotEmpty){
      request['referral_id'] = referral_id;
    }



    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.chkEmailAndRefferalCodeapi),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-CLIENT": AllApiService.x_client,
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      Utility.ProgressloadingDialog(context, false);
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CreateAccountScreen(
                      fullNameController.text,lastNameController.text, passController.text, emailController.text,refferalCodeController.text)));
      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.dialogError(context, jsonResponse['message']);
      setState(() {});
    }

    return;

  }
}
/*String validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    } RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    var passNonNullValue=value??"";
    if(passNonNullValue.isEmpty){
      return ("Password is required");
    }
   */ /* else if(passNonNullValue.length<6){
      return ("Password Must be more than 5 characters");
    }*/ /*
    else if(!regex.hasMatch(passNonNullValue)){
        // passerror "Password should contain upper,lower,digit and Special character ";
    }

    return value;
  }*/




/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/createaccount/createaccountscreen.dart';
import 'package:moneytos/view/loginscreen2.dart';

class LoginScreenPage extends StatefulWidget{
  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {

  bool _isObscure = true;
  TextEditingController passController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool showpass = false;
  bool ispass = false;
  bool isfullname = false;
  bool isfocusname = false;
  bool isfocuspass = false;
  bool isfullnameerror = false;
  bool isemailerror = false;
  bool ispasserror = false;
  String passerror = "";
  String nameerror = "";
  String emailerror = "";
  Color passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  FocusNode fullname_focus = FocusNode();
  FocusNode pass_focus = FocusNode();
  FocusNode email_focus = FocusNode();
  bool _validate = false;
  //RegExp regex=RegExp(r'^(?=.*[A-Z])(?=.*?[!@#\$&*~])$');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullname_focus.unfocus();
    pass_focus.unfocus();
    email_focus.unfocus();
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
           height: size.height * 0.2,
           decoration: BoxDecoration(
             color: MyColors.color_03153B,
             image: DecorationImage(
                 image: AssetImage("s_asset/images/bgimage.png",),
                 fit: BoxFit.cover
             ),
           ),
         ),

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
               margin: EdgeInsets.only(top: 16.0,left: 20.0,right: 20.0),
               child: SingleChildScrollView(
                 child: Column(

                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     hSizedBox2,
                     Align(
                       alignment: Alignment.center,
                         child: Text("Getting Started",style: TextStyle(fontSize: 26,color: MyColors.blackColor,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)),
                     Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         hSizedBox2,

                         /// start//////
                         Form(
                           child: Builder(
                               builder: (context) {
                                 return Column(
                                   children: [

                                     ///name
                                     Container(
                                       height: 50,
                                       width: double.infinity,
                                       margin:EdgeInsets.only(left: 20,right: 20,top: 26),
                                       padding:EdgeInsets.only(left: 20,right: 20) ,
                                       decoration: BoxDecoration(
                                         color: MyColors.lightblueColor.withOpacity(0.02),


                                         borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                       ),

                                       child: Align(
                                           alignment: Alignment.centerLeft,
                                           child: Text("Full Name",textAlign:TextAlign.start,style: TextStyle(fontSize: 12,color:Colors.black38,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),)),

                                     ),
                                     hSizedBox1,
                                     Column(
                                       children: [
                                         Row(
                                           children: [
                                             Container(
                                               child: fullnametextfield(fullNameController,"heshamsq|",fullname_focus,TextInputType.text,TextInputAction.next,false,isfullnameerror),
                                               //fullnamefield(),
                                             ),
                                             Container()
                                           ],
                                         ),
                                         isfullnameerror == true  ?  Container(
                                           padding:EdgeInsets.only(left: 25,right: 20,top: 10) ,
                                           alignment:  Alignment.topLeft,
                                           child: Text(nameerror,style: TextStyle(color: MyColors.red,fontWeight: FontWeight.w600,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),),
                                         ) : Container()
                                       ],
                                     ),

                                     /// email
                                  */
/*   Container(
                                       height: 50,
                                       width: double.infinity,
                                       margin:EdgeInsets.only(left: 20,right: 20,top: 18),
                                       padding:EdgeInsets.only(left: 20,right: 20) ,
                                       decoration: BoxDecoration(
                                         color: MyColors.lightblueColor.withOpacity(0.02),


                                         borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                       ),

                                       child: Align(
                                           alignment: Alignment.centerLeft,
                                           child: Text("Email",textAlign:TextAlign.start,style: TextStyle(fontSize: 12,color:Colors.black38,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),)),

                                     ),*//*

                                    // hSizedBox1,
                                   */
/*  Column(
                                       children: [
                                         Row(
                                           children: [
                                             Container(
                                               child: emailtextfield(emailController,"email@gmail.com",email_focus,TextInputType.emailAddress,TextInputAction.next,false,isemailerror),
                                               //fullnamefield(),
                                             ),
                                             Container()
                                           ],
                                         ),
                                         isemailerror == true  ?  Container(
                                           padding:EdgeInsets.only(left: 25,right: 20,top: 10) ,
                                           alignment:  Alignment.topLeft,
                                           child: Text(emailerror,style: TextStyle(color: MyColors.red,fontWeight: FontWeight.w600,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),),
                                         ) : Container()
                                       ],
                                     ),*//*


                                     /// password
                                     Container(
                                       height: 50,
                                       width: double.infinity,
                                       margin:EdgeInsets.only(left: 20,right: 20,top: 8),
                                       padding:EdgeInsets.only(left: 20,right: 20) ,
                                       decoration: BoxDecoration(
                                         color: MyColors.lightblueColor.withOpacity(0.02),
                                         borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                       ),

                                       child: Align(
                                           alignment: Alignment.centerLeft,
                                           child: Text("Password",textAlign:TextAlign.start,style: TextStyle(fontSize: 12,color:Colors.black38,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),)),

                                     ),
                                     hSizedBox1,
                                     Container(
                                       child: Column(
                                         children: [
                                           Row(
                                             children: [
                                                //passfieald(),
                                               textfield(passController,"*****",pass_focus,TextInputType.text,TextInputAction.done,showpass,ispasserror),
                                               ispasserror == true  ?      Container(
                                                 // width: 20,
                                                 child: SvgPicture.asset("a_assets/icons/error_icon.svg"),
                                               ) : Container()
                                             ],
                                           ),

                                           ispasserror == true  ?  Container(
                                             padding:EdgeInsets.only(left: 25,right: 20,top: 10) ,
                                             alignment:  Alignment.topLeft,
                                             child: Text(passerror,style: TextStyle(color: MyColors.red,fontWeight: FontWeight.w600,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),),
                                           ) : Container()
                                         ],
                                       ),
                                     ),

                                     Padding(
                                       padding:  EdgeInsets.only(top:50.0),
                                       child: Align(

                                         alignment: Alignment.center,
                                         child: ElevatedButton(
                                           child: Text('Getting Started',style: TextStyle(fontSize: 18,fontFamily: "s_asset/font/maven/mavenpro_bold.ttf"),),
                                           onPressed: () {
                                             RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                             var passNonNullValue=passController.text??"";


      if (fullNameController.text.isEmpty) {
        fullNameController.text.isEmpty ?   fullnamebordercolor = MyColors.red : MyColors.lightblueColor.withOpacity(0.03);
        emailController.text.isEmpty ?   emailbordercolor = MyColors.red : emailbordercolor =MyColors.lightblueColor.withOpacity(0.03);
        emailController.text.isEmpty ?   emailfillcolor = MyColors.red.withOpacity(0.03) : emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
        fullNameController.text.isEmpty ?   fullnamefillcolor = MyColors.red.withOpacity(0.03) : MyColors.lightblueColor.withOpacity(0.03);
        passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
        passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

        fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
        passController.text.isEmpty ?   ispasserror =true  : ispasserror =false;
        emailController.text.isEmpty ?   isemailerror =true  : isemailerror =false;

        fullNameController.text.isEmpty ?  nameerror = "Plesse fill name" : nameerror = "";
        emailController.text.isEmpty ?  emailerror = "Please email" : emailerror = "";
        passController.text.isEmpty ?  passerror = "Plesse fill password" : passerror = "";
        setState(() {});
        Fluttertoast.showToast(msg: "Please Enter Your FullName");
      }

     */
/* else if(emailController.text.isEmpty){
    fullNameController.text.isEmpty ?   fullnamebordercolor = MyColors.red : MyColors.lightblueColor.withOpacity(0.03);
    emailController.text.isEmpty ?   emailbordercolor = MyColors.red : emailbordercolor =MyColors.lightblueColor.withOpacity(0.03);
    emailController.text.isEmpty ?   emailfillcolor = MyColors.red.withOpacity(0.03) : emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
    fullNameController.text.isEmpty ?   fullnamefillcolor = MyColors.red.withOpacity(0.03) :fullnamefillcolor =  MyColors.lightblueColor.withOpacity(0.03);
    passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
    passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);


    fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
    passController.text.isEmpty ?   ispasserror =true  : ispasserror =false;
    emailController.text.isEmpty ?   isemailerror =true  : isemailerror =false;


    fullNameController.text.isEmpty ?  nameerror = "please fill name" : nameerror = "";
    emailController.text.isEmpty ?  emailerror = "please email" : emailerror = "";
    passController.text.isEmpty ?  passerror = "please fill password" : passerror = "";
    setState(() {});
    Fluttertoast.showToast(msg: "Please Enter Your FullName");

      }*//*


      else if (passController.text.isEmpty) {
        fullNameController.text.isEmpty ?   fullnamebordercolor = MyColors.red : MyColors.lightblueColor.withOpacity(0.03);
        fullNameController.text.isEmpty ?   fullnamefillcolor = MyColors.red.withOpacity(0.03) : MyColors.lightblueColor.withOpacity(0.03);
        passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
        passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

        fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
        passController.text.isEmpty ?   ispasserror =true  : ispasserror =false;
       // emailController.text.isEmpty ?   isemailerror =true  : isemailerror =false;

        fullNameController.text.isEmpty ?  nameerror = "Please fill name" : nameerror = "";
      //  emailController.text.isEmpty ?  emailerror = "please email" : emailerror = "";
        passController.text.isEmpty ?  passerror = "Please fill password" : passerror = "";
        setState(() {});
        Fluttertoast.showToast(msg: "Please Enter Password");
      }

      else if(!regex.hasMatch(passNonNullValue)){
        print("bdhjfjhdf");
      passbordercolor = MyColors.red ;
     passfillcolor = MyColors.red.withOpacity(0.03) ;
      ispasserror =true;
        passerror ="Password should contain upper,lower,digit and Special character ";
    setState(() {});
      }

      else {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            CreateAccountScreen(fullNameController.text, passController.text,emailController.text)));
      }
  //  }
                                           },
                                           style: ElevatedButton.styleFrom(
                                               primary: MyColors.lightblueColor,
                                               padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),

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
                                 );
                               }
                           ),
                         ),
/// end
                         hSizedBox2,

                      */
/*   textfield(fullNameController,"heshamsq|",fullname_focus,TextInputType.text,TextInputAction.done,false,isfullname,isfocusname),

                         Container(
                           height: 50,
                           width: double.infinity,
                           margin:EdgeInsets.only(left: 20,right: 20,top: 20),
                           padding:EdgeInsets.only(left: 20,right: 20) ,
                           decoration: BoxDecoration(
                             color: MyColors.lightblueColor.withOpacity(0.02),
                             borderRadius: BorderRadius.all(Radius.circular(6.0)),
                           ),

                           child: Align(
                               alignment: Alignment.centerLeft,
                               child: Text("Password",textAlign:TextAlign.start,style: TextStyle(fontSize: 12,color:Colors.black38,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),)),

                         ),
                         hSizedBox2,
                         Container(
                           child: Row(
                             children: [
                              // passfieald(),
                               textfield(passController,"*****",pass_focus,TextInputType.text,TextInputAction.done,true,ispass,isfocuspass),
                               ispass == true ?      Container(
                                // width: 20,
                                 child: SvgPicture.asset("a_assets/icons/error_icon.svg"),
                               ) : Container()
                             ],
                           ),
                         ),

*//*


                        */
/* Padding(
                           padding:  EdgeInsets.only(top:50.0),
                           child: Align(

                             alignment: Alignment.center,
                             child: ElevatedButton(
                               child: Text('Getting Started',style: TextStyle(fontSize: 18,fontFamily: "s_asset/font/maven/mavenpro_bold.ttf"),),
                               onPressed: () {
                                 String fullName= fullNameController.text;
                                 String password= passController.text;

                                 if(fullName.isEmpty){
                                   fullNameController.text.isEmpty?  isfullname = true : isfullname = false;
                                   passController.text.isEmpty?  ispass = true : ispass = false;
                                   fullNameController.text.isEmpty?   isfocusname = false :isfocusname = true ;
                                   passController.text.isEmpty?  isfocuspass = false : isfocusname = true;
                                   setState(() {});
                                   Fluttertoast.showToast(msg: "Please Enter Your FullName");
                                 }
                                 else if(password.isEmpty){
                                   fullNameController.text.isEmpty?  isfullname = true : isfullname = false;
                                   passController.text.isEmpty?  ispass = true : ispass = false;
                                   setState(() {});
                                   Fluttertoast.showToast(msg: "Please Enter Password");
                                 }
                                 else{
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccountScreen(fullNameController.text, passController.text)));

                                 }


                               },
                               style: ElevatedButton.styleFrom(
                                   primary: MyColors.lightblueColor,
                                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),

                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.all(Radius.circular(16.0))
                                   ),
                                   textStyle: TextStyle(
                                       fontSize: 18,
                                       fontWeight: FontWeight.bold)),
                             ),
                           ),
                         ),
*//*

                         Padding(
                           padding:  EdgeInsets.only(top:25.0),
                           child: GestureDetector(
                             onTap: (){
                             },
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("By clicking, I'm agree with ",style: TextStyle(color: MyColors.color_text,fontSize:13,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),),
                                 Text("Terms & Policy",style: TextStyle(color: MyColors.lightblueColor,fontSize:13,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf" ),)
                               ],
                             ),
                           ),
                         ),


                         Align(
                           alignment: Alignment.center,
                           child: GestureDetector(
                             onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen2()));

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
                                   borderRadius: BorderRadius.circular(15),
                                 ),
                                 padding:  EdgeInsets.only(left: 40, right: 40, bottom: 16,top: 16),
                                 margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 50),
                                 child: Text("Sign in",style: TextStyle(color: MyColors.color_3F84E5,fontSize:16,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)
                             ),
                           ),
                         ),
                         hSizedBox4

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





  textfield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction,bool absecure,bool ispasserror) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.74,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: passfillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
     // borderRadius: BorderRadius.circular(15),
      border: Border.all(color: passbordercolor ,
         // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
          width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        obscureText: _isObscure,
        textInputAction: textInputAction,
        onTap: (){
          */
/*fullNameController.text.isEmpty ?   fullnamebordercolor = MyColors.red : MyColors.lightblueColor.withOpacity(0.02);
          fullNameController.text.isEmpty ?   fullnamefillcolor = MyColors.red.withOpacity(0.03) : MyColors.lightblueColor.withOpacity(0.03);
          passerror = "";
          setState((){

          });*//*

          fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.02);
         fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
         emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
         emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
          passbordercolor = MyColors.lightblueColor;
          passfillcolor = MyColors.whiteColor;
          passerror = "";
          ispasserror = false;
          */
/*isfocus = !isfocus;*//*

          setState((){

          });
        },
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),
          suffixIcon:IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,color: ispasserror == true  ? MyColors.red : MyColors.greycolor,),
              onPressed: () {
                setState(() {

                  print(
                      "_isObscure >>>>>>>>>>" + _isObscure.toString());
                  _isObscure = !_isObscure;

                });
              }) ,
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  fullnametextfield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction,bool absecure,bool ispasserror) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.74,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: fullnamefillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(color: fullnamebordercolor ,
              // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
              width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        obscureText: absecure,
        textInputAction: textInputAction,
        onTap: (){
             passbordercolor =  MyColors.lightblueColor.withOpacity(0.03);
          passfillcolor =   MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor =   MyColors.lightblueColor.withOpacity(0.03);
          emailfillcolor =   MyColors.lightblueColor.withOpacity(0.03);
          fullnamebordercolor = MyColors.lightblueColor;
          fullnamefillcolor = MyColors.whiteColor;
             nameerror = "";
          */
/*isfocus = !isfocus;*//*

          setState((){

          });
        },
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  emailtextfield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction,bool absecure,bool ispasserror) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.74,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: emailfillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(color: emailbordercolor ,
              // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
              width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        obscureText: absecure,
        textInputAction: textInputAction,
        onTap: (){
          passbordercolor =  MyColors.lightblueColor.withOpacity(0.03);
          passfillcolor =   MyColors.lightblueColor.withOpacity(0.03);
          fullnamebordercolor = MyColors.lightblueColor.withOpacity(0.03);
          fullnamefillcolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor;
          emailfillcolor = MyColors.whiteColor;
          emailerror = "";
          */
/*isfocus = !isfocus;*//*

          setState((){

          });
        },
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }



  */
/*String validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    } RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    var passNonNullValue=value??"";
    if(passNonNullValue.isEmpty){
      return ("Password is required");
    }
   *//*
*/
/* else if(passNonNullValue.length<6){
      return ("Password Must be more than 5 characters");
    }*//*
*/
/*
    else if(!regex.hasMatch(passNonNullValue)){
        // passerror "Password should contain upper,lower,digit and Special character ";
    }

    return value;
  }*//*

}*/
