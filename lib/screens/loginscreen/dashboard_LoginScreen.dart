import 'dart:async';
import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:moneytos/screens/loginscreen/loginscreen.dart';
import 'package:moneytos/screens/resetpasswordscreen/resetpasswordscreen.dart';
import 'package:moneytos/utils/import_helper.dart';

class DashboardLoginScreen extends StatefulWidget {
  const DashboardLoginScreen({super.key});

  @override
  State<DashboardLoginScreen> createState() => _DashboardLoginScreenState();
}

class _DashboardLoginScreenState extends State<DashboardLoginScreen> {
  String ipaddress = '';
  bool _isObscure = true;
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  String fcm_token = '123456';

  FocusNode pass_focus = FocusNode();
  FocusNode email_focus = FocusNode();
  FocusNode mobilefocus = FocusNode();

  String slectedcountrCode = '+1';
  bool is_phoneborder = false;

  bool load = false;
  bool showpass = false;
  bool ispass = false;
  bool isfocuspass = false;
  bool ismobileerror = false;
  bool ispasserror = false;
  String passerror = '';
  String mobileerror = '';

  Color mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);

  Color emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  Color passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool autoValidate = false;

  String devicetype = 'web';
  String? deviceId = '';

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

  Future printIps() async {
    // for (var interface in await NetworkInterface.list()) {
    //   debugPrint('== Interface: ${interface.name} ==');
    //   for (var addr in interface.addresses) {
    //     debugPrint(
    //         '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
    //     ipaddress = interface.addresses.first.address;
    //     setState(() {});
    //   }
    // }

    final ipv4 = await Ipify.ipv4();
    debugPrint('ipv4>>>>>> $ipv4'); // 98.207.254.136

    final ipv6 = await Ipify.ipv64();
    debugPrint(
      'ipv6>>>>>> $ipv6',
    ); // 98.207.254.136 or 2a00:1450:400f:80d::200e

    final ipv4json = await Ipify.ipv64(format: Format.JSON);
    debugPrint('ipv4json>>>>>> $ipv4json'); //{"ip
    ipaddress = ipv4.toString();
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [
        KeyboardActionsItem(
          focusNode: mobilefocus,
          onTapAction: () {
            ispasserror = false;
            mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
            mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
            passbordercolor = MyColors.lightblueColor;
            passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
            setState(() {});
          },
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

  logindata() async {
    setState(() {
      load = true;
    });
    await Webservices.loginRequest(
      context,
      mobileNumberController.text,
      slectedcountrCode.toString(),
      passController.text,
      devicetype,
      deviceId.toString(),
      fcm_token,
      ipaddress,
    );
    setState(() {
      load = false;
    });
  }

  Future<bool> _willPopCallback() async {
    // this.widget.Oncallback();
    exit(0);
    // Navigator.pop(this.context);
    return true; // return true if the route to be popped
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      printIps();
    });
    FCMTOKEN();
    _getdevicetocken();
    debugPrint('devicetocken $deviceId');
    _getdevicetype();
  }

  void FCMTOKEN() async {
    setState(() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      fcm_token = preferences.getString('fcmtoken').toString();
    });

//you will get token here in the console
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
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
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: MyColors.color_03153B,
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
                      child: SvgPicture.asset('assets/images/logo.svg',fit: BoxFit.cover,))),*/

              Container(
                // color: MyColors.whiteColor,
                margin: const EdgeInsets.only(top: 5.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  color: MyColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 40.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                color: MyColors.blackColor,
                              ),
                            ),
                          ),
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
                                      border: Border.all(
                                        color: mobilebordercolor,
                                        //is_phoneborder == true? MyColors.lightblueColor.withOpacity(0.90): MyColors.lightblueColor.withOpacity(0.03),
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.fromLTRB(
                                      20.0,
                                      42.0,
                                      16.0,
                                      0.0,
                                    ),
                                    child: Row(
                                      children: [
                                        CountryCodePicker(
                                          onChanged: _onCountryChange,
                                          // enabled: false,

                                          initialSelection: 'CA',
                                          // favorite: ['+91','IN'],
                                          showCountryOnly: false,
                                          textStyle: const TextStyle(
                                            color: MyColors.primaryColor,
                                            fontWeight: FontWeight.w300,
                                          ),
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
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textInputAction:
                                                TextInputAction.next,
                                            onTap: () {
                                              ispasserror = false;
                                              mobilebordercolor =
                                                  MyColors.lightblueColor;
                                              mobilefillcolor =
                                                  MyColors.whiteColor;

                                              passbordercolor = MyColors
                                                  .lightblueColor
                                                  .withOpacity(0.03);
                                              passfillcolor = MyColors
                                                  .lightblueColor
                                                  .withOpacity(0.03);
                                              setState(() {});
                                            },
                                            style: const TextStyle(
                                              color: MyColors.blackColor,
                                              fontSize: 12,
                                              fontFamily:
                                                  'assets/fonts/raleway/raleway_medium.ttf',
                                            ),
                                            decoration: const InputDecoration(
                                              hintText: 'Phone Number',
                                              border: InputBorder.none,
                                              fillColor: MyColors.whiteColor,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 0.0,
                                                vertical: 12,
                                              ),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              counterText: '',
                                              //border: InputBorder.none,
                                            ),
                                            // maxLength: 10,

                                            // Only numbers can be entered
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ismobileerror == true
                                      ? Container(
                                          margin: const EdgeInsets.fromLTRB(
                                            25.0,
                                            5.0,
                                            16.0,
                                            0.0,
                                          ),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            mobileerror,
                                            style: const TextStyle(
                                              color: MyColors.red,
                                              fontSize: 12,
                                              fontFamily:
                                                  'assets/fonts/raleway/raleway_semibold.ttf',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
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
                                      fontFamily: "assets/fonts/poppins_regular.ttf"

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
                                      border: Border.all(
                                        color: passbordercolor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.fromLTRB(
                                      20.0,
                                      26.0,
                                      16.0,
                                      0.0,
                                    ),
                                    child: TextField(
                                      controller: passController,
                                      obscureText: _isObscure,
                                      textInputAction: TextInputAction.done,
                                      onTap: () {
                                        ispasserror = false;
                                        mobilebordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        mobilefillcolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        passbordercolor =
                                            MyColors.lightblueColor;
                                        passfillcolor = MyColors.lightblueColor
                                            .withOpacity(0.03);
                                        setState(() {});
                                      },
                                      style: const TextStyle(
                                        color: MyColors.blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:
                                            'assets/fonts/poppins_regular.ttf',
                                      ),

                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscure
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: ispasserror == true
                                                ? MyColors.red
                                                : MyColors.greycolor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              debugPrint(
                                                '_isObscure >>>>>>>>>>$_isObscure',
                                              );
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                        ),
                                        hintText: 'Password',
                                        border: InputBorder.none,
                                        fillColor: MyColors.whiteColor,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 15,
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: MyColors.color_FAFAFC,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(18.0),
                                          ),
                                        ),
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                      ),

                                      keyboardType: TextInputType.text,

                                      // Only numbers can be entered
                                    ),
                                  ),
                                  ispasserror == true
                                      ? Container(
                                          margin: const EdgeInsets.fromLTRB(
                                            25.0,
                                            5.0,
                                            16.0,
                                            0.0,
                                          ),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            passerror,
                                            style: const TextStyle(
                                              color: MyColors.red,
                                              fontSize: 12,
                                              fontFamily:
                                                  'assets/fonts/raleway/raleway_semibold.ttf',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
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
                                      debugPrint("MATCHED");
                                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                          content: new Text("Password is matched")));
                                    },
                                    onFail: () {
                                      debugPrint("NOT MATCHED");
                                    },
                                  )*/
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 18.0,
                                  top: 16.0,
                                ),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ResetPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Forgot Password !',
                                      style: TextStyle(
                                        color: MyColors.color_3F84E5,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:
                                            'assets/fonts/poppins_regular.ttf',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 60.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      pass_focus.unfocus();
                                      mobilefocus.unfocus();
                                      RegExp regex = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                      );
                                      //  RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                      var passNonNullValue =
                                          passController.text;
                                      setState(() {});
                                      if (mobileNumberController.text.isEmpty) {
                                        mobileNumberController.text.isEmpty
                                            ? mobilebordercolor = MyColors.red
                                            : mobilebordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                        mobileNumberController.text.isEmpty
                                            ? mobilefillcolor =
                                                MyColors.red.withOpacity(0.03)
                                            : mobilefillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                        // passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                        // passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                        // fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
                                        //   passController.text.isEmpty ?   ispasserror = true  : ispasserror =false;
                                        mobileNumberController.text.isEmpty
                                            ? ismobileerror = true
                                            : ismobileerror = false;
                                        mobileNumberController.text.isEmpty
                                            ? mobileerror =
                                                'Please enter phone number*'
                                            : mobileerror = '';
                                        // passController.text.isEmpty ?   passerror = "Please enter password*" : passerror = "";
                                        setState(() {});
                                        // Fluttertoast.showToast(msg: "Please Enter Your FullName");
                                      } else if (mobileNumberController
                                              .text.length <
                                          10) {
                                        mobilebordercolor = MyColors.red;
                                        mobilefillcolor =
                                            MyColors.red.withOpacity(0.03);
                                        ismobileerror = true;
                                        mobileerror =
                                            'Please valid phone number*';
                                        setState(() {});
                                      } else if (passController.text.isEmpty) {
                                        mobileNumberController.text.isEmpty
                                            ? mobilebordercolor = MyColors.red
                                            : mobilebordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                        mobileNumberController.text.isEmpty
                                            ? mobilefillcolor =
                                                MyColors.red.withOpacity(0.03)
                                            : mobilefillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                        passController.text.isEmpty
                                            ? passbordercolor = MyColors.red
                                            : passbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                        passController.text.isEmpty
                                            ? passfillcolor =
                                                MyColors.red.withOpacity(0.03)
                                            : passfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                        // fullNameController.text.isEmpty ?   isfullnameerror =true  : isfullnameerror =false;
                                        passController.text.isEmpty
                                            ? ispasserror = true
                                            : ispasserror = false;
                                        passController.text.isEmpty
                                            ? passerror =
                                                'Please enter password*'
                                            : passerror = '';

                                        mobileNumberController.text.isEmpty
                                            ? ismobileerror = true
                                            : ismobileerror = false;
                                        mobileNumberController.text.isEmpty
                                            ? mobileerror =
                                                'Please enter phone number*'
                                            : mobileerror = '';
                                        setState(() {});
                                        // Fluttertoast.showToast(msg: "Please Enter Your FullName");
                                      } else {
                                        passbordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        passfillcolor = MyColors.lightblueColor
                                            .withOpacity(0.03);
                                        mobilebordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        mobilefillcolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        ismobileerror = false;
                                        ispasserror = false;
                                        mobileerror = '';
                                        passerror = '';
                                        setState(() {});
                                        logindata();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.lightblueColor,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50,
                                        vertical: 15,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(13.0),
                                        ),
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontFamily:
                                            'assets/fonts/maven/mavenpro_bold.ttf',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    child: const Text('Log in'),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Not Registered yet?',
                                  style: TextStyle(
                                    color: MyColors.color_text,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        'assets/fonts/poppins_regular.ttf',
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
                                        builder: (context) =>
                                            const LoginScreenPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0, 4),
                                          blurRadius: 5.0,
                                        )
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
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 25,
                                      right: 25,
                                      bottom: 15,
                                      top: 15,
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: 25,
                                      top: 24,
                                    ),
                                    child: const Text(
                                      'Create an Account',
                                      style: TextStyle(
                                        color: MyColors.color_3F84E5,
                                        fontSize: 16,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_bold.ttf',
                                      ),
                                    ),
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
        ),
      ),
    );
  }

  Future<void> _onCountryChange(CountryCode countryCode) async {
    //TODO : manipulate the selected country code here
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    slectedcountrCode = countryCode.toString();
    debugPrint('New Country selected:>>>>$slectedcountrCode');
    debugPrint('Country ISO code :>>>>${countryCode.code}');
    debugPrint('Country name code :>>>>${countryCode.name}');
    debugPrint('Country dialCode code :>>>>${countryCode.dialCode}');
    sharedPreferences.setString('CountryISOCode', countryCode.code.toString());
    setState(() {});
  }
}
