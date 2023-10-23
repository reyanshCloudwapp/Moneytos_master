import 'package:moneytos/utils/import_helper.dart';

import '../ScheduledTransferScreens/scheduled_bank_details_screen.dart';

class ManagePaymentDebitCardScreen extends StatefulWidget {
  final Function oncallBack;

  const ManagePaymentDebitCardScreen({Key? key, required this.oncallBack})
      : super(key: key);

  @override
  State<ManagePaymentDebitCardScreen> createState() =>
      _ManagePaymentDebitCardScreenState();
}

class _ManagePaymentDebitCardScreenState
    extends State<ManagePaymentDebitCardScreen> {
  TextEditingController holdernameController = TextEditingController();
  TextEditingController cardnumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController ccvController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  FocusNode ibanFocus = FocusNode();

  int debitcard = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ibanFocus.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dateController.addListener(() {
    //   String text = dateController.text;
    //   if (text.length == 2) {
    //     text += '/';
    //   }
    //   dateController.value = dateController.value.copyWith(
    //     text: text,
    //     selection:
    //     TextSelection(baseOffset: text.length, extentOffset: text.length),
    //     composing: TextRange.empty,
    //   );
    //   debugPrint(dateController.text);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.primaryColor,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.primaryColor,
              statusBarIconBrightness: Brightness.light,
              // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
          ),
        ),
        backgroundColor: MyColors.whiteColor,
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  color: MyColors.primaryColor,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Add New Debit Card',
                                style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_extrabold.ttf',
                                ),
                              ),
                            ),
                            Container()
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 22, 0, 0),
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
                              hSizedBox3,
                              Image.asset(
                                'assets/images/visa.png',
                                width: 300,
                              ),
                              hSizedBox3,
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 22,
                                  right: 22,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: MyColors.blueColor.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.infinity,
                                child: TextField(
                                  controller: holdernameController,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  //  focusNode: ibanFocus,
                                  // controller: ibanController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                    fillColor:
                                        MyColors.blueColor.withOpacity(0.40),
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
                                    hintText: 'Card holder name',

                                    hintStyle: TextStyle(
                                      color:
                                          MyColors.blackColor.withOpacity(0.30),
                                      fontSize: 14,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_medium.ttf',
                                    ),
                                  ),
                                ),
                              ),
                              hSizedBox3,
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 22,
                                  right: 22,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: MyColors.blueColor.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.infinity,
                                child: TextField(
                                  controller: cardnumberController,
                                  maxLength: 16,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  // focusNode: ibanFocus,
                                  // controller: ibanController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                    fillColor:
                                        MyColors.blueColor.withOpacity(0.40),
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
                                    hintText: 'Card Number',

                                    hintStyle: TextStyle(
                                      color:
                                          MyColors.blackColor.withOpacity(0.30),
                                      fontSize: 14,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_medium.ttf',
                                    ),
                                  ),
                                ),
                              ),
                              hSizedBox3,
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 22,
                                        right: 22,
                                      ),
                                      height: 48,

                                      decoration: BoxDecoration(
                                        color: MyColors.blueColor
                                            .withOpacity(0.02),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      // width: 150,
                                      child: TextField(
                                        controller: dateController,
                                        maxLength: 7,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CardExpirationFormatter(),
                                        ],

                                        // onChanged: (String value){
                                        //   if(value.length == 2){
                                        //     dateController.text += "/"; //<-- Automatically show a '/' after dd
                                        //     dateController.selection = TextSelection.fromPosition(TextPosition(offset: dateController.text.length));
                                        //   }else{
                                        //
                                        //   }
                                        //
                                        //
                                        //
                                        // },
                                        textInputAction: TextInputAction.done,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(signed: true),
                                        //focusNode: ibanFocus,
                                        // controller: ibanController,
                                        cursorColor: MyColors.primaryColor,
                                        decoration: InputDecoration(
                                          fillColor: MyColors.blueColor
                                              .withOpacity(0.40),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: MyColors.whiteColor,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: MyColors.whiteColor,
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: MyColors.whiteColor,
                                            ),
                                          ),
                                          // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                          hintText: 'MM / YYYY',
                                          hintStyle: TextStyle(
                                            color: MyColors.blackColor
                                                .withOpacity(0.30),
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                          counterText: '',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 0.0,
                                        right: 22,
                                      ),
                                      height: 48,

                                      decoration: BoxDecoration(
                                        color: MyColors.blueColor
                                            .withOpacity(0.02),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      // width: 150,
                                      child: TextField(
                                        controller: ccvController,
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.number,
                                        //  focusNode: ibanFocus,
                                        // controller: ibanController,
                                        cursorColor: MyColors.primaryColor,
                                        decoration: InputDecoration(
                                          fillColor: MyColors.blueColor
                                              .withOpacity(0.40),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: MyColors.whiteColor,
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: MyColors.whiteColor,
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: MyColors.whiteColor,
                                            ),
                                          ),
                                          // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                          hintText: 'CCV',

                                          hintStyle: TextStyle(
                                            color: MyColors.blackColor
                                                .withOpacity(0.30),
                                            fontSize: 14,
                                            fontFamily:
                                                'assets/fonts/raleway/raleway_medium.ttf',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              hSizedBox3,
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 22,
                                  right: 22,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: MyColors.blueColor.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.infinity,
                                child: TextField(
                                  controller: addressController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // focusNode: ibanFocus,
                                  // controller: ibanController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                    fillColor:
                                        MyColors.blueColor.withOpacity(0.40),
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
                                    hintText: 'Address',

                                    hintStyle: TextStyle(
                                      color:
                                          MyColors.blackColor.withOpacity(0.30),
                                      fontSize: 14,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_medium.ttf',
                                    ),
                                  ),
                                ),
                              ),
                              hSizedBox3,
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 22,
                                  right: 22,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: MyColors.blueColor.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.infinity,
                                child: TextField(
                                  controller: zipController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  // focusNode: ibanFocus,
                                  // controller: ibanController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                    fillColor:
                                        MyColors.blueColor.withOpacity(0.40),
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
                                    hintText: 'Zip',

                                    hintStyle: TextStyle(
                                      color:
                                          MyColors.blackColor.withOpacity(0.30),
                                      fontSize: 14,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_medium.ttf',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: MyColors.whiteColor,
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  top: 30,
                                  right: 10,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    String holderName =
                                        holdernameController.text.trim();
                                    String cardNumber =
                                        cardnumberController.text.trim();
                                    String cardDate =
                                        dateController.text.trim();
                                    String cardCCV = ccvController.text.trim();
                                    String address = addressController.text;
                                    String zipcode = zipController.text;
                                    if (holderName.isEmpty) {
                                      Utility.showFlutterToast(
                                        'Enter Holder Name',
                                      );
                                    } else if (cardNumber.isEmpty) {
                                      Utility.showFlutterToast(
                                        'Enter Card Number',
                                      );
                                    } else if (cardDate.isEmpty) {
                                      Utility.showFlutterToast(
                                        'Enter Card Date',
                                      );
                                    } else if (cardDate.length < 7) {
                                      Utility.showFlutterToast(
                                        'Enter Card Date',
                                      );
                                    } else if (cardCCV.isEmpty) {
                                      Utility.showFlutterToast(
                                        'Enter Card CCV',
                                      );
                                    } else if (address.isEmpty) {
                                      Utility.showFlutterToast(
                                        'Enter Address',
                                      );
                                    } else if (zipcode.isEmpty) {
                                      Utility.showFlutterToast(
                                        'Enter Zip Code',
                                      );
                                    } else {
                                      // transactionsverifyRequest(context, address, zipcode, holderName, int.parse(cardDate.split("/")[0]), int.parse(cardDate.split("/")[1]), cardNumber,cardCCV);
                                      paymentmethodsRequest(
                                        context,
                                        address,
                                        zipcode,
                                        holderName,
                                        int.parse(cardDate.split('/')[0]),
                                        int.parse(cardDate.split('/')[1]),
                                        cardNumber,
                                        cardCCV,
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 150,
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
                                      left: 30,
                                      right: 30,
                                      bottom: 16,
                                      top: 16,
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: 0,
                                      top: 20.0,
                                    ),
                                    child: const Text(
                                      'Add Card',
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
                              ),
                              hSizedBox2,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        color: MyColors.whiteColor,
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

  Future<void> transactionsverifyRequest(
    BuildContext context,
    String avsAddress,
    String avsZip,
    String name,
    int expiryMonth,
    int expiryYear,
    String card,
    String cardCCV,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    var request = {};
    request['avs_address'] = avsAddress;
    request['avs_zip'] = avsZip;
    request['name'] = name;
    request['expiry_month'] = expiryMonth;
    request['expiry_year'] = expiryYear;
    request['card'] = card;
    request['cvv2'] = cardCCV;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.transactions_verifyURL),
      body: jsonEncode(request),
      headers: {
        // "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
        // "X-USERID": "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': AllApiService.client_id,
      },
    );

    if (response.statusCode == 200) {
      CustomLoader.ProgressloadingDialog(context, false);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> if$jsonResponse');
      if (jsonResponse['status'] == 'Approved') {
        paymentmethodsRequest(
          context,
          avsAddress,
          avsZip,
          name,
          expiryMonth,
          expiryYear,
          card,
          cardCCV,
        );
      }
    } else {
      CustomLoader.ProgressloadingDialog(context, false);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> else$jsonResponse');
      Utility.showFlutterToast(jsonResponse['error_details'].toString());
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

  Future<void> paymentmethodsRequest(
    BuildContext context,
    String avsAddress,
    String avsZip,
    String name,
    int expiryMonth,
    int expiryYear,
    String card,
    String cardCCV,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    request['avs_address'] = avsAddress;
    request['avs_zip'] = avsZip;
    request['name'] = name;
    request['expiry_month'] = expiryMonth;
    request['expiry_year'] = expiryYear;
    request['card'] = card;
    request['cvv2'] = cardCCV;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.payment_methods),
      // var response = await http.post(Uri.parse(AllApiService.payment_methods+sharedPreferences.getString("customer_id").toString()+"/payment-methods"),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': AllApiService.client_id,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == false) {
      CustomLoader.ProgressloadingDialog(context, false);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> else$jsonResponse');
      Utility.showFlutterToast(jsonResponse['message'].toString());
    } else {
      CustomLoader.ProgressloadingDialog(context, false);

      debugPrint('jsonResponse>>> if$jsonResponse');
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManageSelectPaymentMethodScreen(selectedMethodScreen: 1,)));
      widget.oncallBack();
      Navigator.pop(context);
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
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
