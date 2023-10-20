import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/CustomSelectCountryList.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/S_ApiResponse/SelectCountryListResponse.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/view/home/s_home/select_recipient_cityscreen/selectrecipientcity.dart';

import 'dart:convert' as convert;
import 'package:intl/intl.dart' show DateFormat;
import 'package:moneytos/view/home/s_home/sendmoneyquatationfromNewRecipient/sendmoneyquatationfromNewRecipient.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../home/s_home/sendmoneyquotation/sendmoneyfromrecipient.dart';
import '../mfs_select_payment_method.dart';

class SelectRecipentCountry extends StatefulWidget {
  SelectRecipentCountry({Key? key}) : super(key: key);

  @override
  State<SelectRecipentCountry> createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends State<SelectRecipentCountry> {
  SelectCountryListResponse selectCountryListResponse =
      new SelectCountryListResponse();
  List<SelectCountryList> selectCountryList = <SelectCountryList>[];

  ///Textfield contrller
  TextEditingController searchcountryController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) =>selectCountryListApi(context));
    selectCountryListApi(context);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 20, top: 60, right: 20),
            child: Column(
              children: [
                Container(
                  child: Text(
                    MyString.Select_Recipient_Country,
                    style: TextStyle(
                        color: MyColors.color_text,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        fontFamily:
                            "s_asset/font/raleway/raleway_semibold.ttf"),
                  ),
                ),
                hSizedBox4,
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    //  padding:  EdgeInsets.symmetric(horizontal: 20.0),
                    child: searchCountry()
                    //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
                    ),
              ],
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          actions: [
            Container(
              width: 50,
            )
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
        },
        child: Container(
          height: 100,
          color: MyColors.whiteColor,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 2.7,
              vertical: 25),
          margin: EdgeInsets.only(bottom: 0),
          child: CustomButton(
            btnname: MyString.cancel,
            textcolor: MyColors.lightblueColor,
            bordercolor: MyColors.lightblueColor.withOpacity(0.08),
            bg_color: MyColors.lightblueColor.withOpacity(0.14),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //hSizedBox1,
              isLoad == true
                  ? Utility.shrimmerCountryGridLoader(80, 150)
                  : GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 0.50,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 0.5,
                      ),
                      children:
                          List.generate(selectCountryList.length, (index) {
                        return Container(
                          child: GestureDetector(
                            onTap: () async {
                              print("selectCountryList[index].partnerPaymentMethod>>>   "+selectCountryList[index].partnerPaymentMethod.toString());
                              selectCountryList[index].partnerPaymentMethod ==
                                      "nium"
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectPaymentMethodScreen()
                                              // SendMoneyQuotationFromNewRecipient()
                                      ))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SelectPaymentMethodScreen(),
                                      ),
                                    );
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             SendMoneyQuatationFromNewRecipient()));

                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString("country_Name",
                                  selectCountryList[index].name.toString());
                              sharedPreferences.setString("country_Flag",
                                  selectCountryList[index].emoji.toString());
                              sharedPreferences.setString("iso3",
                                  selectCountryList[index].iso3.toString());
                              sharedPreferences.setString("iso2",
                                  selectCountryList[index].iso2.toString());
                              sharedPreferences.setString("country_isoCode3",
                                  selectCountryList[index].iso3.toString());
                              sharedPreferences.setString(
                                  "country_Currency_isoCode3",
                                  selectCountryList[index].currency.toString());
                              sharedPreferences.setString(
                                  "phonecode",
                                  selectCountryList[index]
                                      .phonecode
                                      .toString());
                              sharedPreferences.setString(
                                  "phonenumber_min_max_validation",
                                  selectCountryList[index]
                                      .phonumberMinMaxValidation
                                      .toString());
                              sharedPreferences.setString("currency",
                                  selectCountryList[index].currency.toString());
                              sharedPreferences.setString(
                                  "partnerPaymentMethod",
                                  selectCountryList[index]
                                      .partnerPaymentMethod
                                      .toString());
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: CustomSelectCountryList(
                                  title:
                                      selectCountryList[index].name.toString(),
                                  img:
                                      selectCountryList[index].emoji.toString(),
                                )),
                          ),
                        );
                      }).toList(),
                    ),

              hSizedBox6,
            ],
          ),
        ),
      ),
    );
  }

  searchCountry() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: MyColors.blueColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(5)),
      width: double.infinity,
      child: TextField(
        onChanged: (value) => _searchCountryFilter(value),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: searchFocus,
        controller: searchcountryController,
        cursorColor: MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          hintText: MyString.select_country,
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.30),
              fontWeight: FontWeight.w500,
              fontSize: 13),
        ),
      ),
    );
  }

  Future<void> selectCountryListApi(
    BuildContext context,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    isLoad = true;
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(AllApiService.Countries_List_URL),
        // body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      selectCountryListResponse =
          await SelectCountryListResponse.fromJson(jsonResponse);

      for (int i = 0; i < selectCountryListResponse.data!.length; i++) {
        selectCountryList.add(selectCountryListResponse.data![i]);
      }

      // Utility.ProgressloadingDialog(context, false);
      isLoad = false;
      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);
      isLoad = false;

      selectCountryListResponse =
          await SelectCountryListResponse.fromJson(jsonResponse);
      setState(() {});
    }

    return;
  }

  void _searchCountryFilter(String enteredKeyword) {
    List<SelectCountryList> results = <SelectCountryList>[];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = selectCountryListResponse.data!;
    } else {
      results = selectCountryList
          .where((user) => user.name
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      selectCountryList = results;
    });
  }
}
