import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/recipients_opened_sscreen/recipients_opened_screens.dart';
import 'package:moneytos/view/select_location_screen/select_location_screen.dart';
import 'package:moneytos/view/select_operator_screen/select_oprator_screen.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../add_new_recipients_dashboard/RecipientDetailSelectBankScreen.dart';
import '../add_new_recipients_dashboard/recipient_detail_bank_accountNumber.dart';
import '../s_Api/AllApi/ApiService.dart';
import '../s_Api/s_utils/Utility.dart';
import '../services/Apiservices.dart';
import 'bank_accountnumber/bank_accountNumber.dart';
import 'home/New_selectRecipientIdemDetailPage.dart';
import 'home/s_home/sendmoneyquatationfromNewRecipient/sendmoneyquatationfromNewRecipient.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  final bool? recipientdtl;
  final bool? isAlreadyRecipient;
  final bool? isMfs;
  final Function? Oncallback;

  const SelectPaymentMethodScreen(
      {super.key,
      this.recipientdtl = false,
      this.isAlreadyRecipient = false,
      this.isMfs = false,
      this.Oncallback});

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  String countryISO3 = "";
  String partnerPaymentMethod = "";
  String allowDeliveryMethodTypes = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefData();
    clearAllTransactionValue();
  }

  prefData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("payment method partner>>>>  " +
        sharedPreferences.getString("partnerPaymentMethod").toString());
    print("iso3>>>>  " + sharedPreferences.getString("iso3").toString());
    partnerPaymentMethod =
        sharedPreferences.getString("partnerPaymentMethod").toString();
    countryISO3 = sharedPreferences.getString("iso3").toString();
    countryDetailByIso3Api(context);
    setState(() {});
  }

  update() {
    this.widget.Oncallback!();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: MyColors.primaryColor.withOpacity(0.50),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: MyColors.color_03153B,
              systemOverlayStyle: const SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: MyColors.color_03153B,

                // Status bar brightness (optional)
                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
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
                              "s_asset/images/leftarrow.svg",
                              height: 32,
                              width: 32)),
                    ),
                    // wSizedBox3,
                    // wSizedBox3,
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        alignment: Alignment.center,
                        child: const Text(
                          "Select Payment Method",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              fontFamily:
                                  "s_asset/font/raleway/raleway_extrabold.ttf"),
                        ),
                      ),
                    ),
                    Container(
                      width: 26,
                    )
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 30),
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  color: MyColors.color_03153B,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                                  topRight: Radius.circular(30)),
                            ),
                            child: allowDeliveryMethodTypes == ""
                                ? Container()
                                : Column(
                                    children: [
                                      hSizedBox5,
                                      allowDeliveryMethodTypes.contains("Bank")
                                          ? GestureDetector(
                                              onTap: () {
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPaymentMethodScreen(selectedMethodScreen: 0,)));
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>BankDetailsScreen()));
                                                checkMethod(
                                                  context: context,
                                                  status: "Bank",
                                                );
                                              },
                                              child: Container(
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    border: Border.all(
                                                        color: MyColors
                                                            .color_text
                                                            .withOpacity(0.2),
                                                        width: 1.0),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 24,
                                                          top: 22,
                                                          bottom: 22),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 60),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          "a_assets/icons/bank.svg",
                                                          height: 36,
                                                          width: 36,
                                                        ),
                                                        const SizedBox(
                                                          width: 24,
                                                        ),
                                                        const Text(
                                                          MyString.bank_acount,
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .color_text,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "s_asset/font/raleway/raleway_medium.ttf"),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            )
                                          : Container(),
                                      allowDeliveryMethodTypes
                                              .contains("Mobile")
                                          ? GestureDetector(
                                              onTap: () {
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectServiceProviderScreen()));
                                                checkMethod(
                                                    context: context,
                                                    status: "Mobile");
                                              },
                                              child: Container(
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    border: Border.all(
                                                        color: MyColors
                                                            .color_text
                                                            .withOpacity(0.2),
                                                        width: 1.0),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 24,
                                                          top: 22,
                                                          bottom: 22),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 60),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 8,
                                                            ),
                                                            child: SvgPicture
                                                                .asset(
                                                              "s_asset/images/mobilemoney.svg",
                                                              height: 32,
                                                              width: 32,
                                                            )),
                                                        const SizedBox(
                                                          width: 24,
                                                        ),
                                                        const Text(
                                                          "Mobile Money",
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .color_text,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "s_asset/font/raleway/raleway_medium.ttf"),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            )
                                          : Container(),
                                      allowDeliveryMethodTypes.contains("Cash")
                                          ? GestureDetector(
                                              onTap: () {
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectServiceProviderScreen()));
                                                checkMethod(
                                                    context: context,
                                                    status: "Cash");
                                              },
                                              child: Container(
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    border: Border.all(
                                                        color: MyColors
                                                            .color_text
                                                            .withOpacity(0.2),
                                                        width: 1.0),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0,
                                                          right: 24,
                                                          top: 22,
                                                          bottom: 22),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 60),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 8,
                                                            ),
                                                            child: SvgPicture
                                                                .asset(
                                                              "s_asset/images/cashpickup.svg",
                                                              height: 32,
                                                              width: 32,
                                                            )),
                                                        const SizedBox(
                                                          width: 24,
                                                        ),
                                                        const Text(
                                                          MyString.Cash_Pickup,
                                                          style: TextStyle(
                                                              color: MyColors
                                                                  .color_text,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "s_asset/font/raleway/raleway_medium.ttf"),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            )
                                          : Container(),
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
          ),
        ));
  }

  Update() {
    Navigator.pop(context);
    widget.Oncallback!();
    setState(() {});
  }

  Future<void> checkMethod(
      {required BuildContext context, required String status}) async {
    clearAllTransactionValue();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("mfs_mobile_operator_name", "");
    sharedPreferences.setString("recipientReceiveBankNameOrOperatorName", "");
    sharedPreferences.setString("select_payment_method_status", status);
    bool isMobileMoney = status == 'Mobile';
    print(
        "partnerpayment method>>>>>>> ${sharedPreferences.getString("partnerPaymentMethod").toString()}");

    print("selected status   ${status}");

    (widget.recipientdtl ?? false)
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  sharedPreferences.getString("select_payment_method_status") ==
                          "Mobile"
                      ? SelectOperatorScreen(
                          moreAdd: true,
                          isAlreadyRecipient: true,
                          Oncallback: Update,
                        )
                      : sharedPreferences
                                      .getString("partnerPaymentMethod")
                                      .toString() ==
                                  "juba" &&
                              status == "Cash"
                          ? SelectLocationScreen(
                              isAlreadyRecipient: true,
                            )
                          :
// SelectPaymentMethodScreen(isMfs: true,selectedMethodScreen: 0,)
// SelectDeliveryAddMethodScreen(ismfsAndalready: true,)

                          RecipientDetailBankAccountNumber(
                              Oncallback: Update,
                            ),
              // screen: RecipientDetailSelectBankScreen(onCallback: Update,),
            ))
        : (widget.isMfs ?? false)
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewSelectRecipientHomeDetailScreen(true)))
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (widget.isAlreadyRecipient ?? false)
                      ?
                      // status == 'Mobile'?
                      // SendMoneyQuotationFromNewRecipient(
                      //   isMobileMoney: isMobileMoney,
                      //   isAlreadyRecipient: widget.isAlreadyRecipient,
                      // )
                      // (sharedPreferences
                      //                     .getString("partnerPaymentMethod")
                      //                     .toString() ==
                      //                 "juba" &&
                      //             status == "Cash")
                      //         ? SelectLocationScreen(
                      //             isAlreadyRecipient: true,
                      //           )
                      //         :
                      NewSelectRecipientHomeDetailScreen(widget.isMfs!)
                      :
                      // BankAccountNumber():
                      status == "Mobile"
                          ? SelectOperatorScreen()
                          : (sharedPreferences
                                          .getString("partnerPaymentMethod")
                                          .toString() ==
                                      "juba" &&
                                  status == "Cash")
                              ? SelectLocationScreen()
                              : SendMoneyQuotationFromNewRecipient(
                                  isMobileMoney: isMobileMoney,
                                  isCashPick: status == "Cash" ? true : false,
                                ),
                ),
              );
  }

  clearAllTransactionValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString("dstCurrencyIso3Code","");
    // sharedPreferences.setString("dstCountryIso3Code","").toString();
    // sharedPreferences.setString("sourceCurrencyIso3Code","").toString();
    // sharedPreferences.setString("sendAmount","").toString();
    // sharedPreferences.setString("recipientId","").toString();
    // sharedPreferences.setString("senderId","").toString();
    sharedPreferences.setString("BankdetailResponse", "null").toString();
    // sharedPreferences.setString("exchangerate","").toString();
    // sharedPreferences.setString("fees","").toString();
    sharedPreferences.setString("reasonsending_id", "").toString();
    sharedPreferences.setString("reasonsending_name", "").toString();
    // sharedPreferences.setString("u_first_name","").toString();
    // sharedPreferences.setString("u_last_name","").toString();
    // sharedPreferences.setString("u_profile_img","").toString();
    // sharedPreferences.setString("receiveAmount","").toString();
    setState(() {});
  }

  Future<void> countryDetailByIso3Api(BuildContext context) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //var response = await http.get(Uri.parse(AllApiService.Quote_new_recpi_URL+"dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount="+sendMoney),
    var response = await http.get(
        Uri.parse(Apiservices.countryDetailByIso3api +
            "?country_iso3=${countryISO3}"),
        // body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,
          "content-type": "application/json",
        });
    https: //sandbox-api.readyremit.com/v1/Quote?dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount=3000
    https: //sandbox-api.readyremit.com/v1/Quote?dstCountryIso3Code=IND&dstCurrencyIso3Code=INR&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount=5000
    Utility.ProgressloadingDialog(context, false);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == true) {
        allowDeliveryMethodTypes =
            jsonResponse['data']['allow_delivery_method_types'] ?? '';
      }
    } else {}
    setState(() {});
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
                color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
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
              fontFamily: "s_asset/font/raleway/raleway_bold.ttf",
              fontWeight: FontWeight.w600),
        ))),
  );
}
