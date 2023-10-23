import 'package:http/http.dart' as http;
import 'package:moneytos/services/s_Api/S_ApiResponse/BankDetailResponse.dart';
import 'package:moneytos/services/s_Api/s_ModelClass/niumroutingcodetyperesponse.dart';
import 'package:moneytos/utils/import_helper.dart';

import 'dashselectdeliveryaddmethod.dart';

class EditBankAccountNumber extends StatefulWidget {
  final String bank_name;
  final String bank_id;
  final String recipient_account_id;
  final Function Oncallback;

  const EditBankAccountNumber({
    Key? key,
    this.bank_name = '',
    this.bank_id = '',
    this.recipient_account_id = '',
    required this.Oncallback,
  }) : super(key: key);

  @override
  State<EditBankAccountNumber> createState() => _EditBankAccountNumberState();
}

class _EditBankAccountNumberState extends State<EditBankAccountNumber> {
  ///Textfield contrller
  List<TextEditingController> _controllers = [];
  TextEditingController ibanController = TextEditingController();
  FocusNode ibanFocus = FocusNode();
  bool ischeck = false;
  String? selectedCategory;

  String? selectedCategory2;
  String slect_bank_type = '';

  String countryName = '';
  String countryFlag = '';
  String auhtToken = '';
  String sendMoney = '';
  String recipientId = '';

  String country_isoCode2 = '';
  String desticountry_isoCode3 = '';
  String destcountryCurrency_isoCode3 = '';
  String sourceCurrencyIso3Code = 'USD';

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
  String bankAccountNum = '';
  List<NiumRoutingCodeType> niumroutingcodetypeList = [];
  BankDetailResponse bankDetailResponse = BankDetailResponse();
  String ifsccodevalue = '';
  String ifsccodevalue2 = '';
  TextEditingController PakCodeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadPref();
    // getfieldAccount();

    setState(() {});
  }

  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    countryName = sharedPreferences.getString('country_Name').toString();
    countryFlag = sharedPreferences.getString('country_Flag').toString();
    auhtToken = sharedPreferences.getString('auth_Token').toString();
    country_isoCode2 = sharedPreferences.getString('iso2').toString();
    desticountry_isoCode3 =
        sharedPreferences.getString('country_isoCode3').toString();
    destcountryCurrency_isoCode3 =
        sharedPreferences.getString('country_Currency_isoCode3').toString();
    recipientId = sharedPreferences.getString('recpi_id').toString();

    debugPrint('countryName>>>$countryName');
    debugPrint('countryFlag>>>$countryFlag');
    debugPrint('recipientId>>>$recipientId');

    debugPrint('auhtToken_auhtToken>>>$auhtToken');
    debugPrint('country_isoCode3>>>$desticountry_isoCode3');
    debugPrint('countryCurrency_isoCode3>>>$destcountryCurrency_isoCode3');

    if (sharedPreferences.get('BankdetailResponse').toString() != 'null') {
      var response = sharedPreferences.get('BankdetailResponse').toString();
      Map<String, dynamic> jsonResponse = jsonDecode(response);

      debugPrint('jsonResponse>>>>  $jsonResponse');

      // if (jsonResponse['status'] == true) {
      // Utility.ProgressloadingDialog(context, false);
      bankDetailResponse = BankDetailResponse.fromJson(jsonResponse);
      // for(int i = 0 ; i<bankDetailResponse.data!.length;i++){
      //   if(bankDetailResponse.fields![i].id == "BANK_ACCOUNT_NUMBER"){
      //
      //     BankAccNumber = bankDetailResponse.fields![i].value.toString();
      //   }
      //
      //   if(bankDetailResponse.fields![i].id == "BANK_NAME"){
      //
      //     BankName = bankDetailResponse.fields![i].value.toString();
      //   }
      // }

      bankAccNumberController.text =
          bankDetailResponse.data!.accountNumber.toString();
      bankNameController.text = bankDetailResponse.data!.bankName.toString();
      PakCodeController.text =
          '${bankDetailResponse.data!.routingCodeValue1} - ${bankDetailResponse.data!.bankName}';
      accountTypeController.text =
          bankDetailResponse.data!.bankAccountType.toString();
      ifsccodevalue = bankDetailResponse.data!.routingCodeValue1.toString();
      ifsccodevalue2 = bankDetailResponse.data!.routingCodeValue2.toString();
      debugPrint('bank ifsccodevalue>>> ${bankNameController.text}');

      setState(() {
        // Future.delayed(Duration(seconds: 1), (){
        //   debugPrint("Executed after 5 seconds");
        //   WidgetsBinding.instance.addPostFrameCallback((_) => niumRoutingCodeTypesApi(context));
        // });
        niumRoutingCodeTypesApi(context);
      });
    } else {}

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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => BankAccountSiledApi(
        context,
        fieldsetlistAccount,
        bankAccModelList,
        optionBanklist,
      ),
    );

    setState(() {
      load = false;
    });
  }

  PakCodeUpdate(String pakCode, String pakName) {
    niumroutingcodetypeList.clear();
    debugPrint('pak code>>> $pakCode');
    debugPrint('pak name>>> $pakName');
    niumroutingcodetypeList
        .add(NiumRoutingCodeType(type: 'BANK CODE', value: pakCode));
    PakCodeController.text = '$pakCode-$pakName';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              MyString.bank_account_number,
              style: TextStyle(
                color: MyColors.blackColor,
                fontSize: 18,
                letterSpacing: 0.2,
                fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                // bankAccountNum = bankAccNumberController.text;
                // createAccfildList.clear();
                //
                // for (int i = 0; i < fieldsetlistAccount.length; i++) {
                //   for (int j = 0;
                //       j < fieldsetlistAccount[i].fields!.length;
                //       j++) {
                //     fieldsetlistAccount[i]
                //         .fields![j]
                //         .fieldId ==
                //         "BANK"? fieldsetlistAccount[i].fields![j].valueAcc = widget.bank_id : "";
                //
                //     fieldsetlistAccount[i]
                //         .fields![j]
                //         .fieldId ==
                //         "BANK_ACCOUNT_TYPE"? fieldsetlistAccount[i].fields![j].valueAcc = slect_bank_type.toString(): "";
                //
                //     setState((){});
                //
                //     if (fieldsetlistAccount[i].fields![j].valueAcc != null) {
                //       CreateAccFields addmodel = CreateAccFields(
                //           id: fieldsetlistAccount[i].fields![j].fieldId,
                //           type: fieldsetlistAccount[i].fields![j].fieldType,
                //           value: fieldsetlistAccount[i].fields![j].valueAcc);
                //       createAccfildList.add(addmodel);
                //       debugPrint("" + addmodel.value.toString());
                //       setState(() {});
                //     } else {}
                //   }
                // }
                // if (bankAccountNum.isEmpty) {
                //   Fluttertoast.showToast(
                //       msg: "Please Enter Bank Account Number");
                // } else {
                //   AddBankAccountfieldFieldRequest2(
                //       context, createAccfildList, bankAccountNum, recipientId);
                // }
                String accountNumber = bankAccNumberController.text;
                String accountType = accountTypeController.text;
                String bankName = bankNameController.text;

                for (var valdata in _controllers) {
                  debugPrint('val data>>> ${valdata.value}');
                  if (valdata.text.toString().isEmpty) {
                    Utility.showFlutterToast('Enter routing type');
                  } else if (valdata.text.toString().isEmpty) {
                    Utility.showFlutterToast('Enter routing value');
                  } else if (accountNumber.isEmpty) {
                    Utility.showFlutterToast('Enter account number');
                  } else if (accountType.isEmpty) {
                    Utility.showFlutterToast('Enter account type');
                  } else if (bankName.isEmpty) {
                    Utility.showFlutterToast('Enter bank name');
                  } else {
                    if (ischeck == false) {
                      editrecipientBankAccountapi(
                        context,
                        accountNumber,
                        accountType,
                        bankName,
                      );
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
              hSizedBox5,
              desticountry_isoCode3 == 'PAK'
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Utility().dialogAccountType(context, PakCodeUpdate);
                          },
                          child: Container(
                            width: double.infinity,
                            margin:
                                const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                            decoration: BoxDecoration(
                              color: MyColors.color_93B9EE.withOpacity(0.1),
                              border: Border.all(
                                color: MyColors.color_gray_transparent,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: TextFormField(
                              enabled: false,
                              controller: PakCodeController,
                              // routingValueController,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              textInputAction: TextInputAction.done,

                              style: const TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'assets/fonts/poppins_regular.ttf',
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    // fieldsetlistAccount[index]
                                    //     .fields![i]
                                    //     .placeholderText,
                                    'Select Bank Code',
                                hintStyle: TextStyle(
                                  color: MyColors.color_text.withOpacity(0.4),
                                  fontSize: 12,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                  fontWeight: FontWeight.w500,
                                ),

                                border: InputBorder.none,

                                // fillColor: MyColors.color_gray_transparent,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              // keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            String searchKey = 'BANK CODE';
                            String searchValue =
                                niumroutingcodetypeList[0].value!;
                            String payoutMethod = 'LOCAL';
                            searchbanknamebyifscApi(
                              context,
                              country_isoCode2,
                              searchKey,
                              searchValue,
                              destcountryCurrency_isoCode3,
                              payoutMethod,
                              searchKey,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 23, top: 10),
                            alignment: Alignment.centerRight,
                            child: const Text(
                              'Validate',
                              style: TextStyle(color: MyColors.lightblueColor),
                            ),
                          ),
                        ),
                        hSizedBox3,
                      ],
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // padding: const EdgeInsets.all(8),
                      itemCount: niumroutingcodetypeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.fromLTRB(
                                20.0,
                                0.0,
                                20.0,
                                0.0,
                              ),
                              decoration: BoxDecoration(
                                color: MyColors.color_93B9EE.withOpacity(0.1),
                                border: Border.all(
                                  color: MyColors.color_gray_transparent,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: TextFormField(
                                // controller:
                                // routingValueController,
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                ],
                                onChanged: (val) {
                                  niumroutingcodetypeList[index].value = val;
                                  setState(() {});
                                },
                                // inputFormatters: [
                                //   LengthLimitingTextInputFormatter(18),
                                // ],
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (val) {
                                  if (index == 0) {
                                    debugPrint('hvfh if>>>>  $val');
                                    String searchKey =
                                        niumroutingcodetypeList[index].type!;
                                    String searchValue = val;
                                    String payoutMethod = 'LOCAL';
                                    // searchbanknamebyifscApi(context, country_isoCode2, search_key, search_value, destcountryCurrency_isoCode3, payout_method, search_key);
                                  } else {
                                    debugPrint('hvfh else>>>>  ');
                                  }

                                  // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);

                                  //  addfieldlist.add(addmodel);
                                  //  debugPrint("json..${json.encode(addfieldlist)}");
                                  setState(() {});
                                },

                                style: const TextStyle(
                                  color: MyColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily:
                                      'assets/fonts/poppins_regular.ttf',
                                ),
                                decoration: InputDecoration(
                                  hintText:
                                      // fieldsetlistAccount[index]
                                      //     .fields![i]
                                      //     .placeholderText,
                                      'Enter ${niumroutingcodetypeList[index].type}',
                                  hintStyle: TextStyle(
                                    color: MyColors.color_text.withOpacity(0.4),
                                    fontSize: 12,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_medium.ttf',
                                    fontWeight: FontWeight.w500,
                                  ),

                                  border: InputBorder.none,

                                  // fillColor: MyColors.color_gray_transparent,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                // keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                              ),
                            ),
                            index == 0
                                ? InkWell(
                                    onTap: () {
                                      String searchKey =
                                          niumroutingcodetypeList[index].type!;
                                      String searchValue =
                                          niumroutingcodetypeList[index].value!;
                                      String payoutMethod = 'LOCAL';
                                      searchbanknamebyifscApi(
                                        context,
                                        country_isoCode2,
                                        searchKey,
                                        searchValue,
                                        destcountryCurrency_isoCode3,
                                        payoutMethod,
                                        searchKey,
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        right: 23,
                                        top: 10,
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: const Text(
                                        'Validate',
                                        style: TextStyle(
                                          color: MyColors.lightblueColor,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            hSizedBox3,
                          ],
                        );
                      },
                    ),
              hSizedBox3,
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                decoration: BoxDecoration(
                  color: MyColors.color_93B9EE.withOpacity(0.1),
                  border: Border.all(color: MyColors.color_gray_transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                ),
                child: TextFormField(
                  enabled: false,
                  controller: bankNameController,
                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(18),
                  // ],
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    debugPrint('hvfh');
                    // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);

                    //  addfieldlist.add(addmodel);
                    //  debugPrint("json..${json.encode(addfieldlist)}");
                    setState(() {});
                  },

                  style: const TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'assets/fonts/poppins_regular.ttf',
                  ),
                  decoration: InputDecoration(
                    hintText:
                        // fieldsetlistAccount[index]
                        //     .fields![i]
                        //     .placeholderText,
                        'Bank Name',
                    hintStyle: TextStyle(
                      color: MyColors.color_text.withOpacity(0.4),
                      fontSize: 12,
                      fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      fontWeight: FontWeight.w500,
                    ),

                    border: InputBorder.none,

                    // fillColor: MyColors.color_gray_transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  // keyboardType: TextInputType.numberWithOptions(signed: true,decimal: false),
                ),
              ),
              hSizedBox3,
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                decoration: BoxDecoration(
                  color: MyColors.color_93B9EE.withOpacity(0.1),
                  border: Border.all(color: MyColors.color_gray_transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                ),
                child: TextFormField(
                  controller: bankAccNumberController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(18),
                  ],
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    debugPrint('hvfh');
                    // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);

                    //  addfieldlist.add(addmodel);
                    //  debugPrint("json..${json.encode(addfieldlist)}");
                    setState(() {});
                  },
                  style: const TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'assets/fonts/poppins_regular.ttf',
                  ),
                  decoration: InputDecoration(
                    hintText:
                        // fieldsetlistAccount[index]
                        //     .fields![i]
                        //     .placeholderText,
                        'Account Number',
                    hintStyle: TextStyle(
                      color: MyColors.color_text.withOpacity(0.4),
                      fontSize: 12,
                      fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      fontWeight: FontWeight.w500,
                    ),

                    border: InputBorder.none,

                    // fillColor: MyColors.color_gray_transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: false,
                  ),
                ),
              ),
              hSizedBox3,
              InkWell(
                onTap: () {
                  dialogAccountType(context);
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  decoration: BoxDecoration(
                    color: MyColors.color_93B9EE.withOpacity(0.1),
                    border: Border.all(color: MyColors.color_gray_transparent),
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: TextFormField(
                    enabled: false,
                    controller: accountTypeController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                    ],
                    textInputAction: TextInputAction.next,
                    onTap: () {
                      debugPrint('hvfh');
                      // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);

                      //  addfieldlist.add(addmodel);
                      //  debugPrint("json..${json.encode(addfieldlist)}");
                      setState(() {});
                    },
                    style: const TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'assets/fonts/poppins_regular.ttf',
                    ),
                    decoration: InputDecoration(
                      hintText:
                          // fieldsetlistAccount[index]
                          //     .fields![i]
                          //     .placeholderText,
                          'Bank Account Type',
                      hintStyle: TextStyle(
                        color: MyColors.color_text.withOpacity(0.4),
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        fontWeight: FontWeight.w500,
                      ),

                      border: InputBorder.none,

                      // fillColor: MyColors.color_gray_transparent,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: false,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              )

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
    List<String> listtype = ['Checking', 'Saving'];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Bank Account Type',
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listtype.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              accountTypeController.text = listtype[index];
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.radio_button_off_sharp,
                                  color: MyColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: Text(listtype[index])),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
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
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: ibanFocus,
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
          hintText: MyString.iban_code,
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
        padding: const EdgeInsets.only(left: 10, right: 10),
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
              MyColors.color_3F84E5.withOpacity(0.88),
              MyColors.color_3F84E5,
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
              color: MyColors.whiteColor,
              fontSize: 17,
              fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
            ),
          ),
        ),
      ),
    );
  }

  Future<void> BankAccountSiledApi(
    BuildContext context,
    List<BankAccountNumberFieldSetsModel> fieldsetlistAccount,
    List<BankAccountsfieldModel> bankAccModelList,
    List<BankAccountOptionsModel> optionBanklist,
  ) async {
    Utility.ProgressloadingDialog(context, true);

    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    debugPrint("auth_tocken....${p.getString('auth_Token')}");
    debugPrint("country_isoCode3....${p.getString("country_isoCode3")}");
    debugPrint(
      "country_Currency_isoCode3....${p.getString("country_Currency_isoCode3")}",
    );
    debugPrint(
      'url....'
      "https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT",
    );

    var request = {};

    debugPrint('request $request');
    var response = await http.get(
      Uri.parse(
        "${AllApiService.recipient_banAccount_fields}recipientType=PERSON&dstCountryIso3Code=${p.getString("country_isoCode3")}&dstCurrencyIso3Code=${p.getString("country_Currency_isoCode3")}&transferMethod=BANK_ACCOUNT",
      ),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
      },
    );
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());

    var dataresponse = jsonResponse['fieldSets'];
    debugPrint('dataresponse$dataresponse');
    if (dataresponse != null) {
      Utility.ProgressloadingDialog(context, false);
      setState(() {});

      dataresponse.forEach((element) {
        BankAccountNumberFieldSetsModel fieldstateModel =
            BankAccountNumberFieldSetsModel.fromJson(element);
        fieldsetlistAccount.add(fieldstateModel);
        debugPrint('fieldSetId${fieldsetlistAccount[0].fieldSetId}');
        var fieldresponse = element['fields'];
        debugPrint('fields.....$fieldresponse');

        if (fieldresponse != null) {
          fieldresponse.forEach((element) {
            BankAccountsfieldModel recipientfieldstateModel =
                BankAccountsfieldModel.fromJson(element);
            bankAccModelList.add(recipientfieldstateModel);
            debugPrint('recipientfieldsetlist${bankAccModelList[0].name}');

            debugPrint("element...${element['fieldType']}");

            // for(int i= 0; i < recipientfieldsetlist.length; i++ ){
            if (element['fieldType'] == 'DROPDOWN') {
              var optiondata = element['options'];
              debugPrint('options...$optiondata');

              if (optiondata != null) {
                optiondata.forEach((element) {
                  BankAccountOptionsModel optionmodel =
                      BankAccountOptionsModel.fromJson(element);
                  optionBanklist.add(optionmodel);
                  slect_bank_type = optionBanklist.isNotEmpty
                      ? optionBanklist[0].id.toString()
                      : '';
                  debugPrint('optionmodel $slect_bank_type');
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

  Future<void> searchbanknamebyifscApi(
    BuildContext context,
    String countryCode,
    String searchKey,
    String searchValue,
    String currencyCode,
    String payoutMethod,
    String routingCodeType,
  ) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['country_code'] = countryCode;
    request['search_key'] = searchKey;
    request['search_key'] = searchKey;
    request['search_value'] = searchValue;
    request['currency_code'] = currencyCode;
    request['payout_method'] = payoutMethod;
    request['routing_code_type'] = routingCodeType;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.searchbanknamebyifscapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    try {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(msg: jsonResponse['message']);
        jsonResponse.isNotEmpty
            ? bankNameController.text = jsonResponse[0]['bank_name'].toString()
            : Utility.showFlutterToast('Invalid IFSC');
        setState(() {});
      } else {
        Utility.showFlutterToast('Invalid Search Value');

        setState(() {});
      }
    } catch (e) {
      Utility.showFlutterToast('Invalid Search Value');
    }
    Utility.ProgressloadingDialog(context, false);
    return;
  }

  Future<void> editrecipientBankAccountapi(
    BuildContext context,
    String accountNumber,
    String bankAccType,
    String bankName,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['account_id'] = widget.recipient_account_id;
    request['recipient_id'] = recipientId;
    for (int i = 0; i < niumroutingcodetypeList.length; i++) {
      request['routing_code_type_${i + 1}'] =
          niumroutingcodetypeList[i].type.toString();
      request['routing_code_value_${i + 1}'] =
          niumroutingcodetypeList[i].value.toString();
    }
    request['account_number'] = accountNumber;
    request['bank_account_type'] = bankAccType;
    request['bank_name'] = bankName;

    debugPrint('request $request');
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.post(
      Uri.parse(Apiservices.editrecipientBankAccountapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    debugPrint(response.body);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == true) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('bdjkdshjgh$jsonResponse');
      debugPrint('response.body>>>>${response.body}');

      /* String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();*/

      p.setString('BankdetailResponse', response.body);
      /* message == "" || message.isEmpty || message == ""? null:*/
      //  createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId);

      CustomLoader.ProgressloadingDialog(context, false);
      widget.Oncallback();
      Navigator.pop(context);
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      // Fluttertoast.showToast(msg: errorres[0]["message"]);
      CustomLoader.ProgressloadingDialog(context, false);
    }
    setState(() {});
    return;
  }

  Future<void> AddBankAccountfieldFieldRequest2(
    BuildContext context,
    var createAccfildList,
    String bankAccountNum,
    String recipientId,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['dstCountryIso3Code'] = "${p.getString("country_isoCode3")}";
    request['dstCurrencyIso3Code'] =
        "${p.getString("country_Currency_isoCode3")}";
    request['transferMethod'] = 'BANK_ACCOUNT';
    request['senderId'] = '23cab527-e802-4e49-8cc1-78e5c5c8e8df';
    request['fields'] = createAccfildList;

    debugPrint('request $request');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.put(
      Uri.parse(
        '${Apiservices.accountDetailapi}$recipientId/accounts/${widget.recipient_account_id}',
      ),
      body: jsonEncode(request),
      headers: {
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('bdjkdshjgh$jsonResponse');

      /* String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();*/

      p.setString('BankdetailResponse', response.body);
      /* message == "" || message.isEmpty || message == ""? null:*/
      //  createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId);

      CustomLoader.ProgressloadingDialog(context, false);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => DashSelectDeliveryAddMethodScreen()));
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      //     DashboardScreen(currentpage_index:2)), (Route<dynamic> route) => false);

      widget.Oncallback();
      Navigator.pop(context);
    } else {
      List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast(errorres[0]['message']);
      CustomLoader.ProgressloadingDialog(context, false);
    }
    setState(() {});
    return;
  }

  Future<void> addBankAccFiledField(
    BuildContext context,
    var createAccfildList,
    String bankAccountNum,
    String recipientId,
  ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    debugPrint("auth_tocken....${p.getString('auth_Token')}");
    debugPrint("country_isoCode3....${p.getString("country_isoCode3")}");
    debugPrint(
      "country_Currency_isoCode3....${p.getString("country_Currency_isoCode3")}",
    );

    var request = {};

    request['dstCurrencyIso3Code'] = "${p.getString("country_isoCode3")}";
    request['dstCountryIso3Code'] =
        "${p.getString("country_Currency_isoCode3")}";
    request['transferMethod'] = 'BANK_ACCOUNT';
    request['senderId'] = '23cab527-e802-4e49-8cc1-78e5c5c8e8df';
    request['accountNumber'] = bankAccountNum;

    debugPrint('bankAccountNum>>>>>>>>>$bankAccountNum');
    debugPrint('recipientId>>>>>>$recipientId');

    debugPrint('request $request');
    debugPrint('UrlAddBank>>>>${AllApiService.add_banAccount_fields}');
    var response = await http.post(
      Uri.parse(
        'https://sandbox-api.readyremit.com/v1/recipients/ab16ab0c-1d0f-407d-8463-8b1f95e23b78/accounts',
      ),
      // var response = await http.post(Uri.parse(AllApiService.add_banAccount_fields+recipientId+"/accounts"),

      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
      },
    );
    debugPrint(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('bdjkdshjgh$jsonResponse');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashSelectDeliveryAddMethodScreen(),
        ),
      );
    } else {
      Utility.showFlutterToast('Failled');
    }
    return;
  }

  dropd(String name, BankAccountNumberFieldSetsModel model, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      // height: 55,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: MyColors.color_93B9EE.withOpacity(0.1),
        border: Border.all(color: MyColors.color_gray_transparent),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Text(
        widget.bank_name,
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
        ),
      ),

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
                    debugPrint(value);
                    selectedCategory = value.toString();
                    debugPrint("value $selectedCategory");
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
    String name,
    BankAccountNumberFieldSetsModel model,
    int index,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: MyColors.color_93B9EE.withOpacity(0.1),
        border: Border.all(color: MyColors.color_gray_transparent),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      ),
      child: DropdownButtonHideUnderline(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: DropdownButton(
                isExpanded: true,
                value: selectedCategory2,
                style: const TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                ),
                items: optionBanklist.map((BankAccountOptionsModel model) {
                  return DropdownMenuItem<String>(
                    value: model.id.toString(),
                    child: Text(model.name.toString()),
                  );
                }).toList(),
                hint: Text(
                  optionBanklist.isNotEmpty
                      ? optionBanklist[0].name.toString()
                      : '',
                  style: const TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    model.fields![index].valueAcc = value.toString();
                    debugPrint(value as String?);
                    selectedCategory2 = value.toString();
                    slect_bank_type = selectedCategory2.toString();
                    debugPrint('value $selectedCategory2');
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

  Future<void> niumRoutingCodeTypesApi(
    BuildContext context,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    var request = {};

    SharedPreferences p = await SharedPreferences.getInstance();
    // request['client_id'] = "8i86nj3qmbW3rFWzZyVdpRudJ0XmxAaT";
    // request['client_secret'] = "gSMZhAdUG8azsEXSWgvwJzWqgG8uFeIW0aFxaVnOmb1TOY9KHvRvmwakazbY_EIY";
    // request['audience'] = "https://sandbox-api.readyremit.com";
    // request['grant_type'] = "client_credentials";

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        "${Apiservices.niumRoutingCodeTypesapi}?country_iso2=${p.getString("iso2")}",
      ),
      // body: jsonEncode(request),
      headers: {
        'Content-Type': 'application/json',
        'X-CLIENT': AllApiService.x_client,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    // getTokenResponse  = await GetTokenResponse.fromJson(jsonResponse);
    // Utility.ProgressloadingDialog(context, false);
    for (int i = 0; i < jsonResponse['data'].length; i++) {
      debugPrint('token_auhtToken>>>>>>>>$i');
      _controllers.add(TextEditingController());
      if (i == 0) {
        _controllers[i].text = ifsccodevalue;
        niumroutingcodetypeList.add(
          NiumRoutingCodeType(
            type: jsonResponse['data'][i]['routing_code_type'].toString(),
            value: ifsccodevalue,
          ),
        );
      } else if (i == 1) {
        _controllers[i].text = ifsccodevalue2;
        niumroutingcodetypeList.add(
          NiumRoutingCodeType(
            type: jsonResponse['data'][i]['routing_code_type'].toString(),
            value: ifsccodevalue2,
          ),
        );
      }
    }

    setState(() {});

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
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}