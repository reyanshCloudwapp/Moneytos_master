import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/setup_new_pin_code_screen/setup_newpin_Code_screen.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/view/dash_settingscreen/setting_account_setting/front_image.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../s_Api/s_utils/Utility.dart';
import '../../../services/Apiservices.dart';
import 'dart:convert' as convert;

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  String? status_title;
  bool _isObscure = true;

  /// TextEditingController
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  // TextEditingController countryController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  /// FocusNode
  FocusNode fullnameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phonenumberFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [

        KeyboardActionsItem(
          focusNode: phonenumberFocusNode,

        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullnameFocusNode.unfocus();
    emailFocusNode.unfocus();
    phonenumberFocusNode.unfocus();
    countryFocusNode.unfocus();
    messageFocusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            backgroundColor: MyColors.light_primarycolor2,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child:   AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: MyColors.light_primarycolor2,
                flexibleSpace: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(23, 35, 20, 0),
                  child: Row(
crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            "s_asset/images/leftarrow.svg",
                              height: 32,
                              width: 32
                          )),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                        child: const Text(
                          MyString.help_center,
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
            body: KeyboardActions(
              autoScroll: false,
              config: _buildKeyboardActionsConfig(context),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: <Widget>[
              Container(
                color: MyColors.light_primarycolor2,
                height: 300,
                width: MediaQuery.of(context).size.width,
              ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                          color: MyColors.whiteColor,
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              hSizedBox3,
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                //width: size.width * 0.7,
                                //margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                                child: const Text(
                                  MyString.contact_our_global_support_team,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_bold.ttf"),
                                ),
                              ),
                              hSizedBox5,
                              textfield(
                                  fullnameController,
                                  MyString.your_name,
                                  fullnameFocusNode,
                                  TextInputType.text,
                                  TextInputAction.next),
                              hSizedBox2,
                              textfield(
                                  emailController,
                                  MyString.contact_email,
                                  emailFocusNode,
                                  TextInputType.emailAddress,
                                  TextInputAction.next),
                              hSizedBox2,
                              // textfield(
                              //     phonenumberController,
                              //     MyString.your_phone,
                              //     phonenumberFocusNode,
                              //     TextInputType.numberWithOptions(
                              //         decimal: true, signed: true),
                              //     TextInputAction.next),

                              Container(
                                decoration: BoxDecoration(
                                    color: MyColors.lightblueColor.withOpacity(0.03),
                                    borderRadius: BorderRadius.circular(8)),
                                margin: const EdgeInsets.only(left: 18.0,top: 30),
                                child: Row(
                                  children: [

                                    CountryCodePicker(

                                      onChanged: _onCountryChange,
                                      // enabled: false,

                                      initialSelection: 'CA',
                                      // favorite: ['+91','IN'],
                                      showCountryOnly: false,
                                      textStyle: const TextStyle(color: MyColors.primaryColor,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontSize: 16),
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: false,
                                      showFlag: false,

                                    ),
                                    Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.centerLeft,
                                      // width: MediaQuery.of(context).size.width * 0.7,
                                      child: textphonefield(phonenumberController,MyString.phone_nember,phonenumberFocusNode,TextInputType.number,TextInputAction.next),
                                    ),
                                  ],
                                ),
                              ),
                              hSizedBox2,
                              // textfield(
                              //     countryController,
                              //     MyString.country,
                              //     countryFocusNode,
                              //     TextInputType.text,
                              //     TextInputAction.next),
                              // hSizedBox2,
                              messagetextfield(
                                  messageController,
                                  MyString.type_message,
                                  messageFocusNode,
                                  TextInputType.multiline,
                                  TextInputAction.done),
                              hSizedBox3,
                              GestureDetector(
                                onTap: () {
                                  fullnameFocusNode.unfocus();
                                  emailFocusNode.unfocus();
                                  phonenumberFocusNode.unfocus();
                                  countryFocusNode.unfocus();
                                  messageFocusNode.unfocus();
                                  String name = fullnameController.text;
                                  String email = emailController.text;
                                  String phone_number = phonenumberController.text;
                                  String msg = messageController.text;
                                  if(name.isEmpty){
                                    Utility.showFlutterToast( "Enter Your Name");
                                  }else if(email.isEmpty){
                                    Utility.showFlutterToast( "Enter Your Email");

                                  }else if(!Utility.isEmail(email)){
                                    Utility.showFlutterToast( "Enter Your Valid Email");

                                  }else if(phone_number.isEmpty){
                                    Utility.showFlutterToast( "Enter Your Phone Number");

                                  }else if(msg.isEmpty){
                                    Utility.showFlutterToast( "Enter Your Message");
                                  }else{
                                    addhelpcenterapiRequest(context, name, email, phone_number, msg);
                                  }

                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: CustomButton2(
                                    btnname: MyString.submit,
                                    bg_color: MyColors.lightblueColor,
                                    bordercolor: MyColors.lightblueColor,
                                    height: 58,
                                  ),
                                ),
                              ),
                              // hSizedBox3,
                              // Container(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Container(
                              //         decoration: BoxDecoration(
                              //           gradient: LinearGradient(
                              //             begin: Alignment.center,
                              //             end: Alignment.bottomCenter,
                              //             //  stops: [0.0, 1.0],
                              //             colors: [
                              //               MyColors.color_3F84E5
                              //                   .withOpacity(0.10),
                              //               MyColors.color_3F84E5
                              //                   .withOpacity(0.40),
                              //             ],
                              //           ),
                              //           borderRadius:
                              //           BorderRadius.circular(10),
                              //         ),
                              //         padding: EdgeInsets.all(16),
                              //         child: SvgPicture.asset(
                              //           "a_assets/icons/call.svg",
                              //         ),
                              //       ),
                              //       wSizedBox2,
                              //       Container(
                              //         child: Column(
                              //           crossAxisAlignment: CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               MyString.or_call_us,
                              //               style: TextStyle(
                              //                   color: MyColors.blackColor,
                              //                   fontSize: 16,
                              //                   fontWeight: FontWeight.w700,
                              //                   fontFamily:
                              //                   "s_asset/font/raleway/Raleway-Bold.ttf"),
                              //             ),
                              //             hSizedBox,
                              //             hSizedBox,
                              //             Text(
                              //               "+1 (646) 786-5060",
                              //               style: TextStyle(
                              //                   color: MyColors.lightblueColor,
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.w600,
                              //                   fontFamily:
                              //                   "s_asset/font/raleway/Raleway-SemiBold.ttf"),
                              //             ),
                              //
                              //           ],
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),

                              hSizedBox4,
                            ]),
                          )))
                ]),
              ),
            )));
  }

  textfield(
      TextEditingController controller,
      String hinttext,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.all(22),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.1),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  messagetextfield(
      TextEditingController controller,
      String hinttext,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLines: 6,
        textInputAction: textInputAction,
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.all(22),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.1),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  showbottomsheet(BuildContext context) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: MyColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.86,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: SetupNewPinCodeScreen());
      },
    );
  }

  String slectedcountrCode="+1";
  Future<void> _onCountryChange(CountryCode countryCode ) async {
    //TODO : manipulate the selected country code here
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    slectedcountrCode=countryCode.toString();
    print("New Country selected:>>>>" + slectedcountrCode);
    print("Country ISO code :>>>>" + countryCode.code.toString());
    print("Country name code :>>>>" + countryCode.name.toString());
    print("Country dialCode code :>>>>" + countryCode.dialCode.toString());
    // sharedPreferences.setString('CountryISOCode',countryCode.code.toString());
    setState(() {});

  }

  textphonefield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
          color: MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width/1.5,
      child: TextField(
        controller:controller ,
        maxLength: 10,
        focusNode:  focusNode,
        textInputAction:textInputAction,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.all(22),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          counterText: ''
          //border: InputBorder.none,
        ),

        keyboardType:textInputType,

        // Only numbers can be entered
      ),
    );
  }

  Future <void> addhelpcenterapiRequest(BuildContext context,String name,String email,String phone_number,String msg) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    request['name'] = name;
    request['email'] = email;
    request['country_code'] = slectedcountrCode.replaceAll("+", "");
    request['phone'] = phone_number;
    request['message'] = msg;




    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.addhelpcenterapi),
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
      Utility.showFlutterToast( jsonResponse['message']);
      Navigator.pop(context);
      // this.widget.OncallBack();


      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast( jsonResponse['message']);
      setState(() {});
    }

    return;

  }



}
