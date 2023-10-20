import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:moneytos/main.dart';
import 'package:moneytos/model/account_detailsModel.dart';
import 'package:moneytos/model/reasonforSendingModel.dart';
import 'package:moneytos/model/usermodel.dart';
import 'package:moneytos/model/userprefences.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/services/Apiservices.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/loginscreen/dashboard_LoginScreen.dart';
import 'package:moneytos/view/loginscreen/foregot_otpScreen.dart';
import 'package:moneytos/view/loginscreen/loginscreen.dart';
import 'package:moneytos/view/loginscreen2.dart';
import 'dart:convert' as convert;

import 'package:moneytos/view/otpverifyscreen/otpverifyscreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constance/customLoader/customLoader.dart';
import '../model/RecipientFiealdModel.dart';
import '../model/chart_Model.dart';
import '../model/documentDetailModel.dart';
import '../view/changepasswordscreen/changepasswordscreen.dart';
import '../view/dash_settingscreen/setting_changePass/setting_changePassword.dart';
import '../view/dash_settingscreen/setting_vaerification_screen.dart';
import '../view/dash_settingscreen/setting_verification_successfully_screen.dart';
import '../view/home/s_home/selectdeliverymethod/selectdeliverymethod.dart';
import '../view/otpverifyscreen/LoginOtpVerifyScreen.dart';

class Webservices{




  static Future<void> submitContactNumber(BuildContext context, String mobile_number,
      String country_code,String name,String lastname,String password,String email,String country,String city,String referralCode,
      // String device_type,
      // String device_id,String fcm_token
      ) async {
  //  SharedPreferences p = await SharedPreferences.getInstance();
   // var token = p.getString("token");
   // String email
    var request = {};
    request['mobile_number'] = mobile_number;
    request['country_code'] = country_code.replaceAll("+", "");

    // otpo
    print("request ${request}");

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
    if (jsonResponse['status'] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => OtpVerifyScreen(name,lastname,password,email, mobile_number,country_code,country,city,referralCode)));
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.dialogError(context, jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> verifyOtpWithRegister(BuildContext context, String mobile_number,
      String country_code,String otp,String name,String lastname,String email,String password,String country,String city,
       String device_type,
       String device_id,String fcm_token,String referralCode
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    //  SharedPreferences p = await SharedPreferences.getInstance();
    // var token = p.getString("token");
    // String email
    var request = {};
    request['mobile_number'] = mobile_number;
    request['country_code'] = country_code.replaceAll("+", "");
    request['otp'] = otp;
    request['name'] = name+" "+lastname;
    request['email'] = email;
    request['password'] = password;
    request['country'] = country;
    request['state'] = city;
    request['language'] = "en";
    request['timezone'] = "Asia/Kolkata";
    request['device_type'] = device_type;
    request['device_id'] = device_id;
    request['fcm_token'] = fcm_token;
    if(referralCode.isNotEmpty){
      request['referral_id'] = referralCode;
    }



    // otpo
    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.verifyOtpWithRegister),
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

      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen2()));
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      Utility.dialogError(context, jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }


  static Future<void> loginRequest(BuildContext context,
      String mobile_number,String country_code, String password,
      //String timezone,
      String device_type,
      String device_id,
      String fcm_token,
      String ipaddress
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    print("Countrycode...${country_code}");
    SharedPreferences p = await SharedPreferences.getInstance();
    var token = p.getString("token");

    var request = {};

    request['mobile_number'] = mobile_number;
    request['country_code'] = country_code.replaceAll("+", "");
    request['password'] = password;
    request['timezone'] = "Asia/Kolkata";
    request['device_type'] = device_type;
    request['device_id'] = device_id;
    request['fcm_token'] = fcm_token;
    request['client_ip'] = ipaddress;


    // otpo
    // print("request ${request}");
    // print("request url ${Apiservices.login}");
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
      // var userdata = jsonResponse['data'];
      // print("userdata ${userdata}");
      // var users = userdata['userData'];
      // print("user....${users['auth_token']}");
      // UserDataModel authuser = UserDataModel.fromJson(users);
      // print("authuser...${authuser}");
      // print("user... ${authuser.id}");
      // print("user... ${authuser.authToken}");
      //    // p.setBool("login", true);
      // p.setString("auth", authuser.authToken.toString());
      // p.setString("userid", authuser.id.toString());
      // p.setString("mobileVerify", authuser.mobileVerify.toString());
      // p.setString("emailVerified", authuser.emailVerified.toString());
      // Fluttertoast.showToast(msg: jsonResponse['message']);
     // p.getString("emailVerified") == "1" ?
      CustomLoader.ProgressloadingDialog(context, false);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
      // Navigator.of(context, rootNavigator: true)
      //     .pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) {
      //       return  DashboardScreen();
      //     },
      //   ),
      //       (_) => false,
      // );
      Navigator.of(context, rootNavigator: true)
          .push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return  LoginOtpVerifyScreen(mobile_number,country_code.replaceAll("+", ""),password,device_type,device_id,fcm_token,ipaddress);
          },
        ),
      );
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      CustomLoader.ProgressloadingDialog(context, false);
      Utility.dialogError(context, jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> logoutRequest(BuildContext context,
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    var auth = p.getString("auth");
    var request = {};
    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");

    var response = await http.post(Uri.parse(Apiservices.logout),
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
      p.setBool("login", false);
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.clear();

      pushNewScreen(
        context,
        screen: DashboardLoginScreen(),
        withNavBar: false,
      );

      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreenPage()));
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.clear();
      p.setBool("login", false);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> profileRequest(BuildContext context,List<UserDataModel> userlist
      ) async {
//    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    print("auth ${p.getString("auth")}");

    var request = {};

    print("request ${request}");

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
      print("customer_id...>>>>>>>>> ${authuser.magicpay_customer_id.toString()}");

      p.setString("userid", authuser.id.toString());

      UserPreferences().saveUser(authuser);

      userlist.add(authuser);
      print("user...${userlist[0].name}");

      // Fluttertoast.showToast(msg: jsonResponse['message']);
      // CustomLoader.ProgressloadingDialog(context, true);
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      //CustomLoader.ProgressloadingDialog(context, true);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

/*  static Future<void> logoutRequest(BuildContext context,
      ) async {
   // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    var auth = p.getString("auth");
    var request = {};
    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");

    var response = await http.post(Uri.parse(Apiservices.logout),
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
      p.setBool("login", false);
      Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();

      pushNewScreen(
        context,
        screen: DashboardLoginScreen(),
        withNavBar: false,
      );

    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreenPage()));
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
    //  CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }*/

 /* static Future<void> profileRequest(BuildContext context,List<UserDataModel> userlist
      ) async {
   // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    print("auth ${p.getString("auth")}");

    var request = {};

    print("request ${request}");

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
      p.setBool("login", false);


      var userdata = jsonResponse['data'];
      var userresponse = userdata['userData'];

      UserDataModel authuser = UserDataModel.fromJson(userresponse);
      print("user... ${authuser.id}");
      p.setString("auth", authuser.authToken.toString());
      print("user... ${authuser.authToken.toString()}");
      p.setString("userid", authuser.id.toString());

      UserPreferences().saveUser(authuser);

      userlist.add(authuser);
      print("user...${userlist[0].name}");

      Fluttertoast.showToast(msg: jsonResponse['message']);
     // CustomLoader.ProgressloadingDialog(context, true);
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      //CustomLoader.ProgressloadingDialog(context, true);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }*/


  static Future<void> forgotPasswordRequest(BuildContext context, String mobile_number,
      String country_code
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = mobile_number;
    request['country_code'] = country_code.replaceAll("+", "");

    // otpo
    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.forgotPassword),
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
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotOtpVerifyScreen(mobile_number,country_code)));
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      Utility.dialogError(context, jsonResponse['message']);
    }
    return;
  }


  static Future<void> verifyForgotPasswordOtpRequest(BuildContext context, String mobile_number,
      String country_code,String otp
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = mobile_number;
    request['country_code'] = country_code.replaceAll("+", "");
    request['otp'] = otp;

    // otpo
    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.verifyForgotPasswordOtp),
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
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ChangePasswordScreen(mobile_number,country_code,otp)));
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> resetPasswordRequest(BuildContext context, String mobile_number,
      String country_code,String otp,String new_password,String confirm_password
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = mobile_number;
    request['country_code'] = country_code.replaceAll("+", "");
    request['otp'] = otp;
    request['new_password'] = new_password;
    request['confirm_password'] = confirm_password;

    // otpo
    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.resetPassword),
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
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen2()));
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }



  static Future<void> changepasswordRequest(BuildContext context, String old_password,
      String new_password,String confirm_password,
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    var auth = p.getString("auth");
    var request = {};
    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");

    request['old_password'] = old_password;
    request['new_password'] = new_password;
    request['confirm_password'] = confirm_password;


    // otpo
    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.changepassword),
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
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
     Navigator.pop(context);

    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }


  static Future<void> setpinRequest(BuildContext context, String pin,
      ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    var auth = p.getString("auth");
    var request = {};
    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");

    request['pin'] = pin;

    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.setpin),
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
      CustomLoader.ProgressloadingDialog(context, false);
      confirfationDialog(context);

    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }


  static Future<void> uploadDocumentsRequest(BuildContext context,
      String document_type, String document_id, String ducument_front_image, String ducument_back_image,) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences pre = await SharedPreferences.getInstance();

    try {
      print('route is ${Apiservices.uploadDocuments}');
      var request = http.MultipartRequest(
          'POST', Uri.parse(Apiservices.uploadDocuments));
      if (context != null && document_type != null && document_id != null) {
        ducument_front_image == "" ? null :
        request.files
            .add(await http.MultipartFile.fromPath('ducument_front_image', ducument_front_image));

        request.files
            .add(await http.MultipartFile.fromPath('ducument_back_image', ducument_back_image));
        request.fields['document_type'] = document_type;
        request.fields['document_id'] = document_id;
      }


      Map<String, String> headers = {
        "X-AUTHTOKEN": "${pre.getString("auth")}",
        "X-USERID": "${pre.getString("userid")}",
        "content-type": "application/json",
        "accept": "application/json"};

      print('the request is :${headers}');
      print(request.fields);
      print(request.files);
      request.headers.addAll(headers);
      var response = await request.send();
      response.stream.transform(convert.utf8.decoder).listen((event) {
        Map map = convert.jsonDecode(event);
        if (map["status"] == true) {
        //  Navigator.push(context, MaterialPageRoute(builder: (_) => SettingVerificationSuccessfullyScreen()));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Document Added Successfully')),
          );
          DocumentDetailRequest(context,documentdetaillist);
          CustomLoader.ProgressloadingDialog(context, false);

          /// SUCCESS
        } else {
          print(map);
          print('error');
          CustomLoader.ProgressloadingDialog(context, false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('error')),
          );

          /// FAIL
        }
      });
    } catch (e) {
      ///EXCEPTION
      print('error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    }
  }


  static Future<void> DocumentDetailRequest(BuildContext context,List<DocumentDataDetailModel> documentdetaillist
      ) async {
    print("uploadstatus2356457834..}");
    SharedPreferences p = await SharedPreferences.getInstance();
    print("auth ${p.getString("auth")}");

    var request = {};

    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.uploadedDocumentDetail),
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
      var docdata = jsonResponse['data'];
      if (docdata != null) {
      var pdoclist = docdata['DocumentData'];
      print("document list..." + pdoclist.toString());
      if (pdoclist != null) {
        DocumentDataDetailModel documentdetailModel = DocumentDataDetailModel.fromJson(pdoclist);
        documentdetaillist.add(documentdetailModel);
          print("promooooo${documentdetaillist[0].rejectReason}");
        // Fluttertoast.showToast(msg: jsonResponse['message']);
        CustomLoader.ProgressloadingDialog2(context, false);
    }}
    } else {
    //  Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog2(context, false);

    }
    return;
  }



  static Future<void> RecipientFieldRequest(BuildContext context,List<FieldSetsModel> fieldsetlist,List<RecipientFieldsModel> recipientfieldsetlist,List<Options> optionlist
      ) async {
    //CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    print("auth_tocken....${p.getString('auth_Token')}");
    print("country_isoCode3....${p.getString("country_isoCode3")}");
    print("country_Currency_isoCode3....${p.getString("country_Currency_isoCode3")}");
    print("url...."+"https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT");

    var request = {};

    print("request ${request}");

    var response = await http.get(
        Uri.parse(
            "https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT"
        ),
        //body: convert.jsonEncode(request),

        headers: {
         // "Token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImlyUmg0cHJQSGxfdm5KSm15dVdrcyJ9.eyJpc3MiOiJodHRwczovL3JlYWR5cmVtaXQudXMuYXV0aDAuY29tLyIsInN1YiI6IjhpODZuajNxbWJXM3JGV3paeVZkcFJ1ZEowWG14QWFUQGNsaWVudHMiLCJhdWQiOiJodHRwczovL3NhbmRib3gtYXBpLnJlYWR5cmVtaXQuY29tIiwiaWF0IjoxNjYzNTY3OTA3LCJleHAiOjE2NjM2NTQzMDcsImF6cCI6IjhpODZuajNxbWJXM3JGV3paeVZkcFJ1ZEowWG14QWFUIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.krBMI3Up6o4djlRU7ZRzJFV_aMu6-UyWu1g-Jqt3XT7thLBkzeMEpUXOXCRVg8k57stpcNkSVgsKYmHBUEHDjNKLngfGX864TiGgkwcUB1GLCU1B306P6R2R_9nbG5EzKmBjxmPnGf-xWy2wBSm3x7T7pz9gp0NfFFx9njtfSkNmWVTIHdeplauhMtCIFk2u13x2VyqrLv_-GNCvUe5QBz1OTgDDaPhUBp4MWkqBPdHaxH6SeymZ5DanCAUt6GzTJU-hBJ9MW6y4Iv9fw1wr1vsB9CT5eEQ2oMaLGKTXwPPEgl-YqeLixFRtON51c7zQbXa49gNYScBObM7zi9dUCA",
          //"X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
        });
    print(response.body);

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);


    var dataresponse = jsonResponse['fieldSets'];
    print("dataresponse${dataresponse}");
    if(dataresponse != null) {
    //  print("size >>>"+dataresponse.length);
      dataresponse.forEach((element) {
        FieldSetsModel fieldstateModel = FieldSetsModel.fromJson(element);
        fieldsetlist.add(fieldstateModel);
        print("fieldSetId${fieldsetlist[0].fieldSetId}");
        var fieldresponse = element['fields'];
        print("fields.....${fieldresponse}");


        if(fieldresponse != null){
          fieldresponse.forEach((element1) {
            print("element...${element1['isRequired']}");

          //  if(element1['isRequired'] == true){

              RecipientFieldsModel recipientfieldstateModel = RecipientFieldsModel.fromJson(element1);
              if(recipientfieldstateModel.isRequired == true||recipientfieldstateModel.fieldId=="PHONE_NUMBER"){
                recipientfieldsetlist.add(recipientfieldstateModel);
                print("is_required...recipientfieldsetlist${recipientfieldsetlist.length}");
              }


       /*       if(element1['fieldType'] == "DROPDOWN" ) {
                var optiondata = element1['options'];
                print("options...${optiondata}");

                if (optiondata != null) {
                  optiondata.forEach((element2) {
                    Options optionmodel = Options.fromJson(element2);
                    optionlist.add(optionmodel);
                    print("optionmodel ${recipientfieldsetlist[0].name}");
                  });
                }

              }*/
           // }
            else{

            }

          });

        }
      });

    }else{
     // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }


  static Future<void> AddRecipientFieldRequest(BuildContext context,
     var field,String profileimg ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    request['UserType'] = "PERSON";
    request['dstCountryIso3Code'] = "${p.getString("country_isoCode3")}";
    request['dstCurrencyIso3Code'] = "${p.getString("country_Currency_isoCode3")}";
    request['transferMethod'] = "BANK_ACCOUNT";
    request['SenderId'] = "23cab527-e802-4e49-8cc1-78e5c5c8e8df";
    request['accountNumber'] = "333000333";
    request['fields'] = field;


    // otpo
    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.addrecipientfield),
        body: convert.jsonEncode(request),
        headers: {
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("bdjkdshjgh"+jsonResponse.toString());

      String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();
      String recipientId = jsonResponse['recipientId'].toString();
      String senderId = jsonResponse['senderId'].toString();
      print("recipientId...${recipientId}");
      p.setString("recipientId", recipientId);
      p.setString("senderId", senderId);
      p.setString("firstName", firstname);
      p.setString("lastname", lastname);

      print("recipientId22...${p.getString("recipientId")}");
     /* message == "" || message.isEmpty || message == ""? null:*/
      String phone_number="" , phone_code="";
      // List<dynamic> fieldsList = json.decode(jsonResponse['fields']);
      var fieldsList =   jsonResponse["fields"];
      for(int i = 0 ; i< fieldsList.length  ;i++){

        print("fields response>>>> "+fieldsList[i]["id"]);
        if(fieldsList[i]["id"]=="PHONE_NUMBER"){
          phone_number = fieldsList[i]["value"]["number"].toString();
          phone_code = fieldsList[i]["value"]["countryPhoneCode"].toString();
        }


      }
      createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId,phone_code,phone_number);

      CustomLoader.ProgressloadingDialog(context, false);

    } else {
      List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast( errorres[0]["message"]);
      CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  static Future<void> createRecipient2Request(BuildContext context,
      String first_name, String last_name, String profile_img, String countryIso3Code,String recipentId,String phonecode,String phone_number) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      pre.setString("u_first_name", first_name);
      pre.setString("u_last_name", last_name);
      pre.setString("u_phone_number", phone_number);
      pre.setString("u_profile_img", profile_img);
      print('route is ${Apiservices.createRecipient}');
      var request = http.MultipartRequest(
          'POST', Uri.parse(Apiservices.createRecipient));
      if (context != null && first_name != null && last_name != null) {
        profile_img == "" ? null :
        request.files
            .add(await http.MultipartFile.fromPath('profileImage', profile_img));
        request.fields['first_name'] = first_name;
        request.fields['last_name'] = last_name;
        request.fields['countryIso3Code'] = countryIso3Code;
        request.fields['country_name'] = "${pre.getString("country_Name")}";
        request.fields['recipientId'] = recipentId;
        request.fields['phonecode'] = phonecode;
        request.fields['phone_number'] = phone_number;
      }


      Map<String, String> headers = {
        "X-AUTHTOKEN": "${pre.getString("auth")}",
        "X-AUTHTOKEN": "${pre.getString("auth")}",
        "X-USERID": "${pre.getString("userid")}",
        "content-type": "application/json",
        "accept": "application/json"};

      print('the request is :');
      print(request.fields);
      print(request.files);
      request.headers.addAll(headers);
      var response = await request.send();

      response.stream.transform(convert.utf8.decoder).listen((event) {
        Map map = convert.jsonDecode(event);
        print("create response>>>> "+map.toString());
        if (map["status"] == true) {
          CustomLoader.ProgressloadingDialog(context, false);
          pre.setString("recpi_id", map['data']['recipient_server_id'].toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectDeliveryMethodScreen()));

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Create Recipient Successfully')),
          // );


          /// SUCCESS
        } else {
          print(map);
          print('error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('error')),
          );
          CustomLoader.ProgressloadingDialog(context, false);

          /// FAIL
        }
      });
    } catch (e) {
      ///EXCEPTION
      print('error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    }
  }



  static Future<void> AccountDetailsRequest(BuildContext context,List<AccountsDetailModel> accountdetaillist,List<AccountDetailFieldsModel> accountdetailfieldsetlist,
      String receipent_id) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    print("request ${Apiservices.accountDetailapi+receipent_id+"/accounts"}");
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(
        Uri.parse(Apiservices.accountDetailapi+receipent_id+"/accounts"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
        });
    print("fbsdhfbshifgbhjsfbhsbfg>>>>> "+response.body);

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);


    var dataresponse = jsonResponse['accounts'];
    print("dataresponse${dataresponse}");
    if(dataresponse != null) {
      dataresponse.forEach((element) {
        AccountsDetailModel accountModel = AccountsDetailModel.fromJson(element);
        accountdetaillist.add(accountModel);

        var fieldresponse = element['fields'];
        print("fields.....${fieldresponse}");
        if(fieldresponse != null){
          fieldresponse.forEach((element1) {
            AccountDetailFieldsModel accountfieldstateModel = AccountDetailFieldsModel.fromJson(element1);
            accountdetailfieldsetlist.add(accountfieldstateModel);

            print("element...${accountdetailfieldsetlist.length}");

            if(element1['fieldType'] == "DROPDOWN" ) {
              var optiondata = element1['options'];
              print("options...${optiondata}");
             // CustomLoader.ProgressloadingDialog(context, false);

              }
            else{
             //  CustomLoader.ProgressloadingDialog(context, false);
            }


          });

        }
      });

    }else{
    //  CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }



  static Future<void> AccountDetailsitemRequest(BuildContext context,List<AccountsDetailModel> accountdetaillist,List<AccountDetailFieldsModel> accountdetailfieldsetlist,String recipientid,String recipient_account_id
      ) async {
   // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    print("request ${request}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(
        Uri.parse("https://sandbox-api.readyremit.com/v1/recipients/${recipientid}/accounts/${recipient_account_id}"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
        });
    print(response.body);

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print("BankdetailResponse>>>"+jsonResponse.toString());

    p.setString("BankdetailResponse", response.body);
   /* var dataresponse = jsonResponse['accounts'];
    print("iotem${dataresponse}");
    if(dataresponse != null) {
      dataresponse.forEach((element) {*/
        AccountsDetailModel accountModel = AccountsDetailModel.fromJson(jsonResponse);
        accountdetaillist.add(accountModel);

        print("account detail model>>> "+accountdetaillist[0].recipientAccountId.toString());


        var fieldresponse = jsonResponse['fields'];
        print("itemfields.....${fieldresponse}");
        if(fieldresponse != null){
          fieldresponse.forEach((element) {
            AccountDetailFieldsModel accountfieldstateModel = AccountDetailFieldsModel.fromJson(element);
            accountdetailfieldsetlist.add(accountfieldstateModel);

            print("element...${accountdetailfieldsetlist.length}");

          });
        }
    //  });

    else{
    //  CustomLoader.ProgressloadingDialog2(context, false);
    }

    return;
  }

  static Future<void> ReasonForsendingRequest(BuildContext context,
      List<ReasonForSendingFieldSetsModel> reasonforlist,
      List<ReasongforSendinItemFieldsModel> reasongforSendinItemFieldslist,
      List<ReasonforSendingOptionsModel> optionlistt
      ) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    print("request ${request}");

    var response = await http.get(
        Uri.parse("https://sandbox-api.readyremit.com/v1/transfer-fields?recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
        });

    print(response.body);
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);


    var fieldSetsdata = jsonResponse['fieldSets'];
    if(fieldSetsdata != null){
      print("fieldSetsdata....${fieldSetsdata}");

      fieldSetsdata.forEach((element) {
        ReasonForSendingFieldSetsModel reasonModel = ReasonForSendingFieldSetsModel.fromJson(element);
        reasonforlist.add(reasonModel);

        var fieldlist = element['fields'];
         if(fieldlist != null){
           print("fieldlist....${fieldSetsdata}");

           fieldlist.forEach((e) {

             ReasongforSendinItemFieldsModel reasonforModel = ReasongforSendinItemFieldsModel.fromJson(e);
             reasongforSendinItemFieldslist.add(reasonforModel);
             var optionlist = e['options'];

             if(optionlist != null) {
               print("options..${optionlist}");

               optionlist.forEach((ele) {
                 ReasonforSendingOptionsModel elementModel = ReasonforSendingOptionsModel
                     .fromJson(ele);
                 optionlistt.add(elementModel);

                 print("options2..${optionlist}");
               });
             }
           });




         }




      });
      //CustomLoader.ProgressloadingDialog(context, false);

    }else{
     // CustomLoader.ProgressloadingDialog(context, false);
  }
    return;
  }

  static Future<void> ChartRecipientRequest(BuildContext context,
      List<ChartDataModel> chartdatalist,
      List<ChartRecipientDataModel> ChartRecipientDatlist,
      List<TxnGraphDataModel> txnGraphDatalist,

      String year

      ) async {

    SharedPreferences p = await SharedPreferences.getInstance();
    print("dgsfgejf${p.getString("auth")}");

    var request = {};

    print("chartrequest ${request}");
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(
        Uri.parse(Apiservices.chartRecipientapi+"?year="+year),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
        });

    print(response.body);
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);


    var chartresponse = jsonResponse['data'];
    if(chartresponse != null){
      print("chart....${chartresponse}");

      ChartDataModel chartModel = ChartDataModel.fromJson(chartresponse);
      chartdatalist.add(chartModel);

      var chartrecipientresponse = chartresponse['recipientData'];
      if(chartrecipientresponse != null) {
        print("chart.. chart....${chartrecipientresponse}");

        ChartRecipientDatlist.clear();
        chartrecipientresponse.forEach((e) {
          ChartRecipientDataModel chartRecipientDataModel = ChartRecipientDataModel
              .fromJson(e);
          ChartRecipientDatlist.add(chartRecipientDataModel);
        });
      }

      var graphdata = chartresponse['TxnGraphData'];
      if(graphdata != null){
        print("TxnGraphData ${graphdata}");
        txnGraphDatalist.clear();
        graphdata.forEach((ele) {
          TxnGraphDataModel chartRecipientDataModel = TxnGraphDataModel.fromJson(ele);
          txnGraphDatalist.add(chartRecipientDataModel);

        });

        print("chartRecipientDataModel...${ChartRecipientDatlist.length}");
        print("TxnGraphData>>>>>>...${txnGraphDatalist.length}");


      }
    }else{
    }
    return;
  }

}