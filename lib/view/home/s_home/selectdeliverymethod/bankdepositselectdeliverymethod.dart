import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/S_ApiResponse/SelectBankListResponse.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/view/bank_accountnumber/bank_accountNumber.dart';
import 'package:moneytos/view/home/s_home/cashpickupmethodscreen/cashpickupseleclocation.dart';
import 'package:moneytos/view/home/s_home/mobilemoneyMethod/mobilemoneynumkeyboard.dart';
import 'package:moneytos/view/home/s_home/selectbankaccounnum/selectdeliverymethodbankaccountnumber.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class BankDepositDeliveryMethodScreen extends StatefulWidget {
  String status = MyString.bank_deposit;

  BankDepositDeliveryMethodScreen(this.status);

  @override
  State<BankDepositDeliveryMethodScreen> createState() =>
      _BankDepositDeliveryMethodScreenState();
}

class _BankDepositDeliveryMethodScreenState
    extends State<BankDepositDeliveryMethodScreen> {
  TextEditingController searchBankController = TextEditingController();
  TextEditingController searchStoreController = TextEditingController();
  TextEditingController serviceProvider = TextEditingController();
  FocusNode searchFocus = FocusNode();

  ///Textfield contrller
  TextEditingController searchMobileCompanyController = TextEditingController();

  // SelectBankListResponse selectBankListResponse = new SelectBankListResponse();
  // List<SelectBankListResponse> selectBankListResponse = [];
  FocusNode searchstoreFocus = FocusNode();

  List<BankListSelectPost> posts = [];
  String countryName = "";
  String countryFlag = "";
  String totalFees = "";
  String auhtToken = "";
  String desticountry_isoCode3 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadPref();
    setState(() {});
  }

  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    countryName = sharedPreferences.getString("country_Name").toString();
    countryFlag = sharedPreferences.getString("country_Flag").toString();
    totalFees = sharedPreferences.getString("totalCostFee").toString();
    auhtToken = sharedPreferences.getString("auth_Token").toString();
    desticountry_isoCode3 =
        sharedPreferences.getString("country_isoCode3").toString();

    print("countryName>>>" + countryName);
    print("countryFlag>>>" + countryFlag);
    print("totalCostFee>>>" + totalFees);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => selectBankApi(context, auhtToken, desticountry_isoCode3));

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocus.unfocus();
    searchstoreFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(390),
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
            padding: const EdgeInsets.only(top: 65, left: 20, right: 20),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      MyString.Select_Delivery_Method,
                      style: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4),
                    ),
                  ),
                  hSizedBox3,
                  Container(
                      height: 55,
                      width: double.infinity,
                      // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                      padding: const EdgeInsets.fromLTRB(16.0, 5.0, 20.0, 5.0),
                      decoration: const BoxDecoration(
                        color: MyColors.whiteColor,
                        //border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.color_linecolor,
                            offset: Offset(0.0, 1.6), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
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
                          Container(
                              width: 50,
                              child: SvgPicture.asset(
                                  "a_assets/icons/clear_red.svg")),
                        ],
                      )),
                  hSizedBox2,
                  Container(
                      height: 55,
                      width: double.infinity,
                      // margin:  EdgeInsets.fromLTRB(12.0, 16.0, 0.0, 0.0),
                      padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                      decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                        border:
                            Border.all(color: MyColors.color_gray_transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: const [
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
                          const Row(
                            children: [
                              // SvgPicture.asset("s_asset/images/flag2.svg",width: 24,height: 24,),
                              //wSizedBox1,
                              Text(
                                MyString.City_Name,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                        "s_asset/font/raleway/raleway_bold.ttf",
                                    fontWeight: FontWeight.w700,
                                    color: MyColors.color_text),
                              ),
                            ],
                          ),
                          Container(
                              width: 50,
                              child: SvgPicture.asset(
                                  "a_assets/icons/clear_red.svg")),
                        ],
                      )),
                  //
                  hSizedBox1,

                  Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                          widget.status == MyString.bank_deposit
                              ? MyString.select_bank
                              : widget.status == MyString.mobile_money
                                  ? "Select Service Provider"
                                  : widget.status == MyString.Cash_Pickup
                                      ? "Select Store"
                                      : "",
                          style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.4,
                              fontFamily:
                                  "s_asset/font/raleway/raleway_semibold.ttf"))),

                  hSizedBox1,
                  Container(
                      child: widget.status == MyString.bank_deposit
                          ? searchbank()
                          : widget.status == MyString.mobile_money
                              ? searchCompany()
                              : widget.status == MyString.Cash_Pickup
                                  ? searchStore()
                                  : Container()
                      //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
                      ),
                  hSizedBox2,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: 100,
          color: MyColors.whiteColor,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 2.7,
              vertical: 25),
          // margin: EdgeInsets.symmetric(vertical:10 ),
          child: CustomButton(
            btnname: MyString.back,
            textcolor: MyColors.lightblueColor,
            bordercolor: MyColors.lightblueColor.withOpacity(0.08),
            bg_color: MyColors.lightblueColor.withOpacity(0.14),
          ),
        ),
      ),
      body: Stack(children: [
        widget.status == MyString.bank_deposit
            ? Container(
                margin: const EdgeInsets.only(left: 12, right: 12, top: 1),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        //scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 0.73,
                          crossAxisSpacing: 1.1,
                          mainAxisSpacing: 0.3,
                        ),
                        children: List.generate(posts.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SelectDeliveryMethodBankAccNum()));
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 0),
                                child: CustomSelectBankList(
                                  title: posts[index].name.toString(),
                                  img:
                                      "a_assets/images/onboarding_img/logo.png",
                                )),
                          );
                        }).toList(),
                      ),
                      hSizedBox6,
                      hSizedBox4,
                    ],
                  ),
                ),
              )
            : widget.status == MyString.mobile_money
                ? mobilemoneydeposit()
                : cashpickup(),
        hSizedBox2,
      ]),
    );
  }

  searchbank() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: MyColors.blueColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(5)),
      width: double.infinity,
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: searchFocus,
        controller: searchBankController,
        cursorColor: MyColors.lightblueColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          enabledBorder: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.lightblueColor)),
          hintText: MyString.search_bank,
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.30),
              fontWeight: FontWeight.w500,
              fontSize: 13),
        ),
      ),
    );
  }

  searchStore() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: MyColors.blueColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(5)),
      width: double.infinity,
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: searchFocus,
        controller: searchStoreController,
        cursorColor: MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          hintText: MyString.Search_Store,
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.30),
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
      ),
    );
  }

  searchCompany() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: MyColors.blueColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(5)),
      width: double.infinity,
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: searchFocus,
        controller: serviceProvider,
        cursorColor: MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          hintText: MyString.Search_Mobile_Company,
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.30),
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
      ),
    );
  }

  mobilemoneydeposit() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox3,
            GridView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 0.74,
                crossAxisSpacing: 1.1,
                mainAxisSpacing: 0.3,
              ),
              children: CustomList.countrylist.map((String url) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MobileMoneyNumberKeyboardScreen()));
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: CustomSelectBankList(
                        title: MyString.Company_name,
                        img: "s_asset/images/companyimg.png",
                      )),
                );
              }).toList(),
            ),
            hSizedBox6,
            hSizedBox4,
          ],
        ),
      ),
    );
  }

  cashpickup() {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          // hSizedBox2,

          GridView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 0.74,
              crossAxisSpacing: 1.1,
              mainAxisSpacing: 0.3,
            ),
            children: CustomList.countrylist.map((String url) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CashPickUpSelectLocation()));
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: CustomSelectBankList(
                      title: MyString.Company_name,
                      img: "s_asset/images/store.png",
                    )),
              );
            }).toList(),
          ),
          hSizedBox6,
          hSizedBox6,
        ],
      ),
    ));
  }

  /*<<<<<<<<<<<<<<<<<<<SelecBankApi>>>>>>>>>>>>>>>>>>>*/

  Future<void> selectBankApi(BuildContext context, String auhtToken,
      String desticountry_isoCode3) async {
    Utility.ProgressloadingDialog(context, true);
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(
        Uri.parse(AllApiService.select_Banks_URL +
            "countryIso3Code=" +
            desticountry_isoCode3),
        // body: convert.jsonEncode(request),
        headers: {
          "Authorization": "Bearer " + auhtToken,
        });
    print("authToken?>>>>>>" + "Bearer " + auhtToken);

    // Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    /*  final jsonList = jsonDecode(response.body) as List<dynamic>;
    final searchedUsers = [
      for (final map in jsonList.cast<Map<String, dynamic>>())
        SelectBankListResponse.fromJson(map)
    ];

    searchedUsers.forEach(print);
    print("vnjksngjksgfjknfjkn>>>  "+jsonList[0]);
*/

    posts = PostsBankList.fromJson(json.decode(response.body)).bankList!;
    print("ndlknbldnfb>>> " +
        PostsBankList.fromJson(json.decode(response.body))
            .bankList![0]
            .name
            .toString());

    Utility.ProgressloadingDialog(context, false);

    setState(() {});

//     if (jsonResponse['status'] == true) {
//       selectBankListResponse  = await SelectBankListResponse.fromJson(jsonResponse);
//
//
//
//     /*  for(int i =0; i<selectCountryListResponse.data!.length;i++){
//
//         selectCountryList.add(selectCountryListResponse.data![i]);
//
//
//
//
//
//       }
// */
//
//       Utility.ProgressloadingDialog(context, false);
//       setState(() {
//
//       });
//     } else {
//       Utility.ProgressloadingDialog(context, false);
//
//       selectBankListResponse  = await SelectBankListResponse.fromJson(jsonResponse);
//       setState(() {
//
//       });
//     }

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
