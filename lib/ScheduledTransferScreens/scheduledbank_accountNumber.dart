import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/ScheduledTransferScreens/scheduledselectdeliveryaddmethod.dart';
import 'package:moneytos/constance/customLoader/customLoader.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/s_ModelClass/BankAccountNumberModel.dart';
import 'package:moneytos/s_Api/s_ModelClass/CreateAccountDetailsResponse.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/home/home.dart';
import 'package:moneytos/view/home/s_home/selectbankaccounnum/selectdeliveryaddmethod.dart';
import 'package:moneytos/view/select_bank/selectBank_screen.dart';
import 'package:moneytos/view/select_recipent_contry/select_recipentCountry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;
import 'package:intl/intl.dart' show DateFormat;
import 'package:moneytos/view/home/s_home/sendmoneyquatationfromNewRecipient/sendmoneyquatationfromNewRecipient.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constance/customTextfield/uppercase_textfield.dart';
import '../s_Api/s_ModelClass/niumroutingcodetyperesponse.dart';
import '../services/Apiservices.dart';

class ScheduledBankAccountNumber extends StatefulWidget {
  String bank_name;
  String bank_id;

  ScheduledBankAccountNumber({Key? key, this.bank_name = "", this.bank_id = ""}) : super(key: key);

  @override
  State<ScheduledBankAccountNumber> createState() => _ScheduledBankAccountNumberState();
}

class _ScheduledBankAccountNumberState extends State<ScheduledBankAccountNumber> {
  ///Textfield contrller
  bool ischeck = false;
  TextEditingController ibanController = TextEditingController();
  FocusNode ibanFocus = FocusNode();

  String? selectedCategory;

  String? selectedCategory2;
  String slect_bank_type = "";

  String countryName = "";
  String countryFlag = "";
  String auhtToken = "";
  String sendMoney = "";
  String recipientId = "";

  String country_isoCode2 = "";
  String desticountry_isoCode3 = "";
  String destcountryCurrency_isoCode3 = "";
  String sourceCurrencyIso3Code = "USD";

  List<BankAccountNumberFieldSetsModel> fieldsetlistAccount = [];
  List<BankAccountsfieldModel> bankAccModelList = [];
  List<BankAccountOptionsModel> optionBanklist = [];
  List<CreateAccFields> createAccfildList = [];
  bool load = false;
  TextEditingController routingTypeController = TextEditingController();
  TextEditingController routingValueController = TextEditingController();
  TextEditingController bankAccNumberController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  FocusNode accounNumFocusNode = FocusNode();
  String bankAccountNum = "";
  List<NiumRoutingCodeType> niumroutingcodetypeList = [];
  TextEditingController PakCodeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadPref();
    WidgetsBinding.instance.addPostFrameCallback((_) => niumRoutingCodeTypesApi(context));
    // getfieldAccount();
    setState(() {});
  }

  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    countryName = sharedPreferences.getString("country_Name").toString();
    countryFlag = sharedPreferences.getString("country_Flag").toString();
    auhtToken = sharedPreferences.getString("auth_Token").toString();
    country_isoCode2 = sharedPreferences.getString("iso2").toString();
    desticountry_isoCode3 =
        sharedPreferences.getString("country_isoCode3").toString();
    destcountryCurrency_isoCode3 =
        sharedPreferences.getString("country_Currency_isoCode3").toString();
    recipientId = sharedPreferences.getString("recpi_id").toString();

    print("countryName>>>" + countryName);
    print("countryFlag>>>" + countryFlag);
    print("recipientId>>>" + recipientId);

    print("auhtToken_auhtToken>>>" + auhtToken);
    print("country_isoCode3>>>" + desticountry_isoCode3);
    print("countryCurrency_isoCode3>>>" + destcountryCurrency_isoCode3);

    //  WidgetsBinding.instance.addPostFrameCallback((_) =>BankAccountSiledApi());

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    accounNumFocusNode.unfocus();
  }

  /*List<AddaccounNumberFieldModel> addfieldlist = [];
  bool field_load =false;*/

  getfieldAccount() {
    fieldsetlistAccount.clear();
    bankAccModelList.clear();
    optionBanklist.clear();
    setState(() {
      load = true;
    });
    // await BankAccountSiledApi(context, fieldsetlistAccount,bankAccModelList,optionBanklist);
    WidgetsBinding.instance.addPostFrameCallback((_) => BankAccountSiledApi(
        context, fieldsetlistAccount, bankAccModelList, optionBanklist));

    setState(() {
      load = false;
    });
  }

  PakCodeUpdate(String pakCode , String pakName){
    niumroutingcodetypeList.clear();
    print("pak code>>> "+pakCode);
    print("pak name>>> "+pakName);
    niumroutingcodetypeList.add(NiumRoutingCodeType(type: "BANK CODE",value: pakCode)) ;
    PakCodeController.text = pakCode+"-"+pakName;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          title: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                MyString.bank_account_number,
                style: TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 18,
                    letterSpacing: 0.2,
                    fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
              )),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: MyColors.whiteColor,
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                //  padding: EdgeInsets.only(top: size.height / 2),
                alignment: Alignment.center,
                child: Custombtn(MyString.back, 70, 140, context),
              ),
            ),
            GestureDetector(
              onTap: () {
                String accountNumber = bankAccNumberController.text;
                String accountType = accountTypeController.text;
                String bankName = bankNameController.text;
                for(var valdata in niumroutingcodetypeList){
                  print("val data>>> "+valdata.value.toString());
                  if(valdata.type.toString().isEmpty){
                    Utility.showFlutterToast( "Enter routing type");
                  }else if(valdata.value.toString().isEmpty){
                    Utility.showFlutterToast( "Enter routing value");
                  }else if(accountNumber.isEmpty){
                    Utility.showFlutterToast( "Enter account number");
                  }else if(accountType.isEmpty){
                    Utility.showFlutterToast( "Enter account type");
                  }else if(bankName.isEmpty){
                    Utility.showFlutterToast( "Enter bank name");
                  }else{
                    if(ischeck==false){
                      addRecipientBankAccountapi(context, accountNumber, accountType, bankName);
                      ischeck = true;
                    }

                  }
                }
              },
              child: addMathodButton(MyString.add_method, 70, 200),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height / 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              hSizedBox3,
              desticountry_isoCode3=="PAK"?
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      Utility().dialogAccountType(context,PakCodeUpdate);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(
                          20.0, 0.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                        color: MyColors.color_93B9EE
                            .withOpacity(0.1),
                        border: Border.all(
                            color: MyColors
                                .color_gray_transparent),
                        borderRadius: BorderRadius.all(
                            Radius.circular(12.0)),
                      ),
                      child: TextFormField(
                        enabled: false,
                        controller:PakCodeController,
                        // routingValueController,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        textInputAction:
                        TextInputAction.done,

                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                            "a_assets/font/poppins_regular.ttf"),
                        decoration: InputDecoration(
                          hintText:
                          // fieldsetlistAccount[index]
                          //     .fields![i]
                          //     .placeholderText,
                          "Select Bank Code",
                          hintStyle: TextStyle(
                              color: MyColors.color_text
                                  .withOpacity(0.4),
                              fontSize: 12,
                              fontFamily:
                              "s_asset/font/raleway/raleway_medium.ttf",
                              fontWeight:
                              FontWeight.w500),

                          border: InputBorder.none,

                          // fillColor: MyColors.color_gray_transparent,
                          contentPadding:
                          EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12),
                        ),
                        // keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                      ),
                    ),
                  ),
                  InkWell(onTap:(){
                    String search_key = "BANK CODE";
                    String search_value = niumroutingcodetypeList[0].value!;
                    String payout_method = "LOCAL";
                    searchbanknamebyifscApi(context, country_isoCode2, search_key, search_value, destcountryCurrency_isoCode3, payout_method, search_key);
                  }, child: Container(margin: EdgeInsets.only(right: 23,top: 10), alignment:Alignment.centerRight, child: Text("Validate",style: TextStyle(color: MyColors.lightblueColor),))),
                  hSizedBox3,
                ],
              ):
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(8),
                  itemCount: niumroutingcodetypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(
                              20.0, 0.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                            color: MyColors.color_93B9EE
                                .withOpacity(0.1),
                            border: Border.all(
                                color: MyColors
                                    .color_gray_transparent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(12.0)),
                          ),
                          child: TextFormField(
                            // controller:
                            // routingValueController,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            onChanged: (val){
                              niumroutingcodetypeList[index].value = val;
                              setState(() {

                              });
                            },
                            // inputFormatters: [
                            //   LengthLimitingTextInputFormatter(18),
                            // ],
                            textInputAction:
                            TextInputAction.done,
                            onFieldSubmitted: (val) {
                              if(index==0){
                                print("hvfh if>>>>  ${val}");
                                String search_key = niumroutingcodetypeList[index].type!;
                                String search_value = val;
                                String payout_method = "LOCAL";
                                // searchbanknamebyifscApi(context, country_isoCode2, search_key, search_value, destcountryCurrency_isoCode3, payout_method, search_key);
                              }else{
                                print("hvfh else>>>>  ");
                              }

                              // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);

                              //  addfieldlist.add(addmodel);
                              //  print("json..${json.encode(addfieldlist)}");
                              setState(() {});
                            },

                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily:
                                "a_assets/font/poppins_regular.ttf"),
                            decoration: InputDecoration(
                              hintText:
                              // fieldsetlistAccount[index]
                              //     .fields![i]
                              //     .placeholderText,
                              "Enter ${niumroutingcodetypeList[index].type}",
                              hintStyle: TextStyle(
                                  color: MyColors.color_text
                                      .withOpacity(0.4),
                                  fontSize: 12,
                                  fontFamily:
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight:
                                  FontWeight.w500),

                              border: InputBorder.none,

                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding:
                              EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12),
                            ),
                            // keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                          ),
                        ),
                        index == 0?InkWell(onTap:(){
                          String search_key = niumroutingcodetypeList[index].type!;
                          String search_value = niumroutingcodetypeList[index].value!;
                          String payout_method = "LOCAL";
                          searchbanknamebyifscApi(context, country_isoCode2, search_key, search_value, destcountryCurrency_isoCode3, payout_method, search_key);
                        }, child: Container(margin: EdgeInsets.only(right: 23,top: 10), alignment:Alignment.centerRight, child: Text("Validate",style: TextStyle(color: MyColors.lightblueColor),))):Container(),
                        hSizedBox3,
                      ],
                    );
                  }
              ),


              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(
                    20.0, 0.0, 20.0, 0.0),
                decoration: BoxDecoration(
                  color: MyColors.color_93B9EE
                      .withOpacity(0.1),
                  border: Border.all(
                      color: MyColors
                          .color_gray_transparent),
                  borderRadius: BorderRadius.all(
                      Radius.circular(12.0)),
                ),
                child: TextFormField(
                  enabled: false,
                  controller:
                  bankNameController,
                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(18),
                  // ],
                  textInputAction:
                  TextInputAction.next,
                  onTap: () {
                    print("hvfh");
                    // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);

                    //  addfieldlist.add(addmodel);
                    //  print("json..${json.encode(addfieldlist)}");
                    setState(() {});
                  },

                  style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily:
                      "a_assets/font/poppins_regular.ttf"),
                  decoration: InputDecoration(
                    hintText:
                    // fieldsetlistAccount[index]
                    //     .fields![i]
                    //     .placeholderText,
                    "Bank Name",
                    hintStyle: TextStyle(
                        color: MyColors.color_text
                            .withOpacity(0.4),
                        fontSize: 12,
                        fontFamily:
                        "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight:
                        FontWeight.w500),

                    border: InputBorder.none,

                    // fillColor: MyColors.color_gray_transparent,
                    contentPadding:
                    EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),

              hSizedBox3,
              // hSizedBox3,
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(
                    20.0, 0.0, 20.0, 0.0),
                decoration: BoxDecoration(
                  color: MyColors.color_93B9EE
                      .withOpacity(0.1),
                  border: Border.all(
                      color: MyColors
                          .color_gray_transparent),
                  borderRadius: BorderRadius.all(
                      Radius.circular(12.0)),
                ),
                child: TextFormField(
                  controller:
                  bankAccNumberController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(18),
                  ],
                  textInputAction:
                  TextInputAction.next,
                  onTap: () {
                    print("hvfh");
                    // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);

                    //  addfieldlist.add(addmodel);
                    //  print("json..${json.encode(addfieldlist)}");
                    setState(() {});
                  },

                  style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily:
                      "a_assets/font/poppins_regular.ttf"),
                  decoration: InputDecoration(
                    hintText:
                    // fieldsetlistAccount[index]
                    //     .fields![i]
                    //     .placeholderText,
                    "Account Number",
                    hintStyle: TextStyle(
                        color: MyColors.color_text
                            .withOpacity(0.4),
                        fontSize: 12,
                        fontFamily:
                        "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight:
                        FontWeight.w500),

                    border: InputBorder.none,

                    // fillColor: MyColors.color_gray_transparent,
                    contentPadding:
                    EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12),
                  ),
                  keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                ),
              ),
              hSizedBox3,
              InkWell(
                onTap: (){
                  dialogAccountType(context);
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(
                      20.0, 0.0, 20.0, 0.0),
                  decoration: BoxDecoration(
                    color: MyColors.color_93B9EE
                        .withOpacity(0.1),
                    border: Border.all(
                        color: MyColors
                            .color_gray_transparent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(12.0)),
                  ),
                  child: TextFormField(
                    enabled: false,
                    controller:
                    accountTypeController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                    ],
                    textInputAction:
                    TextInputAction.next,
                    onTap: () {
                      print("hvfh");
                      // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);

                      //  addfieldlist.add(addmodel);
                      //  print("json..${json.encode(addfieldlist)}");
                      setState(() {});
                    },

                    style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily:
                        "a_assets/font/poppins_regular.ttf"),
                    decoration: InputDecoration(
                      hintText:
                      // fieldsetlistAccount[index]
                      //     .fields![i]
                      //     .placeholderText,
                      "Bank Account Type",
                      hintStyle: TextStyle(
                          color: MyColors.color_text
                              .withOpacity(0.4),
                          fontSize: 12,
                          fontFamily:
                          "s_asset/font/raleway/raleway_medium.ttf",
                          fontWeight:
                          FontWeight.w500),

                      border: InputBorder.none,

                      // fillColor: MyColors.color_gray_transparent,
                      contentPadding:
                      EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12),
                    ),
                    keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                  ),
                ),
              ),



              /*  IBAN(),
             hSizedBox2,
             hSizedBox1,
             GestureDetector(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (_) => SelectRecipentCountry()));
               },
               child: Container(
                 alignment: Alignment.bottomRight,
                 child:Custombtn(MyString.check,70,140,context) ,
               ),
             ),
*/
            ],
          ),
        ),
      ),
    );
  }

  dialogAccountType(BuildContext context) {

    List<String> listtype = ["Checking","Saving"];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Container(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[


                Container(
                  // margin: EdgeInsets.only(left: 14,right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Select Bank Account Type",
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily:
                            "s_asset/font/raleway/raleway_extrabold.ttf"),
                      ),

                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listtype.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  accountTypeController.text = listtype[index];
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.radio_button_off_sharp,color: MyColors.primaryColor,),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text('${listtype[index]}')),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),

                      SizedBox(height: 10,),
                    ],
                  ),),



              ],
            ),
          ),
        ),
      ),
    );

  }

  IBAN() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: MyColors.blueColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(5)),
      width: double.infinity,
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: ibanFocus,
        controller: ibanController,
        cursorColor: MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintText: MyString.iban_code,
          suffixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: SvgPicture.asset(
              "a_assets/icons/paste.svg",
              height: 15,
            ),
          ),
          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.30),
              fontSize: 14,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        ),
      ),
    );
  }

  addMathodButton(
    String text,
    double height,
    double width,
  ) {
    return Container(
      height: height,
      // width: width,
      color: MyColors.whiteColor,
      //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
      child: Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
            ],
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              //  stops: [0.0, 1.0],
              colors: [
                MyColors.color_3F84E5.withOpacity(0.88),
                MyColors.color_3F84E5,
              ],
            ),
            //color: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: MyColors.whiteColor,
                fontSize: 17,
                fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
          ))),
    );
  }

  Future<void> BankAccountSiledApi(
      BuildContext context,
      List<BankAccountNumberFieldSetsModel> fieldsetlistAccount,
      List<BankAccountsfieldModel> bankAccModelList,
      List<BankAccountOptionsModel> optionBanklist) async {
    Utility.ProgressloadingDialog(context, true);

    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString("userid");
    print("auth_tocken....${p.getString('auth_Token')}");
    print("country_isoCode3....${p.getString("country_isoCode3")}");
    print(
        "country_Currency_isoCode3....${p.getString("country_Currency_isoCode3")}");
    print("url...." +
        "https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT");

    var request = {};

    print("request ${request}");
    var response = await http.get(
        Uri.parse(AllApiService.recipient_banAccount_fields +
            "recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
        });
    print(response.body);

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    var dataresponse = jsonResponse['fieldSets'];
    print("dataresponse${dataresponse}");
    if (dataresponse != null) {
      Utility.ProgressloadingDialog(context, false);
      setState(() {});

      dataresponse.forEach((element) {
        BankAccountNumberFieldSetsModel fieldstateModel =
            BankAccountNumberFieldSetsModel.fromJson(element);
        fieldsetlistAccount.add(fieldstateModel);
        print("fieldSetId${fieldsetlistAccount[0].fieldSetId}");
        var fieldresponse = element['fields'];
        print("fields.....${fieldresponse}");

        if (fieldresponse != null) {
          fieldresponse.forEach((element) {
            BankAccountsfieldModel recipientfieldstateModel =
                BankAccountsfieldModel.fromJson(element);
            bankAccModelList.add(recipientfieldstateModel);
            print("recipientfieldsetlist${bankAccModelList[0].name}");

            print("element...${element['fieldType']}");

            // for(int i= 0; i < recipientfieldsetlist.length; i++ ){
            if (element['fieldType'] == "DROPDOWN") {
              var optiondata = element['options'];
              print("options...${optiondata}");

              if (optiondata != null) {
                optiondata.forEach((element) {
                  BankAccountOptionsModel optionmodel =
                      BankAccountOptionsModel.fromJson(element);
                  optionBanklist.add(optionmodel);
                  slect_bank_type = optionBanklist.length > 0 ?   optionBanklist[0].id.toString() : "" ;
                  print("optionmodel ${slect_bank_type}");
                });
              }
              // }

            } else {}
          });
        }
      });
    } else {
      Utility.ProgressloadingDialog(context, false);
      setState(() {});
    }
    return;
  }


  static Future<void> AddBankAccountfieldFieldRequest2(BuildContext context,
      var createAccfildList,
      String bankAccountNum, String recipientId) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['dstCountryIso3Code'] = "${p.getString("country_isoCode3")}";
    request['dstCurrencyIso3Code'] = "${p.getString("country_Currency_isoCode3")}";
    request['transferMethod'] = "BANK_ACCOUNT";
    request['senderId'] = "23cab527-e802-4e49-8cc1-78e5c5c8e8df";
    request['fields'] = createAccfildList;

    print("request ${request}");
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse("https://sandbox-api.readyremit.com/v1/recipients/"+recipientId+"/accounts"),
        body: convert.jsonEncode(request),
        headers: {
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("bdjkdshjgh"+jsonResponse.toString());

     /* String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();*/

      p.setString("BankdetailResponse", response.body);
      /* message == "" || message.isEmpty || message == ""? null:*/
    //  createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId);

      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScheduledSelectDeliveryAddMethodScreen()));


    } else {
      List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast( errorres[0]["message"]);
        CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }


  Future<void> addBankAccFiledField(BuildContext context, var createAccfildList,
      String bankAccountNum, String recipientId) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    print("auth_tocken....${p.getString('auth_Token')}");
    print("country_isoCode3....${p.getString("country_isoCode3")}");
    print(
        "country_Currency_isoCode3....${p.getString("country_Currency_isoCode3")}");

    var request = {};

    request['dstCurrencyIso3Code'] = "${p.getString("country_isoCode3")}";
    request['dstCountryIso3Code'] = "${p.getString("country_Currency_isoCode3")}";
    request['transferMethod'] = "BANK_ACCOUNT";
    request['senderId'] = "23cab527-e802-4e49-8cc1-78e5c5c8e8df";
    request['accountNumber'] = bankAccountNum;

    print("bankAccountNum>>>>>>>>>" + bankAccountNum.toString());
    print("recipientId>>>>>>" + recipientId.toString());

    print("request ${request}");
    print("UrlAddBank>>>>" + AllApiService.add_banAccount_fields.toString());
    var response = await http.post(
        Uri.parse("https://sandbox-api.readyremit.com/v1/recipients/ab16ab0c-1d0f-407d-8463-8b1f95e23b78/accounts"),
        // var response = await http.post(Uri.parse(AllApiService.add_banAccount_fields+recipientId+"/accounts"),

        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
        });
    print(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("bdjkdshjgh" + jsonResponse.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectDeliveryAddMethodScreen()));
    } else {
      Utility.showFlutterToast( "Failled");
    }
    return;
  }



  dropd(String name, BankAccountNumberFieldSetsModel model, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 16),
      // height: 55,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: MyColors.color_93B9EE.withOpacity(0.1),
        border: Border.all(color: MyColors.color_gray_transparent),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child:Text(widget.bank_name,style: TextStyle(color: MyColors.blackColor,fontSize: 13,fontWeight: FontWeight.w600,fontFamily:"s_asset/font/raleway/raleway_bold.ttf"),)

      /*DropdownButtonHideUnderline(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: DropdownButton(
                isExpanded: true,
                value: selectedCategory,
                style: TextStyle(color: MyColors.blackColor),
                items: optionBanklist.map((BankAccountOptionsModel model) {
                  return new DropdownMenuItem<String>(
                      value: model.id.toString(),
                      child: new Text(model.name.toString()));
                }).toList(),
                hint: Text(
                  "${name}",
                  style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (value) {
                  model.fields![index].valueAcc = value.toString();

                  setState(() {
                    print(value);
                    selectedCategory = value.toString();
                    print("value $selectedCategory");
                  });

                  //  updateClassState();
                },
              ),
            );
          },
        ),
      ),*/
    );
  }

  addressstatedropd(
      String name, BankAccountNumberFieldSetsModel model, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: MyColors.color_93B9EE.withOpacity(0.1),
        border: Border.all(color: MyColors.color_gray_transparent),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: DropdownButtonHideUnderline(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: DropdownButton(
                isExpanded: true,
                value: selectedCategory2,
                style: TextStyle(color: MyColors.blackColor,fontSize: 13,fontWeight: FontWeight.w600,fontFamily:"s_asset/font/raleway/raleway_bold.ttf"),
                items: optionBanklist.map((BankAccountOptionsModel model) {
                  return new DropdownMenuItem<String>(
                      value: model.id.toString(),
                      child: new Text(model.name.toString()));
                }).toList(),
                hint: Text(
                  "${optionBanklist.length > 0 ? optionBanklist[0].name.toString() : ""}",
                  style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (value) {
                  setState(() {
                    model.fields![index].valueAcc = value.toString();
                    print(value);
                    selectedCategory2 = value.toString();
                    slect_bank_type = selectedCategory2.toString();
                    print("value $selectedCategory2");
                  });

                  //  updateClassState();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future <void> niumRoutingCodeTypesApi(BuildContext context,) async {

    Utility.ProgressloadingDialog(context, true);
    var request = {};

    SharedPreferences p = await SharedPreferences.getInstance();
    // request['client_id'] = "8i86nj3qmbW3rFWzZyVdpRudJ0XmxAaT";
    // request['client_secret'] = "gSMZhAdUG8azsEXSWgvwJzWqgG8uFeIW0aFxaVnOmb1TOY9KHvRvmwakazbY_EIY";
    // request['audience'] = "https://sandbox-api.readyremit.com";
    // request['grant_type'] = "client_credentials";




    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(Apiservices.niumRoutingCodeTypesapi+"?country_iso2="+p.getString("iso2").toString()),
        // body: convert.jsonEncode(request),
        headers: {

          "Content-Type": "application/json",
          "X-CLIENT": AllApiService.x_client,

        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    // getTokenResponse  = await GetTokenResponse.fromJson(jsonResponse);
    Utility.ProgressloadingDialog(context, false);
    for(var dataval in jsonResponse['data']){
      print("token_auhtToken>>>>>>>>"+dataval['routing_code_type'].toString());
      niumroutingcodetypeList.add(NiumRoutingCodeType(type: dataval['routing_code_type'].toString(),value: ""));
    }



    setState(() {

    });

    return;

  }

  Future <void> searchbanknamebyifscApi(BuildContext context,String country_code,String search_key,String search_value,String currency_code,String payout_method,String routing_code_type) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['country_code'] = country_code;
    request['search_key'] = search_key;
    request['search_key'] = search_key;
    request['search_value'] = search_value;
    request['currency_code'] = currency_code;
    request['payout_method'] = payout_method;
    request['routing_code_type'] = routing_code_type;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.searchbanknamebyifscapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    try{
      List<dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: jsonResponse['message']);
        jsonResponse.length>0?
        bankNameController.text = jsonResponse[0]["bank_name"].toString():
        Utility.showFlutterToast( "Invalid IFSC");;
        setState(() {

        });
      } else {
        Utility.showFlutterToast( "Invalid Search Value");


        setState(() {

        });
      }
    }catch(e){
      Utility.showFlutterToast( "Invalid Search Value");
    }
    Utility.ProgressloadingDialog(context, false);
    return;
  }



  Future<void> addRecipientBankAccountapi(BuildContext context,String account_number,String bank_acc_type,String bank_name) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['recipient_id'] = "${recipientId}";
    for(int i=0;i<niumroutingcodetypeList.length;i++){
      request['routing_code_type_${i+1}'] = niumroutingcodetypeList[i].type.toString();
      request['routing_code_value_${i+1}'] = niumroutingcodetypeList[i].value.toString();
    }
    request['account_number'] = account_number;
    request['bank_account_type'] = bank_acc_type;
    request['bank_name'] = bank_name;
    request['country_iso2'] = p.getString("iso2");

    print("request ${request}");
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Apiservices.addRecipientBankAccountapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN":"${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });
    print(response.body);
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    if (jsonResponse['status'] == true) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("bdjkdshjgh"+jsonResponse.toString());
      print("response.body>>>>"+response.body);

      /* String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();*/

      p.setString("BankdetailResponse", response.body);
      /* message == "" || message.isEmpty || message == ""? null:*/
      //  createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId);

      CustomLoader.ProgressloadingDialog(context, false);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScheduledSelectDeliveryAddMethodScreen()));


    } else {
      // List<dynamic> errorres = json.decode(response.body);
      // Fluttertoast.showToast(msg: errorres[0]["message"]);
      ischeck = false;
      Utility.showFlutterToast( jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
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
          boxShadow: [
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
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: MyColors.lightblueColor,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ))),
  );
}
