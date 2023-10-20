import 'dart:convert';
import 'dart:io';
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/S_ApiResponse/SendMoneyQuatationNewRecipResponse.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/view/addrecipientinfoscreen/addrecipientinfoscreen.dart';
import 'package:moneytos/view/resonforsendingscreen/reasonforsendingscreen.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;

import '../../../../constance/customLoader/customLoader.dart';
import '../../../../s_Api/S_ApiResponse/AccountSettingResponse.dart';
import '../../../../services/Apiservices.dart';
import '../home/s_home/go_toreview_screen/go_toreview_screen.dart';

class SendAgainMoneyQuatationFromNewRecipient extends StatefulWidget {
  String selected_acc_id;
  String selected_acc_name;
  String selected_payment_type;
  String selected_last4;
  bool isMfs;
  SendAgainMoneyQuatationFromNewRecipient(
      {Key? key,
      required this.isMfs,
      required this.selected_acc_id,
      required this.selected_acc_name,
      required this.selected_payment_type,
      required this.selected_last4})
      : super(key: key);

  @override
  State<SendAgainMoneyQuatationFromNewRecipient> createState() =>
      _SendAgainMoneyQuatationFromNewRecipientState();
}

class _SendAgainMoneyQuatationFromNewRecipientState
    extends State<SendAgainMoneyQuatationFromNewRecipient> {
  String moneytos_fees_type = "";
  SharedPreferences? sharedPreferences;
  String fixrateAmt = "";
  String countryName = "";
  String countryFlag = "";
  String auhtToken = "";
  String sendMoney = "";

  String desticountry_isoCode3 = "";
  String destcountryCurrency_isoCode3 = "";
  String sourceCurrencyIso3Code = "USD";

  double recieveAmt = 0;
  double exchangeRate = 0;
  double sendAmt = 0;
  double totalCostFee = 0;
  double totalCostFee2 = 0;
  String sendAmount = "";
  double recAmountReciever = 0;

  TextEditingController toMoneyController = TextEditingController();
  TextEditingController fromMoneyController = TextEditingController();
  SendMoneyQuatationNewRecipResponse sendMoneyQuatationNewRecipResponse =
      new SendMoneyQuatationNewRecipResponse();
  String select_payment_method_status = "";
  String document_status = "";
  int transfer_fees = 0;
  double send_moneytos = 0;
  String Is_transaction_fees_free = "0";
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
            }),
        KeyboardActionsItem(
            focusNode: _toamountFocus,
            onTapAction: () async {
              FocusManager.instance.primaryFocus?.unfocus();

              // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));
            }),
      ],
    );
  }

  prefData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {

    });
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

  defaultDataSet() {
    // fromMoneyController.text= "1";
    sendAmt = 1;
    sendAmount = "1";
    var multiply = 1 * 100;
    setState(() {});
    print("multiply....${multiply}");
    sendMoney = multiply.toString();
    print("sendmoney.......£££${sendMoney}");

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        countryWiseExchangeRateApi(
            context,
            sendMoney,
            destcountryCurrency_isoCode3,
            desticountry_isoCode3,
            sourceCurrencyIso3Code));
  }

  Future<void> loadPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    select_payment_method_status = sharedPreferences!.getString("select_payment_method_status").toString();
    destcountryCurrency_isoCode3 =
        sharedPreferences!.getString("country_Currency_isoCode3").toString();

    countryName = sharedPreferences!.getString("country_Name").toString();
    countryFlag = sharedPreferences!.getString("country_Flag").toString();
    auhtToken = sharedPreferences!.getString("auth_Token").toString();
    desticountry_isoCode3 =
        sharedPreferences!.getString("country_isoCode3").toString();
    print("desticountry_isoCode3???? ${desticountry_isoCode3}");
    print("select_payment_method_status???? ${select_payment_method_status}");

    if((desticountry_isoCode3 == "NGA" && select_payment_method_status == "Bank") || (desticountry_isoCode3 == "SOM") || (desticountry_isoCode3 == "ETH")){
      destcountryCurrency_isoCode3 = "USD";
    }else if(desticountry_isoCode3 == "NGA" && select_payment_method_status == "Mobile"){
      destcountryCurrency_isoCode3 = "NGN";
    }

    else{
      countryName = sharedPreferences!.getString("country_Name").toString();
      countryFlag = sharedPreferences!.getString("country_Flag").toString();
      auhtToken = sharedPreferences!.getString("auth_Token").toString();
      desticountry_isoCode3 =
          sharedPreferences!.getString("country_isoCode3").toString();
      destcountryCurrency_isoCode3 = sharedPreferences!.getString("country_Currency_isoCode3").toString();
    }

    print("countryName>>>" + countryName);
    print("countryFlag>>>" + countryFlag);

    print("auhtToken_auhtToken>>>" + auhtToken);
    print("country_isoCode3>>>" + desticountry_isoCode3);
    print("countryCurrency_isoCode3>>>" + destcountryCurrency_isoCode3);

    //WidgetsBinding.instance.addPostFrameCallback((_) =>sendMoneFromneApi(context));
    //   recieveAmt=sendMoneyQuatationNewRecipResponse.receiveAmount!.value.toString();

    print("recieveAmt>>>>>>>>" + recieveAmt.toString());

    feesbuyapi(context, desticountry_isoCode3);
    txnminmaxlimitapi(context, "USD");

    defaultDataSet();
    setState(() {});
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
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
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
                      MyString.Select_Delivery_Method,
                      style: TextStyle(
                          color: MyColors.color_text,
                          fontFamily:
                              "s_asset/font/raleway/raleway_semibold.ttf",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4),
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
                              //SvgPicture.asset("s_asset/images/flag2.svg",width: 26,height: 26,),
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
                                        "s_asset/font/raleway/raleway_medium.ttf",
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.color_text),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                width: 50,
                                child: SvgPicture.asset(
                                    "a_assets/icons/clear_red.svg")),
                          ),
                        ],
                      )),
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
                            // SvgPicture.asset("s_asset/images/flag2.svg",width: 24,height: 24,),
                            //wSizedBox1,
                            Text(MyString.city_name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/Raleway-Medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                          ],
                        ),
                        Container(
                            width: 50,
                            child: SvgPicture.asset("a_assets/icons/clear_red.svg")),

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
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox1,
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(12.0, 26.0, 12.0, 0.0),
                        padding: const EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 9.0),
                        decoration: BoxDecoration(
                          color: MyColors.color_D8E6FA_bac,
                          border: Border.all(
                              color: MyColors.color_gray_transparent),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                    decimal: true),
                                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                focusNode: _amountFocus,

                                onChanged: (String value) async {
                                  if (value.isEmpty) {
                                    toMoneyController.text = "";
                                  } else {
                                    sendAmount = value;
                                    print("sendAmount>>>" + sendAmount);
                                    sendAmt = double.parse(sendAmount);
                                    print("amountEnter" + sendAmt.toString());

                                    //totalAmountOf=amountEnter*amount;
                                    //default data set

                                    var multiply =
                                        double.parse(fromMoneyController.text) *
                                            100;
                                    setState(() {});
                                    print("multiply....${multiply}");
                                    sendMoney = multiply.toString();
                                    print("sendmoney.......£££${sendMoney}");

                                    // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));
                                    //default dataset
                                    recieveAmt =
                                        double.parse(fixrateAmt) * sendAmt;

                                    recAmountReciever = recieveAmt;
                                    print("recAmountReciever>>>>>>>" +
                                        recAmountReciever.toString());

                                    var amount = double.parse(
                                        recAmountReciever.toString());

                                    toMoneyController.text =
                                        (amount).toStringAsFixed(2);

                                    print("amount...${toMoneyController.text}");

                                    exchangeRate = double.parse(fixrateAmt);
                                    print("exchangeRate before>>>>" +
                                        exchangeRate.toString());
                                    exchangeRate = double.parse(
                                        exchangeRate.toStringAsFixed(2));
                                    print("exchangeRate>>>>" +
                                        exchangeRate.toString());

                                    totalCostFee =
                                        double.parse(fixrateAmt) * sendAmt;
                                    print("totalCostFee>>>>>>" +
                                        totalCostFee.toString());
                                    // totalCostFee2 = totalCostFee;
                                    // totalCostFee2 = totalCostFee2 / 100;
                                    totalCostFee2 = sendAmt + moneytos;

                                    print("totalCostFee2>>>>>>" +
                                        totalCostFee2.toString());

                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString("totalCostFee",
                                        totalCostFee2.toString());
                                    print("totalCostFee2>>>>>>>" +
                                        totalCostFee2.toString());

                                    print("dstCurrencyIso3Code" +
                                        destcountryCurrency_isoCode3);
                                    print("dstCountryIso3Code" +
                                        desticountry_isoCode3);
                                    print("sourceCurrencyIso3Code" +
                                        sourceCurrencyIso3Code);
                                    print("sendAmount" + (sendAmt).toString());
                                    print("receiveAmount" +
                                        (recAmountReciever).toString());
                                    sharedPreferences.setString(
                                        "dstCurrencyIso3Code",
                                        destcountryCurrency_isoCode3);
                                    sharedPreferences.setString(
                                        "dstCountryIso3Code",
                                        desticountry_isoCode3);
                                    sharedPreferences.setString(
                                        "sourceCurrencyIso3Code",
                                        sourceCurrencyIso3Code);
                                    sharedPreferences.setString(
                                        "sendAmount", (sendAmt).toString());
                                    sharedPreferences.setString("receiveAmount",
                                        (recAmountReciever).toString());
                                    sharedPreferences.setString("exchangerate",
                                        exchangeRate.toStringAsFixed(2));
                                    sharedPreferences.setString(
                                        "fees", totalCostFee2.toString());

                                    if(Is_transaction_fees_free == "1"){
                                      if(sendAmt >= transaction_fees_free_amount_limit){
                                        send_moneytos = 0;
                                        sharedPreferences.setString("monyetosfee", "0");
                                      }else{
                                        send_moneytos = transfer_fees>0?0:moneytos_fees_type=="Percentage"?double.parse(((moneytos*sendAmt)/100).toStringAsFixed(2)):moneytos;
                                        sharedPreferences.setString("monyetosfee", send_moneytos.toString());
                                      }
                                    }else{
                                      send_moneytos = transfer_fees>0?0:moneytos_fees_type=="Percentage"?double.parse(((moneytos*sendAmt)/100).toStringAsFixed(2)):moneytos;
                                      sharedPreferences.setString("monyetosfee", send_moneytos.toString());
                                      print("send moneytos feess>>>  ${moneytos_fees_type} -- ${send_moneytos} -- ${transfer_fees} -- ${sendAmt} -- ${moneytos}");
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
                                  hintText: "You send",
                                  // contentPadding: EdgeInsets.only(bottom: 5),
                                  hintStyle: TextStyle(
                                      fontSize: 25,
                                      fontFamily:
                                          "s_asset/font/raleway/raleway_medium.ttf",
                                      fontWeight: FontWeight.w800,
                                      color: MyColors.color_ffF4287_text
                                          .withOpacity(0.20)),
                                ),

                                style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily:
                                        "s_asset/font/montserrat/Montserrat-ExtraBold.otf",
                                    fontWeight: FontWeight.w800,
                                    color: MyColors.blackColor),
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset("s_asset/images/flag1.svg"),
                                wSizedBox,
                                const Text(
                                  MyString.usd,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily:
                                          "s_asset/font/raleway/raleway_bold.ttf",
                                      fontWeight: FontWeight.w700,
                                      color: MyColors.color_text),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(12.0, 26.0, 12.0, 0.0),
                        padding: const EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 9.0),
                        decoration: BoxDecoration(
                          color: MyColors.color_D8E6FA_bac,
                          border: Border.all(
                              color: MyColors.color_gray_transparent),
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextField(
                                  controller: toMoneyController,
                                  keyboardType: const TextInputType.numberWithOptions(
                                      decimal: true),
                                  focusNode: _toamountFocus,
                                  maxLines: null,
                                  onChanged: (String value) async {
                                    if (value.isEmpty) {
                                      fromMoneyController.text = "";
                                    } else {
                                      //default dataset
                                      // recieveAmt = double.parse(value)/double.parse(fixrateAmt);
                                      //
                                      // recAmountReciever = recieveAmt;
                                      // print("recAmountReciever>>>>>>>" +
                                      //     recAmountReciever.toString());

                                      var amount = double.parse(value) /
                                          double.parse(fixrateAmt);

                                      fromMoneyController.text =
                                          (amount).toStringAsFixed(2);

                                      print(
                                          "amount...${toMoneyController.text}");

                                      sendAmount = fromMoneyController.text;
                                      print("sendAmount>>>" + sendAmount);
                                      sendAmt = double.parse(sendAmount);
                                      print("amountEnter" + sendAmt.toString());

                                      recieveAmt = double.parse(value);
                                      recAmountReciever = recieveAmt;
                                      print("recAmountReciever>>>>>>>" +
                                          recAmountReciever.toString());
                                      //totalAmountOf=amountEnter*amount;
                                      //default data set

                                      // var multiply =
                                      //     int.parse(toMoneyController.text) * 100;
                                      // setState(() {});
                                      // print("multiply....${multiply}");
                                      // sendMoney = multiply.toString();
                                      print("sendmoney.......£££${sendMoney}");

                                      // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));

                                      exchangeRate = double.parse(fixrateAmt);
                                      print("exchangeRate before>>>>" +
                                          exchangeRate.toString());
                                      exchangeRate = double.parse(
                                          exchangeRate.toStringAsFixed(2));
                                      print("exchangeRate>>>>" +
                                          exchangeRate.toString());

                                      totalCostFee =
                                          double.parse(fixrateAmt) * sendAmt;
                                      print("totalCostFee>>>>>>" +
                                          totalCostFee.toString());
                                      // totalCostFee2 = totalCostFee;
                                      // totalCostFee2 = totalCostFee2 / 100;
                                      totalCostFee2 = sendAmt + moneytos;

                                      print("totalCostFee2>>>>>>" +
                                          totalCostFee2.toString());

                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      sharedPreferences.setString(
                                          "totalCostFee",
                                          totalCostFee2.toString());
                                      print("totalCostFee2>>>>>>>" +
                                          totalCostFee2.toString());

                                      print("dstCurrencyIso3Code" +
                                          destcountryCurrency_isoCode3);
                                      print("dstCountryIso3Code" +
                                          desticountry_isoCode3);
                                      print("sourceCurrencyIso3Code" +
                                          sourceCurrencyIso3Code);
                                      print(
                                          "sendAmount" + (sendAmt).toString());
                                      print("receiveAmount" +
                                          (recAmountReciever).toString());
                                      sharedPreferences.setString(
                                          "dstCurrencyIso3Code",
                                          destcountryCurrency_isoCode3);
                                      sharedPreferences.setString(
                                          "dstCountryIso3Code",
                                          desticountry_isoCode3);
                                      sharedPreferences.setString(
                                          "sourceCurrencyIso3Code",
                                          sourceCurrencyIso3Code);
                                      sharedPreferences.setString(
                                          "sendAmount", (sendAmt).toString());
                                      sharedPreferences.setString(
                                          "receiveAmount",
                                          (recAmountReciever).toString());
                                      sharedPreferences.setString(
                                          "exchangerate",
                                          exchangeRate.toStringAsFixed(2));
                                      sharedPreferences.setString(
                                          "fees", totalCostFee2.toString());

                                      if(Is_transaction_fees_free == "1"){
                                        if(sendAmt >= transaction_fees_free_amount_limit){
                                          send_moneytos = 0;
                                          sharedPreferences.setString("monyetosfee", "0");
                                        }else{
                                          send_moneytos = transfer_fees>0?0:moneytos_fees_type=="Percentage"?double.parse(((moneytos*sendAmt)/100).toStringAsFixed(2)):moneytos;
                                          sharedPreferences.setString("monyetosfee", send_moneytos.toString());
                                        }
                                      }else{
                                        send_moneytos = transfer_fees>0?0:moneytos_fees_type=="Percentage"?double.parse(((moneytos*sendAmt)/100).toStringAsFixed(2)):moneytos;
                                        sharedPreferences.setString("monyetosfee", send_moneytos.toString());
                                      }
                                    }

                                    setState(() {});
                                  },
                                  onSubmitted: (_) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    // labelText: 'Enter Name',
                                    //hintText:"Yhesham sqrat gets",
                                    contentPadding: EdgeInsets.zero,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily:
                                            "s_asset/font/raleway/raleway_medium.ttf",
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.color_ffF4287_text),
                                  ),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontFamily:
                                          "s_asset/font/montserrat/Montserrat-ExtraBold.otf",
                                      fontWeight: FontWeight.w700,
                                      color: MyColors.blackColor),
                                )),
                            Row(
                              children: [
                                //  SvgPicture.asset("s_asset/images/flag2.svg"),
                                (desticountry_isoCode3 == "NGA" && select_payment_method_status == "Bank") || (desticountry_isoCode3 == "SOM") || (desticountry_isoCode3 == "ETH")?     SvgPicture.asset("s_asset/images/flag1.svg")   :    CircledFlag(
                                  flag: countryFlag,
                                  radius: 9,
                                ),
                                wSizedBox,
                                Text(
                                  (desticountry_isoCode3 == "NGA" && select_payment_method_status == "Bank") || (desticountry_isoCode3 == "SOM") || (desticountry_isoCode3 == "ETH")?  "USD":  destcountryCurrency_isoCode3,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_bold.ttf",
                                      fontWeight: FontWeight.w700,
                                      color: MyColors.color_text),
                                ),
                                /*  wSizedBox,
                                  SvgPicture.asset("s_asset/images/dropdown.svg",),*/
                              ],
                            ),
                          ],
                        )),
                    hSizedBox3,
                    hSizedBox3,
                    const Text(
                      "Exchange Rate",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                          fontWeight: FontWeight.w500,
                          color: MyColors.color_text_a),
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
                              "01.00",
                              style: TextStyle(
                                color: MyColors.color_text,
                                fontSize: 12,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              " USD",
                              style: TextStyle(
                                color: MyColors.color_text,
                                fontSize: 9,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf",
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        wSizedBox1,
                        SvgPicture.asset(
                          "s_asset/images/leftrightarrow.svg",
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
                                    "s_asset/font/raleway/raleway_semibold.ttf",
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
                                    "s_asset/font/raleway/raleway_medium.ttf",
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
                        border:
                            Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Fees   ",
                            style: TextStyle(
                              color: MyColors.color_text_a,
                              fontSize: 12,
                              fontFamily:
                                  "s_asset/font/raleway/raleway_medium.ttf",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              send_moneytos.toString(),
                              style: const TextStyle(
                                color: MyColors.color_text,
                                fontSize: 12,
                                fontFamily:
                                "s_asset/font/raleway/raleway_semibold.ttf",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const Text(
                            " USD",
                            style: TextStyle(
                              color: MyColors.color_text,
                              fontSize: 9,
                              fontFamily:
                                  "s_asset/font/raleway/raleway_medium.ttf",
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
                          Utility.showFlutterToast( "Please Enter Send Amount");
                        } else {
                          if (double.parse(sendAmount) < min_limit) {
                            Utility.showFlutterToast(
                                "Please enter a minimum of \$${min_limit}");
                          } else if (double.parse(sendAmount) > max_limit) {
                            Utility.showFlutterToast(
                                "Maximum limit is \$${max_limit}, please contact to raise your send limit");
                          } else {
                            if (document_status == "Approved") {
                              print("document status Approved>>>>>> ");
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectPaymentMethodScreen(isMfs: widget.isMfs,selectedMethodScreen: 1,)));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => GotoreviewScreen(
                              //       isMfs: widget.isMfs,
                              //       selected_acc_id: widget.selected_acc_id,
                              //       selected_payment_type:
                              //           widget.selected_payment_type,
                              //       selected_acc_name: widget.selected_acc_name,
                              //       selected_last4: widget.selected_last4,
                              //       mfsRecipientParam: MfsRecipientParam(
                              //           deliveryMethodType: sharedPreferences!.getString("select_payment_method_status"),
                              //           recipientReceiveBankOrMobileNo: sharedPreferences!.getString("recipientReceiveBankOrMobileNo"),
                              //           recipientReceiveBankNameOrOperatorName: sharedPreferences!.getString("recipientReceiveBankNameOrOperatorName"),
                              //       ),
                              //     ),
                              //   ),
                              // );
                            } else {
                              print("document status Blank>>>>>> ");
                              if (double.parse(sendAmount) <= 200) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => GotoreviewScreen(
                                //               isMfs: widget.isMfs,
                                //           mfsRecipientParam: MfsRecipientParam(
                                //               deliveryMethodType: sharedPreferences!.getString("select_payment_method_status"),
                                //               recipientReceiveBankOrMobileNo: sharedPreferences!.getString("recipientReceiveBankOrMobileNo"),
                                //               recipientReceiveBankNameOrOperatorName: sharedPreferences!.getString("recipientReceiveBankNameOrOperatorName")
                                //           ),
                                //
                                //           selected_acc_id:
                                //                   widget.selected_acc_id,
                                //               selected_payment_type:
                                //                   widget.selected_payment_type,
                                //               selected_acc_name:
                                //                   widget.selected_acc_name,
                                //               selected_last4:
                                //                   widget.selected_last4,
                                //             )));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectPaymentMethodScreen(isMfs: widget.isMfs,selectedMethodScreen: 1,)));
                              } else {
                                Utility.showFlutterToast(
                                        "Please verify your account first to transfer amount more than \$200");
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
                        margin:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              MyColors.lightblueColor.withOpacity(0.90),
                              MyColors.lightblueColor,
                            ]),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: MyColors.lightblueColor, width: 1)),
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
                                          "s_asset/font/raleway/raleway_bold.ttf"),
                                )),
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
        ));
  }

  Future<void> countryWiseExchangeRateApi(
      BuildContext context,
      String sendMoney,
      String destcountryCurrency_isoCode3,
      String desticountry_isoCode3,
      String sourceCurrencyIso3Code) async {
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
    print("amount>>>>>"+sendMoney.toString());*/
    print("destCountryCurrencycodeiso3>>>>>" +
        destcountryCurrency_isoCode3.toString());
    print("destCountrycodeiso3>>>>>" + desticountry_isoCode3.toString());
    print("sourceCountry>>>>>" + sourceCurrencyIso3Code.toString());

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    //var response = await http.get(Uri.parse(AllApiService.Quote_new_recpi_URL+"dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount="+sendMoney),
    var response = await http.get(
        Uri.parse(Apiservices.countryWiseExchangeRateapi +
            "?country_iso3=${desticountry_isoCode3}"),
        // body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,
          "content-type": "application/json",
          "Authorization": "Bearer " + auhtToken,
        });
    print("authToken?>>>>>>" + "Bearer " + auhtToken);
    https: //sandbox-api.readyremit.com/v1/Quote?dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount=3000
    https: //sandbox-api.readyremit.com/v1/Quote?dstCountryIso3Code=IND&dstCurrencyIso3Code=INR&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount=5000

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      // sendMoneyQuatationNewRecipResponse =
      // await SendMoneyQuatationNewRecipResponse.fromJson(jsonResponse);



      recAmountReciever = recieveAmt;
      print("recAmountReciever>>>>>>>" + recAmountReciever.toString());

      var amount = double.parse(recAmountReciever.toString());

      if((desticountry_isoCode3 == "NGA" && select_payment_method_status == "Bank") || (desticountry_isoCode3 == "SOM") || (desticountry_isoCode3 == "ETH")){
        exchangeRate = double.parse("1");
        recieveAmt = double.parse("1");

        fixrateAmt = "1";
      } else{
        exchangeRate = double.parse(jsonResponse['data']['fx_rate'].toString());
        fixrateAmt = jsonResponse['data']['fx_rate'].toString();
        recieveAmt =
            double.parse(jsonResponse['data']['fx_rate'].toString()) * sendAmt;

      }


      // toMoneyController.text = (amount).toString();

      print("amount...${toMoneyController.text}");
      exchangeRate = double.parse(exchangeRate.toStringAsFixed(2));
      print("exchangeRate>>>>" + exchangeRate.toString());

      totalCostFee =
          double.parse(jsonResponse['data']['fx_rate'].toString()) * sendAmt;
      print("totalCostFee>>>>>>" + totalCostFee.toString());
      // totalCostFee2 = totalCostFee;
      // totalCostFee2 = totalCostFee2 / 100;
      totalCostFee2 = sendAmt + moneytos;

      print("totalCostFee2>>>>>>" + totalCostFee2.toString());

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("totalCostFee", totalCostFee2.toString());
      print("totalCostFee2>>>>>>>" + totalCostFee2.toString());

      print("dstCurrencyIso3Code" + destcountryCurrency_isoCode3);
      print("dstCountryIso3Code" + desticountry_isoCode3);
      print("sourceCurrencyIso3Code" + sourceCurrencyIso3Code);
      print("sendAmount" + (sendAmt).toString());
      print("receiveAmount" + (recAmountReciever).toString());
      sharedPreferences.setString(
          "dstCurrencyIso3Code", destcountryCurrency_isoCode3);
      sharedPreferences.setString("dstCountryIso3Code", desticountry_isoCode3);
      sharedPreferences.setString(
          "sourceCurrencyIso3Code", sourceCurrencyIso3Code);
      sharedPreferences.setString("sendAmount", (sendAmt).toString());
      sharedPreferences.setString(
          "receiveAmount", (recAmountReciever).toString());
      sharedPreferences.setString("exchangerate", exchangeRate.toStringAsFixed(2));
      sharedPreferences.setString("fees", totalCostFee2.toString());

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

  Future<void> accountSettingApi(
    BuildContext context,
  ) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    var userid = p.getString("userid");
    var auth = p.getString("auth");
    var request = {};
    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.accountSetting_URl),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      Utility.ProgressloadingDialog(context, false);
      AccountSettingResponse accountSettingResponse =
          await AccountSettingResponse.fromJson(jsonResponse);
      document_status =
          accountSettingResponse.data!.userData!.documentStatus.toString();
      transfer_fees = accountSettingResponse.data!.userData!.freeTransation!;
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast( jsonResponse['message']);
      //  Utility.ProgressloadingDialog(context, false);

      setState(() {});
    }
    return;
  }

  Future<void> feesbuyapi(BuildContext context, String country_iso3) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};
    request['iso3'] = country_iso3;
    request['delivery_method_type'] = sharedPreferences.getString("select_payment_method_status").toString();
    if(sharedPreferences.getString("select_payment_method_status").toString()=="Mobile"){
      request['mobile_operator_name'] = sharedPreferences.getString("recipientReceiveBankNameOrOperatorName").toString();
    }

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.feesbuyapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,
          "content-type": "application/json",
          "accept": "application/json",
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog6(context, false);
      // referlistResponse = await ReferlistResponse.fromJson(jsonResponse);

      print("money tos fees>>> " +
          jsonResponse['data']['monyetosfee'].toString());
      moneytos_fees_type = sharedPreferences.getString("select_payment_method_status").toString()=="Mobile"?
      jsonResponse['data']['mobile_moneytosfee_type'].toString():
      sharedPreferences.getString("select_payment_method_status").toString()=="Cash"?
      jsonResponse['data']['cash_moneytosfee_type'].toString():
      jsonResponse['data']['bank_moneytosfee_type'].toString();

      Is_transaction_fees_free =
      sharedPreferences.getString("select_payment_method_status").toString()=="Mobile"?
      jsonResponse['data']['mobile_Is_transaction_fees_free'].toString():
      sharedPreferences.getString("select_payment_method_status").toString()=="Cash"?
      jsonResponse['data']['cash_Is_transaction_fees_free'].toString():
      jsonResponse['data']['Is_transaction_fees_free'].toString();

      transaction_fees_free_amount_limit =
      sharedPreferences.getString("select_payment_method_status").toString()=="Mobile"?
      double.parse(jsonResponse['data']['mobile_transaction_fees_free_amount_limit'].toString()):
      sharedPreferences.getString("select_payment_method_status").toString()=="Cash"?
      double.parse(jsonResponse['data']['cash_transaction_fees_free_amount_limit'].toString()):
      double.parse(jsonResponse['data']['transaction_fees_free_amount_limit'].toString());

      moneytos =
      sharedPreferences.getString("select_payment_method_status").toString()=="Mobile"
          ? double.parse(jsonResponse['data']['mobile_monyetosfee'].toString()) :
      sharedPreferences.getString("select_payment_method_status").toString()=="Cash"
          ? double.parse(jsonResponse['data']['cash_monyetosfee'].toString()) :
      double.parse(jsonResponse['data']['monyetosfee'].toString());

      send_moneytos = transfer_fees>0?0:moneytos;
      sharedPreferences.setString("monyetosfee", send_moneytos.toString());
      // sharedPreferences.setString("monyetosfee", moneytos.toString());
      setState(() {});
    } else {
      CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {});
    }
    return;
  }

  Future<void> txnminmaxlimitapi(BuildContext context, String currency) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};
    request['currency'] = currency;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.txnminmaxlimitapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,
          "content-type": "application/json",
          "accept": "application/json",
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      // referlistResponse = await ReferlistResponse.fromJson(jsonResponse);

      print("money tos fees>>> " +
          jsonResponse['data']['monyetosfee'].toString());
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
