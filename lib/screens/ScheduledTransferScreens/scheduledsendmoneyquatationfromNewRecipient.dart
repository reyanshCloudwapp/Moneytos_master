import 'package:moneytos/screens/ScheduledTransferScreens/scheduledaddrecipientinfoscreen.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/SendMoneyQuatationNewRecipResponse.dart';
import 'package:moneytos/utils/import_helper.dart';

class ScheduledSendMoneyQuatationFromNewRecipient extends StatefulWidget {
  const ScheduledSendMoneyQuatationFromNewRecipient({super.key});

  @override
  State<ScheduledSendMoneyQuatationFromNewRecipient> createState() =>
      _ScheduledSendMoneyQuatationFromNewRecipientState();
}

class _ScheduledSendMoneyQuatationFromNewRecipientState
    extends State<ScheduledSendMoneyQuatationFromNewRecipient> {
  String fixrateAmt = '';
  String countryName = '';
  String countryFlag = '';
  String auhtToken = '';
  String sendMoney = '';

  String desticountry_isoCode3 = '';
  String destcountryCurrency_isoCode3 = '';
  String sourceCurrencyIso3Code = 'USD';

  double recieveAmt = 0;
  double exchangeRate = 0;
  double sendAmt = 0;
  double totalCostFee = 0;
  double totalCostFee2 = 0;
  String sendAmount = '';
  double recAmountReciever = 0;

  TextEditingController toMoneyController = TextEditingController();
  TextEditingController fromMoneyController = TextEditingController();
  SendMoneyQuatationNewRecipResponse sendMoneyQuatationNewRecipResponse =
      SendMoneyQuatationNewRecipResponse();

  String document_status = '';
  int transfer_fees = 0;
  double send_moneytos = 0;
  String Is_transaction_fees_free = '0';
  double transaction_fees_free_amount_limit = 0;
  double moneytos = 0;
  int min_limit = 0;
  int max_limit = 0;

  final _amountFocus = FocusNode();
  final _toamountFocus = FocusNode();

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [
        KeyboardActionsItem(
          focusNode: _amountFocus,
          onTapAction: () async {
            FocusManager.instance.primaryFocus?.unfocus();

            // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));
          },
        ),
        KeyboardActionsItem(
          focusNode: _toamountFocus,
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
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => accountSettingApi(context));
    loadPref();
    setState(() {});
  }

  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    countryName = sharedPreferences.getString('country_Name').toString();
    countryFlag = sharedPreferences.getString('country_Flag').toString();
    auhtToken = sharedPreferences.getString('auth_Token').toString();
    desticountry_isoCode3 =
        sharedPreferences.getString('country_isoCode3').toString();
    destcountryCurrency_isoCode3 =
        sharedPreferences.getString('country_Currency_isoCode3').toString();

    debugPrint('countryName>>>$countryName');
    debugPrint('countryFlag>>>$countryFlag');

    debugPrint('auhtToken_auhtToken>>>$auhtToken');
    debugPrint('country_isoCode3>>>$desticountry_isoCode3');
    debugPrint('countryCurrency_isoCode3>>>$destcountryCurrency_isoCode3');

    //WidgetsBinding.instance.addPostFrameCallback((_) =>sendMoneFromneApi(context));
    //   recieveAmt=sendMoneyQuatationNewRecipResponse.receiveAmount!.value.toString();

    debugPrint('recieveAmt>>>>>>>>$recieveAmt');

    feesbuyapi(context, desticountry_isoCode3);
    txnminmaxlimitapi(context, 'USD');

    defaultDataSet();
    setState(() {});
  }

  defaultDataSet() {
    // fromMoneyController.text= "1";
    sendAmt = 1;
    sendAmount = '1';
    var multiply = 1 * 100;
    setState(() {});
    debugPrint('multiply....$multiply');
    sendMoney = multiply.toString();
    debugPrint('sendmoney.......£££$sendMoney');

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => countryWiseExchangeRateApi(
        context,
        sendMoney,
        destcountryCurrency_isoCode3,
        desticountry_isoCode3,
        sourceCurrencyIso3Code,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          actions: const [],
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 65, left: 26, right: 26),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.enter_amount,
                    style: TextStyle(
                      color: MyColors.color_text,
                      fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                hSizedBox4,
                Container(
                  width: double.infinity,
                  height: 50,
                  // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 20.0, 0.0),
                  decoration: const BoxDecoration(
                    color: MyColors.whiteColor,
                    //border: Border.all(color: MyColors.color_gray_transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.color_linecolor,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          //SvgPicture.asset("assets/images/flag2.svg",width: 26,height: 26,),
                          CircledFlag(
                            flag: countryFlag,
                            radius: 13,
                          ),
                          wSizedBox1,
                          Text(
                            countryName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_medium.ttf',
                              fontWeight: FontWeight.w500,
                              color: MyColors.color_text,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                        child: SvgPicture.asset(
                          'assets/icons/clear_red.svg',
                        ),
                      ),
                    ],
                  ),
                ),
                //SizedBox2,
                /*   hSizedBox,

                Container(
                    height: 50,
                    width:double.infinity,
                    //  margin:  EdgeInsets.fromLTRB(12.0, 16.0, 0.0, 0.0),
                    padding: EdgeInsets.fromLTRB(16.0,0, 20.0, 0.0),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      //  border: Border.all(color: MyColors.color_gray_transparent),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.color_linecolor,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
                        ),
                      ],
                    ),


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // SvgPicture.asset("assets/images/flag2.svg",width: 24,height: 24,),
                            //wSizedBox1,
                            Text(MyString.city_name,style: TextStyle(fontSize: 14,fontFamily: "assets/fonts/raleway/Raleway-Medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                          ],
                        ),
                        Container(
                            width: 50,
                            child: SvgPicture.asset("assets/icons/clear_red.svg")),

                      ],
                    )
                ),
*/
              ],
            ),
          ),
        ),
      ),
      body: KeyboardActions(
        autoScroll: false,
        config: _buildKeyboardActionsConfig(context),
        child: Container(
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          width: double.infinity,
          /*  decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(30),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),bottomLeft: Radius.circular(5)),
                  color: MyColors.whiteColor),*/
          child: SingleChildScrollView(
            child: Column(
              children: [
                hSizedBox1,
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(12.0, 26.0, 12.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  decoration: BoxDecoration(
                    color: MyColors.color_D8E6FA_bac,
                    border: Border.all(
                      color: MyColors.color_gray_transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        child: TextField(
                          controller: fromMoneyController,
                          // keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          focusNode: _amountFocus,

                          onChanged: (String value) async {
                            if (value.isEmpty) {
                              toMoneyController.text = '';
                            } else {
                              sendAmount = value;
                              debugPrint('sendAmount>>>$sendAmount');
                              sendAmt = double.parse(sendAmount);
                              debugPrint('amountEnter$sendAmt');

                              //totalAmountOf=amountEnter*amount;
                              //default data set

                              var multiply =
                                  double.parse(fromMoneyController.text) * 100;
                              setState(() {});
                              debugPrint('multiply....$multiply');
                              sendMoney = multiply.toString();
                              debugPrint(
                                'sendmoney.......£££$sendMoney',
                              );

                              // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));
                              //default dataset
                              recieveAmt = double.parse(fixrateAmt) * sendAmt;

                              recAmountReciever = recieveAmt;
                              debugPrint(
                                'recAmountReciever>>>>>>>$recAmountReciever',
                              );

                              var amount = double.parse(
                                recAmountReciever.toString(),
                              );

                              toMoneyController.text =
                                  (amount).toStringAsFixed(2);

                              debugPrint(
                                'amount...${toMoneyController.text}',
                              );

                              exchangeRate = double.parse(fixrateAmt);
                              debugPrint(
                                'exchangeRate before>>>>$exchangeRate',
                              );
                              exchangeRate = double.parse(
                                exchangeRate.toStringAsFixed(2),
                              );
                              debugPrint('exchangeRate>>>>$exchangeRate');

                              totalCostFee = double.parse(fixrateAmt) * sendAmt;
                              debugPrint(
                                'totalCostFee>>>>>>$totalCostFee',
                              );
                              // totalCostFee2 = totalCostFee;
                              // totalCostFee2 = totalCostFee2 / 100;
                              totalCostFee2 = sendAmt + moneytos;

                              debugPrint(
                                'totalCostFee2>>>>>>$totalCostFee2',
                              );

                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString(
                                'totalCostFee',
                                totalCostFee2.toString(),
                              );
                              debugPrint(
                                'totalCostFee2>>>>>>>$totalCostFee2',
                              );

                              debugPrint(
                                'dstCurrencyIso3Code$destcountryCurrency_isoCode3',
                              );
                              debugPrint(
                                'dstCountryIso3Code$desticountry_isoCode3',
                              );
                              debugPrint(
                                'sourceCurrencyIso3Code$sourceCurrencyIso3Code',
                              );
                              debugPrint('sendAmount$sendAmt');
                              debugPrint(
                                'receiveAmount$recAmountReciever',
                              );
                              sharedPreferences.setString(
                                'dstCurrencyIso3Code',
                                destcountryCurrency_isoCode3,
                              );
                              sharedPreferences.setString(
                                'dstCountryIso3Code',
                                desticountry_isoCode3,
                              );
                              sharedPreferences.setString(
                                'sourceCurrencyIso3Code',
                                sourceCurrencyIso3Code,
                              );
                              sharedPreferences.setString(
                                'sendAmount',
                                (sendAmt).toString(),
                              );
                              sharedPreferences.setString(
                                'receiveAmount',
                                (recAmountReciever).toString(),
                              );
                              sharedPreferences.setString(
                                'exchangerate',
                                exchangeRate.toStringAsFixed(2),
                              );
                              sharedPreferences.setString(
                                'fees',
                                totalCostFee2.toString(),
                              );
                              if (Is_transaction_fees_free == '1') {
                                if (sendAmt >=
                                    transaction_fees_free_amount_limit) {
                                  send_moneytos = 0;
                                  sharedPreferences.setString(
                                    'monyetosfee',
                                    '0',
                                  );
                                } else {
                                  send_moneytos = moneytos;
                                  sharedPreferences.setString(
                                    'monyetosfee',
                                    moneytos.toString(),
                                  );
                                }
                              } else {
                                send_moneytos = moneytos;
                                sharedPreferences.setString(
                                  'monyetosfee',
                                  moneytos.toString(),
                                );
                              }
                            }

                            setState(() {});
                          },

                          onSubmitted: (_) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            // labelText: 'Enter Name',
                            hintText: 'You send',
                            // contentPadding: EdgeInsets.only(bottom: 5),
                            hintStyle: TextStyle(
                              fontSize: 25,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_medium.ttf',
                              fontWeight: FontWeight.w800,
                              color:
                                  MyColors.color_ffF4287_text.withOpacity(0.20),
                            ),
                          ),

                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily:
                                'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                            fontWeight: FontWeight.w800,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/flag1.svg'),
                          wSizedBox,
                          const Text(
                            MyString.usd,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                              fontWeight: FontWeight.w700,
                              color: MyColors.color_text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(12.0, 26.0, 12.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  decoration: BoxDecoration(
                    color: MyColors.color_D8E6FA_bac,
                    border: Border.all(
                      color: MyColors.color_gray_transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextField(
                          controller: toMoneyController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          focusNode: _toamountFocus,
                          maxLines: null,
                          onChanged: (String value) async {
                            if (value.isEmpty) {
                              fromMoneyController.text = '';
                            } else {
                              //default dataset
                              // recieveAmt = double.parse(value)/double.parse(fixrateAmt);
                              //
                              // recAmountReciever = recieveAmt;
                              // debugPrint("recAmountReciever>>>>>>>" +
                              //     recAmountReciever.toString());

                              var amount = double.parse(value) /
                                  double.parse(fixrateAmt);

                              fromMoneyController.text =
                                  (amount).toStringAsFixed(2);

                              debugPrint(
                                'amount...${toMoneyController.text}',
                              );

                              sendAmount = fromMoneyController.text;
                              debugPrint('sendAmount>>>$sendAmount');
                              sendAmt = double.parse(sendAmount);
                              debugPrint('amountEnter$sendAmt');

                              recieveAmt = double.parse(value);
                              recAmountReciever = recieveAmt;
                              debugPrint(
                                'recAmountReciever>>>>>>>$recAmountReciever',
                              );
                              //totalAmountOf=amountEnter*amount;
                              //default data set

                              // var multiply =
                              //     int.parse(toMoneyController.text) * 100;
                              // setState(() {});
                              // debugPrint("multiply....${multiply}");
                              // sendMoney = multiply.toString();
                              debugPrint(
                                'sendmoney.......£££$sendMoney',
                              );

                              // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));

                              exchangeRate = double.parse(fixrateAmt);
                              debugPrint(
                                'exchangeRate before>>>>$exchangeRate',
                              );
                              exchangeRate = double.parse(
                                exchangeRate.toStringAsFixed(2),
                              );
                              debugPrint(
                                'exchangeRate>>>>$exchangeRate',
                              );

                              totalCostFee = double.parse(fixrateAmt) * sendAmt;
                              debugPrint(
                                'totalCostFee>>>>>>$totalCostFee',
                              );
                              // totalCostFee2 = totalCostFee;
                              // totalCostFee2 = totalCostFee2 / 100;
                              totalCostFee2 = sendAmt + moneytos;

                              debugPrint(
                                'totalCostFee2>>>>>>$totalCostFee2',
                              );

                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString(
                                'totalCostFee',
                                totalCostFee2.toString(),
                              );
                              debugPrint(
                                'totalCostFee2>>>>>>>$totalCostFee2',
                              );

                              debugPrint(
                                'dstCurrencyIso3Code$destcountryCurrency_isoCode3',
                              );
                              debugPrint(
                                'dstCountryIso3Code$desticountry_isoCode3',
                              );
                              debugPrint(
                                'sourceCurrencyIso3Code$sourceCurrencyIso3Code',
                              );
                              debugPrint('sendAmount$sendAmt');
                              debugPrint(
                                'receiveAmount$recAmountReciever',
                              );
                              sharedPreferences.setString(
                                'dstCurrencyIso3Code',
                                destcountryCurrency_isoCode3,
                              );
                              sharedPreferences.setString(
                                'dstCountryIso3Code',
                                desticountry_isoCode3,
                              );
                              sharedPreferences.setString(
                                'sourceCurrencyIso3Code',
                                sourceCurrencyIso3Code,
                              );
                              sharedPreferences.setString(
                                'sendAmount',
                                (sendAmt).toString(),
                              );
                              sharedPreferences.setString(
                                'receiveAmount',
                                (recAmountReciever).toString(),
                              );
                              sharedPreferences.setString(
                                'exchangerate',
                                exchangeRate.toStringAsFixed(2),
                              );
                              sharedPreferences.setString(
                                'fees',
                                totalCostFee2.toString(),
                              );

                              if (Is_transaction_fees_free == '1') {
                                if (sendAmt >=
                                    transaction_fees_free_amount_limit) {
                                  send_moneytos = 0;
                                  sharedPreferences.setString(
                                    'monyetosfee',
                                    '0',
                                  );
                                } else {
                                  send_moneytos = moneytos;
                                  sharedPreferences.setString(
                                    'monyetosfee',
                                    moneytos.toString(),
                                  );
                                }
                              } else {
                                send_moneytos = moneytos;
                                sharedPreferences.setString(
                                  'monyetosfee',
                                  moneytos.toString(),
                                );
                              }
                            }

                            setState(() {});
                          },
                          onSubmitted: (_) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            // labelText: 'Enter Name',
                            //hintText:"Yhesham sqrat gets",
                            contentPadding: EdgeInsets.zero,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_medium.ttf',
                              fontWeight: FontWeight.w500,
                              color: MyColors.color_ffF4287_text,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 25,
                            fontFamily:
                                'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                            fontWeight: FontWeight.w800,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          //  SvgPicture.asset("assets/images/flag2.svg"),
                          CircledFlag(
                            flag: countryFlag,
                            radius: 9,
                          ),
                          Text(
                            destcountryCurrency_isoCode3,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                              fontWeight: FontWeight.w700,
                              color: MyColors.color_text,
                            ),
                          ),
                          /*  wSizedBox,
                                SvgPicture.asset("assets/images/dropdown.svg",),*/
                        ],
                      ),
                    ],
                  ),
                ),
                hSizedBox3,
                hSizedBox3,
                const Text(
                  'Exchange Rate',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                    fontWeight: FontWeight.w500,
                    color: MyColors.color_text_a,
                  ),
                ),
                hSizedBox1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '01.00',
                          style: TextStyle(
                            color: MyColors.color_text,
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          ' USD',
                          style: TextStyle(
                            color: MyColors.color_text,
                            fontSize: 9,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    wSizedBox1,
                    SvgPicture.asset(
                      'assets/images/leftrightarrow.svg',
                      height: 10,
                      width: 10,
                    ),
                    wSizedBox1,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          exchangeRate.toStringAsFixed(2),
                          style: const TextStyle(
                            color: MyColors.color_text,
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_semibold.ttf',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          destcountryCurrency_isoCode3,
                          style: const TextStyle(
                            color: MyColors.color_text,
                            fontSize: 9,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                hSizedBox3,
                Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    color: MyColors.color_D8E6FA_bac,
                    border: Border.all(color: MyColors.color_gray_transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Fees   ',
                        style: TextStyle(
                          color: MyColors.color_text_a,
                          fontSize: 12,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        send_moneytos.toString(),
                        style: const TextStyle(
                          color: MyColors.color_text,
                          fontSize: 12,
                          fontFamily:
                              'assets/fonts/raleway/raleway_semibold.ttf',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        ' USD',
                        style: TextStyle(
                          color: MyColors.color_text,
                          fontSize: 9,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                hSizedBox1,
                GestureDetector(
                  onTap: () {
                    sendMoney = fromMoneyController.text;

                    if (sendMoney.isEmpty) {
                      Utility.showFlutterToast('Please Enter Send Amount');
                    } else {
                      if (double.parse(sendAmount) < min_limit) {
                        Utility.showFlutterToast(
                          'Please enter more than $min_limit amount',
                        );
                      } else if (double.parse(sendAmount) > max_limit) {
                        Utility.showFlutterToast(
                          'Please enter less than $max_limit amount',
                        );
                      } else {
                        if (document_status == 'Approved') {
                          debugPrint('document status Approved>>>>>> ');
                          transferbottomsheet(context);
                        } else {
                          debugPrint('document status Blank>>>>>> ');
                          if (double.parse(sendAmount) <= 200) {
                            transferbottomsheet(context);
                          } else {
                            Utility.showFlutterToast(
                              'Please verify your account first to transfer amount more than \$200',
                            );
                          }
                        }
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width / 4,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 40,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MyColors.lightblueColor.withOpacity(0.90),
                          MyColors.lightblueColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: MyColors.lightblueColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            MyString.Next,
                            style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                hSizedBox1,
                hSizedBox2,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> countryWiseExchangeRateApi(
    BuildContext context,
    String sendMoney,
    String destcountrycurrencyIsocode3,
    String desticountryIsocode3,
    String sourceCurrencyIso3Code,
  ) async {
    Utility.ProgressloadingDialog(context, true);
    var request = {};
    /*dstCountryIso3Code=MEX
    &dstCurrencyIso3Code=MXN
    &srcCurrencyIso3Code=USD
    &transferMethod=BANK_ACCOUNT
    &quoteBy=SEND_AMOUNT
    &amount=2000*/
    /*request['amount'] = sendMoney;
    request['dstCountryIso3Code'] = "MEX";
    request['dstCurrencyIso3Code'] = "MXN";
    request['srcCurrencyIso3Code'] = "USD";
    request['transferMethod'] = "BANK_ACCOUNT";
    request['quoteBy'] = "SEND_AMOUNT";
    debugPrint("amount>>>>>"+sendMoney.toString());*/
    debugPrint('destCountryCurrencycodeiso3>>>>>$destcountrycurrencyIsocode3');
    debugPrint('destCountrycodeiso3>>>>>$desticountryIsocode3');
    debugPrint('sourceCountry>>>>>$sourceCurrencyIso3Code');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    //var response = await http.get(Uri.parse(AllApiService.Quote_new_recpi_URL+"dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount="+sendMoney),
    var response = await http.get(
      Uri.parse(
        '${Apiservices.countryWiseExchangeRateapi}?country_iso3=$desticountryIsocode3',
      ),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
        'content-type': 'application/json',
        'Authorization': 'Bearer $auhtToken',
      },
    );
    debugPrint('authToken?>>>>>>' 'Bearer ' '$auhtToken');
    https: //sandbox-api.readyremit.com/v1/Quote?dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount=3000
    https: //sandbox-api.readyremit.com/v1/Quote?dstCountryIso3Code=IND&dstCurrencyIso3Code=INR&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount=5000

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // sendMoneyQuatationNewRecipResponse =
      // await SendMoneyQuatationNewRecipResponse.fromJson(jsonResponse);

      fixrateAmt = jsonResponse['data']['fx_rate'].toString();
      recieveAmt =
          double.parse(jsonResponse['data']['fx_rate'].toString()) * sendAmt;

      recAmountReciever = recieveAmt;
      debugPrint('recAmountReciever>>>>>>>$recAmountReciever');

      var amount = double.parse(recAmountReciever.toString());

      // toMoneyController.text = (amount).toString();

      debugPrint('amount...${toMoneyController.text}');

      exchangeRate = double.parse(jsonResponse['data']['fx_rate'].toString());
      debugPrint('exchangeRate before>>>>$exchangeRate');
      exchangeRate = double.parse(exchangeRate.toStringAsFixed(2));
      debugPrint('exchangeRate>>>>$exchangeRate');

      totalCostFee =
          double.parse(jsonResponse['data']['fx_rate'].toString()) * sendAmt;
      debugPrint('totalCostFee>>>>>>$totalCostFee');
      // totalCostFee2 = totalCostFee;
      // totalCostFee2 = totalCostFee2 / 100;
      totalCostFee2 = sendAmt + moneytos;

      debugPrint('totalCostFee2>>>>>>$totalCostFee2');

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('totalCostFee', totalCostFee2.toString());
      debugPrint('totalCostFee2>>>>>>>$totalCostFee2');

      debugPrint('dstCurrencyIso3Code$destcountrycurrencyIsocode3');
      debugPrint('dstCountryIso3Code$desticountryIsocode3');
      debugPrint('sourceCurrencyIso3Code$sourceCurrencyIso3Code');
      debugPrint('sendAmount$sendAmt');
      debugPrint('receiveAmount$recAmountReciever');
      sharedPreferences.setString(
        'dstCurrencyIso3Code',
        destcountrycurrencyIsocode3,
      );
      sharedPreferences.setString('dstCountryIso3Code', desticountryIsocode3);
      sharedPreferences.setString(
        'sourceCurrencyIso3Code',
        sourceCurrencyIso3Code,
      );
      sharedPreferences.setString('sendAmount', (sendAmt).toString());
      sharedPreferences.setString(
        'receiveAmount',
        (recAmountReciever).toString(),
      );
      sharedPreferences.setString(
        'exchangerate',
        exchangeRate.toStringAsFixed(2),
      );
      sharedPreferences.setString('fees', totalCostFee2.toString());

      Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      // Fluttertoast.showToast(msg: errorres[0]["message"]);
      //Fluttertoast.showToast(msg: "Minimum amount was not met for this transaction.");

      Utility.ProgressloadingDialog(context, false);
      setState(() {});
    }
  }

  transferbottomsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      // anchorPoint: Offset(20.0, 30.0),
      //  backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: CustompinDialog(context),
          ),
        );
      },
    );
  }

  CustompinDialog(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/logo/confirm_img.svg',
                height: 100,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: const Text(
                MyString.please_confirm,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: const Text(
                MyString.exchange_rate_will_be_calculated_on_the,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 40,
                left: 25,
                right: 25,
                bottom: 60,
              ),
              //  alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => TransferReasonforSendingScreen2()));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ScheduledAddRecipientInfoScreen(),
                    ),
                  );
                  setState(() {});
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
                          MyString.confirm,
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
            ),
            hSizedBox3
          ],
        ),
      ),
    );
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
      Utility.ProgressloadingDialog(context, false);
      AccountSettingResponse accountSettingResponse =
          AccountSettingResponse.fromJson(jsonResponse);
      document_status =
          accountSettingResponse.data!.userData!.documentStatus.toString();
      transfer_fees = accountSettingResponse.data!.userData!.freeTransation!;
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast(jsonResponse['message']);
      //  Utility.ProgressloadingDialog(context, false);

      setState(() {});
    }
    return;
  }

  Future<void> feesbuyapi(BuildContext context, String countryIso3) async {
    CustomLoader.progressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
    var request = {};
    request['iso3'] = countryIso3;
    request['delivery_method_type'] =
        sharedPreferences.getString('select_payment_method_status').toString();
    if (sharedPreferences
            .getString('select_payment_method_status')
            .toString() ==
        'Mobile') {
      request['mobile_operator_name'] = sharedPreferences
          .getString('recipientReceiveBankNameOrOperatorName')
          .toString();
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.feesbuyapi),
      body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CustomLoader.progressloadingDialog6(context, false);
      // referlistResponse = await ReferlistResponse.fromJson(jsonResponse);

      debugPrint("money tos fees>>> ${jsonResponse['data']['monyetosfee']}");
      Is_transaction_fees_free =
          jsonResponse['data']['Is_transaction_fees_free'].toString();
      transaction_fees_free_amount_limit = double.parse(
        jsonResponse['data']['transaction_fees_free_amount_limit'].toString(),
      );
      moneytos = double.parse(jsonResponse['data']['monyetosfee'].toString());
      send_moneytos = moneytos;
      sharedPreferences.setString('monyetosfee', moneytos.toString());
      // sharedPreferences.setString("monyetosfee", moneytos.toString());
      setState(() {});
    } else {
      CustomLoader.progressloadingDialog6(context, false);
      setState(() {});
    }
    return;
  }

  Future<void> txnminmaxlimitapi(BuildContext context, String currency) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
    var request = {};
    request['currency'] = currency;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.txnminmaxlimitapi),
      body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      // referlistResponse = await ReferlistResponse.fromJson(jsonResponse);

      debugPrint("money tos fees>>> ${jsonResponse['data']['monyetosfee']}");
      min_limit = int.parse(jsonResponse['data']['min_limit'].toString());
      max_limit = int.parse(jsonResponse['data']['max_limit'].toString());
      setState(() {});
    } else {
      setState(() {});
    }
    return;
  }
}

class CircledFlag extends StatelessWidget {
  const CircledFlag({
    Key? key,
    required this.flag,
    required this.radius,
  }) : super(key: key);

  final String flag;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _FlagClipper(radius),
      child: Text(
        flag,
        style: TextStyle(fontSize: 3 * radius),
      ),
    );
  }
}

class _FlagClipper extends CustomClipper<Path> {
  const _FlagClipper(this.radius);

  final double radius;

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);

    path.addOval(Rect.fromCircle(center: center, radius: radius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
