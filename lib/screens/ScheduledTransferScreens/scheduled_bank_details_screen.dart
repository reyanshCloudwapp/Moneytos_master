import 'package:moneytos/screens/ScheduledTransferScreens/scheduled_select_payment_method_screen.dart';
import 'package:moneytos/utils/import_helper.dart';

class ScheduledBankDetailsScreen extends StatefulWidget {
  final bool isMfs;

  const ScheduledBankDetailsScreen({super.key, required this.isMfs});

  @override
  State<ScheduledBankDetailsScreen> createState() =>
      _ScheduledBankDetailsScreenState();
}

class _ScheduledBankDetailsScreenState
    extends State<ScheduledBankDetailsScreen> {
  TextEditingController ibanController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController routingnumberController = TextEditingController();
  TextEditingController seccodeController = TextEditingController();
  TextEditingController accountnumberController = TextEditingController();
  FocusNode ibanFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ibanFocus.unfocus();
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
          preferredSize: const Size.fromHeight(55),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.color_03153B,
            flexibleSpace: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 50, left: 22, right: 20),
              // margin: EdgeInsets.fromLTRB(50, 20, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  const Text(
                    'Bank Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      fontFamily: 'assets/fonts/raleway/raleway_extrabold.ttf',
                    ),
                  ),
                  wSizedBox3,
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
              Container(
                margin: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                height: MediaQuery.of(context).size.height,
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
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 24,
                              left: 0,
                              right: 0,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'A small amount will be deducted and \n refunded again for verified and linked your\n bank account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: MyColors.color_text.withOpacity(0.90),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                              ),
                            ),
                          ),
                          hSizedBox3,
                          hSizedBox2,
                          Container(
                            margin: const EdgeInsets.only(left: 22, right: 22),
                            // height: 48,
                            decoration: BoxDecoration(
                              color: MyColors.blueColor.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: double.infinity,
                            child: TextField(
                              controller: nameController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              // focusNode: ibanFocus,
                              // controller: ibanController,
                              cursorColor: MyColors.primaryColor,
                              decoration: InputDecoration(
                                fillColor: MyColors.blueColor.withOpacity(0.40),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Enter Name',

                                hintStyle: TextStyle(
                                  color: MyColors.blackColor.withOpacity(0.30),
                                  fontSize: 14,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                              ),
                            ),
                          ),
                          // IBAN(),
                          //
                          hSizedBox2,
                          Container(
                            margin: const EdgeInsets.only(left: 22, right: 22),
                            // height: 48,
                            decoration: BoxDecoration(
                              color: MyColors.blueColor.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: double.infinity,
                            child: TextField(
                              controller: routingnumberController,
                              maxLength: 9,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              // focusNode: ibanFocus,
                              // controller: ibanController,
                              cursorColor: MyColors.primaryColor,
                              decoration: InputDecoration(
                                fillColor: MyColors.blueColor.withOpacity(0.40),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                counterText: '',
                                hintText: 'Enter Routing Number',

                                hintStyle: TextStyle(
                                  color: MyColors.blackColor.withOpacity(0.30),
                                  fontSize: 14,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                              ),
                            ),
                          ),
                          hSizedBox2,

                          Container(
                            margin: const EdgeInsets.only(left: 22, right: 22),
                            // height: 48,
                            decoration: BoxDecoration(
                              color: MyColors.blueColor.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: double.infinity,
                            child: TextField(
                              controller: seccodeController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              // focusNode: ibanFocus,
                              // controller: ibanController,
                              cursorColor: MyColors.primaryColor,
                              decoration: InputDecoration(
                                fillColor: MyColors.blueColor.withOpacity(0.40),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Enter Sec Code',

                                hintStyle: TextStyle(
                                  color: MyColors.blackColor.withOpacity(0.30),
                                  fontSize: 14,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                              ),
                            ),
                          ),
                          hSizedBox2,

                          Container(
                            margin: const EdgeInsets.only(left: 22, right: 22),
                            // height: 48,
                            decoration: BoxDecoration(
                              color: MyColors.blueColor.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: double.infinity,
                            child: TextField(
                              controller: accountnumberController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              // focusNode: ibanFocus,
                              // controller: ibanController,
                              cursorColor: MyColors.primaryColor,
                              decoration: InputDecoration(
                                fillColor: MyColors.blueColor.withOpacity(0.40),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                                // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                hintText: 'Enter Account Number',

                                hintStyle: TextStyle(
                                  color: MyColors.blackColor.withOpacity(0.30),
                                  fontSize: 14,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                              ),
                            ),
                          ),

                          hSizedBox4,
                          GestureDetector(
                            onTap: () {
                              String name = nameController.text;
                              String routing_number =
                                  routingnumberController.text;
                              String sec_code = seccodeController.text;
                              String account_number =
                                  accountnumberController.text;
                              if (name.isEmpty) {
                                Utility.showFlutterToast('Enter Name');
                              } else if (routing_number.isEmpty) {
                                Utility.showFlutterToast(
                                  'Enter Routing Number',
                                );
                              } else if (routing_number.length < 9) {
                                Utility.showFlutterToast(
                                  'Please enter 9 digit Routing Number',
                                );
                              } else if (sec_code.isEmpty) {
                                Utility.showFlutterToast('Enter Sec Code');
                              } else if (account_number.isEmpty) {
                                Utility.showFlutterToast(
                                  'Enter Account Number',
                                );
                              } else {
                                debugPrint('Enter Api Calling >>>>> ');
                                paymentmethodsRequest(
                                  context,
                                  name,
                                  routing_number,
                                  sec_code,
                                  account_number,
                                );
                              }
                            },
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0, 4),
                                    blurRadius: 5.0,
                                  )
                                ],
                                gradient: const LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  //  stops: [0.0, 1.0],
                                  colors: [
                                    MyColors.lightblueColor,
                                    MyColors.lightblueColor,
                                  ],
                                ),
                                //color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.only(
                                left: 0,
                                right: 0,
                                bottom: 15,
                                top: 15,
                              ),
                              margin: const EdgeInsets.only(
                                left: 90,
                                right: 90,
                                bottom: 0,
                                top: 20.0,
                              ),
                              child: const Text(
                                'Link Bank Account',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_bold.ttf',
                                ),
                              ),
                            ),
                          ),
                          hSizedBox2,
                          Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            color: MyColors.whiteColor,
                            height: 100,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Custombtn(
                                  MyString.back,
                                  70,
                                  140,
                                  context,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> paymentmethodsRequest(
    BuildContext context,
    String name,
    String routing_number,
    String sec_code,
    String account_number,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    request['name'] = name;
    request['routing_number'] = routing_number;
    request['account_type'] = 'checking';
    request['sec_code'] = sec_code;
    request['account_number'] = account_number;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.AddMagicSenderBank),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        // "Authorization": AllApiService.client_id,
      },
    );

    if (response.statusCode == 200) {
      CustomLoader.ProgressloadingDialog(context, false);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> if$jsonResponse');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduledSelectPaymentMethodScreen(
            selectedMethodScreen: 0,
            isMfs: widget.isMfs,
          ),
        ),
      );
    } else {
      CustomLoader.ProgressloadingDialog(context, false);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> else$jsonResponse');
      Utility.showFlutterToast(jsonResponse['message'].toString());
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

  IBAN() {
    return Container(
      margin: const EdgeInsets.only(left: 22, right: 22),
      height: 48,
      decoration: BoxDecoration(
        color: MyColors.blueColor.withOpacity(0.02),
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        //  focusNode: ibanFocus,
        controller: ibanController,
        cursorColor: MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          hintText: 'AccountNumber',
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/paste.svg',
              height: 15,
            ),
          ),
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.30),
            fontSize: 14,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
          ),
        ),
      ),
    );
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
