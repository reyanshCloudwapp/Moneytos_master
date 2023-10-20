import 'dart:async';
import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/home/s_home/go_toreview_screen/go_toreview_screen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/sheduled_successfully_screen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/treansfer_enter_pin_code.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/nium_payout_request.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/S_ApiResponse/AccountSettingResponse.dart';
import '../../s_Api/S_ApiResponse/BankDetailResponse.dart';
import '../../s_Api/S_Request/TransactionChargeRequest.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../s_Api/s_utils/timer_change_notifier.dart';
import '../../services/Apiservices.dart';
import 'dart:convert' as convert;

import '../home/s_home/sendsuccessfullytransferscreen/sendsuccessfulyscreen.dart';

class FaceAndTouchScreen extends StatefulWidget {
  String selected_acc_id;
  String selected_acc_name;
  String selected_payment_type;
  String selected_last4;
  String? cvv2;
  String avs_address;
  String avs_zipcode;
  MfsRecipientParam? mfsRecipientParam;
  bool isMfs;
  FaceAndTouchScreen({
    Key? key,
    required this.selected_acc_id,
    required this.selected_acc_name,
    required this.selected_payment_type,
    required this.selected_last4,
    required this.isMfs,
    this.mfsRecipientParam,
    this.cvv2,
    this.avs_address = '',
    this.avs_zipcode = '',
  }) : super(key: key);

  @override
  State<FaceAndTouchScreen> createState() => _FaceAndTouchScreenState();
}

class _FaceAndTouchScreenState extends State<FaceAndTouchScreen> {
  String ipaddress = "";
  String dstCurrencyIso3Code = "";
  String dstCountryIso3Code = "";
  String sourceCurrencyIso3Code = "";
  String sendAmount = "";
  String recipient_recieve_amount = "";
  String recipientId = "";
  String senderId = "";
  String s_BankdetailResponse = "";
  String exchangerate = "";
  String fees = "";
  String monyetosfee = "";
  BankDetailResponse bankDetailResponse = new BankDetailResponse();
  String BankName = "";
  String BankAccNumber = "";
  String reasonsending_id = "";
  String reasonsending_name = "";
  String u_first_name = "";
  String u_last_name = "";
  String u_profile_img = "";
  String relationship = "";
  AccountSettingResponse accountSettingResponse = new AccountSettingResponse();
  String total_amount = "0";
  String is_pin_enabled = "";
  String is_face_enabled = "";
  String device_type = "";
  String select_payment_method_status = "";
  SharedPreferences? prefData;

  //biometric  variables
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getId();

    pref();

    //biometric initstate
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    setState(() {});
  }

  pref() async {
    prefData = await SharedPreferences.getInstance();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    select_payment_method_status = sharedPreferences.getString("select_payment_method_status").toString();
    dstCurrencyIso3Code =
        sharedPreferences.getString("dstCurrencyIso3Code").toString();
    dstCountryIso3Code =
        sharedPreferences.getString("dstCountryIso3Code").toString();
    sourceCurrencyIso3Code =
        sharedPreferences.getString("sourceCurrencyIso3Code").toString();
    sendAmount = sharedPreferences.getString("sendAmount").toString();
    recipient_recieve_amount =
        sharedPreferences.getString("receiveAmount").toString();
    recipientId = sharedPreferences.getString("recpi_id").toString();
    senderId = sharedPreferences.getString("senderId").toString();
    s_BankdetailResponse =
        sharedPreferences.getString("BankdetailResponse").toString();
    exchangerate = sharedPreferences.getString("exchangerate").toString();
    fees = sharedPreferences.getString("fees").toString();
    monyetosfee = sharedPreferences.getString("monyetosfee").toString();
    reasonsending_id =
        sharedPreferences.getString("reasonsending_id").toString();
    reasonsending_name =
        sharedPreferences.getString("reasonsending_name").toString();
    u_first_name = sharedPreferences.getString("u_first_name").toString();
    u_last_name = sharedPreferences.getString("u_last_name").toString();
    u_profile_img = sharedPreferences.getString("u_profile_img").toString();
    relationship = sharedPreferences.getString("relationship").toString();

    // print("reasonsending_name>>>> " + reasonsending_name);
    // print("reasonsending_id>>>> " + reasonsending_id);
    // print("dstCurrencyIso3Code>>>> " + dstCurrencyIso3Code);
    // print("dstCountryIso3Code>>>> " + dstCountryIso3Code);
    // print("sourceCurrencyIso3Code>>>> " + sourceCurrencyIso3Code);
    // print("recipient_recieve_amount>>>> " + recipient_recieve_amount);
    // print("sendAmount>>>> " + sendAmount);
    // print("recipientId>>>> " + recipientId);
    // print("senderId>>>> " + senderId);
    // print("s_BankdetailResponse>>>> " + s_BankdetailResponse);
    // print("exchangerate>>>> " + exchangerate);
    // print("fees>>>> " + fees);
    // print("monyetosfee>>>> " + monyetosfee);
    // print("currency>>>> " + sharedPreferences.getString("currency").toString());

    if (sharedPreferences.get("BankdetailResponse").toString() != "null") {
      Timer(
        Duration(seconds: 1),
        () {
          var response = sharedPreferences.get("BankdetailResponse").toString();
          Map<String, dynamic> jsonResponse = convert.jsonDecode(response);

          // print("jsonResponse>>>>  " + jsonResponse.toString());

          // if (jsonResponse['status'] == true) {
          // Utility.ProgressloadingDialog(context, false);
          bankDetailResponse = BankDetailResponse.fromJson(jsonResponse);
          // for(int i = 0 ; i<bankDetailResponse.fields!.length;i++){
          //   if(bankDetailResponse.fields![i].id == "BANK_ACCOUNT_NUMBER"){
          //
          //     BankAccNumber = bankDetailResponse.fields![i].value.toString();
          //   }
          //
          //   if(bankDetailResponse.fields![i].id == "BANK_NAME"){
          //
          //     BankName = bankDetailResponse.fields![i].value.toString();
          //   }
          // }
          BankAccNumber = bankDetailResponse.data!.accountNumber.toString();
          BankName = bankDetailResponse.data!.bankName.toString();
          // print("bank name>>> " + BankName);

          setState(() {});
        },
      );
    } else {}

    accountSettingApi(context);

    Future.delayed(Duration.zero, () {
      this.printIps();
    });

    setState(() {});
  }

  //biometric functions
  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');

    if (authenticated) {
      // transaction_chargeRequest(context);
      submitPaymentapi(context);
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
    if (authenticated) {
      // transaction_chargeRequest(context);
      submitPaymentapi(context);
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightblueColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.lightblueColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.lightblueColor,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
      body: device_type == "ios" ? iosUI() : androidUI(),
    );
  }

  androidUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // hSizedBox5,
          hSizedBox2,

          ///title
          Container(
            alignment: Alignment.center,
            child: Text(
              MyString.verification1,
              style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
            ),
          ),
          hSizedBox,

          /// des
          Container(
            alignment: Alignment.center,
            child: Text(
              MyString.using_one_of_below_to_proceed_transaction,
              style: TextStyle(
                  color: MyColors.whiteColor.withOpacity(0.80),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
            ),
          ),
          hSizedBox4,
          hSizedBox1,

          //using touchid and face id
          Visibility(
            visible: is_face_enabled == "1" ? true : false,
            child: Column(
              children: [
                /// usin touch id
                ///title
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.using_touch_id,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily:
                            "s_asset/font/raleway/raleway_semibold.ttf"),
                  ),
                ),
                hSizedBox2,
                hSizedBox1,

                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // transferbottomsheet(context);
                    _authenticateWithBiometrics();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset("a_assets/logo/touch_id.svg")),
                ),

                hSizedBox5,
                hSizedBox2,

                /// usin face id
                ///title
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.using_face_id,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily:
                            "s_asset/font/raleway/raleway_semibold.ttf"),
                  ),
                ),
                hSizedBox2,
                hSizedBox1,

                InkWell(
                  onTap: () {
                    _authenticateWithBiometrics();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset("a_assets/logo/face_d.svg")),
                ),
                hSizedBox5,
              ],
            ),
          ),

          /// usin pincode
          ///title
          Visibility(
            visible: is_pin_enabled == "1" ? true : false,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                transferbottomsheet(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  MyString.or_using_pin_code,
                  style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
                ),
              ),
            ),
          ),
          hSizedBox5,
        ],
      ),
    );
  }

  iosUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // hSizedBox5,
          hSizedBox2,

          ///title
          Container(
            alignment: Alignment.center,
            child: Text(
              MyString.verification1,
              style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
            ),
          ),
          hSizedBox,

          /// des
          Container(
            alignment: Alignment.center,
            child: Text(
              MyString.using_one_of_below_to_proceed_transaction,
              style: TextStyle(
                  color: MyColors.whiteColor.withOpacity(0.80),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
            ),
          ),
          hSizedBox4,
          hSizedBox1,

          //using touchid and face id
          Visibility(
            visible: is_face_enabled == "1" ? true : false,
            child: Column(
              children: [
                /// usin touch id
                ///title

                hSizedBox5,
                hSizedBox2,

                /// usin face id
                ///title
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.using_face_id,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily:
                            "s_asset/font/raleway/raleway_semibold.ttf"),
                  ),
                ),
                hSizedBox2,
                hSizedBox1,

                InkWell(
                  onTap: () {
                    // transaction_chargeRequest(context);
                    // _authenticateWithBiometrics();
                    _authenticate();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset("a_assets/logo/face_d.svg")),
                ),
                hSizedBox5,
              ],
            ),
          ),

          /// usin pincode
          ///title
          Visibility(
            visible: is_pin_enabled == "1" ? true : false,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                transferbottomsheet(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: Text(
                  MyString.or_using_pin_code,
                  style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
                ),
              ),
            ),
          ),
          hSizedBox5,
        ],
      ),
    );
  }

  transferbottomsheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        // anchorPoint: Offset(20.0, 30.0),
        backgroundColor: MyColors.lightblueColor.withOpacity(0.10),
        builder: (context) {
          return Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.88,
              child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: TransferPinCodeScreen(
                    Oncallback: UpdateFunction,
                  )));
        });
  }

  void UpdateFunction() {
    print("UpdateFunction>>>>>> ");
    // transaction_chargeRequest(context);
    submitPaymentapi(context);
  }

  Future<void> transaction_chargeRequest(BuildContext context) async {
    Utility.transactionloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // TransactionChargeRequest transactionChargeRequest = new TransactionChargeRequest();
    // transactionChargeRequest.amount = double.parse(total_amount);
    // AmountDetails amountDetails = new AmountDetails();
    // amountDetails.tax=0;
    // amountDetails.surcharge=0;
    // amountDetails.shipping=0;
    // amountDetails.tip=0;
    // amountDetails.discount=0;
    // transactionChargeRequest.amountDetails = amountDetails;
    // transactionChargeRequest.name = accountSettingResponse.data!.userData!.name.toString();
    // Customer customer = new Customer();
    // customer.sendReceipt = false;
    // customer.email = accountSettingResponse.data!.userData!.email.toString();
    // customer.fax = "String";
    // customer.identifier = "String";
    // customer.customerId = accountSettingResponse.data!.userData!.magicpayCustomerId!.isEmpty?0:int.parse(accountSettingResponse.data!.userData!.magicpayCustomerId.toString());
    // transactionChargeRequest.customer = customer;
    // BillingInfo billingInfo = new BillingInfo();
    // billingInfo.firstName = "String";
    // billingInfo.lastName = "String";
    // billingInfo.street = "String";
    // billingInfo.street2 = "String";
    // billingInfo.state = "String";
    // billingInfo.city = "String";
    // billingInfo.zip = "String";
    // billingInfo.country = "String";
    // billingInfo.phone = "String";
    // transactionChargeRequest.billingInfo = billingInfo;
    // transactionChargeRequest.expiryMonth = 4;
    // transactionChargeRequest.expiryYear = 2023;
    // transactionChargeRequest.cvv2 = "123";
    // transactionChargeRequest.card = "4111111111111111";
    // transactionChargeRequest.capture = true;
    // transactionChargeRequest.saveCard = true;

    TransactionChargeRequest transactionChargeRequest =
        new TransactionChargeRequest();
    // transactionChargeRequest.amount = double.parse("15");//Please uncomment below line when we will do live testing
    transactionChargeRequest.amount = double.parse(total_amount);
    AmountDetails amountDetails = new AmountDetails();
    amountDetails.tax = 0;
    amountDetails.surcharge = 0;
    amountDetails.shipping = 0;
    amountDetails.tip = 0;
    amountDetails.discount = 0;
    transactionChargeRequest.amountDetails = amountDetails;
    transactionChargeRequest.cvv2 = widget.cvv2;

    // transactionChargeRequest.name = accountSettingResponse.data!.userData!.name.toString();
    // Customer customer = new Customer();
    // customer.sendReceipt = false;
    // customer.email = accountSettingResponse.data!.userData!.email.toString();
    // customer.fax = "String";
    // customer.identifier = "String";
    // customer.customerId = accountSettingResponse.data!.userData!.magicpayCustomerId!.isEmpty?0:int.parse(accountSettingResponse.data!.userData!.magicpayCustomerId.toString());
    // transactionChargeRequest.customer = customer;
    if (widget.selected_payment_type == "card") {
      BillingInfo billingInfo = new BillingInfo();
      billingInfo.firstName = accountSettingResponse.data!.userData!.name
          .toString()
          .split(" ")[0]
          .toString()
          .trim();
      try {
        billingInfo.lastName = accountSettingResponse.data!.userData!.name
            .toString()
            .toString()
            .split(" ")[1]
            .toString()
            .trim();
      } catch (ex) {
        billingInfo.lastName = "";
      }
      billingInfo.company = "String";
      billingInfo.street = "String";
      billingInfo.street2 = "String";
      billingInfo.state = "String";
      billingInfo.city = "String";
      billingInfo.zip = "String";
      billingInfo.country =
          accountSettingResponse.data!.userData!.country.toString();
      billingInfo.phone =
          accountSettingResponse.data!.userData!.mobileNumber.toString();
      transactionChargeRequest.billingInfo = billingInfo;
    }
    // transactionChargeRequest.expiryMonth = 4;
    // transactionChargeRequest.expiryYear = 2023;
    // transactionChargeRequest.cvv2 = "123";
    // transactionChargeRequest.card = "4111111111111111";
    transactionChargeRequest.source = "pm-" + widget.selected_acc_id;
    transactionChargeRequest.capture = true;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(
        Uri.parse(AllApiService.transaction_chargeURL),
        body: convert.jsonEncode(transactionChargeRequest),
        headers: {
          // "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          // "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": AllApiService.client_id,
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("transaction_chargeURL>>>> " + jsonResponse.toString());
      if (jsonResponse['status'].toString() == "Error") {
        Utility.transactionloadingDialog(context, false);
        Utility.transactionloadingDialog(context, false);
      } else {
        print(
            "transaction>>> id" + jsonResponse['transaction']['id'].toString());
        print("jsonResponse>>> status" + jsonResponse['status'].toString());
        String magicpay_txnid = jsonResponse['transaction']['id'].toString();
        String magicpay_txnstatus = jsonResponse['status'].toString();
        createMagicpayTxnapi(
            context, sendAmount, magicpay_txnid, magicpay_txnstatus);
      }
    } else {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>> else" + jsonResponse.toString());
      Utility.showFlutterToast( jsonResponse["error_details"].toString());
    }
    setState(() {});

    // if (jsonResponse['status'] == true) {
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Fluttertoast.showToast(msg: jsonResponse['message']);
    //
    //
    //   setState(() {});
    // } else {
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Fluttertoast.showToast(msg: jsonResponse['message']);
    //   setState(() {});
    // }

    return;
  }

  Future<void> createMagicpayTxnapi(BuildContext context, String send_amount,
      String magicpay_txnid, String magicpay_txnstatus) async {
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['send_amount'] = send_amount;
    request['magicpay_txnid'] = magicpay_txnid;
    request['magicpay_txnstatus'] = magicpay_txnstatus;
    //add new fields
    request['recipient_receive_method'] = BankName;
    request['recipient_receive_method_last4digit'] = BankAccNumber;
    request['sender_send_method'] = widget.selected_payment_type;
    request['sender_send_method_id'] = widget.selected_acc_id;
    request['sender_send_method_last4digit'] = widget.selected_last4;
    request['exchange_rate'] = exchangerate;
    request['delivery_method_type'] =
        bankDetailResponse.data!.bankAccountType.toString();
    request['transaction_fees'] = fees;
    request['sending_currency'] = "USD";
    request['receiving_currency'] = dstCurrencyIso3Code;
    request['trasnsfer_reason'] = reasonsending_name;
    request['trasnsfer_reason_id'] = reasonsending_id;
    request['recipient_recived_amout'] = recipient_recieve_amount;
    request['monyetosfee'] = int.parse(accountSettingResponse
                .data!.userData!.freeTransation
                .toString()) >
            0
        ? "0"
        : monyetosfee;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(
        Uri.parse(AllApiService.createMagicpayTxnapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print("createMagicpayTxnapi>>>> " + jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      TransfersApi(context, magicpay_txnid);

      setState(() {});
    } else {
      Utility.showFlutterToast( jsonResponse['message']);

      setState(() {});
    }
    return;
  }

  Future<void> TransfersApi(BuildContext context, String magicpay_txnid) async {
    Utility.transactionloadingDialog(context, true);
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    //Nium Request-----------
    NiumPayoutsRequest niumPayoutsRequest = new NiumPayoutsRequest();
    niumPayoutsRequest.requestId = Apiservices.nium_request_id;
    niumPayoutsRequest.transactionNumber = magicpay_txnid;
    niumPayoutsRequest.destinationAccount =
        double.parse(recipient_recieve_amount);
    niumPayoutsRequest.destinationCurrency = p.getString("currency");
    niumPayoutsRequest.localConversionCurrency = "USD";
    niumPayoutsRequest.statementNarrative = reasonsending_name;
    niumPayoutsRequest.originalRemitterFi = "";
    niumPayoutsRequest.sourceAccount =
        int.parse(Apiservices.nium_source_account);
    niumPayoutsRequest.feePayer = "BEN";
    Beneficiary beneficiary = new Beneficiary();
    beneficiary.name = p.getString("u_first_name").toString() +
        " " +
        p.getString("u_last_name").toString();
    beneficiary.address = p.getString("rec_address");
    beneficiary.city = p.getString("rec_city");
    beneficiary.countryCode = p.getString("iso2");
    beneficiary.email = "";
    beneficiary.accountType = "Individual";
    beneficiary.contactNumber =
        accountSettingResponse.data!.userData!.mobileNumber;
    beneficiary.state = "";
    beneficiary.postcode = p.getString("postcode").toString();
    // beneficiary.walletId = "";
    beneficiary.accountNumber =
        bankDetailResponse.data!.accountNumber.toString();
    beneficiary.bankAccountType =
        bankDetailResponse.data!.bankAccountType.toString();
    beneficiary.bankName = bankDetailResponse.data!.bankName.toString();
    beneficiary.bankCode = "";
    // beneficiary.identificationType = "";
    // beneficiary.identificationValue = "";
    // beneficiary.cardNumber = "";
    // beneficiary.encryptedCardNumber = "";
    // beneficiary.cardExpiryDate = "";
    beneficiary.relationship = relationship;
    beneficiary.accountIdentifierType = "MOBILE";
    beneficiary.accountIdentifierValue = p.getString("u_phone_number");
    beneficiary.contactCountryCode =
        accountSettingResponse.data!.userData!.countryCode;
    beneficiary.nameLocalLanguage = "en";
    niumPayoutsRequest.beneficiary = beneficiary;

    Remitter remitter = new Remitter();
    remitter.name = "Money Tos";
    remitter.givenName = true;
    remitter.accountType = "Individual";
    remitter.bankAccountNumber = Apiservices.nium_source_account;
    remitter.identificationType = Apiservices.nium_identification_type;
    remitter.identificationNumber = Apiservices.nium_identification_number;
    remitter.countryCode = "US";
    remitter.address = "2355 Hwy 36 West, Suite 400";
    remitter.purposeCode = "IR001";
    remitter.sourceOfIncome = "Cross border remittence";
    remitter.contactNumber = Apiservices.nium_contact_number;
    remitter.dob = "1980-01-01";
    remitter.city = "Minneapolis";
    remitter.postcode = "55113";
    remitter.state = "MN";
    remitter.sourceOfFunds = Apiservices.nium_source_account;
    remitter.placeOfBirth = "US";
    remitter.nationality = "US";
    remitter.occupation = "EXECUTIVE";
    niumPayoutsRequest.remitter = remitter;

    AdditionalInfo additionalInfo = new AdditionalInfo();
    additionalInfo.tradeOrderId = "";
    additionalInfo.tradeTime = "";
    additionalInfo.tradeCurrency = "";
    additionalInfo.tradeAmount = "";
    additionalInfo.tradeName = "";
    additionalInfo.tradeCount = "";
    additionalInfo.goodsCarrier = "";
    additionalInfo.serviceDetail = "";
    additionalInfo.serviceTime = "";
    additionalInfo.cashPickup = "";
    additionalInfo.tradePlatformName = "";
    niumPayoutsRequest.additionalInfo = additionalInfo;

    niumPayoutsRequest.routingCodeType1 =
        bankDetailResponse.data!.routingCodeType1.toString();
    niumPayoutsRequest.routingCodeValue1 =
        bankDetailResponse.data!.routingCodeValue1.toString();
    niumPayoutsRequest.routingCodeType2 =
        bankDetailResponse.data!.routingCodeType2.toString();
    niumPayoutsRequest.routingCodeValue2 =
        bankDetailResponse.data!.routingCodeValue2.toString();
    niumPayoutsRequest.routingCodeType3 = "";
    niumPayoutsRequest.routingCodeValue3 = "";

    niumPayoutsRequest.payoutMethod = "";
    niumPayoutsRequest.swiftFeePayer = "";
    niumPayoutsRequest.documentReference = "";

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.niumpayoutsapi),
        body: convert.jsonEncode(niumPayoutsRequest),
        headers: {
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
          "content-type": "application/json",
          "accept": "application/json"
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    print("TransfersURL>>>> " + jsonResponse.toString());
    if (response.statusCode == 200) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.transactionloadingDialog(context, false);
      Utility.transactionfinishloadingDialog(context, true);
      createRTxnbyMtxnidApi(
          context,
          magicpay_txnid,
          jsonResponse['reference_number'],
          jsonResponse['payment_id'],
          sendAmount);
      setState(() {});
    } else {
      Utility.showFlutterToast( jsonResponse['message']);

      setState(() {});
    }
    return;
  }

  Future<void> createRTxnbyMtxnidApi(
      BuildContext context,
      String magicpay_txnid,
      String readyremit_transferId,
      String confirmationNumber,
      String sendAmount) async {
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['magicpay_txnid'] = magicpay_txnid;
    request['reference_number'] = readyremit_transferId;
    request['payment_id'] = confirmationNumber;
    request['recipientId'] = recipientId;
    request['recipientAccountId'] = bankDetailResponse.data!.id.toString();
    request['recipient_name'] = u_first_name + " " + u_last_name;
    request['recipient_image'] = u_profile_img;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.createRTxnbyMtxnidapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.transactionfinishloadingDialog(context, false);
      pushNewScreen(
        context,
        screen: SendSuccessfullyTransferScreen(
          readyremit_transferId: jsonResponse['data']['id'].toString(),
          sendAmount: sendAmount,
          transfer_reason: reasonsending_name,
          fees: fees,
        ),
        withNavBar: false,
      );
      setState(() {});
    } else {
      Utility.showFlutterToast( jsonResponse['message']);

      setState(() {});
    }
    return;
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
    print("ipv4>>>>>> " + ipv4); // 98.207.254.136

    final ipv6 = await Ipify.ipv64();
    print("ipv6>>>>>> " + ipv6); // 98.207.254.136 or 2a00:1450:400f:80d::200e

    final ipv4json = await Ipify.ipv64(format: Format.JSON);
    print("ipv4json>>>>>> " + ipv4json); //{"ip
    ipaddress = ipv4.toString();
  }


  Future <void> submitPaymentapi(BuildContext context) async {

    Utility.transactionloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['send_amount'] = sendAmount;
    request['recipientId'] = recipientId;
    request['recipientAccountId'] = bankDetailResponse.data?.id.toString() ?? '';
    request['recipient_receive_method'] = BankName;
    request['recipient_receive_method_last4digit'] = BankAccNumber;
    request['sender_send_method'] = widget.selected_payment_type;
    request['sender_send_method_id'] = widget.selected_acc_id;
    request['sender_send_method_last4digit'] = widget.selected_last4;
    request['trasnsfer_reason'] = reasonsending_name;
    request['trasnsfer_reason_id'] = reasonsending_id;
    request['sending_currency'] = "USD";
    request['receiving_currency'] = dstCurrencyIso3Code;
    // request['delivery_method_type'] = widget.selected_payment_type;
    request['delivery_method_type'] = "Bank";
    request['recipient_recived_amout'] = recipient_recieve_amount;
    request['exchange_rate'] = exchangerate;
    request['transaction_fees'] = fees;
    request['monyetosfee'] = int.parse(accountSettingResponse
        .data!.userData!.freeTransation
        .toString()) >
        0
        ? "0"
        : monyetosfee;
    request['client_ip'] = ipaddress;
    request['avs_address'] = widget.avs_address;
    request['avs_zip'] = widget.avs_zipcode;
    request['cvv2'] = widget.cvv2;

    var mfsRequest = {};
    mfsRequest['send_amount'] = sendAmount;
    mfsRequest['recipientId'] = recipientId;
    mfsRequest['recipientAccountId'] = bankDetailResponse.data?.id.toString() ?? '';
    mfsRequest['recipient_receive_method'] = widget.mfsRecipientParam?.recipientReceiveBankNameOrOperatorName;
    mfsRequest['recipient_receive_method_last4digit'] = widget.mfsRecipientParam?.recipientReceiveBankOrMobileNo;
    mfsRequest['sender_send_method'] = widget.selected_payment_type;
    mfsRequest['sender_send_method_id'] = widget.selected_acc_id;
    mfsRequest['sender_send_method_last4digit'] = widget.selected_last4;
    mfsRequest['trasnsfer_reason'] = reasonsending_name;
    mfsRequest['trasnsfer_reason_id'] = reasonsending_id;
    mfsRequest['sending_currency'] = "USD";
    mfsRequest['receiving_currency'] = dstCurrencyIso3Code;
    mfsRequest['delivery_method_type'] =
    (widget.mfsRecipientParam?.deliveryMethodType?.isNotEmpty ?? false)
        ? widget.mfsRecipientParam?.deliveryMethodType.toString()
        : widget.selected_payment_type;
    mfsRequest['recipient_recived_amout'] = recipient_recieve_amount;
    mfsRequest['exchange_rate'] = exchangerate;
    mfsRequest['transaction_fees'] = int.parse(accountSettingResponse
        .data!.userData!.freeTransation
        .toString()) >
        0
        ? "0"
        : monyetosfee;
    mfsRequest['monyetosfee'] = int.parse(accountSettingResponse
        .data!.userData!.freeTransation
        .toString()) >
        0
        ? "0"
        : monyetosfee;
    mfsRequest['client_ip'] = ipaddress;
    mfsRequest['avs_address'] = widget.avs_address;
    mfsRequest['avs_zip'] = widget.avs_zipcode;
    mfsRequest['cvv2'] = widget.cvv2;

    var jubaRequest = {};
    jubaRequest['send_amount'] = sendAmount;
    jubaRequest['recipientId'] = recipientId;
    jubaRequest['recipientAccountId'] = bankDetailResponse.data?.id.toString() ?? '';
    jubaRequest['recipient_receive_method'] = widget.mfsRecipientParam?.recipientReceiveBankNameOrOperatorName;
    if(select_payment_method_status=="Cash"){

    }else{

      jubaRequest['recipient_receive_method_last4digit'] = widget.mfsRecipientParam?.recipientReceiveBankOrMobileNo;
    }

    jubaRequest['sender_send_method'] = widget.selected_payment_type;
    jubaRequest['sender_send_method_id'] = widget.selected_acc_id;
    jubaRequest['sender_send_method_last4digit'] = widget.selected_last4;
    jubaRequest['trasnsfer_reason'] = reasonsending_name;
    jubaRequest['trasnsfer_reason_id'] = reasonsending_id;
    jubaRequest['sending_currency'] = "USD";
    jubaRequest['receiving_currency'] = dstCurrencyIso3Code;
    jubaRequest['delivery_method_type'] =
    (widget.mfsRecipientParam?.deliveryMethodType?.isNotEmpty ?? false)
        ? widget.mfsRecipientParam?.deliveryMethodType.toString()
        : widget.selected_payment_type;
    jubaRequest['recipient_recived_amout'] = recipient_recieve_amount;
    jubaRequest['exchange_rate'] = exchangerate;
    jubaRequest['transaction_fees'] = int.parse(accountSettingResponse
        .data!.userData!.freeTransation
        .toString()) >
        0
        ? "0"
        : monyetosfee;
    jubaRequest['monyetosfee'] = int.parse(accountSettingResponse
        .data!.userData!.freeTransation
        .toString()) >
        0
        ? "0"
        : monyetosfee;
    jubaRequest['client_ip'] = ipaddress;
    jubaRequest['avs_address'] = widget.avs_address;
    jubaRequest['avs_zip'] = widget.avs_zipcode;
    jubaRequest['cvv2'] = widget.cvv2;
    jubaRequest['juba_NominatedCode'] = p.getString("juba_NominatedCode").toString();




    var body = convert.jsonEncode(request);
    if (widget.isMfs) {
      print("mfs request>>>>");
      body = convert.jsonEncode(mfsRequest);
    }

    if(p.getString("partnerPaymentMethod").toString()=="juba"){
      print("juba request>>>>");
      body = convert.jsonEncode(jubaRequest);
    }

    debugPrint('-----${mfsRequest}----');


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.submitPaymentapi),
        body: body,
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print("createMagicpayTxnapi>>>> "+jsonResponse.toString());
    Utility.transactionloadingDialog(context, false);
    Utility.transactionfinishloadingDialog(context, true);
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.transactionfinishloadingDialog(context, false);
      CountdownTimerState(context).stopTimer();
      pushNewScreen(
        context,
        screen: SendSuccessfullyTransferScreen(
          readyremit_transferId: jsonResponse['data']['id'].toString(),
          sendAmount: sendAmount,
          transfer_reason: reasonsending_name,
          fees: fees,
        ),
        withNavBar: false,
      );
      setState(() {

      });
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      Utility.transactionfinishloadingDialog(context, false);

      setState(() {

      });
    }
    return;
  }



  Future<void> accountSettingApi(
    BuildContext context,
  ) async {
    //  Utility.ProgressloadingDialog(context, true);
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
      accountSettingResponse =
          await AccountSettingResponse.fromJson(jsonResponse);
      is_pin_enabled =
          accountSettingResponse.data!.userData!.isPinEnabled.toString();
      is_face_enabled =
          accountSettingResponse.data!.userData!.isFaceEnabled.toString();
      fees = int.parse(accountSettingResponse.data!.userData!.freeTransation
                  .toString()) >
              0
          ? "0"
          : fees;
      total_amount =
          (double.parse(sendAmount) + double.parse(monyetosfee)).toString();
      total_amount = double.parse(double.parse(total_amount).toStringAsFixed(2))
          .toString();
      print("total_amount>>>> " + total_amount);
      if (is_face_enabled == "1") {
        if (device_type == "ios") {
          _authenticate();
        } else {
          _authenticateWithBiometrics();
        }
      }

      if (is_pin_enabled == "1") {
        transferbottomsheet(context);
      }

      // Fluttertoast.showToast(msg: jsonResponse['message']);

      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      //  Utility.ProgressloadingDialog(context, false);

      setState(() {});
    }
    return;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      // devicetoken=iosDeviceInfo.identifierForVendor!;
      device_type = "ios";
      print("device tyoe>>> " + device_type);
      setState(() {});
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // devicetoken=androidDeviceInfo.androidId!;
      device_type = "android";
      print("device tyoe>>> " + device_type);
      setState(() {});
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}

//biometric enum
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
