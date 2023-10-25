import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moneytos/screens/transfers_scheduled_screens/sheduled_successfully_screen.dart';
import 'package:moneytos/screens/transfers_scheduled_screens/treansfer_enter_pin_code.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/BankDetailResponse.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ScheduledFaceAndTouchScreen extends StatefulWidget {
  final String selected_acc_id;
  final String selected_acc_name;
  final String selected_payment_type;
  final String selected_last4;

  const ScheduledFaceAndTouchScreen({
    Key? key,
    required this.selected_acc_id,
    required this.selected_acc_name,
    required this.selected_payment_type,
    required this.selected_last4,
  }) : super(key: key);

  @override
  State<ScheduledFaceAndTouchScreen> createState() =>
      _ScheduledFaceAndTouchScreenState();
}

class _ScheduledFaceAndTouchScreenState
    extends State<ScheduledFaceAndTouchScreen> {
  String dstCurrencyIso3Code = '';
  String dstCountryIso3Code = '';
  String sourceCurrencyIso3Code = '';
  String sendAmount = '';
  String recipient_recieve_amount = '';
  String recipientId = '';
  String senderId = '';
  String s_BankdetailResponse = '';
  String exchangerate = '';
  String fees = '';
  String monyetosfee = '';
  BankDetailResponse bankDetailResponse = BankDetailResponse();
  String BankName = '';
  String BankAccNumber = '';
  String reasonsending_id = '';
  String reasonsending_name = '';
  String u_first_name = '';
  String u_last_name = '';
  String u_profile_img = '';
  AccountSettingResponse accountSettingResponse = AccountSettingResponse();
  String total_amount = '0';
  String is_pin_enabled = '';
  String is_face_enabled = '';
  String device_type = '';
  String schedule_date = '';
  String schedule_end_date = '';
  String schedule_type = '';
  String recipient_server_id = '';

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
    accountSettingApi(context);
    pref();

    //biometric initstate
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(
            () => _supportState = isSupported
                ? _SupportState.supported
                : _SupportState.unsupported,
          ),
        );
    setState(() {});
  }

  pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dstCurrencyIso3Code =
        sharedPreferences.getString('dstCurrencyIso3Code').toString();
    dstCountryIso3Code =
        sharedPreferences.getString('dstCountryIso3Code').toString();
    sourceCurrencyIso3Code =
        sharedPreferences.getString('sourceCurrencyIso3Code').toString();
    sendAmount = sharedPreferences.getString('sendAmount').toString();
    recipient_recieve_amount =
        sharedPreferences.getString('receiveAmount').toString();
    recipientId = sharedPreferences.getString('recpi_id').toString();
    senderId = sharedPreferences.getString('senderId').toString();
    s_BankdetailResponse =
        sharedPreferences.getString('BankdetailResponse').toString();
    exchangerate = sharedPreferences.getString('exchangerate').toString();
    fees = sharedPreferences.getString('fees').toString();
    monyetosfee = sharedPreferences.getString('monyetosfee').toString();
    reasonsending_id =
        sharedPreferences.getString('reasonsending_id').toString();
    reasonsending_name =
        sharedPreferences.getString('reasonsending_name').toString();
    u_first_name = sharedPreferences.getString('u_first_name').toString();
    u_last_name = sharedPreferences.getString('u_last_name').toString();
    u_profile_img = sharedPreferences.getString('u_profile_img').toString();
    schedule_date = sharedPreferences.getString('ScheduleStartDate').toString();
    schedule_end_date =
        sharedPreferences.getString('ScheduleEndDate').toString();
    schedule_type = sharedPreferences.getString('ScheduleType').toString();
    recipient_server_id = sharedPreferences.getString('recpi_id').toString();

    debugPrint('recipient_server_id>>>> $recipient_server_id');
    debugPrint('schedule_date>>>> $schedule_date');
    debugPrint('schedule_end_date>>>> $schedule_end_date');
    debugPrint('schedule_type>>>> $schedule_type');
    debugPrint('reasonsending_name>>>> $reasonsending_name');
    debugPrint('reasonsending_id>>>> $reasonsending_id');
    debugPrint('dstCurrencyIso3Code>>>> $dstCurrencyIso3Code');
    debugPrint('dstCountryIso3Code>>>> $dstCountryIso3Code');
    debugPrint('sourceCurrencyIso3Code>>>> $sourceCurrencyIso3Code');
    debugPrint('sendAmount>>>> $sendAmount');
    debugPrint('recipient_recieve_amount>>>> $recipient_recieve_amount');
    debugPrint('recipientId>>>> $recipientId');
    debugPrint('senderId>>>> $senderId');
    debugPrint('s_BankdetailResponse>>>> $s_BankdetailResponse');
    debugPrint('exchangerate>>>> $exchangerate');
    debugPrint('fees>>>> $fees');
    debugPrint('monyetosfee>>>> $monyetosfee');

    total_amount = (double.parse(sendAmount) + double.parse(fees)).toString();
    total_amount =
        double.parse(double.parse(total_amount).toStringAsFixed(2)).toString();
    debugPrint('total_amount>>>> $total_amount');
    if (sharedPreferences.get('BankdetailResponse').toString() != 'null') {
      Timer(const Duration(seconds: 1), () {
        var response = sharedPreferences.get('BankdetailResponse').toString();
        Map<String, dynamic> jsonResponse = jsonDecode(response);

        debugPrint('jsonResponse>>>>  $jsonResponse');

        // if (jsonResponse['status'] == true) {
        // Utility.ProgressloadingDialog(context, false);
        bankDetailResponse = BankDetailResponse.fromJson(jsonResponse);
        // for(int i = 0 ; i<bankDetailResponse.data!.length;i++){
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

        setState(() {});
        // } else {
        //   // Utility.ProgressloadingDialog(context, false);
        //   // isLoading = false;
        //   setState(() {
        //
        //   });
        // }
      });
    } else {}

    setState(() {});
  }

  //biometric functions
  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
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
      () => _authorized = authenticated ? 'Authorized' : 'Not Authorized',
    );

    if (authenticated) {
      saveScheduleApi(context);
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
      debugPrint(e.toString());
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
      saveScheduleApi(context);
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.lightblueColor,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
      body: device_type == 'ios' ? iosUI() : androidUI(),
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
            child: const Text(
              MyString.verification1,
              style: TextStyle(
                color: MyColors.whiteColor,
                fontSize: 26,
                fontWeight: FontWeight.w600,
                fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
              ),
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
                fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
              ),
            ),
          ),
          hSizedBox4,
          hSizedBox1,

          //using touchid and face id
          Visibility(
            visible: is_face_enabled == '1' ? true : false,
            child: Column(
              children: [
                /// usin touch id
                ///title
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.using_touch_id,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                    ),
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
                    child: SvgPicture.asset('assets/logo/touch_id.svg'),
                  ),
                ),

                hSizedBox5,
                hSizedBox2,

                /// usin face id
                ///title
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.using_face_id,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                    ),
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
                    child: SvgPicture.asset('assets/logo/face_d.svg'),
                  ),
                ),
                hSizedBox5,
              ],
            ),
          ),

          /// usin pincode
          ///title
          Visibility(
            visible: is_pin_enabled == '1' ? true : false,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                transferbottomsheet(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: const Text(
                  MyString.or_using_pin_code,
                  style: TextStyle(
                    color: MyColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                  ),
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
            child: const Text(
              MyString.verification1,
              style: TextStyle(
                color: MyColors.whiteColor,
                fontSize: 26,
                fontWeight: FontWeight.w600,
                fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
              ),
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
                fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
              ),
            ),
          ),
          hSizedBox4,
          hSizedBox1,

          //using touchid and face id
          Visibility(
            visible: is_face_enabled == '1' ? true : false,
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
                  child: const Text(
                    MyString.using_face_id,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                    ),
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
                    child: SvgPicture.asset('assets/logo/face_d.svg'),
                  ),
                ),
                hSizedBox5,
              ],
            ),
          ),

          /// usin pincode
          ///title
          Visibility(
            visible: is_pin_enabled == '1' ? true : false,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                transferbottomsheet(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: const Text(
                  MyString.or_using_pin_code,
                  style: TextStyle(
                    color: MyColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                  ),
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TransferPinCodeScreen(
              Oncallback: UpdateFunction,
            ),
          ),
        );
      },
    );
  }

  void UpdateFunction() {
    debugPrint('UpdateFunction>>>>>> ');
    saveScheduleApi(context);
  }

  Future<void> saveScheduleApi(BuildContext context) async {
    Utility.transactionloadingDialog(context, true);
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['schedule_date'] = schedule_date;
    request['schedule_exp_date'] = schedule_end_date;
    request['schedule_type'] = schedule_type;
    request['dstCountryIso3Code'] = dstCountryIso3Code;
    request['recipientId'] = recipientId;
    request['recipient_server_id'] = recipient_server_id;
    request['recipient_name'] = '$u_first_name $u_last_name';
    request['recipient_image'] = u_profile_img;
    request['recipient_recived_amount'] = recipient_recieve_amount;
    request['transaction_fees'] = fees;
    request['exchange_rate'] = exchangerate;
    request['recipient_receive_method'] = BankName;
    request['delivery_method_type'] =
        bankDetailResponse.data!.bankAccountType.toString();
    request['recipient_receive_method_last4digit'] = BankAccNumber;
    request['sender_send_method'] = widget.selected_payment_type;
    request['sender_send_method_id'] = widget.selected_acc_id;
    request['sender_send_method_last4digit'] = widget.selected_last4;
    request['trasnsfer_reason'] = reasonsending_name;
    request['trasnsfer_reason_id'] = reasonsending_id;
    request['sending_currency'] = 'USD';
    request['receiving_currency'] = dstCurrencyIso3Code;
    request['recipientAccountId'] = bankDetailResponse.data!.id.toString();
    request['send_amount'] = sendAmount;
    request['monyetosfee'] = monyetosfee;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.saveScheduleapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.transactionfinishloadingDialog(context, false);
      pushNewScreen(
        context,
        screen: SheduledSuccessfullyScreen(
          amount: sendAmount,
        ),
        withNavBar: false,
      );
      setState(() {});
    } else {
      Utility.showFlutterToast(jsonResponse['message']);

      setState(() {});
    }
    return;
  }

  Future<void> accountSettingApi(
    BuildContext context,
  ) async {
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    var userid = p.getString('userid');
    var auth = p.getString('auth');
    var request = {};
    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.accountSetting_URl),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      accountSettingResponse = AccountSettingResponse.fromJson(jsonResponse);
      is_pin_enabled =
          accountSettingResponse.data!.userData!.isPinEnabled.toString();
      is_face_enabled =
          accountSettingResponse.data!.userData!.isFaceEnabled.toString();

      if (is_face_enabled == '1') {
        if (device_type == 'ios') {
          _authenticate();
        } else {
          _authenticateWithBiometrics();
        }
      }

      if (is_pin_enabled == '1') {
        transferbottomsheet(context);
      }
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
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
      device_type = 'ios';
      debugPrint('device tyoe>>> $device_type');
      setState(() {});
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // devicetoken=androidDeviceInfo.androidId!;
      device_type = 'android';
      debugPrint('device tyoe>>> $device_type');
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
