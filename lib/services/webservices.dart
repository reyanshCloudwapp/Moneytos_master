import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneytos/main.dart';
import 'package:moneytos/model/account_detailsModel.dart';
import 'package:moneytos/model/reasonforSendingModel.dart';
import 'package:moneytos/model/usermodel.dart';
import 'package:moneytos/model/userprefences.dart';
import 'package:moneytos/screens/changepasswordscreen/changepasswordscreen.dart';
import 'package:moneytos/screens/dash_settingscreen/setting_changePass/setting_changePassword.dart';
import 'package:moneytos/screens/home/s_home/selectdeliverymethod/selectdeliverymethod.dart';
import 'package:moneytos/screens/loginscreen/dashboard_LoginScreen.dart';
import 'package:moneytos/screens/loginscreen/foregot_otpScreen.dart';
import 'package:moneytos/screens/loginscreen2.dart';
import 'package:moneytos/screens/otpverifyscreen/LoginOtpVerifyScreen.dart';
import 'package:moneytos/screens/otpverifyscreen/otpverifyscreen.dart';
import 'package:moneytos/services/Apiservices.dart';
import 'package:moneytos/services/s_Api/s_utils/Utility.dart';
import 'package:moneytos/utils/constance/customLoader/customLoader.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/RecipientFiealdModel.dart';
import '../model/chart_Model.dart';
import '../model/documentDetailModel.dart';

class Webservices {
  static Future<void> submitContactNumber(
    BuildContext context,
    String mobileNumber,
    String countryCode,
    String name,
    String lastname,
    String password,
    String email,
    String country,
    String city,
    String referralCode,
    // String device_type,
    // String device_id,String fcm_token
  ) async {
    //  SharedPreferences p = await SharedPreferences.getInstance();
    // var token = p.getString("token");
    // String email
    var request = {};
    request['mobile_number'] = mobileNumber;
    request['country_code'] = countryCode.replaceAll('+', '');

    // otpo
    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.submitContactNumber),
      body: jsonEncode(request),
      headers: {
        'X-CLIENT': 'e0271afd8a3b8257af70deacee4',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerifyScreen(
            name,
            lastname,
            password,
            email,
            mobileNumber,
            countryCode,
            country,
            city,
            referralCode,
          ),
        ),
      );
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.dialogError(context, jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> verifyOtpWithRegister(
    BuildContext context,
    String mobileNumber,
    String countryCode,
    String otp,
    String name,
    String lastname,
    String email,
    String password,
    String country,
    String city,
    String deviceType,
    String deviceId,
    String fcmToken,
    String referralCode,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    //  SharedPreferences p = await SharedPreferences.getInstance();
    // var token = p.getString("token");
    // String email
    var request = {};
    request['mobile_number'] = mobileNumber;
    request['country_code'] = countryCode.replaceAll('+', '');
    request['otp'] = otp;
    request['name'] = '$name $lastname';
    request['email'] = email;
    request['password'] = password;
    request['country'] = country;
    request['state'] = city;
    request['language'] = 'en';
    request['timezone'] = 'Asia/Kolkata';
    request['device_type'] = deviceType;
    request['device_id'] = deviceId;
    request['fcm_token'] = fcmToken;
    if (referralCode.isNotEmpty) {
      request['referral_id'] = referralCode;
    }

    // otpo
    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.verifyOtpWithRegister),
      body: jsonEncode(request),
      headers: {
        'X-CLIENT': 'e0271afd8a3b8257af70deacee4',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen2()),
      );
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      Utility.dialogError(context, jsonResponse['message']);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> loginRequest(
    BuildContext context,
    String mobileNumber,
    String countryCode,
    String password,
    //String timezone,
    String deviceType,
    String deviceId,
    String fcmToken,
    String ipaddress,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    debugPrint('Countrycode...$countryCode');
    SharedPreferences p = await SharedPreferences.getInstance();

    var request = {};

    request['mobile_number'] = mobileNumber;
    request['country_code'] = countryCode.replaceAll('+', '');
    request['password'] = password;
    request['timezone'] = 'Asia/Kolkata';
    request['device_type'] = deviceType;
    request['device_id'] = deviceId;
    request['fcm_token'] = fcmToken;
    request['client_ip'] = ipaddress;

    // otpo
    // debugPrint("request ${request}");
    // debugPrint("request url ${Apiservices.login}");
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.post(
      Uri.parse(Apiservices.sendLoginOtp),
      body: jsonEncode(request),
      headers: {
        'X-CLIENT': 'e0271afd8a3b8257af70deacee4',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      debugPrint('dfhdfjhdf');
      // var userdata = jsonResponse['data'];
      // debugPrint("userdata ${userdata}");
      // var users = userdata['userData'];
      // debugPrint("user....${users['auth_token']}");
      // UserDataModel authuser = UserDataModel.fromJson(users);
      // debugPrint("authuser...${authuser}");
      // debugPrint("user... ${authuser.id}");
      // debugPrint("user... ${authuser.authToken}");
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
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginOtpVerifyScreen(
              mobileNumber,
              countryCode.replaceAll('+', ''),
              password,
              deviceType,
              deviceId,
              fcmToken,
              ipaddress,
            );
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

  static Future<void> logoutRequest(
    BuildContext context,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    var auth = p.getString('auth');
    var request = {};
    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    var response = await http.post(
      Uri.parse(Apiservices.logout),
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
      p.setBool('login', false);
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.clear();

      pushNewScreen(
        context,
        screen: const DashboardLoginScreen(),
        withNavBar: false,
      );

      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreenPage()));
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.clear();
      p.setBool('login', false);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> profileRequest(
    BuildContext context,
    List<UserDataModel> userlist,
  ) async {
//    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    debugPrint("auth ${p.getString("auth")}");

    var request = {};

    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.profile),
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
      // p.setBool("login", true);

      var userdata = jsonResponse['data'];
      var userresponse = userdata['userData'];

      UserDataModel authuser = UserDataModel.fromJson(userresponse);
      debugPrint('user... ${authuser.id}');

      p.setString('auth...>>>>>>>>', authuser.authToken.toString());
      p.setString('customer_id', authuser.magicpay_customer_id.toString());
      debugPrint('user...>>>>>>>>> ${authuser.authToken.toString()}');
      debugPrint(
        'customer_id...>>>>>>>>> ${authuser.magicpay_customer_id.toString()}',
      );

      p.setString('userid', authuser.id.toString());

      UserPreferences().saveUser(authuser);

      userlist.add(authuser);
      debugPrint('user...${userlist[0].name}');

      // Fluttertoast.showToast(msg: jsonResponse['message']);
      // CustomLoader.ProgressloadingDialog(context, true);
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
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
    debugPrint("request ${request}");
    debugPrint("userid ${userid}");
    debugPrint("auth ${auth}");

    var response = await http.post(Uri.parse(Apiservices.logout),
        body: jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });

    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse);
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
    debugPrint("auth ${p.getString("auth")}");

    var request = {};

    debugPrint("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.profile),
        body: jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse);
    if (jsonResponse['status'] == true) {
      p.setBool("login", false);


      var userdata = jsonResponse['data'];
      var userresponse = userdata['userData'];

      UserDataModel authuser = UserDataModel.fromJson(userresponse);
      debugPrint("user... ${authuser.id}");
      p.setString("auth", authuser.authToken.toString());
      debugPrint("user... ${authuser.authToken.toString()}");
      p.setString("userid", authuser.id.toString());

      UserPreferences().saveUser(authuser);

      userlist.add(authuser);
      debugPrint("user...${userlist[0].name}");

      Fluttertoast.showToast(msg: jsonResponse['message']);
     // CustomLoader.ProgressloadingDialog(context, true);
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      //CustomLoader.ProgressloadingDialog(context, true);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }*/

  static Future<void> forgotPasswordRequest(
    BuildContext context,
    String mobileNumber,
    String countryCode,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = mobileNumber;
    request['country_code'] = countryCode.replaceAll('+', '');

    // otpo
    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.forgotPassword),
      body: jsonEncode(request),
      headers: {
        'X-CLIENT': 'e0271afd8a3b8257af70deacee4',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ForgotOtpVerifyScreen(mobileNumber, countryCode),
        ),
      );
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      Utility.dialogError(context, jsonResponse['message']);
    }
    return;
  }

  static Future<void> verifyForgotPasswordOtpRequest(
    BuildContext context,
    String mobileNumber,
    String countryCode,
    String otp,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = mobileNumber;
    request['country_code'] = countryCode.replaceAll('+', '');
    request['otp'] = otp;

    // otpo
    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.verifyForgotPasswordOtp),
      body: jsonEncode(request),
      headers: {
        'X-CLIENT': 'e0271afd8a3b8257af70deacee4',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(mobileNumber, countryCode, otp),
        ),
      );
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> resetPasswordRequest(
    BuildContext context,
    String mobileNumber,
    String countryCode,
    String otp,
    String newPassword,
    String confirmPassword,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = mobileNumber;
    request['country_code'] = countryCode.replaceAll('+', '');
    request['otp'] = otp;
    request['new_password'] = newPassword;
    request['confirm_password'] = confirmPassword;

    // otpo
    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.resetPassword),
      body: jsonEncode(request),
      headers: {
        'X-CLIENT': 'e0271afd8a3b8257af70deacee4',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen2()),
      );
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> changepasswordRequest(
    BuildContext context,
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    var auth = p.getString('auth');
    var request = {};
    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    request['old_password'] = oldPassword;
    request['new_password'] = newPassword;
    request['confirm_password'] = confirmPassword;

    // otpo
    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.changepassword),
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
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.pop(context);
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> setpinRequest(
    BuildContext context,
    String pin,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    var auth = p.getString('auth');
    var request = {};
    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    request['pin'] = pin;

    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.setpin),
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
      CustomLoader.ProgressloadingDialog(context, false);
      confirfationDialog(context);
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  static Future<void> uploadDocumentsRequest(
    BuildContext context,
    String documentType,
    String documentId,
    String ducumentFrontImage,
    String ducumentBackImage,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences pre = await SharedPreferences.getInstance();

    try {
      debugPrint('route is ${Apiservices.uploadDocuments}');
      var request =
          http.MultipartRequest('POST', Uri.parse(Apiservices.uploadDocuments));
      if (context != null && documentType != null && documentId != null) {
        ducumentFrontImage == ''
            ? null
            : request.files.add(
                await http.MultipartFile.fromPath(
                  'ducument_front_image',
                  ducumentFrontImage,
                ),
              );

        request.files.add(
          await http.MultipartFile.fromPath(
            'ducument_back_image',
            ducumentBackImage,
          ),
        );
        request.fields['document_type'] = documentType;
        request.fields['document_id'] = documentId;
      }

      Map<String, String> headers = {
        'X-AUTHTOKEN': "${pre.getString("auth")}",
        'X-USERID': "${pre.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      };

      debugPrint('the request is :$headers');
      debugPrint(request.fields as String?);
      debugPrint(request.files as String?);
      request.headers.addAll(headers);
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((event) {
        Map map = jsonDecode(event);
        if (map['status'] == true) {
          //  Navigator.push(context, MaterialPageRoute(builder: (_) => SettingVerificationSuccessfullyScreen()));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Document Added Successfully')),
          );
          DocumentDetailRequest(context, documentdetaillist);
          CustomLoader.ProgressloadingDialog(context, false);

          /// SUCCESS
        } else {
          debugPrint(map as String?);
          debugPrint('error');
          CustomLoader.ProgressloadingDialog(context, false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('error')),
          );

          /// FAIL
        }
      });
    } catch (e) {
      ///EXCEPTION
      debugPrint('error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    }
  }

  static Future<void> DocumentDetailRequest(
    BuildContext context,
    List<DocumentDataDetailModel> documentdetaillist,
  ) async {
    debugPrint('uploadstatus2356457834..}');
    SharedPreferences p = await SharedPreferences.getInstance();
    debugPrint("auth ${p.getString("auth")}");

    var request = {};

    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.uploadedDocumentDetail),
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
      var docdata = jsonResponse['data'];
      if (docdata != null) {
        var pdoclist = docdata['DocumentData'];
        debugPrint('document list...$pdoclist');
        if (pdoclist != null) {
          DocumentDataDetailModel documentdetailModel =
              DocumentDataDetailModel.fromJson(pdoclist);
          documentdetaillist.add(documentdetailModel);
          debugPrint('promooooo${documentdetaillist[0].rejectReason}');
          // Fluttertoast.showToast(msg: jsonResponse['message']);
          CustomLoader.ProgressloadingDialog2(context, false);
        }
      }
    } else {
      //  Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog2(context, false);
    }
    return;
  }

  static Future<void> RecipientFieldRequest(
    BuildContext context,
    List<FieldSetsModel> fieldsetlist,
    List<RecipientFieldsModel> recipientfieldsetlist,
    List<Options> optionlist,
  ) async {
    //CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    debugPrint("auth_tocken....${p.getString('auth_Token')}");
    debugPrint("country_isoCode3....${p.getString("country_isoCode3")}");
    debugPrint(
      "country_Currency_isoCode3....${p.getString("country_Currency_isoCode3")}",
    );
    debugPrint(
      'url....'
      "https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT",
    );

    var request = {};

    debugPrint('request $request');

    var response = await http.get(
      Uri.parse(
        "https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT",
      ),
      //body: jsonEncode(request),

      headers: {
        // "Token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImlyUmg0cHJQSGxfdm5KSm15dVdrcyJ9.eyJpc3MiOiJodHRwczovL3JlYWR5cmVtaXQudXMuYXV0aDAuY29tLyIsInN1YiI6IjhpODZuajNxbWJXM3JGV3paeVZkcFJ1ZEowWG14QWFUQGNsaWVudHMiLCJhdWQiOiJodHRwczovL3NhbmRib3gtYXBpLnJlYWR5cmVtaXQuY29tIiwiaWF0IjoxNjYzNTY3OTA3LCJleHAiOjE2NjM2NTQzMDcsImF6cCI6IjhpODZuajNxbWJXM3JGV3paeVZkcFJ1ZEowWG14QWFUIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.krBMI3Up6o4djlRU7ZRzJFV_aMu6-UyWu1g-Jqt3XT7thLBkzeMEpUXOXCRVg8k57stpcNkSVgsKYmHBUEHDjNKLngfGX864TiGgkwcUB1GLCU1B306P6R2R_9nbG5EzKmBjxmPnGf-xWy2wBSm3x7T7pz9gp0NfFFx9njtfSkNmWVTIHdeplauhMtCIFk2u13x2VyqrLv_-GNCvUe5QBz1OTgDDaPhUBp4MWkqBPdHaxH6SeymZ5DanCAUt6GzTJU-hBJ9MW6y4Iv9fw1wr1vsB9CT5eEQ2oMaLGKTXwPPEgl-YqeLixFRtON51c7zQbXa49gNYScBObM7zi9dUCA",
        //"X-USERID": "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());

    var dataresponse = jsonResponse['fieldSets'];
    debugPrint('dataresponse$dataresponse');
    if (dataresponse != null) {
      //  debugPrint("size >>>"+dataresponse.length);
      dataresponse.forEach((element) {
        FieldSetsModel fieldstateModel = FieldSetsModel.fromJson(element);
        fieldsetlist.add(fieldstateModel);
        debugPrint('fieldSetId${fieldsetlist[0].fieldSetId}');
        var fieldresponse = element['fields'];
        debugPrint('fields.....$fieldresponse');

        if (fieldresponse != null) {
          fieldresponse.forEach((element1) {
            debugPrint("element...${element1['isRequired']}");

            //  if(element1['isRequired'] == true){

            RecipientFieldsModel recipientfieldstateModel =
                RecipientFieldsModel.fromJson(element1);
            if (recipientfieldstateModel.isRequired == true ||
                recipientfieldstateModel.fieldId == 'PHONE_NUMBER') {
              recipientfieldsetlist.add(recipientfieldstateModel);
              debugPrint(
                'is_required...recipientfieldsetlist${recipientfieldsetlist.length}',
              );
            }

            /*       if(element1['fieldType'] == "DROPDOWN" ) {
                var optiondata = element1['options'];
                debugPrint("options...${optiondata}");

                if (optiondata != null) {
                  optiondata.forEach((element2) {
                    Options optionmodel = Options.fromJson(element2);
                    optionlist.add(optionmodel);
                    debugPrint("optionmodel ${recipientfieldsetlist[0].name}");
                  });
                }

              }*/
            // }
            else {}
          });
        }
      });
    } else {
      // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  static Future<void> AddRecipientFieldRequest(
    BuildContext context,
    var field,
    String profileimg,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    request['UserType'] = 'PERSON';
    request['dstCountryIso3Code'] = "${p.getString("country_isoCode3")}";
    request['dstCurrencyIso3Code'] =
        "${p.getString("country_Currency_isoCode3")}";
    request['transferMethod'] = 'BANK_ACCOUNT';
    request['SenderId'] = '23cab527-e802-4e49-8cc1-78e5c5c8e8df';
    request['accountNumber'] = '333000333';
    request['fields'] = field;

    // otpo
    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.addrecipientfield),
      body: jsonEncode(request),
      headers: {
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('bdjkdshjgh$jsonResponse');

      String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();
      String recipientId = jsonResponse['recipientId'].toString();
      String senderId = jsonResponse['senderId'].toString();
      debugPrint('recipientId...$recipientId');
      p.setString('recipientId', recipientId);
      p.setString('senderId', senderId);
      p.setString('firstName', firstname);
      p.setString('lastname', lastname);

      debugPrint("recipientId22...${p.getString("recipientId")}");
      /* message == "" || message.isEmpty || message == ""? null:*/
      String phoneNumber = '', phoneCode = '';
      // List<dynamic> fieldsList = json.decode(jsonResponse['fields']);
      var fieldsList = jsonResponse['fields'];
      for (int i = 0; i < fieldsList.length; i++) {
        debugPrint("fields response>>>> ${fieldsList[i]["id"]}");
        if (fieldsList[i]['id'] == 'PHONE_NUMBER') {
          phoneNumber = fieldsList[i]['value']['number'].toString();
          phoneCode = fieldsList[i]['value']['countryPhoneCode'].toString();
        }
      }
      createRecipient2Request(
        context,
        firstname,
        lastname,
        profileimg,
        "${p.getString("country_isoCode3")}",
        recipientId,
        phoneCode,
        phoneNumber,
      );

      CustomLoader.ProgressloadingDialog(context, false);
    } else {
      List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast(errorres[0]['message']);
      CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  static Future<void> createRecipient2Request(
    BuildContext context,
    String firstName,
    String lastName,
    String profileImg,
    String countryIso3Code,
    String recipentId,
    String phonecode,
    String phoneNumber,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      pre.setString('u_first_name', firstName);
      pre.setString('u_last_name', lastName);
      pre.setString('u_phone_number', phoneNumber);
      pre.setString('u_profile_img', profileImg);
      debugPrint('route is ${Apiservices.createRecipient}');
      var request =
          http.MultipartRequest('POST', Uri.parse(Apiservices.createRecipient));
      if (context != null && firstName != null && lastName != null) {
        profileImg == ''
            ? null
            : request.files.add(
                await http.MultipartFile.fromPath('profileImage', profileImg),
              );
        request.fields['first_name'] = firstName;
        request.fields['last_name'] = lastName;
        request.fields['countryIso3Code'] = countryIso3Code;
        request.fields['country_name'] = "${pre.getString("country_Name")}";
        request.fields['recipientId'] = recipentId;
        request.fields['phonecode'] = phonecode;
        request.fields['phone_number'] = phoneNumber;
      }

      Map<String, String> headers = {
        'X-AUTHTOKEN': "${pre.getString("auth")}",
        'X-USERID': "${pre.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      };

      debugPrint('the request is :');
      debugPrint(request.fields as String?);
      debugPrint(request.files as String?);
      request.headers.addAll(headers);
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((event) {
        Map map = jsonDecode(event);
        debugPrint('create response>>>> $map');
        if (map['status'] == true) {
          CustomLoader.ProgressloadingDialog(context, false);
          pre.setString(
            'recpi_id',
            map['data']['recipient_server_id'].toString(),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectDeliveryMethodScreen(),
            ),
          );

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Create Recipient Successfully')),
          // );

          /// SUCCESS
        } else {
          debugPrint(map as String?);
          debugPrint('error');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('error')),
          );
          CustomLoader.ProgressloadingDialog(context, false);

          /// FAIL
        }
      });
    } catch (e) {
      ///EXCEPTION
      debugPrint('error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    }
  }

  static Future<void> AccountDetailsRequest(
    BuildContext context,
    List<AccountsDetailModel> accountdetaillist,
    List<AccountDetailFieldsModel> accountdetailfieldsetlist,
    String receipentId,
  ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    debugPrint(
      "request ${"${Apiservices.accountDetailapi}$receipentId/accounts"}",
    );
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.get(
      Uri.parse('${Apiservices.accountDetailapi}$receipentId/accounts'),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
      },
    );
    debugPrint('fbsdhfbshifgbhjsfbhsbfg>>>>> ${response.body}');

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());

    var dataresponse = jsonResponse['accounts'];
    debugPrint('dataresponse$dataresponse');
    if (dataresponse != null) {
      dataresponse.forEach((element) {
        AccountsDetailModel accountModel =
            AccountsDetailModel.fromJson(element);
        accountdetaillist.add(accountModel);

        var fieldresponse = element['fields'];
        debugPrint('fields.....$fieldresponse');
        if (fieldresponse != null) {
          fieldresponse.forEach((element1) {
            AccountDetailFieldsModel accountfieldstateModel =
                AccountDetailFieldsModel.fromJson(element1);
            accountdetailfieldsetlist.add(accountfieldstateModel);

            debugPrint('element...${accountdetailfieldsetlist.length}');

            if (element1['fieldType'] == 'DROPDOWN') {
              var optiondata = element1['options'];
              debugPrint('options...$optiondata');
              // CustomLoader.ProgressloadingDialog(context, false);
            } else {
              //  CustomLoader.ProgressloadingDialog(context, false);
            }
          });
        }
      });
    } else {
      //  CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  static Future<void> AccountDetailsitemRequest(
    BuildContext context,
    List<AccountsDetailModel> accountdetaillist,
    List<AccountDetailFieldsModel> accountdetailfieldsetlist,
    String recipientid,
    String recipientAccountId,
  ) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    debugPrint('request $request');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        'https://sandbox-api.readyremit.com/v1/recipients/$recipientid/accounts/$recipientAccountId',
      ),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint('BankdetailResponse>>>$jsonResponse');

    p.setString('BankdetailResponse', response.body);
    /* var dataresponse = jsonResponse['accounts'];
    debugPrint("iotem${dataresponse}");
    if(dataresponse != null) {
      dataresponse.forEach((element) {*/
    AccountsDetailModel accountModel =
        AccountsDetailModel.fromJson(jsonResponse);
    accountdetaillist.add(accountModel);

    debugPrint(
      'account detail model>>> ${accountdetaillist[0].recipientAccountId}',
    );

    var fieldresponse = jsonResponse['fields'];
    debugPrint('itemfields.....$fieldresponse');
    if (fieldresponse != null) {
      fieldresponse.forEach((element) {
        AccountDetailFieldsModel accountfieldstateModel =
            AccountDetailFieldsModel.fromJson(element);
        accountdetailfieldsetlist.add(accountfieldstateModel);

        debugPrint('element...${accountdetailfieldsetlist.length}');
      });
    }
    //  });

    else {
      //  CustomLoader.ProgressloadingDialog2(context, false);
    }

    return;
  }

  static Future<void> ReasonForsendingRequest(
    BuildContext context,
    List<ReasonForSendingFieldSetsModel> reasonforlist,
    List<ReasongforSendinItemFieldsModel> reasongforSendinItemFieldslist,
    List<ReasonforSendingOptionsModel> optionlistt,
  ) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    debugPrint('request $request');

    var response = await http.get(
      Uri.parse(
        "https://sandbox-api.readyremit.com/v1/transfer-fields?recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT",
      ),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
      },
    );

    debugPrint(response.body);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());

    var fieldSetsdata = jsonResponse['fieldSets'];
    if (fieldSetsdata != null) {
      debugPrint('fieldSetsdata....$fieldSetsdata');

      fieldSetsdata.forEach((element) {
        ReasonForSendingFieldSetsModel reasonModel =
            ReasonForSendingFieldSetsModel.fromJson(element);
        reasonforlist.add(reasonModel);

        var fieldlist = element['fields'];
        if (fieldlist != null) {
          debugPrint('fieldlist....$fieldSetsdata');

          fieldlist.forEach((e) {
            ReasongforSendinItemFieldsModel reasonforModel =
                ReasongforSendinItemFieldsModel.fromJson(e);
            reasongforSendinItemFieldslist.add(reasonforModel);
            var optionlist = e['options'];

            if (optionlist != null) {
              debugPrint('options..$optionlist');

              optionlist.forEach((ele) {
                ReasonforSendingOptionsModel elementModel =
                    ReasonforSendingOptionsModel.fromJson(ele);
                optionlistt.add(elementModel);

                debugPrint('options2..$optionlist');
              });
            }
          });
        }
      });
      //CustomLoader.ProgressloadingDialog(context, false);
    } else {
      // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  static Future<void> ChartRecipientRequest(
    BuildContext context,
    List<ChartDataModel> chartdatalist,
    List<ChartRecipientDataModel> ChartRecipientDatlist,
    List<TxnGraphDataModel> txnGraphDatalist,
    String year,
  ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    debugPrint("dgsfgejf${p.getString("auth")}");

    var request = {};

    debugPrint('chartrequest $request');
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.get(
      Uri.parse('${Apiservices.chartRecipientapi}?year=$year'),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
      },
    );

    debugPrint(response.body);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());

    var chartresponse = jsonResponse['data'];
    if (chartresponse != null) {
      debugPrint('chart....$chartresponse');

      ChartDataModel chartModel = ChartDataModel.fromJson(chartresponse);
      chartdatalist.add(chartModel);

      var chartrecipientresponse = chartresponse['recipientData'];
      if (chartrecipientresponse != null) {
        debugPrint('chart.. chart....$chartrecipientresponse');

        ChartRecipientDatlist.clear();
        chartrecipientresponse.forEach((e) {
          ChartRecipientDataModel chartRecipientDataModel =
              ChartRecipientDataModel.fromJson(e);
          ChartRecipientDatlist.add(chartRecipientDataModel);
        });
      }

      var graphdata = chartresponse['TxnGraphData'];
      if (graphdata != null) {
        debugPrint('TxnGraphData $graphdata');
        txnGraphDatalist.clear();
        graphdata.forEach((ele) {
          TxnGraphDataModel chartRecipientDataModel =
              TxnGraphDataModel.fromJson(ele);
          txnGraphDatalist.add(chartRecipientDataModel);
        });

        debugPrint('chartRecipientDataModel...${ChartRecipientDatlist.length}');
        debugPrint('TxnGraphData>>>>>>...${txnGraphDatalist.length}');
      }
    } else {}
    return;
  }
}
