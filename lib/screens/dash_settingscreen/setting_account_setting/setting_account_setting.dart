import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../loginscreen/dashboard_LoginScreen.dart';
import '../edit_account_setting.dart';

class Setting_Account_setting extends StatefulWidget {
  const Setting_Account_setting({Key? key}) : super(key: key);

  @override
  State<Setting_Account_setting> createState() =>
      _Setting_Account_settingState();
}

class _Setting_Account_settingState extends State<Setting_Account_setting> {
  AccountSettingResponse accountSettingResponse = AccountSettingResponse();
  String Auth = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadPref();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => accountSettingApi(context));

    setState(() {});
  }

  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Auth = sharedPreferences.getString('auth').toString();

    debugPrint('Auth>$Auth');

    //  WidgetsBinding.instance.addPostFrameCallback((_) =>BankAccountSiledApi());

    setState(() {});
  }

  void Update() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => accountSettingApi(context));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.light_primarycolor2,
            flexibleSpace: Container(
              padding: const EdgeInsets.fromLTRB(22, 30, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/leftarrow.svg',
                      height: 32,
                      width: 32,
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Account Settings',
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditAccountSettingScreen(
                            accountSettingResponse: accountSettingResponse,
                            Oncallback: Update,
                          ),
                        ),
                      );
                    },
                    child: SvgPicture.asset('assets/images/edit.svg'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: 300,
                color: MyColors.light_primarycolor2,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: MyColors.whiteColor,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: accountSettingResponse.status == true
                      ? Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Name',
                                        style: TextStyle(
                                          color: MyColors.greycolor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          accountSettingResponse
                                              .data!.userData!.name
                                              .toString(),
                                          style: const TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                          color: MyColors.greycolor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          accountSettingResponse
                                              .data!.userData!.email
                                              .toString(),
                                          style: const TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Phone Number',
                                        style: TextStyle(
                                          color: MyColors.greycolor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          accountSettingResponse
                                              .data!.userData!.mobileNumber
                                              .toString(),
                                          style: const TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Birthdate',
                                        style: TextStyle(
                                          color: MyColors.greycolor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          accountSettingResponse
                                                      .data!.userData!.dob
                                                      .toString() ==
                                                  'null'
                                              ? ''
                                              : Utility.DatefomatToYYYYMMTOMMDD(
                                                  accountSettingResponse
                                                      .data!.userData!.dob
                                                      .toString(),
                                                ),
                                          style: const TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Country',
                                        style: TextStyle(
                                          color: MyColors.greycolor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          accountSettingResponse
                                              .data!.userData!.countryName
                                              .toString(),
                                          style: const TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'State',
                                        style: TextStyle(
                                          color: MyColors.greycolor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          accountSettingResponse
                                              .data!.userData!.stateName
                                              .toString(),
                                          style: const TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Address',
                                        style: TextStyle(
                                          color: MyColors.greycolor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          accountSettingResponse
                                              .data!.userData!.address
                                              .toString(),
                                          style: const TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Zip Code',
                                        style: TextStyle(
                                          color: MyColors.greycolor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          0,
                                        ),
                                        child: Text(
                                          accountSettingResponse
                                              .data!.userData!.zipcode
                                              .toString(),
                                          style: const TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                hSizedBox,
                                GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                    // logout();
                                    // logoutdialog(context);
                                    dialogDeleteAccount(context);
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.fromLTRB(
                                      00,
                                      50,
                                      0,
                                      0,
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/delete.svg',
                                          width: 20,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                            20,
                                            0,
                                            0,
                                            0,
                                          ),
                                          child: const Text(
                                            'Delete Account',
                                            style: TextStyle(
                                              color: MyColors.color_ED5565,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              fontFamily:
                                                  'assets/fonts/raleway/raleway_bold.ttf',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> accountSettingApi(
    BuildContext context,
  ) async {
    CustomLoader.ProgressloadingDialog6(context, true);
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
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {});
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.ProgressloadingDialog6(context, false);

      setState(() {});
    }
    return;
  }

  dialogDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Are you sure, you want to Delete?',
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                      25.0,
                                      12.0,
                                      25.0,
                                      12.0,
                                    ),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColors.darkbtncolor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // Navigator.pop(context);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(context);
                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                /* shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),*/
                                //  color: MyColors.darkbtncolor,
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_regular.ttf',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                      25.0,
                                      12.0,
                                      25.0,
                                      12.0,
                                    ),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColors.darkbtncolor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  delete_userapi(context);

                                  setState(() {});
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_regular.ttf',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> delete_userapi(BuildContext context) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.post(
      Uri.parse(Apiservices.delete_userapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    debugPrint(response.body);

    if (response.statusCode == 200) {
      p.setBool('login', false);
      Utility.showFlutterToast('Delete Successfully');
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop(context);
      CustomLoader.ProgressloadingDialog6(context, false);

      pushNewScreen(
        context,
        screen: const DashboardLoginScreen(),
        withNavBar: false,
      );
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast('Invalid Request');
      Navigator.of(context, rootNavigator: true).pop(context);
      CustomLoader.ProgressloadingDialog6(context, false);
      // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }
}
