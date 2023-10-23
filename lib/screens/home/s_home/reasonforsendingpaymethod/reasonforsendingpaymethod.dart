import 'package:moneytos/screens/home/s_home/linknewmethod/link_new_method.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/services/s_Api/S_Request/CreateCustomerRequest.dart';
import 'package:moneytos/utils/import_helper.dart';

class ReasonForSendingPaymethod extends StatefulWidget {
  final String id;

  const ReasonForSendingPaymethod({super.key, required this.id});

  @override
  State<ReasonForSendingPaymethod> createState() =>
      _ReasonForSendingPaymethodState();
}

class _ReasonForSendingPaymethodState extends State<ReasonForSendingPaymethod> {
  AccountSettingResponse accountSettingResponse = AccountSettingResponse();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => accountSettingApi(context));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        /*  appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
              elevation: 0,
              backgroundColor: MyColors.whiteColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: MyColors.light_primarycolor2,
                statusBarIconBrightness: Brightness.light, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              flexibleSpace:      Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              "assets/images/leftarrow.svg",
                              height: 20,
                              width: 20,
                            )),
                        wSizedBox4,
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Select Payment Method",
                            style: TextStyle(
                                color: MyColors.whiteColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily:
                                "assets/fonts/raleway/raleway_medium.ttf"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ), */

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: MyColors.color_03153B,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.color_03153B,

              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            elevation: 0,
            centerTitle: true,
            flexibleSpace: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        'assets/images/leftarrow.svg',
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                  // wSizedBox3,
                  // wSizedBox3,
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Select Payment Method',
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                  ),
                  Container(
                    width: 0,
                  )
                ],
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        bottomSheet: Container(
          decoration: const BoxDecoration(
            color: MyColors.whiteColor,
          ),
          margin: const EdgeInsets.only(bottom: 30),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 80,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Custombtn(MyString.back, 70, 140, context),
            ),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
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
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 0,
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
                              hSizedBox4,
                              InkWell(
                                onTap: () {
                                  //Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                  'assets/images/empty_illustration.svg',
                                ),
                              ),
                              hSizedBox1,
                              Container(
                                width: size.width * 0.6,
                                margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                                child: const Text(
                                  "There's no Payment method linked yet before to pay by it",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: MyColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_medium.ttf',
                                  ),
                                ),
                              ),
                              hSizedBox4,
                              GestureDetector(
                                onTap: () {
                                  accountSettingResponse.status == true
                                      ? accountSettingResponse.data!.userData!
                                                  .magicpayCustomerId ==
                                              ''
                                          ? createcustomersRequest(context)
                                          : nextpage()
                                      : null;
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 30,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    horizontal: size.width / 6.7,
                                    vertical: 20,
                                  ),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter,
                                      //  stops: [0.0, 1.0],
                                      colors: [
                                        MyColors.color_3F84E5.withOpacity(0.80),
                                        MyColors.color_3F84E5.withOpacity(0.90),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/bold_plus.svg',
                                        color: MyColors.whiteColor,
                                      ),
                                      hSizedBox1,
                                      const Text(
                                        MyString.link_new_method,
                                        style: TextStyle(
                                          color: MyColors.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily:
                                              'assets/fonts/maven/mavenpro_bold.ttf',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  nextpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LinkNewMethodScreen()),
    );
  }

  Future<void> createcustomersRequest(BuildContext context) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    CreateCustomerRequest createCustomerRequest = CreateCustomerRequest();

    createCustomerRequest.identifier =
        accountSettingResponse.data!.userData!.id.toString();
    createCustomerRequest.customerNumber =
        accountSettingResponse.data!.userData!.id.toString();
    createCustomerRequest.firstName =
        accountSettingResponse.data!.userData!.name.toString();
    createCustomerRequest.lastName =
        accountSettingResponse.data!.userData!.name.toString();
    createCustomerRequest.email =
        accountSettingResponse.data!.userData!.email.toString();
    createCustomerRequest.website = '';
    createCustomerRequest.phone =
        accountSettingResponse.data!.userData!.mobileNumber.toString();
    createCustomerRequest.alternatePhone =
        accountSettingResponse.data!.userData!.mobileNumber.toString();
    CreateCustomerBillingInfo billingInfo = CreateCustomerBillingInfo();
    billingInfo.firstName =
        accountSettingResponse.data!.userData!.name.toString();
    billingInfo.lastName =
        accountSettingResponse.data!.userData!.name.toString();
    billingInfo.street =
        accountSettingResponse.data!.userData!.address.toString();
    billingInfo.street2 =
        accountSettingResponse.data!.userData!.address.toString();
    billingInfo.state = accountSettingResponse.data!.userData!.state.toString();
    billingInfo.city = accountSettingResponse.data!.userData!.city.toString();
    billingInfo.zip = '';
    billingInfo.country =
        accountSettingResponse.data!.userData!.country.toString();
    billingInfo.phone =
        accountSettingResponse.data!.userData!.mobileNumber.toString();
    createCustomerRequest.billingInfo = billingInfo;
    createCustomerRequest.active = true;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.createcustomersURL),
      body: jsonEncode(createCustomerRequest),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        // "Authorization": AllApiService.client_id,
      },
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> if$jsonResponse');
      debugPrint("magig pay id>>> if${jsonResponse["id"]}");
      Utility.ProgressloadingDialog(context, false);
      sharedPreferences.setString('customer_id', jsonResponse['id'].toString());
      addMagicpayCustomerIdapi(context, jsonResponse['id'].toString());
    } else {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> else$jsonResponse');
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast(jsonResponse['error_details'].toString());
    }
    setState(() {});

    return;
  }

  Future<void> addMagicpayCustomerIdapi(
    BuildContext context,
    String magicpayCustomerId,
  ) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['magicpay_customer_id'] = magicpayCustomerId;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.addMagicpayCustomerIdapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint('createMagicpayTxnapi>>>> $jsonResponse');
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.ProgressloadingDialog(context, false);
      nextpage();
      setState(() {});
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.ProgressloadingDialog(context, false);

      setState(() {});
    }
    return;
  }

  Future<void> accountSettingApi(
    BuildContext context,
  ) async {
    Utility.ProgressloadingDialog(context, true);
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

      Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      Utility.ProgressloadingDialog(context, false);

      setState(() {});
    }
    return;
  }
}

Custombtn(String text, double height, double width, BuildContext context) {
  return Container(
    height: height,
    width: width,
    color: MyColors.whiteColor,
    //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
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
            MyColors.lightblueColor.withOpacity(0.10),
            MyColors.lightblueColor.withOpacity(0.36),
          ],
        ),
        //color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: MyColors.lightblueColor,
            fontSize: 16,
            fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
