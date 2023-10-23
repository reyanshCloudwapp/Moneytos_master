import 'package:flutter_share/flutter_share.dart';
import 'package:moneytos/screens/customScreens/setup_new_pin_code_screen/setup_newpin_Code_screen.dart';
import 'package:moneytos/utils/import_helper.dart';

import '../../refer_send_moneynow_screen.dart';

class ReferAFriendScreen extends StatefulWidget {
  final Function OncallBack;

  const ReferAFriendScreen({Key? key, required this.OncallBack})
      : super(key: key);

  @override
  State<ReferAFriendScreen> createState() => _ReferAFriendScreenState();
}

class _ReferAFriendScreenState extends State<ReferAFriendScreen> {
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
  String referral_id = '';

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
  }

  @override
  void initState() {
    super.initState();
    pref();
  }

  Future<void> pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    referral_id = sharedPreferences.getString('referral_id').toString();
    setState(() {});
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
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: MyColors.light_primarycolor2,
            flexibleSpace: Container(
              padding: const EdgeInsets.fromLTRB(22, 35, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                  //  wSizedBox,
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      MyString.refe_friend,
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                  ),
                  wSizedBox2
                ],
              ),
            ),
          ),
        ),
        body: KeyboardActions(
          autoScroll: false,
          config: _buildKeyboardActionsConfig(context),
          child: Stack(
            children: <Widget>[
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
                  elevation: 0,
                  color: MyColors.whiteColor,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          hSizedBox3,

                          // Container(
                          //   width: size.width * 0.6,
                          //   margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                          //   child: Text(
                          //     MyString.refer_a_friend,
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         color: MyColors.blackColor,
                          //         fontWeight: FontWeight.w700,
                          //         fontSize: 16,
                          //         fontFamily:
                          //         "assets/fonts/raleway/Raleway-Bold.ttf"),
                          //   ),
                          // ),
                          // hSizedBox1,
                          Container(
                            width: size.width * 0.6,
                            margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                            child: Text(
                              'Your Referral code : $referral_id',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: MyColors.blackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_bold.ttf',
                              ),
                            ),
                          ),
                          hSizedBox5,

                          textfield(
                            fullnameController,
                            MyString.full_name,
                            fullnameFocusNode,
                            TextInputType.text,
                            TextInputAction.next,
                          ),
                          hSizedBox2,
                          textfield(
                            emailController,
                            MyString.email,
                            emailFocusNode,
                            TextInputType.emailAddress,
                            TextInputAction.next,
                          ),
                          hSizedBox2,

                          Container(
                            decoration: BoxDecoration(
                              color: MyColors.lightblueColor.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.only(
                              left: 18.0,
                              top: 0,
                              right: 20,
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
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_medium.ttf',
                                    fontSize: 16,
                                  ),
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  showFlag: false,
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                    // width: MediaQuery.of(context).size.width * 0.7,
                                    child: textphonefield(
                                      phonenumberController,
                                      MyString.phone_nember,
                                      phonenumberFocusNode,
                                      TextInputType.number,
                                      TextInputAction.next,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          hSizedBox5,
                          GestureDetector(
                            onTap: () {
                              fullnameFocusNode.unfocus();
                              emailFocusNode.unfocus();
                              phonenumberFocusNode.unfocus();
                              // pushNewScreen(
                              //   context,
                              //   screen: ReferSendMoneyScreen(),
                              //   withNavBar: false,
                              // );

                              String name = fullnameController.text;
                              String email = emailController.text;
                              String phone_number = phonenumberController.text;
                              if (name.isEmpty) {
                                Utility.showFlutterToast('Enter Full Name');
                              } else if (email.isEmpty) {
                                Utility.showFlutterToast('Enter Email');
                              } else if (!Utility.isEmail(email)) {
                                Utility.showFlutterToast(
                                  'Enter Valid Email',
                                );
                              } else if (phone_number.isEmpty) {
                                Utility.showFlutterToast(
                                  'Enter Phone Number',
                                );
                              } else {
                                addreferralapiRequest(
                                  context,
                                  name,
                                  email,
                                  phone_number,
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: const CustomButton2(
                                btnname: MyString.refer_new_friend,
                                bg_color: MyColors.lightblueColor,
                                bordercolor: MyColors.lightblueColor,
                                height: 60,
                              ),
                            ),
                          ),

                          hSizedBox2,

                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              MyString.or,
                              style: TextStyle(
                                color: MyColors.light_primarycolor2,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_extrabold.ttf',
                              ),
                            ),
                          ),
                          hSizedBox2,

                          const Text(
                            'Invite your friends\nEarn upto 3 free transactions',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: MyColors.light_primarycolor2,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_extrabold.ttf',
                            ),
                          ),

                          hSizedBox2,

                          GestureDetector(
                            onTap: () {
                              share();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: const CustomButton2(
                                btnname: 'Share',
                                bg_color: MyColors.lightblueColor,
                                bordercolor: MyColors.lightblueColor,
                                height: 60,
                              ),
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
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Moneytos',
      text:
          'Sign up with my referral code $referral_id \n${AllApiService.personabashurl}refferallink',
      chooserTitle: 'Moneytos',
    );
  }

  transferbottomsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // anchorPoint: Offset(20.0, 30.0),
      //  backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.85,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const ReferSendMoneyScreen(),
          ),
        );
      },
    );
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

  textphonefield(
    TextEditingController controller,
    String hinttext,
    FocusNode focusNode,
    TextInputType textInputType,
    TextInputAction textInputAction,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: MyColors.lightblueColor.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
      ),
      // width: MediaQuery.of(context).size.width/1.5,
      child: TextField(
        controller: controller,
        maxLength: 10,
        focusNode: focusNode,
        textInputAction: textInputAction,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          counterText: '',
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

  String slectedcountrCode = '+1';

  Future<void> _onCountryChange(CountryCode countryCode) async {
    //TODO : manipulate the selected country code here

    slectedcountrCode = countryCode.toString();
    debugPrint('New Country selected:>>>>$slectedcountrCode');
    debugPrint('Country ISO code :>>>>${countryCode.code}');
    debugPrint('Country name code :>>>>${countryCode.name}');
    debugPrint('Country dialCode code :>>>>${countryCode.dialCode}');
    // sharedPreferences.setString('CountryISOCode',countryCode.code.toString());
    setState(() {});
  }

  Future<void> addreferralapiRequest(
    BuildContext context,
    String name,
    String email,
    String phone_number,
  ) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    request['name'] = name;
    request['email'] = email;
    request['country_code'] = slectedcountrCode.replaceAll('+', '');
    request['phone'] = phone_number;
    request['status'] = 'Sent';

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.addreferralapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      Utility.ProgressloadingDialog(context, false);
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      Navigator.pop(context);
      widget.OncallBack();

      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast(jsonResponse['message']);
      setState(() {});
    }

    return;
  }
}
