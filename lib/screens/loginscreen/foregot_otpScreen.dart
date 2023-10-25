import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotOtpVerifyScreen extends StatefulWidget {
  final String mobileno, countrycode;

  const ForgotOtpVerifyScreen(this.mobileno, this.countrycode, {super.key});

  @override
  State<ForgotOtpVerifyScreen> createState() => _ForgotOtpVerifyScreenState();
}

class _ForgotOtpVerifyScreenState extends State<ForgotOtpVerifyScreen> {
  bool load = false;
  String otp = '';
  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;

  String otperror = '';
  bool is_otp = false;

  String messageTitle = 'Empty';
  String notificationAlert = 'alert';
  String fcmtoken = '12345';

  String devicetype = 'web';
  String? deviceId = '';

  final formKey = GlobalKey<FormState>();
  final _otpFocus = FocusNode();

  forgotpassApi() async {
    setState(() {
      load = true;
    });
    await Webservices.verifyForgotPasswordOtpRequest(
      context,
      widget.mobileno,
      widget.countrycode,
      otp,
    );
    setState(() {
      load = false;
    });
  }

  FutureOr<String?> _getdevicetype() async {
    if (Platform.isIOS) {
      devicetype = 'ios';
      setState(() {});
      debugPrint('is a ios');
    } else if (Platform.isAndroid) {
      devicetype = 'android';
      debugPrint('is a Andriod}');
      setState(() {});
      debugPrint('type $devicetype');
    } else {}
    return null;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    } else {
      var web = await deviceInfo.webBrowserInfo;
      debugPrint('webbbbb${web.appCodeName}');
      return web.appCodeName;
      // unique ID on Android
    }
  }

  _getdevicetocken() async {
    deviceId = await _getId();
    debugPrint('devuce$deviceId');
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
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    /*  _getdevicetocken();
    debugPrint("devicetocken ${deviceId}");
    _getdevicetype();*/
    // starttimer();

    setState(() {});
  }

  forgotverifyOtpApi() async {
    setState(() {
      load = true;
    });
    await Webservices.verifyForgotPasswordOtpRequest(
      context,
      widget.mobileno,
      widget.countrycode,
      otp,
    );
    setState(() {
      load = false;
    });
  }

  void starttimer() {
    timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
          debugPrint('seconRemainnig---->>>$secondsRemaining');
        });
      } else {
        setState(() {
          debugPrint('Cancel Timing>>><<<<<<<<$secondsRemaining');
          enableResend = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(190),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/bgimage.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 20, left: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset('assets/icons/arrow_back.svg'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
              decoration: const BoxDecoration(
                //color: MyColors.primaryColor,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bgimage.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Image.asset('assets/images/map.png',fit: BoxFit.cover,),

            Container(
              // color: MyColors.whiteColor,
              margin: const EdgeInsets.only(top: 20.0),
              height: size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Material(
                color: MyColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin:
                      const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: MyColors.blackColor,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 22.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Please enter the verification code\n sent to your phone number',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: MyColors.blackColor.withOpacity(0.70),
                                fontFamily:
                                    'assets/fonts/raleway/raleway_bold.ttf',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40.0,
                            left: 20.0,
                            right: 0.0,
                          ),
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
                              //   enabledBorderColor: MyColors.lightblueColor,
                              //   // styles: otpTextStyles,
                              //   showFieldAsBox: true,
                              //   borderRadius: BorderRadius.all(Radius.circular(14)),
                              //   borderWidth: 1.0,
                              //
                              //   //runs when a code is typed in
                              //   onCodeChanged: (String code) {
                              //     is_otp = false;
                              //     setState(() {
                              //       otp = code.toString();
                              //     });
                              //     //handle validation or checks here if necessary
                              //   },
                              //   //runs when every textfield is filled
                              //   onSubmit: (String verificationCode) {
                              //     is_otp = false;
                              //     setState(() {
                              //       otp = verificationCode.toString();
                              //     });
                              //   },
                              // ),

                              Form(
                                key: formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 15,
                                  ),
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
                                      return null;
                                    },
                                    pinTheme: PinTheme(
                                      activeColor: MyColors.light_primarycolor2,
                                      selectedFillColor: MyColors.whiteColor,
                                      selectedColor:
                                          MyColors.light_primarycolor2,
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 50,
                                      activeFillColor: Colors.white,
                                      inactiveColor: Colors.white,
                                      inactiveFillColor: Colors.white,
                                    ),
                                    cursorColor: MyColors.light_primarycolor2,
                                    animationDuration:
                                        const Duration(milliseconds: 300),
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
                                    onCompleted: (v) {},
                                    onChanged: (value) {
                                      setState(() {
                                        debugPrint('current Text???$value');
                                        otp = value;
                                      });
                                    },
                                    beforeTextPaste: (text) {
                                      return true;
                                    },
                                  ),
                                ),
                              ),

                              is_otp == true
                                  ? Container(
                                      margin: const EdgeInsets.fromLTRB(
                                        20.0,
                                        8.0,
                                        16.0,
                                        0.0,
                                      ),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        otperror,
                                        style: const TextStyle(
                                          color: MyColors.red,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_semibold.ttf',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  : Container(),

                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 30,
                                  left: 18.0,
                                  right: 18.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // InkWell(
                                    //   // resendOtp(context,countryCodeget,mobileNumber);
                                    //
                                    //     child: Text("Expired after "+secondsRemaining.toString()+"s",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: MyColors.blackColor),)),
                                    InkWell(
                                      onTap: () {
                                        _resendCode();
                                      },
                                      child: const Text(
                                        'Resend',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.lightblueColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 80.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: load == true
                                      ? const CircularProgressIndicator(
                                          color: MyColors.lightblueColor,
                                        )
                                      : ElevatedButton(
                                          onPressed: () {
                                            if (otp.isEmpty) {
                                              is_otp = true;
                                              otperror = 'Please enter otp*';
                                              setState(() {});
                                              Utility.showFlutterToast(
                                                'Please enter otp',
                                              );
                                            } else {
                                              is_otp = false;
                                              otperror = '';
                                              setState(() {});
                                              forgotverifyOtpApi();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                MyColors.lightblueColor,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 50,
                                              vertical: 17,
                                            ),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  16.0,
                                                ),
                                              ),
                                            ),
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          child: const Text('Submit'),
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
    setState(() {
      // secondsRemaining = 30;
      // enableResend = false;
      // timer.cancel();
      // starttimer();
      resendOTPRequest(context, widget.mobileno, widget.countrycode);
    });
  }

  Future<void> resendOTPRequest(
    BuildContext context,
    String mobileNumber,
    String countryCode,
  ) async {
    CustomLoader.progressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = mobileNumber;
    request['country_code'] = countryCode.replaceAll('+', '');

    // otpo
    debugPrint('request $request');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

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
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.progressloadingDialog(context, false);
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.progressloadingDialog(context, false);
    }
    return;
  }
}
