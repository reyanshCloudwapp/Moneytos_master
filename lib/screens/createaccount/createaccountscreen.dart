import 'package:moneytos/services/s_Api/S_ApiResponse/SelectCountryListResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/StateListResponse.dart';
import 'package:moneytos/utils/import_helper.dart';

bool isload = false;
List<SelectCountryList> selectCountryList = <SelectCountryList>[];
List<StateListData> selectStateList = <StateListData>[];
TextEditingController cityController = TextEditingController();
SelectCountryListResponse countryListResponse = SelectCountryListResponse();
String country_id = '';
String city_id = '';
StateListResponse stateListResponse = StateListResponse();

class CreateAccountScreen extends StatefulWidget {
  final String fullname;
  final String lastname;
  final String pass;
  final String email;
  final String referralCode;

  const CreateAccountScreen(
    this.fullname,
    this.lastname,
    this.pass,
    this.email,
    this.referralCode, {
    super.key,
  });

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isVisibleButton = true;
  bool isVisibleResendOtp = true;
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  FocusNode mobileno_focus = FocusNode();
  FocusNode country_focus = FocusNode();
  FocusNode city_focus = FocusNode();
  FocusNode email_focus = FocusNode();

  String slectedcountrCode = '+1';
  bool is_phoneborder = false;
  bool load = false;
  String passerror = '';

  Color citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color cityfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color countryfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color countrybordercolor = MyColors.lightblueColor.withOpacity(0.03);

  bool iscity = false;
  bool iscountry = false;
  bool ismobile = false;
  bool isemailerror = false;

  String emailerror = '';
  String cityerror = '';
  String countryerror = '';
  String mobileerror = '';

  Color emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  //FlutterLocalNotificationsPlugin? fltNotification;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  /*void pushFCMtoken() async {
    String? token= await messaging.getToken();
    fcmtoken = token.toString();
    debugPrint("fcmtoken>>>>"+fcmtoken.toString());
//you will get token here in the console
  }

  String devicetype = "web";
  String? deviceId ="";
  Future<String?> _getdevicetype() async{
    if (Platform.isIOS) {
      devicetype = "ios";
      setState(() {

      });
      debugPrint('is a ios');
    } else if (Platform.isAndroid) {
      devicetype = "android";
      debugPrint('is a Andriod}');
      setState(() {

      });
      debugPrint("type ${devicetype}");
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
      debugPrint("webbbbb${web.appCodeName}");
      return web.appCodeName;
      // unique ID on Android
    }
  }

  _getdevicetocken() async{
    deviceId = await _getId();
    debugPrint("devuce${deviceId}");

  }*/

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [
        KeyboardActionsItem(focusNode: mobileno_focus, onTapAction: () {}),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) =>selectCountryListApi(context));

    /*  _getdevicetocken();
    debugPrint("devicetocken ${deviceId}");
    _getdevicetype();*/

    defautCountrySet();
  }

  defautCountrySet() {
    countryController.text = 'United States';
    country_id = '233';

    setState(() {});
  }

  submitContactnumber() async {
    await Webservices.submitContactNumber(
      context,
      mobileNumberController.text,
      slectedcountrCode.toString(),
      widget.fullname,
      widget.lastname,
      widget.pass,
      widget.email,
      country_id,
      city_id,
      widget.referralCode,
    );
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
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
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
              margin: const EdgeInsets.only(top: 100.0, left: 0.0),
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              // color: MyColors.whiteColor,
              margin: const EdgeInsets.only(top: 0.0),
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
                            'Create Account',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: MyColors.blackColor,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///country field
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.fromLTRB(
                                    20.0,
                                    50.0,
                                    16.0,
                                    0.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: countryfillcolor,
                                    border: Border.all(
                                      color: countrybordercolor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // showModalBottomSheet<void>(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //     return Container(
                                      //       height: 200,
                                      //       color: Colors.white,
                                      //       child: ListView.builder(
                                      //         shrinkWrap: true,
                                      //           padding: const EdgeInsets.all(8),
                                      //           itemCount: selectCountryList.length,
                                      //           itemBuilder: (BuildContext context, int index) {
                                      //             return InkWell(
                                      //               onTap: (){
                                      //                 countryController.text = selectCountryList[index].name.toString();
                                      //                 country_id = selectCountryList[index].id.toString();
                                      //                 Navigator.pop(context);
                                      //               },
                                      //               child: Container(
                                      //                 alignment: Alignment.center,
                                      //                 height: 50,
                                      //                 child: Text(selectCountryList[index].name.toString()),
                                      //               ),
                                      //             );
                                      //           }
                                      //       ),
                                      //     );
                                      //   },
                                      // );
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller: countryController,
                                      textInputAction: TextInputAction.next,
                                      onTap: () {
                                        mobilebordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        mobilefillcolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        citybordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        citybordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        cityfillcolor = MyColors.lightblueColor
                                            .withOpacity(0.03);
                                        countrybordercolor =
                                            MyColors.lightblueColor;
                                        countryfillcolor = MyColors.whiteColor;
                                        emailbordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        emailfillcolor = MyColors.lightblueColor
                                            .withOpacity(0.03);

                                        iscity = false;
                                        iscountry = false;
                                        ismobile = false;
                                        isemailerror = false;

                                        setState(() {});
                                      },
                                      style: const TextStyle(
                                        color: MyColors.blackColor,
                                        fontSize: 12,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_medium.ttf',
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: 'Country',
                                        border: InputBorder.none,
                                        fillColor: MyColors.whiteColor,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 12,
                                        ),
                                        //border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),

                                      keyboardType: TextInputType.emailAddress,

                                      // Only numbers can be entered
                                    ),
                                  ),
                                ),
                                iscountry == true
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.74,
                                        padding: const EdgeInsets.only(
                                          // left: 25,
                                          // right: 15,
                                          top: 10,
                                        ),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          countryerror.toString(),
                                          style: const TextStyle(
                                            color: MyColors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_semibold.ttf',
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),

                            /// city field
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.fromLTRB(
                                    20.0,
                                    20.0,
                                    16.0,
                                    0.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: cityfillcolor,
                                    border: Border.all(
                                      color: citybordercolor,
                                      width: 1,
                                    ),
                                    //MyColors.lightblueColor.withOpacity(0.03),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const CustomStateBottomSheet();
                                        },
                                      );
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller: cityController,
                                      textInputAction: TextInputAction.next,
                                      onTap: () {
                                        mobilebordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        mobilefillcolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        countrybordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        countryfillcolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        citybordercolor =
                                            MyColors.lightblueColor;
                                        cityfillcolor = MyColors.whiteColor;
                                        iscity = false;
                                        iscountry = false;
                                        ismobile = false;
                                        isemailerror = false;
                                        emailbordercolor = MyColors
                                            .lightblueColor
                                            .withOpacity(0.03);
                                        emailfillcolor = MyColors.lightblueColor
                                            .withOpacity(0.03);
                                        //is_phoneborder = false;
                                        setState(() {});
                                      },
                                      style: const TextStyle(
                                        color: MyColors.blackColor,
                                        fontSize: 12,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_medium.ttf',
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: 'State',
                                        border: InputBorder.none,
                                        fillColor: MyColors.whiteColor,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 12,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        //border: InputBorder.none,
                                      ),

                                      keyboardType: TextInputType.emailAddress,

                                      // Only numbers can be entered
                                    ),
                                  ),
                                ),
                                iscity == true
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.74,
                                        padding: const EdgeInsets.only(
                                          // left: 25,
                                          // right: 15,
                                          top: 10,
                                        ),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          cityerror.toString(),
                                          style: const TextStyle(
                                            color: MyColors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_semibold.ttf',
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),

                            /// email field
                            /*  Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin: EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 0.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: emailtextfield(
                                        emailController,
                                        "email@gmail.com",
                                        email_focus,
                                        TextInputType.emailAddress,
                                        TextInputAction.next,
                                        false,
                                        isemailerror),
                                    //fullnamefield(),
                                  ),
                                  isemailerror == true
                                      ? Container(
                                    width:  MediaQuery.of(context).size.width * 0.74,
                                    padding: EdgeInsets.only(
                                      // left: 25,
                                      // right: 15,
                                        top: 10),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      emailerror.toString(),
                                      style: TextStyle(
                                          color: MyColors.red,
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 12,
                                          fontFamily:
                                          "assets/fonts/raleway/Raleway-SemiBold.ttf"),
                                    ),
                                  )
                                      : Container(),
                                ],
                              ),
                            ),*/

                            /// Mobile field
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: mobilefillcolor,
                                    border: Border.all(
                                      color: mobilebordercolor,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: const EdgeInsets.only(
                                    left: 18.0,
                                    top: 20,
                                    right: 18,
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
                                          focusNode: mobileno_focus,
                                          // keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                                          // inputFormatters: [
                                          //   LengthLimitingTextInputFormatter(10),
                                          // ],
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputAction: TextInputAction.done,
                                          onTap: () {
                                            mobilebordercolor =
                                                MyColors.lightblueColor;
                                            mobilefillcolor =
                                                MyColors.whiteColor;
                                            countrybordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            countryfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            citybordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            cityfillcolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);

                                            emailbordercolor = MyColors
                                                .lightblueColor
                                                .withOpacity(0.03);
                                            emailfillcolor = MyColors
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
                                ismobile == true
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.74,
                                        padding: const EdgeInsets.only(
                                          //left: 20,
                                          // right: 15,
                                          top: 10,
                                        ),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          mobileerror.toString(),
                                          style: const TextStyle(
                                            color: MyColors.red,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_semibold.ttf',
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    mobileno_focus.unfocus();
                                    country_focus.unfocus();
                                    city_focus.unfocus();
                                    email_focus.unfocus();

                                    setState(() {});
                                    if (countryController.text.isEmpty) {
                                      countrybordercolor = MyColors.red;
                                      countryfillcolor =
                                          MyColors.red.withOpacity(0.03);

                                      iscountry = true;
                                      countryerror = 'Please select country';

                                      setState(() {});
                                    } else if (cityController.text.isEmpty) {
                                      iscountry = false;
                                      citybordercolor = MyColors.red;

                                      cityfillcolor =
                                          MyColors.red.withOpacity(0.03);

                                      iscity = true;
                                      cityerror = 'Please select state';

                                      setState(() {});
                                    }
                                    /* else if (emailController.text.isEmpty) {
                                      iscity = false;
                                      iscountry = false;
                                      emailbordercolor = MyColors.red;
                                      emailfillcolor =
                                          MyColors.red.withOpacity(0.03);


                                      isemailerror = true ;

                                      emailerror = "Please email";

                                      setState(() {});
                                    }*/
                                    /*else if(validateEmail(emailController.text) == false){
                                      iscity = false;
                                      iscountry = false;
                                      emailbordercolor = MyColors.red;
                                      emailfillcolor =
                                          MyColors.red.withOpacity(0.03);
                                      isemailerror = true;

                                      emailerror = "Please enter vailid email*";
                                      setState(() {});
                                    }*/
                                    else if (mobileNumberController
                                        .text.isEmpty) {
                                      iscity = false;
                                      iscountry = false;
                                      isemailerror = false;
                                      mobilebordercolor = MyColors.red;

                                      mobilefillcolor =
                                          MyColors.red.withOpacity(0.03);

                                      ismobile = true;

                                      mobileerror =
                                          'Please enter phone number*';
                                      setState(() {});
                                    } else if (mobileNumberController
                                            .text.length <
                                        10) {
                                      iscity = false;
                                      iscountry = false;
                                      isemailerror = false;
                                      mobilebordercolor = MyColors.red;
                                      emailbordercolor = MyColors.lightblueColor
                                          .withOpacity(0.03);
                                      emailfillcolor = MyColors.lightblueColor
                                          .withOpacity(0.03);
                                      mobilefillcolor =
                                          MyColors.red.withOpacity(0.03);
                                      ismobile = true;
                                      mobileerror =
                                          'Please enter valid phone number*';
                                      setState(() {});
                                    } else {
                                      iscity = false;
                                      iscountry = false;
                                      isemailerror = false;
                                      ismobile = false;

                                      mobilebordercolor = MyColors
                                          .lightblueColor
                                          .withOpacity(0.03);
                                      mobilefillcolor = MyColors.lightblueColor
                                          .withOpacity(0.03);

                                      emailbordercolor = MyColors.lightblueColor
                                          .withOpacity(0.03);
                                      emailfillcolor = MyColors.lightblueColor
                                          .withOpacity(0.03);

                                      citybordercolor = MyColors.lightblueColor
                                          .withOpacity(0.03);
                                      cityfillcolor = MyColors.lightblueColor
                                          .withOpacity(0.03);

                                      countrybordercolor = MyColors
                                          .lightblueColor
                                          .withOpacity(0.03);
                                      countryfillcolor = MyColors.lightblueColor
                                          .withOpacity(0.03);
                                      setState(() {});
                                      submitContactnumber();
                                    }
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerifyScreen()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.lightblueColor,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 50,
                                      vertical: 20,
                                    ),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16.0),
                                      ),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_bold.ttf',
                                    ),
                                  ),
                                  child: const Text('Create Account'),
                                ),
                              ),
                            ),

                            hSizedBox4,
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
    );
  }

  emailtextfield(
    TextEditingController controller,
    String hinttext,
    FocusNode focusNode,
    TextInputType textInputType,
    TextInputAction textInputAction,
    bool absecure,
    bool ispasserror,
  ) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: emailfillcolor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: emailbordercolor, width: 1),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: absecure,
        textInputAction: textInputAction,
        onTap: () {
          cityfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          countryfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
          citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor;
          emailfillcolor = MyColors.whiteColor;
          emailerror = '';
          cityerror = '';
          countryerror = '';
          mobileerror = '';
          iscity = false;
          iscountry = false;
          ismobile = false;
          isemailerror = false;

          setState(() {});
        },
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.50),
            fontSize: 12,
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

  Future<void> selectCountryListApi(
    BuildContext context,
  ) async {
    Utility.ProgressloadingDialog(context, true);
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(AllApiService.SignupCountries_List_URL),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      countryListResponse = SelectCountryListResponse.fromJson(jsonResponse);

      for (int i = 0; i < countryListResponse.data!.length; i++) {
        selectCountryList.add(countryListResponse.data![i]);
      }

      Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);

      setState(() {});
    }

    return;
  }

  Future<void> statelistbycountryidApi(
    BuildContext context,
    String countryId,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    setState(() {
      isload = true;
    });
    selectStateList.clear();
    var request = {};
    request['country_id'] = countryId;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        '${AllApiService.statelistbycountryid_List_URL}?country_id=$countryId',
      ),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      stateListResponse = StateListResponse.fromJson(jsonResponse);

      for (int i = 0; i < stateListResponse.data!.length; i++) {
        selectStateList.add(stateListResponse.data![i]);
      }

      // Utility.ProgressloadingDialog(context, false);
      setState(() {
        isload = false;
      });
      Navigator.of(context).pop();
      debugPrint('isload >>>> if$isload');
    } else {
      // Utility.ProgressloadingDialog(context, false);

      setState(() {
        isload = false;
      });
      Navigator.of(context).pop();
      debugPrint('isload >>>> else$isload');
    }

    return;
  }
}

/*class CreateAccountScreen extends StatefulWidget{
  String fullname;
  String pass;
  String email;


  CreateAccountScreen(this.fullname, this.pass,this.email);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {


  bool isVisibleButton = true;
  bool isVisibleResendOtp = true;
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  FocusNode mobileno_focus = FocusNode();
  FocusNode country_focus = FocusNode();
  FocusNode city_focus = FocusNode();
  FocusNode email_focus = FocusNode();


  String slectedcountrCode = "+91";
  bool is_phoneborder = false;
  bool load = false;
  String passerror = "";


  Color citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color cityfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color countryfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color countrybordercolor = MyColors.lightblueColor.withOpacity(0.03);

  bool iscity = false;
  bool iscountry = false;
  bool ismobile = false;
  bool isemailerror = false;

  String emailerror = "";
  String cityerror = "";
  String countryerror = "";
  String mobileerror = "";

  Color emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);


  //FlutterLocalNotificationsPlugin? fltNotification;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return (!regex.hasMatch(value)) ? false : true;
  }

  */ /*void pushFCMtoken() async {
    String? token= await messaging.getToken();
    fcmtoken = token.toString();
    debugPrint("fcmtoken>>>>"+fcmtoken.toString());
//you will get token here in the console
  }

  String devicetype = "web";
  String? deviceId ="";
  Future<String?> _getdevicetype() async{
    if (Platform.isIOS) {
      devicetype = "ios";
      setState(() {

      });
      debugPrint('is a ios');
    } else if (Platform.isAndroid) {
      devicetype = "android";
      debugPrint('is a Andriod}');
      setState(() {

      });
      debugPrint("type ${devicetype}");
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
      debugPrint("webbbbb${web.appCodeName}");
      return web.appCodeName;
      // unique ID on Android
    }
  }

  _getdevicetocken() async{
    deviceId = await _getId();
    debugPrint("devuce${deviceId}");

  }*/ /*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    */ /*  _getdevicetocken();
    debugPrint("devicetocken ${deviceId}");
    _getdevicetype();*/ /*
  }


  submitContactnumber() async {

    await Webservices.submitContactNumber(

      context,
      mobileNumberController.text,
      slectedcountrCode.toString(),
      widget.fullname,
      widget.pass,
      emailController.text,
      cityController.text,
      countryController.text,);


  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(190),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bgimage.png",),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 50.0, left: 0.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/images/logo.svg', fit: BoxFit.cover,))),
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
                    image: AssetImage("assets/images/bgimage.png",),
                    fit: BoxFit.cover
                )
            ),
          ),
          // Image.asset('assets/images/map.png',fit: BoxFit.cover,),
          Container(
              margin: EdgeInsets.only(top: 100.0, left: 0.0),

              child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/logo.svg', fit: BoxFit.cover,))),

          Container(

            // color: MyColors.whiteColor,
            margin: EdgeInsets.only(top: 0.0),
            height: size.height * 0.8,
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
                margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text("Create Account", style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: MyColors.blackColor,
                              fontFamily: "assets/fonts/raleway/raleway_bold.ttf"),)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ///country field
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                margin: EdgeInsets.fromLTRB(20.0, 50.0, 16.0, 0.0),

                                decoration: BoxDecoration(
                                    color: countryfillcolor,
                                    border: Border.all(
                                        color: countrybordercolor, width: 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextField(
                                  controller: countryController,
                                  textInputAction: TextInputAction.next,
                                  onTap: () {
                                    mobilebordercolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    mobilefillcolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    citybordercolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    citybordercolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    cityfillcolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    countrybordercolor = MyColors.lightblueColor;
                                    countryfillcolor = MyColors.whiteColor;
                                    emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                    iscity = false;
                                    iscountry = false;
                                    ismobile = false;
                                    isemailerror = false;

                                    setState(() {});
                                  },
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 12,
                                      fontFamily: "assets/fonts/raleway/raleway_medium.ttf"

                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Country',
                                    border: InputBorder.none,
                                    fillColor: MyColors.whiteColor,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),
                                    //border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),

                                  keyboardType: TextInputType.emailAddress,

                                  // Only numbers can be entered
                                ),
                              ),

                              iscountry == true
                                  ? Container(
                                width:  MediaQuery.of(context).size.width * 0.74,
                                padding: EdgeInsets.only(
                                  // left: 25,
                                  // right: 15,
                                    top: 10),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  countryerror.toString(),
                                  style: TextStyle(
                                      color: MyColors.red,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: 12,
                                      fontFamily:
                                      "assets/fonts/raleway/raleway_semibold.ttf"),
                                ),
                              )
                                  : Container()
                            ],
                          ),

                          /// city field
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                margin: EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 0.0),
                                decoration: BoxDecoration(
                                    color: cityfillcolor,
                                    border: Border.all(
                                        color: citybordercolor, width: 1),
                                    //MyColors.lightblueColor.withOpacity(0.03),
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextField(
                                  controller: cityController,
                                  textInputAction: TextInputAction.next,
                                  onTap: () {
                                    mobilebordercolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    mobilefillcolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    countrybordercolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    countryfillcolor =
                                        MyColors.lightblueColor.withOpacity(0.03);
                                    citybordercolor = MyColors.lightblueColor;
                                    cityfillcolor = MyColors.whiteColor;
                                    iscity = false;
                                    iscountry = false;
                                    ismobile = false;
                                    isemailerror = false;
                                    emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                    //is_phoneborder = false;
                                    setState(() {});
                                  },
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 12,
                                      fontFamily: "assets/fonts/raleway/raleway_medium.ttf"

                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'City',
                                    border: InputBorder.none,
                                    fillColor: MyColors.whiteColor,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 22, vertical: 12),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    //border: InputBorder.none,

                                  ),

                                  keyboardType: TextInputType.emailAddress,

                                  // Only numbers can be entered
                                ),
                              ),
                              iscity == true
                                  ? Container(
                                width:  MediaQuery.of(context).size.width * 0.74,
                                padding: EdgeInsets.only(
                                  // left: 25,
                                  // right: 15,
                                    top: 10),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  cityerror.toString(),
                                  style: TextStyle(
                                      color: MyColors.red,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: 12,
                                      fontFamily:
                                      "assets/fonts/raleway/raleway_semibold.ttf"),
                                ),
                              )
                                  : Container()
                            ],
                          ),

                          /// email field
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 0.0),
                            child: Column(
                              children: [
                                Container(
                                  child: emailtextfield(
                                      emailController,
                                      "email@gmail.com",
                                      email_focus,
                                      TextInputType.emailAddress,
                                      TextInputAction.next,
                                      false,
                                      isemailerror),
                                  //fullnamefield(),
                                ),
                                isemailerror == true
                                    ? Container(
                                  width:  MediaQuery.of(context).size.width * 0.74,
                                  padding: EdgeInsets.only(
                                    // left: 25,
                                    // right: 15,
                                      top: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    emailerror.toString(),
                                    style: TextStyle(
                                        color: MyColors.red,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: 12,
                                        fontFamily:
                                        "assets/fonts/raleway/raleway_semibold.ttf"),
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ),

                          /// Mobile field
                          Column(
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: mobilefillcolor,
                                    border: Border.all(color: mobilebordercolor,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(
                                    left: 18.0, top: 20, right: 18),
                                child: Row(
                                  children: [

                                    CountryCodePicker(

                                      onChanged: _onCountryChange,
                                      // enabled: false,

                                      initialSelection: 'IN',
                                      // favorite: ['+91','IN'],
                                      showCountryOnly: false,
                                      textStyle: TextStyle(
                                          color: MyColors.primaryColor,
                                          fontWeight: FontWeight.w300),
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
                                        keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        textInputAction: TextInputAction.done,
                                        onTap: () {
                                          mobilebordercolor =
                                              MyColors.lightblueColor;
                                          mobilefillcolor = MyColors.whiteColor;
                                          countrybordercolor =
                                              MyColors.lightblueColor.withOpacity(
                                                  0.03);
                                          countryfillcolor =
                                              MyColors.lightblueColor.withOpacity(
                                                  0.03);
                                          citybordercolor =
                                              MyColors.lightblueColor.withOpacity(
                                                  0.03);
                                          cityfillcolor =
                                              MyColors.lightblueColor.withOpacity(
                                                  0.03);

                                          emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                          emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                          setState(() {});
                                        },
                                        style: TextStyle(

                                            color: MyColors.blackColor,
                                            fontSize: 12,
                                            fontFamily: "assets/fonts/raleway/raleway_medium.ttf"

                                        ),
                                        decoration: InputDecoration(
                                            hintText: 'Phone Number',
                                            border: InputBorder.none,
                                            fillColor: MyColors.whiteColor,
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 0.0, vertical: 12),
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

                              ismobile == true
                                  ? Container(
                                width:  MediaQuery.of(context).size.width * 0.74,
                                padding: EdgeInsets.only(
                                  //left: 20,
                                  // right: 15,
                                    top: 10),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  mobileerror.toString(),
                                  style: TextStyle(
                                      color: MyColors.red,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: 12,
                                      fontFamily:
                                      "assets/fonts/raleway/raleway_semibold.ttf"),
                                ),
                              )
                                  : Container()
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: Align(

                              alignment: Alignment.center,
                              child:  ElevatedButton(
                                child: Text('Create Account'),
                                onPressed: () {
                                  mobileno_focus.unfocus();
                                  country_focus.unfocus();
                                  city_focus.unfocus();
                                  email_focus.unfocus();

                                  setState(() {});
                                  if (countryController.text.isEmpty ) {
                                    countrybordercolor = MyColors.red;
                                    countryfillcolor =
                                        MyColors.red.withOpacity(0.03);

                                    iscountry = true;
                                    countryerror = "Please enter country";

                                    setState(() {});
                                  }
                                  else if (cityController.text.isEmpty) {
                                    iscountry = false;
                                    citybordercolor = MyColors.red;

                                    cityfillcolor =
                                        MyColors.red.withOpacity(0.03);

                                    iscity = true;
                                    cityerror = "Please enter city";

                                    setState(() {});
                                  }
                                  else if (emailController.text.isEmpty) {
                                    iscity = false;
                                    iscountry = false;
                                    emailbordercolor = MyColors.red;
                                    emailfillcolor =
                                        MyColors.red.withOpacity(0.03);


                                    isemailerror = true ;

                                    emailerror = "Please email";

                                    setState(() {});
                                  }
                                  */ /*else if(validateEmail(emailController.text) == false){
                                    iscity = false;
                                    iscountry = false;
                                    emailbordercolor = MyColors.red;
                                    emailfillcolor =
                                        MyColors.red.withOpacity(0.03);
                                    isemailerror = true;

                                    emailerror = "Please enter vailid email*";
                                    setState(() {});
                                  }*/ /*
                                  else if (mobileNumberController.text.isEmpty) {
                                    iscity = false;
                                    iscountry = false;
                                    isemailerror = false;
                                    mobilebordercolor = MyColors.red;

                                    mobilefillcolor =
                                        MyColors.red.withOpacity(0.03);


                                    ismobile = true ;

                                    mobileerror = "Please enter phone number*";
                                    setState(() {});
                                  }

                                  else if (mobileNumberController.text.length < 10) {
                                    iscity = false;
                                    iscountry = false;
                                    isemailerror = false;
                                    mobilebordercolor = MyColors.red;
                                    emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                    mobilefillcolor =
                                        MyColors.red.withOpacity(0.03);
                                    ismobile = true;
                                    mobileerror = "Please valid phone number*";
                                    setState(() {});
                                  }
                                  else {
                                    iscity = false;
                                    iscountry = false;
                                    isemailerror = false;
                                    ismobile = false;

                                    mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                    emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                    citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    cityfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                    countrybordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                    countryfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                    setState(() {});
                                    submitContactnumber();
                                  }
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerifyScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: MyColors.lightblueColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 20),

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0))
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "assets/fonts/raleway/raleway_bold.ttf",
                                    )),
                              ),
                            ),
                          ),

                          hSizedBox4,

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

  emailtextfield(TextEditingController controller, String hinttext,
      FocusNode focusNode, TextInputType textInputType,
      TextInputAction textInputAction, bool absecure, bool ispasserror) {
    return Container(
      height: 50,

      decoration: BoxDecoration(
          color: emailfillcolor,
          borderRadius: BorderRadius.circular(15),

          border: Border.all(color: emailbordercolor,
              width: 1)),

      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: absecure,
        textInputAction: textInputAction,
        onTap: () {
          cityfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          countryfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
          citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor;
          emailfillcolor = MyColors.whiteColor;
          emailerror = "";
          cityerror = "";
          countryerror = "";
          mobileerror = "";
          iscity = false;
          iscountry = false;
          ismobile = false;
          isemailerror = false;

          setState(() {

          });
        },
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "assets/fonts/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "assets/fonts/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }


  Future<void> _onCountryChange(CountryCode countryCode) async {
    //TODO : manipulate the selected country code here
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    slectedcountrCode = countryCode.toString();
    debugPrint("New Country selected:>>>>" + slectedcountrCode);
    debugPrint("Country ISO code :>>>>" + countryCode.code.toString());
    debugPrint("Country name code :>>>>" + countryCode.name.toString());
    debugPrint("Country dialCode code :>>>>" + countryCode.dialCode.toString());
    sharedPreferences.setString('CountryISOCode', countryCode.code.toString());
    setState(() {});
  }


}*/

/*
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/otpverifyscreen/otpverifyscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountScreen extends StatefulWidget{
  String fullname;
  String pass;
  String email;


  CreateAccountScreen(this.fullname, this.pass,this.email);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {


  bool isVisibleButton = true;
  bool isVisibleResendOtp = true;
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  FocusNode mobileno_focus = FocusNode();
  FocusNode country_focus = FocusNode();
  FocusNode city_focus = FocusNode();
  FocusNode email_focus = FocusNode();


  String slectedcountrCode = "+972";
  bool is_phoneborder = false;
  bool load = false;
  String passerror = "";


  Color citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color cityfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color countryfillcolor = MyColors.lightblueColor.withOpacity(0.03);
  Color countrybordercolor = MyColors.lightblueColor.withOpacity(0.03);

  bool iscity = false;
  bool iscountry = false;
  bool ismobile = false;
  bool isemailerror = false;

  String emailerror = "";
  String cityerror = "";
  String countryerror = "";
  String mobileerror = "";

  Color emailbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color emailfillcolor = MyColors.lightblueColor.withOpacity(0.03);


  //FlutterLocalNotificationsPlugin? fltNotification;

  */
/*void pushFCMtoken() async {
    String? token= await messaging.getToken();
    fcmtoken = token.toString();
    debugPrint("fcmtoken>>>>"+fcmtoken.toString());
//you will get token here in the console
  }

  String devicetype = "web";
  String? deviceId ="";
  Future<String?> _getdevicetype() async{
    if (Platform.isIOS) {
      devicetype = "ios";
      setState(() {

      });
      debugPrint('is a ios');
    } else if (Platform.isAndroid) {
      devicetype = "android";
      debugPrint('is a Andriod}');
      setState(() {

      });
      debugPrint("type ${devicetype}");
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
      debugPrint("webbbbb${web.appCodeName}");
      return web.appCodeName;
      // unique ID on Android
    }
  }

  _getdevicetocken() async{
    deviceId = await _getId();
    debugPrint("devuce${deviceId}");

  }*/ /*

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    */
/*  _getdevicetocken();
    debugPrint("devicetocken ${deviceId}");
    _getdevicetype();*/ /*

  }


  submitContactnumber() async {
    load = true;
    setState(() {});
    await Webservices.submitContactNumber(

      context,
      mobileNumberController.text,
      slectedcountrCode.toString(),
      widget.fullname,
      widget.pass,
      widget.email,
      cityController.text,
      countryController.text,);

    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(190),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bgimage.png",),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 50.0, left: 0.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          'assets/images/logo.svg', fit: BoxFit.cover,))),
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
                    image: AssetImage("assets/images/bgimage.png",),
                    fit: BoxFit.cover
                )
            ),
          ),
          // Image.asset('assets/images/map.png',fit: BoxFit.cover,),
          Container(
              margin: EdgeInsets.only(top: 100.0, left: 0.0),

              child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/images/logo.svg', fit: BoxFit.cover,))),

          Container(

            // color: MyColors.whiteColor,
            margin: EdgeInsets.only(top: 0.0),
            height: size.height * 0.8,
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
                margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text("Create Account", style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: MyColors.blackColor,
                              fontFamily: "assets/fonts/raleway/raleway_bold.ttf"),)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ///country field
                          Container(
                            height: 50,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.fromLTRB(20.0, 50.0, 16.0, 0.0),

                            decoration: BoxDecoration(
                                color: countryfillcolor,
                                border: Border.all(
                                    color: countrybordercolor, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                              controller: countryController,
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                mobilebordercolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                mobilefillcolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                citybordercolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                citybordercolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                cityfillcolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                countrybordercolor = MyColors.lightblueColor;
                                countryfillcolor = MyColors.whiteColor;

                                iscity = false;
                                iscountry = false;
                                ismobile = false;
                                isemailerror = false;

                                setState(() {});
                              },
                              style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontSize: 12,
                                  fontFamily: "assets/fonts/raleway/raleway_medium.ttf"

                              ),
                              decoration: InputDecoration(
                                hintText: 'Country',
                                border: InputBorder.none,
                                fillColor: MyColors.whiteColor,
                                contentPadding: EdgeInsets.all(22),
                                //border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),

                              keyboardType: TextInputType.emailAddress,

                              // Only numbers can be entered
                            ),
                          ),

                          /// city field
                          Container(
                            height: 50,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 0.0),
                            decoration: BoxDecoration(
                                color: cityfillcolor,
                                border: Border.all(
                                    color: citybordercolor, width: 1),
                                //MyColors.lightblueColor.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                              controller: cityController,
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                mobilebordercolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                mobilefillcolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                countrybordercolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                countryfillcolor =
                                    MyColors.lightblueColor.withOpacity(0.03);
                                citybordercolor = MyColors.lightblueColor;
                                cityfillcolor = MyColors.whiteColor;
                                iscity = false;
                                iscountry = false;
                                ismobile = false;
                                isemailerror = false;

                                //is_phoneborder = false;
                                setState(() {});
                              },
                              style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontSize: 12,
                                  fontFamily: "assets/fonts/raleway/raleway_medium.ttf"

                              ),
                              decoration: InputDecoration(
                                hintText: 'City',
                                border: InputBorder.none,
                                fillColor: MyColors.whiteColor,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 12),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                //border: InputBorder.none,

                              ),

                              keyboardType: TextInputType.emailAddress,

                              // Only numbers can be entered
                            ),
                          ),

                          /// email field
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 0.0),
                            child: Column(
                              children: [
                                Container(
                                  child: emailtextfield(
                                      emailController,
                                      "email@gmail.com",
                                      email_focus,
                                      TextInputType.emailAddress,
                                      TextInputAction.next,
                                      false,
                                      isemailerror),
                                  //fullnamefield(),
                                ),
                                Container(),
                                isemailerror == true ? Container(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 20, top: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(emailerror, style: TextStyle(
                                      color: MyColors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      fontFamily: "assets/fonts/raleway/raleway_semibold.ttf"),),
                                ) : Container()
                              ],
                            ),
                          ),

                          /// password field
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: mobilefillcolor,
                                //is_phoneborder == true? MyColors.whiteColor : MyColors.lightblueColor.withOpacity(0.03),
                                border: Border.all(color: mobilebordercolor,
                                  //is_phoneborder == true? MyColors.lightblueColor.withOpacity(0.90): MyColors.lightblueColor.withOpacity(0.03),
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.only(
                                left: 18.0, top: 22, right: 18),
                            child: Row(
                              children: [

                                CountryCodePicker(

                                  onChanged: _onCountryChange,
                                  // enabled: false,

                                  initialSelection: 'IN',
                                  // favorite: ['+91','IN'],
                                  showCountryOnly: false,
                                  textStyle: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontWeight: FontWeight.w300),
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
                                    keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    textInputAction: TextInputAction.done,
                                    onTap: () {
                                      mobilebordercolor =
                                          MyColors.lightblueColor;
                                      mobilefillcolor = MyColors.whiteColor;
                                      countrybordercolor =
                                          MyColors.lightblueColor.withOpacity(
                                              0.03);
                                      countryfillcolor =
                                          MyColors.lightblueColor.withOpacity(
                                              0.03);
                                      citybordercolor =
                                          MyColors.lightblueColor.withOpacity(
                                              0.03);
                                      cityfillcolor =
                                          MyColors.lightblueColor.withOpacity(
                                              0.03);
                                      setState(() {});
                                    },
                                    style: TextStyle(

                                        color: MyColors.blackColor,
                                        fontSize: 12,
                                        fontFamily: "assets/fonts/raleway/raleway_medium.ttf"

                                    ),
                                    decoration: InputDecoration(
                                        hintText: 'Phone Number',
                                        border: InputBorder.none,
                                        fillColor: MyColors.whiteColor,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 22.0, vertical: 12),
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
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: Align(

                              alignment: Alignment.center,
                              child: load == true ? CircularProgressIndicator(
                                color: MyColors.primaryColor,) : ElevatedButton(
                                child: Text('Create Account'),
                                onPressed: () {
                                  setState(() {});
                                  if (countryController.text.isEmpty ) {
                                    countryController.text.isEmpty ?
                                    countrybordercolor = MyColors.red : MyColors
                                        .lightblueColor.withOpacity(0.03);
                                    countryController.text.isEmpty
                                        ? countryfillcolor =
                                        MyColors.red.withOpacity(0.03)
                                        : MyColors.lightblueColor.withOpacity(
                                        0.03);
                                    */
/*cityController.text.isEmpty
                                        ? citybordercolor = MyColors.red
                                        : citybordercolor =
                                        MyColors.lightblueColor.withOpacity(
                                            0.03);
                                    cityController.text.isEmpty
                                        ? cityfillcolor =
                                        MyColors.red.withOpacity(0.03)
                                        : cityfillcolor =
                                        MyColors.lightblueColor.withOpacity(
                                            0.03);
                                    cityController.text.isEmpty
                                        ? iscity = true
                                        : iscity = false;
                                    cityController.text.isEmpty
                                        ? cityerror = "Please enter city"
                                        : cityerror = "";*/ /*


                                    countryController.text.isEmpty ?
                                    iscountry = true : iscountry = false;
                                    countryController.text.isEmpty
                                        ? countryerror = "Please enter country"
                                        : countryerror = "";

                                    setState(() {});
                                  }
                                  if (cityController.text.isEmpty) {
                                    */
/*countryController.text.isEmpty ?
                                    countrybordercolor = MyColors.red : MyColors
                                        .lightblueColor.withOpacity(0.03);
                                    countryController.text.isEmpty
                                        ? countryfillcolor =
                                        MyColors.red.withOpacity(0.03)
                                        : MyColors.lightblueColor.withOpacity(
                                        0.03);*/ /*

                                    cityController.text.isEmpty
                                        ? citybordercolor = MyColors.red
                                        : citybordercolor =
                                        MyColors.lightblueColor.withOpacity(
                                            0.03);
                                    cityController.text.isEmpty
                                        ? cityfillcolor =
                                        MyColors.red.withOpacity(0.03)
                                        : cityfillcolor =
                                        MyColors.lightblueColor.withOpacity(
                                            0.03);
                                    cityController.text.isEmpty
                                        ? iscity = true
                                        : iscity = false;
                                    cityController.text.isEmpty
                                        ? cityerror = "Please enter city"
                                        : cityerror = "";

                                    */
/*countryController.text.isEmpty ?
                                    iscountry = true : iscountry = false;
                                    countryController.text.isEmpty
                                        ? countryerror = "Please enter country"
                                        : countryerror = "";*/ /*


                                    setState(() {});
                                  }
                                  else if (emailController.text.isEmpty) {
                                    emailController.text.isEmpty
                                        ? emailbordercolor = MyColors.red
                                        : emailbordercolor =
                                        MyColors.lightblueColor.withOpacity(
                                            0.03);
                                    emailController.text.isEmpty
                                        ? emailfillcolor =
                                        MyColors.red.withOpacity(0.03)
                                        : emailfillcolor =
                                        MyColors.lightblueColor.withOpacity(
                                            0.03);

                                    emailController.text.isEmpty ?
                                    isemailerror = true : isemailerror = false;
                                    emailController.text.isEmpty ?
                                    emailerror = "Please email" : emailerror =
                                    "";
                                    setState(() {});
                                    Fluttertoast.showToast(
                                        msg: "Please Enter Your FullName");
                                  }
                                 else if (mobileNumberController.text.isEmpty) {
                                    mobileNumberController.text.isEmpty
                                        ? mobilebordercolor = MyColors.red
                                        : mobilebordercolor =
                                        MyColors.lightblueColor.withOpacity(
                                            0.03);
                                    mobileNumberController.text.isEmpty
                                        ? mobilefillcolor =
                                        MyColors.red.withOpacity(0.03)
                                        : mobilefillcolor =
                                        MyColors.lightblueColor.withOpacity(
                                            0.03);
                                    mobileNumberController.text.isEmpty ?
                                    ismobile = true : ismobile = false;
                                    mobileNumberController.text.isEmpty
                                        ?
                                    mobileerror = "Please enter mobile number*"
                                        : mobileerror = "";
                                    setState(() {});
                                  }

                                  else if (mobileNumberController.text.length < 10) {
                                    mobilebordercolor = MyColors.red;
                                    mobilefillcolor =
                                        MyColors.red.withOpacity(0.03);
                                    ismobile = true;
                                    mobileerror = "Please valid mobile number*";
                                    setState(() {});
                                  }
                                  else {
                                    iscity = false;
                                    iscountry = false;
                                    isemailerror = false;
                                    ismobile = false;
                                    setState(() {});
                                    submitContactnumber();
                                  }
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerifyScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: MyColors.lightblueColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 20),

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0))
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "assets/fonts/raleway/raleway_bold.ttf",
                                    )),
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

  emailtextfield(TextEditingController controller, String hinttext,
      FocusNode focusNode, TextInputType textInputType,
      TextInputAction textInputAction, bool absecure, bool ispasserror) {
    return Container(
      height: 50,

     */
/* margin: EdgeInsets.symmetric(horizontal: 20),*/ /*

      decoration: BoxDecoration(
          color: emailfillcolor,
          //error == "1"? MyColors.whiteColor :  error == "2"? MyColors.red.withOpacity(0.05) : MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          // borderRadius: BorderRadius.circular(15),
          border: Border.all(color: emailbordercolor,
              // == "1"? MyColors.lightblueColor : error == "2" ? MyColors.red : MyColors.lightblueColor.withOpacity(0.03),
              width: 1)),
      //width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: absecure,
        textInputAction: textInputAction,
        onTap: () {
          cityfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          countryfillcolor = MyColors.lightblueColor.withOpacity(0.03);
          citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
          citybordercolor = MyColors.lightblueColor.withOpacity(0.03);
          emailbordercolor = MyColors.lightblueColor;
          emailfillcolor = MyColors.whiteColor;
          emailerror = "";
          cityerror = "";
          countryerror = "";
            mobileerror = "";
          iscity = false;
       iscountry = false;
         ismobile = false;
          isemailerror = false;

          setState(() {

          });
        },
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: "assets/fonts/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "assets/fonts/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }


  Future<void> _onCountryChange(CountryCode countryCode) async {
    //TODO : manipulate the selected country code here
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    slectedcountrCode = countryCode.toString();
    debugPrint("New Country selected:>>>>" + slectedcountrCode);
    debugPrint("Country ISO code :>>>>" + countryCode.code.toString());
    debugPrint("Country name code :>>>>" + countryCode.name.toString());
    debugPrint("Country dialCode code :>>>>" + countryCode.dialCode.toString());
    sharedPreferences.setString('CountryISOCode', countryCode.code.toString());
    setState(() {});
  }


}*/
class CustomStateBottomSheet extends StatefulWidget {
  const CustomStateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomStateBottomSheet> createState() => _CustomStateBottomSheetState();
}

class _CustomStateBottomSheetState extends State<CustomStateBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => statelistbycountryidApi(context, country_id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: isload == true
          ? const GFLoader(
              type: GFLoaderType.custom,
              child: Image(
                image: AssetImage('assets/logo/progress_image.png'),
              ),
            )
          : selectStateList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: selectStateList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        cityController.text =
                            selectStateList[index].name.toString();
                        city_id = selectStateList[index].id.toString();
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(selectStateList[index].name.toString()),
                      ),
                    );
                  },
                )
              : const Text('No State Found'),
    );
  }

  Future<void> statelistbycountryidApi(
    BuildContext context,
    String countryId,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    setState(() {
      isload = true;
    });
    selectStateList.clear();
    var request = {};
    request['country_id'] = countryId;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        '${AllApiService.statelistbycountryid_List_URL}?country_id=$countryId',
      ),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      stateListResponse = StateListResponse.fromJson(jsonResponse);

      for (int i = 0; i < stateListResponse.data!.length; i++) {
        selectStateList.add(stateListResponse.data![i]);
      }

      // Utility.ProgressloadingDialog(context, false);
      setState(() {
        isload = false;
      });
      //Navigator.of(context).pop();
      debugPrint('isload >>>> if$isload');
    } else {
      // Utility.ProgressloadingDialog(context, false);

      setState(() {
        isload = false;
      });

      /// Navigator.of(context).pop();
      debugPrint('isload >>>> else$isload');
    }

    return;
  }
}
