import 'dart:async';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:moneytos/screens/customScreens/setup_new_pin_code_screen/setup_newpin_Code_screen.dart';
import 'package:moneytos/utils/import_helper.dart';

class SettingForgotPinCodeScreen extends StatefulWidget {
  const SettingForgotPinCodeScreen({Key? key}) : super(key: key);

  @override
  State<SettingForgotPinCodeScreen> createState() =>
      _SettingForgotPinCodeScreenState();
}

class _SettingForgotPinCodeScreenState
    extends State<SettingForgotPinCodeScreen> {
  String? status_title;
  bool _isObscure = true;

  /// TextEditingController
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();

  /// FocusNode
  FocusNode fullnameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phonenumberFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullnameFocusNode.unfocus();
    emailFocusNode.unfocus();
    phonenumberFocusNode.unfocus();
  }

  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    starttimer();

    setState(() {});
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
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: MyColors.color_03153B,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.color_03153B,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.color_03153B,
              statusBarIconBrightness: Brightness.light,
              // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            flexibleSpace: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(23, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/images/leftarrow.svg',
                      height: 32,
                      width: 32,
                    ),
                  ),
                  // wSizedBox3,
                  // wSizedBox3,
                  //  wSizedBox,
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                    child: const Text(
                      MyString.forgot_pin_code,
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                  )
                ],
              ),
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                color: MyColors.color_03153B,
                height: 300,
                width: MediaQuery.of(context).size.width,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox,

                    /// otp field

                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: MyColors.whiteColor,
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            hSizedBox3,
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                              child: const Text(
                                MyString.reset_pin_code,
                                style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_bold.ttf',
                                ),
                              ),
                            ),
                            hSizedBox2,
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width / 5.8,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                MyString.you_have_recived_an_otp,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  letterSpacing: 0.4,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                              ),
                            ),
                            hSizedBox2,
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
                                  OtpTextField(
                                    numberOfFields: 4,
                                    fieldWidth: 60.0,
                                    disabledBorderColor: Colors.white,
                                    cursorColor: MyColors.whiteColor,
                                    textStyle: const TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                    ),

                                    borderColor: Colors.white,
                                    focusedBorderColor: MyColors.lightblueColor,
                                    // styles: otpTextStyles,
                                    showFieldAsBox: true,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(14),
                                    ),
                                    borderWidth: 0.8,

                                    //runs when a code is typed in
                                    onCodeChanged: (String code) {
                                      //handle validation or checks here if necessary
                                    },
                                    //runs when every textfield is filled
                                    onSubmit: (String verificationCode) {},
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 30,
                                      left: 18.0,
                                      right: 18.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          // resendOtp(context,countryCodeget,mobileNumber);

                                          child: Text(
                                            'Expired after ${secondsRemaining}s',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: MyColors.blackColor
                                                  .withOpacity(0.80),
                                            ),
                                          ),
                                        ),
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
                                      child: ElevatedButton(
                                        onPressed: () {
                                          confirfationDialog(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              MyColors.lightblueColor,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 60,
                                            vertical: 15,
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
                            hSizedBox,
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  confirfationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomConfirmationDialog(context),
          ),
        );
      },
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
      timer.cancel();
      starttimer();
    });
  }

  textfield(
    TextEditingController controller,
    String hinttext,
    FocusNode focusNode,
    TextInputType textInputType,
    TextInputAction textInputAction,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: MyColors.lightblueColor.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: MyColors.lightblueColor, width: 1),
          ),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.all(22),

          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.50),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            letterSpacing: 0.3,
          ),
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
          child: const SetupNewPinCodeScreen(),
        );
      },
    );
  }
}

CustomConfirmationDialog(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Wrap(
      children: [
        Image.asset(
          'assets/images/onboarding_img/img1.png',
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: const Text(
            MyString.are_you_sure_to_remove,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 40),
          //  alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Material(
                  color: MyColors.whiteColor,
                  elevation: 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //  color: MyColors.ligh
                      //  border: Border.all(color: bordercolor,width: 1.4)
                    ),
                    child: const Center(
                      child: Text(
                        MyString.cancel,
                        style: TextStyle(
                          fontFamily:
                              'assets/fonts/raleway/raleway_semibold.ttf',
                          color: MyColors.lightblueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  PinconfirfationDialog(context);
                },
                child: SizedBox(
                  width: 130,
                  child: Material(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.red,
                        //  border: Border.all(color: bordercolor,width: 1.4)
                      ),
                      child: const Center(
                        child: Text(
                          MyString.remove,
                          style: TextStyle(
                            fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                            color: MyColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

PinconfirfationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomSuccesFailedDialog(context),
        ),
      );
    },
  );
}

CustomSuccesFailedDialog(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Wrap(
      children: [
        Container(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/images/failed.svg',
            height: 100,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: const Text(
            MyString.something_want_wrong,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 40),
          //  alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  //  width: 100,
                  child: Material(
                    color: MyColors.whiteColor,
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.lightblueColor,
                        //  border: Border.all(color: bordercolor,width: 1.4)
                      ),
                      child: const Center(
                        child: Text(
                          MyString.ok,
                          style: TextStyle(
                            fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                            color: MyColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
