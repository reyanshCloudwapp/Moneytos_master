import 'package:flutter/cupertino.dart';
import 'package:moneytos/screens/add_new_recipients_dashboard/recipient_detail_bank_accountNumber.dart';
import 'package:moneytos/screens/customScreens/CustomSelectCountryList.dart';
import 'package:moneytos/screens/home/s_home/sendmoneyquatationfromNewRecipient/sendmoneyquatationfromNewRecipient.dart';
import 'package:moneytos/screens/resonforsendingscreen/reasonforsendingscreen.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/BankDetailResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/BankListResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/SelectCountryListResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/SendMoneyQuatationNewRecipResponse.dart';
import 'package:moneytos/services/s_Api/s_utils/timer_change_notifier.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../model/RecipientFiealdModel.dart';
import '../../model/account_detailsModel.dart';
import '../../model/location_response.dart';
import '../../model/purpose_code_response.dart';
import '../select_location_screen/select_location_screen.dart';
import '../select_operator_screen/select_oprator_screen.dart';

List<AccountsDetailModel> accountdetaillist = [];
List<AccountDetailFieldsModel> accountdetailfieldsetlist = [];

List<AccountsDetailModel> accountdetaillist2 = [];
List<AccountDetailFieldsModel> accountdetailfieldsetlist2 = [];
SelectCountryListResponse selectCountryListResponse =
    SelectCountryListResponse();
List<SelectCountryList> selectCountryList = <SelectCountryList>[];

class NewSelectRecipientHomeDetailScreen extends StatefulWidget {
  final bool isMfs;

  const NewSelectRecipientHomeDetailScreen(this.isMfs, {super.key});

  @override
  State<NewSelectRecipientHomeDetailScreen> createState() =>
      _NewSelectRecipientHomeDetailScreenState();
}

class _NewSelectRecipientHomeDetailScreenState
    extends State<NewSelectRecipientHomeDetailScreen> {
  String recipient_firstname = '';
  String recipient_lastname = '';
  String img = '';
  String countryIso3Code = '';
  String phonecode = '';
  String phone_number = '';
  String currencyIso3Code = '';
  String countryEmoji = '';

  PurposeCodesResponse purposeCodesResponse = PurposeCodesResponse();

  ///Textfield contrller
  TextEditingController reasonController = TextEditingController();
  TextEditingController searchcountryController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  bool load = true;
  int cureentindex = 0;
  Color bordercolor = MyColors.whiteColor;
  String? recipientId;
  bool itemload = false;

  TextEditingController mobileNumberController = TextEditingController();

  TextEditingController toMoneyController = TextEditingController();
  TextEditingController fromMoneyController = TextEditingController();
  SendMoneyQuatationNewRecipResponse sendMoneyQuatationNewRecipResponse =
      SendMoneyQuatationNewRecipResponse();

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

  String is_country = 'select_bankdetail';
  String country_name = MyString.country_name;

  SharedPreferences? sharedPreferences;
  String receipent_id = '';
  String receipent_account_id = '';
  String bankName = '', account_type = '', account_number = '';
  String delivery_method = '';
  String document_status = '';
  int transfer_fees = 0;
  double moneytos = 0;
  double send_moneytos = 0;
  String Is_transaction_fees_free = '0';
  double transaction_fees_free_amount_limit = 0;
  int min_limit = 0;
  int max_limit = 0;
  String moneytos_fees_type = '';
  List<Locationdata> locationList = [];
  BankListResponse bankListResponse = BankListResponse();

  Future<void> loadPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences!.setString("country_Name", widget.country_name);
    // sharedPreferences!.setString("country_Flag", widget.countryEmoji);
    // sharedPreferences!.setString("iso3", widget.countryIso3Code);
    // sharedPreferences!.setString("country_isoCode3", widget.countryIso3Code);
    // sharedPreferences!
    //     .setString("country_Currency_isoCode3", widget.currencyIso3Code);
    // sharedPreferences!.setString("phonecode", widget.phonecode);
    // sharedPreferences!.setString("recipientId", widget.recipientId);
    // sharedPreferences!
    //     .setString("senderId", "23cab527-e802-4e49-8cc1-78e5c5c8e8df");
    // sharedPreferences!.setString("firstName", widget.recipient_firstname);
    // sharedPreferences!.setString("lastname", widget.recipient_lastname);
    // sharedPreferences!.setString("u_first_name", widget.recipient_firstname);
    // sharedPreferences!.setString("u_last_name", widget.recipient_lastname);
    // sharedPreferences!.setString("u_phone_number", widget.phone_number);
    // sharedPreferences!.setString("u_profile_img", widget.img);
    countryName = sharedPreferences!.getString('country_Name').toString();
    countryFlag = sharedPreferences!.getString('country_Flag').toString();
    auhtToken = sharedPreferences!.getString('auth_Token').toString();
    desticountry_isoCode3 =
        sharedPreferences!.getString('country_isoCode3').toString();
    destcountryCurrency_isoCode3 =
        sharedPreferences!.getString('country_Currency_isoCode3').toString();
    receipent_id = sharedPreferences!.getString('recipientId').toString();
    recipient_firstname = sharedPreferences!.getString('firstName').toString();
    recipient_lastname = sharedPreferences!.getString('lastname').toString();
    img = sharedPreferences!.getString('u_profile_img').toString();
    countryIso3Code = sharedPreferences!.getString('iso3').toString();
    phonecode = sharedPreferences!.getString('phonecode').toString();
    phone_number = sharedPreferences!.getString('u_phone_number').toString();
    country_name = sharedPreferences!.getString('country_Name').toString();
    recipientId = sharedPreferences!.getString('recipientId').toString();
    currencyIso3Code =
        sharedPreferences!.getString('country_Currency_isoCode3').toString();
    countryEmoji = sharedPreferences!.getString('country_Flag').toString();

    if ((desticountry_isoCode3 == 'NGA' &&
            sharedPreferences
                    ?.getString('select_payment_method_status')
                    .toString() ==
                'Bank') ||
        (desticountry_isoCode3 == 'SOM') ||
        (desticountry_isoCode3 == 'ETH')) {
      destcountryCurrency_isoCode3 = 'USD';
    } else if (desticountry_isoCode3 == 'NGA' &&
        sharedPreferences
                ?.getString('select_payment_method_status')
                .toString() ==
            'Mobile') {
      destcountryCurrency_isoCode3 = 'NGN';
    } else {}

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
    (sharedPreferences?.getString('partnerPaymentMethod').toString() ==
                'juba' &&
            sharedPreferences
                    ?.getString('select_payment_method_status')
                    .toString() ==
                'Cash')
        ? getLocationListApi(context)
        : null;
    defaultDataSet();

    // if(widget.isMfs){
    //   Update();
    // }
    Update();
    setState(() {});
  }

  getaccountitemdetailApi(
    String recipentid,
    String receipentAccountId,
  ) async {
    accountdetailfieldsetlist2.clear();
    // setState((){
    //   itemload = true;
    // });
    // await AccountDetailsitemRequest(context, accountdetaillist2, accountdetailfieldsetlist2, recipentid,receipent_account_id);
    // setState((){
    //   itemload = false;
    //
    // });

    for (int i = 0; i < accountdetailfieldsetlist2.length; i++) {
      debugPrint(
        'accountdetailfieldsetlist2[i].id.toString()>>>> ${accountdetailfieldsetlist2[i].id}',
      );
      if (accountdetailfieldsetlist2[i].id.toString() == 'BANK_NAME') {
        bankName = accountdetailfieldsetlist2[i].value.toString();
      }
      if (accountdetailfieldsetlist2[i].id.toString() == 'BANK_ACCOUNT_TYPE') {
        account_type = accountdetailfieldsetlist2[i].value.toString();
      }
      if (accountdetailfieldsetlist2[i].id.toString() ==
          'BANK_ACCOUNT_NUMBER') {
        account_number = accountdetailfieldsetlist2[i].value.toString();
      }
    }
    setState(() {
      debugPrint(
        'accountdetaillist2>>> ${accountdetaillist2[0].dstCountryIso3Code}',
      );
    });
  }

  getaccountdetailApi() async {
    // accountdetaillist.clear();
    // accountdetailfieldsetlist.clear();

    // setState((){
    //   load = true;
    // });
    // String receipent_id = sharedPreferences!.getString("recipientId").toString();
    // await Webservices.AccountDetailsRequest(context,accountdetaillist,accountdetailfieldsetlist,"${receipent_id}");
    WidgetsBinding.instance
        .addPostFrameCallback((_) => recipientBankAccountsapi(context));
    // recipientBankAccountsapi(context);
    niumPurposeCodesApi(context);
    // recipientId =  accountdetaillist.length > 0 ? accountdetaillist[0].recipientAccountId.toString(): "";
    // receipent_account_id =  accountdetaillist.length > 0 ? accountdetaillist[0].recipientAccountId.toString(): "";
    // setState((){});
    // getaccountitemdetailApi(receipent_id,receipent_account_id);
    // setState((){
    //   load = false;
    // });
    debugPrint('dhghfgfj${accountdetailfieldsetlist.length}');
  }

  void Update() {
    is_country = 'select_bankdetail';
    getaccountdetailApi();
  }

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

    debugPrint('send_moneytos>>>  $send_moneytos');
    getPrefences();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => accountSettingApi(context));
    // getfieldrecipient();

    setState(() {});

    // //Country Api
    // is_country = 'country';
    // setState((){});
    // WidgetsBinding.instance.addPostFrameCallback((_) =>selectCountryListApi(context));
    //
    // setState(() {
    //
    // });
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

  Future<void> recipientBankAccountsapi(BuildContext context) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    load = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
    var request = {};
    request['recipient_id'] =
        sharedPreferences.getString('recpi_id').toString();

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      (widget.isMfs) ||
              sharedPreferences.getString('partnerPaymentMethod').toString() ==
                  'juba'
          ? Uri.parse(
              "${Apiservices.recipientBankAccountsapi}?recipient_id=${sharedPreferences.getString("recpi_id")}&delivery_method_type=${sharedPreferences.getString("select_payment_method_status")}",
            )
          : Uri.parse(
              "${Apiservices.recipientBankAccountsapi}?recipient_id=${sharedPreferences.getString("recpi_id")}",
            ),
      // body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    // CustomLoader.ProgressloadingDialog(context, false);

    if (jsonResponse['status'] == true) {
      bankListResponse = BankListResponse.fromJson(jsonResponse);
      load = false;
      setState(() {});
    } else {
      bankListResponse = BankListResponse.fromJson(jsonResponse);
      load = false;
      setState(() {});
    }
    return;
  }

  Future<void> AccountDetailsitemRequest(
    BuildContext context,
    List<AccountsDetailModel> accountdetaillist,
    List<AccountDetailFieldsModel> accountdetailfieldsetlist,
    String recipientid,
    String recipientAccountId,
  ) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    debugPrint('request $request');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.get(
      Uri.parse(
        'https://sandbox-api.readyremit.com/v1/recipients/$recipientid/accounts/$recipientAccountId',
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

    p.setString('BankdetailResponse', response.body);
    /* var dataresponse = jsonResponse['accounts'];
    debugPrint("iotem${dataresponse}");
    if(dataresponse != null) {
      dataresponse.forEach((element) {*/
    AccountsDetailModel accountModel =
        AccountsDetailModel.fromJson(jsonResponse);
    accountdetaillist.add(accountModel);
    delivery_method = accountModel.transferMethod.toString();
    debugPrint('account detail model>>> $delivery_method');

    var fieldresponse = jsonResponse['fields'];
    debugPrint('itemfields.....$fieldresponse');
    if (fieldresponse != null) {
      fieldresponse.forEach((element) {
        AccountDetailFieldsModel accountfieldstateModel =
            AccountDetailFieldsModel.fromJson(element);
        accountdetailfieldsetlist.add(accountfieldstateModel);

        debugPrint('element...${accountdetailfieldsetlist.length}');
      });
    }
    //  });

    else {
      //  CustomLoader.ProgressloadingDialog2(context, false);
    }

    return;
  }

  //add recipient
  String url =
      'https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&transferMethod=BANK_ACCOUNT';

  String slectedcountrCode = '+91';
  String? selectedCategory;
  String? selectedCategory2;
  List<FieldSetsModel> fieldsetlist = [];
  List<RecipientFieldsModel> recipientfieldsetlist = [];
  List<Options> optionlist = [];

  List<TextEditingController> _controllers1 = [];
  List<TextEditingController> _controllers2 = [];

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressline1Controller = TextEditingController();
  TextEditingController addressline2Controller = TextEditingController();
  TextEditingController addressline3Controller = TextEditingController();
  TextEditingController address_zip3Controller = TextEditingController();

  FocusNode firstFocusNode = FocusNode();
  FocusNode lastFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode address1FocusNode = FocusNode();
  FocusNode address2FocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode zipFocusNode = FocusNode();

  String img_error = '';

  XFile? _frontimage;
  String front_images = '';
  String? frontimg = '';

  SharedPreferences? p;

  getPrefences() async {
    p = await SharedPreferences.getInstance();
  }

  bool frontimageSelected = false;

  final ImagePicker imagePicker = ImagePicker();

  getfieldrecipient() async {
    fieldsetlist.clear();
    recipientfieldsetlist.clear();
    optionlist.clear();
    setState(() {
      load = true;
    });
    await Webservices.RecipientFieldRequest(
      context,
      fieldsetlist,
      recipientfieldsetlist,
      optionlist,
    );

    setState(() {
      load = false;
    });
  }

  List<TextEditingController> _controllers = [];

  frontDocumentbottoms(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('camera'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('gallery'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void compressImage(imageSource) async {
    var image =
        await imagePicker.getImage(source: imageSource, imageQuality: 10);
    if (image == null) {
      debugPrint('+++++++++null');
    } else {
      _frontimage = XFile(image.path);
      front_images = _frontimage!.path;
      frontimg = _frontimage!.path;
      setState(() {});

      debugPrint('image path is $frontimg');
    }
  }

  Future getfrontCameraImage(imageSource) async {
    var image =
        await imagePicker.getImage(source: imageSource, imageQuality: 5);
    if (mounted) {
      setState(() {
        frontimageSelected = true;

        if (image == null) {
          debugPrint('+++++++++null');
        } else {
          _frontimage = XFile(image.path);
          front_images = _frontimage!.path;
          frontimg = _frontimage!.path;
          setState(() {});
          debugPrint('image path is $frontimg');
        }
        //  Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstFocusNode.unfocus();
    lastFocusNode.unfocus();
    mobileFocusNode.unfocus();
    address1FocusNode.unfocus();
    address2FocusNode.unfocus();
    cityFocusNode.unfocus();
    zipFocusNode.unfocus();
  }

  List<AddRecipientFieldModel> addfieldlist = [];
  bool field_load = false;

  addRecipientField() async {
    // setState(() {
    //   field_load= true;
    // });
    AddRecipientFieldRequest(context, addfieldlist, frontimg.toString());
    // setState(() {
    //   field_load = false;
    // });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.color_03153B,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(265),
        child: AppBar(
          backgroundColor: MyColors.color_03153B,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, top: 65, right: 20),
            child: Column(
              children: [
                /// appbar ui....
                Container(
                  alignment: Alignment.centerLeft,
                  //  margin: EdgeInsets.only(left: 22),
                  // height: 25,
                  // width: 25,
                  margin: const EdgeInsets.only(top: 5),
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
                Column(
                  children: [
                    // hSizedBox2,
                    /// Profile image
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0.0, 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: MyColors.divider_color,
                              // .withOpacity(0.05),
                            ),
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FadeInImage(
                                height: 156,
                                width: 149,
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  img,
                                ),
                                placeholder: const AssetImage(
                                  'assets/logo/progress_image.png',
                                ),
                                placeholderFit: BoxFit.scaleDown,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      recipient_firstname
                                          .toString()[0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        color: MyColors.shedule_color,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_bold.ttf',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: (){
                        //     Navigator.pop(context);
                        //   },
                        //   child: Container(
                        //     height: 26,
                        //     width: 26,
                        //     decoration: BoxDecoration(
                        //         color: MyColors.accent_ED5565_red,
                        //         borderRadius: BorderRadius.all(Radius.circular(10)),
                        //         image: DecorationImage(
                        //             image: AssetImage("assets/images/closeimg.png")
                        //         )
                        //
                        //     ),
                        //     margin: EdgeInsets.fromLTRB(26, 0, 0.0, 10.0),
                        //
                        //   ),
                        // ),
                      ],
                    ),

                    /// recipent name

                    hSizedBox1,
                    Text(
                      '$recipient_firstname  $recipient_lastname',
                      // MyString.recipient_name,
                      style: const TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                      ),
                    ),
                    hSizedBox1,

                    Text(
                      '(+$phonecode) $phone_number',
                      style: TextStyle(
                        color: MyColors.whiteColor.withOpacity(0.50),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                    ),

                    hSizedBox1,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding:
                        //   EdgeInsets.only(top: 0.0, right: 1),
                        //   child: SvgPicture.asset(
                        //     "assets/icons/au_australia.svg",
                        //     height: 20,
                        //     width: 20,
                        //   ),
                        // ),
                        // wSizedBox,
                        Container(
                          margin: const EdgeInsets.fromLTRB(00, 0, 0, 0),
                          child: Text(
                            '$countryEmoji  $country_name',
                            style: const TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_semibold.ttf',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
        ),
      ),
      body: KeyboardActions(
        autoScroll: false,
        config: _buildKeyboardActionsConfig(context),
        child: Stack(
          children: [
            Container(
              color: MyColors.color_03153B,
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),

            /*  is_country == "" ?   Container(
              height: size.height,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              width: double.infinity,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(30),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0)),
                  color: MyColors.whiteColor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox1,


                    /// create listview....

                    hSizedBox2,
                    GestureDetector(
                      onTap: (){
                        is_country = 'country';
                        setState((){});
                        WidgetsBinding.instance.addPostFrameCallback((_) =>selectCountryListApi(context));

                        setState(() {

                        });
                      },
                      child: Container(
                          width:double.infinity,
                          height: 50,
                          // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                          padding: EdgeInsets.fromLTRB(16.0,0, 20.0, 0.0),
                          decoration: BoxDecoration(
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
                                  SvgPicture.asset("assets/images/flag2.svg",width: 26,height: 26,),
                                  wSizedBox1,
                                  Text(MyString.country_name,style: TextStyle(fontSize: 14,fontFamily: "assets/fonts/raleway/Raleway-Medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                                ],
                              ),
                              Container(
                                  width: 50,
                                  child: SvgPicture.asset("assets/icons/clear_red.svg")),
                            ],
                          )
                      ),
                    ),

                    hSizedBox2,
                    GestureDetector(
                      onTap: (){
                        is_country = 'city';
                        setState((){});
                      },
                      child: Container(
                          width:double.infinity,
                          height: 50,
                          // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                          padding: EdgeInsets.fromLTRB(16.0,0, 20.0, 0.0),
                          decoration: BoxDecoration(
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
                                  wSizedBox1,
                                  Text(MyString.city_name,style: TextStyle(fontSize: 14,fontFamily: "assets/fonts/raleway/Raleway-Medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                                ],
                              ),
                              Container(
                                  width: 50,
                                  child: SvgPicture.asset("assets/icons/clear_red.svg")),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ),
            )*/
            // :
            SingleChildScrollView(
              child: is_country == 'country'
                  ? countrybody()
                  : is_country == 'delivery_method'
                      ? countryDelevery_paymentMathod()
                      : is_country == 'add_recipient'
                          ? addrecipientInfobody()
                          : is_country == 'select_bankdetail'
                              ? SelectbankDetailBody()
                              : Container(
                                  height: size.height,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 0,
                                  ),
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    // borderRadius: BorderRadius.circular(30),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30.0),
                                    ),
                                    color: MyColors.whiteColor,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        hSizedBox1,

                                        /// create listview....

                                        hSizedBox2,
                                        GestureDetector(
                                          onTap: () {
                                            is_country = 'country';
                                            setState(() {});
                                            // WidgetsBinding.instance.addPostFrameCallback((_) =>selectCountryListApi(context));

                                            setState(() {});
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 50,
                                            // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                                            padding: const EdgeInsets.fromLTRB(
                                              16.0,
                                              0,
                                              20.0,
                                              0.0,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: MyColors.whiteColor,
                                              //border: Border.all(color: MyColors.color_gray_transparent),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      MyColors.color_linecolor,
                                                  offset: Offset(
                                                    0.0,
                                                    1.0,
                                                  ), //(x,y)
                                                  blurRadius: 2.0,
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/flag2.svg',
                                                      width: 26,
                                                      height: 26,
                                                    ),
                                                    wSizedBox1,
                                                    Text(
                                                      country_name,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'assets/fonts/raleway/raleway_medium.ttf',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            MyColors.color_text,
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
                                        ),

                                        hSizedBox6,
                                        hSizedBox6,
                                        hSizedBox6,
                                        hSizedBox6,
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          child: GestureDetector(
                                            onTap: () {
                                              is_country = 'delivery_method';
                                              setState(() {});
                                              /*sendMoney=fromMoneyController.text;

                          if(sendMoney.isEmpty){
                            Fluttertoast.showToast(msg: "Please Enter Send Amount");

                          }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRecipientInfoScreen()));
                          }

*/
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width / 4,
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 30,
                                                vertical: 40,
                                              ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    MyColors.lightblueColor
                                                        .withOpacity(0.90),
                                                    MyColors.lightblueColor,
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                border: Border.all(
                                                  color:
                                                      MyColors.lightblueColor,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      MyString.Next,
                                                      style: TextStyle(
                                                        color:
                                                            MyColors.whiteColor,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                        ),

                                        /*  hSizedBox2,
                    GestureDetector(
                      onTap: (){
                        is_country = 'city';
                        setState((){});
                      },
                      child: Container(
                          width:double.infinity,
                          height: 50,
                          // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                          padding: EdgeInsets.fromLTRB(16.0,0, 20.0, 0.0),
                          decoration: BoxDecoration(
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
                                  wSizedBox1,
                                  Text(MyString.city_name,style: TextStyle(fontSize: 14,fontFamily: "assets/fonts/raleway/Raleway-Medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                                ],
                              ),
                              Container(
                                  width: 50,
                                  child: SvgPicture.asset("assets/icons/clear_red.svg")),
                            ],
                          )
                      ),
                    ),*/
                                      ],
                                    ),
                                  ),
                                ),
            )
          ],
        ),
      ),
    );
  }

  countrybody() {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(30),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
        color: MyColors.whiteColor,
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  hSizedBox6,
                  hSizedBox3,
                  GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.50,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 0.5,
                    ),
                    children: List.generate(selectCountryList.length, (index) {
                      return GestureDetector(
                        onTap: () async {
                          country_name =
                              selectCountryList[index].name.toString();

                          // is_country = "";
                          is_country = 'delivery_method';
                          setState(() {});
                          // setState((){});

                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SendMoneyQuatationFromNewRecipient()));

                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                            'country_Name',
                            selectCountryList[index].name.toString(),
                          );
                          sharedPreferences.setString(
                            'country_Flag',
                            selectCountryList[index].emoji.toString(),
                          );
                          sharedPreferences.setString(
                            'iso3',
                            selectCountryList[index].iso3.toString(),
                          );
                          sharedPreferences.setString(
                            'iso2',
                            selectCountryList[index].iso2.toString(),
                          );
                          sharedPreferences.setString(
                            'country_isoCode3',
                            selectCountryList[index].iso3.toString(),
                          );
                          sharedPreferences.setString(
                            'country_Currency_isoCode3',
                            selectCountryList[index].currency.toString(),
                          );
                          sharedPreferences.setString(
                            'phonecode',
                            selectCountryList[index].phonecode.toString(),
                          );
                          sharedPreferences.setString(
                            'phonenumber_min_max_validation',
                            selectCountryList[index]
                                .phonumberMinMaxValidation
                                .toString(),
                          );

                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 5,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          child: CustomSelectCountryList(
                            title: selectCountryList[index].name.toString(),
                            img: selectCountryList[index].emoji.toString(),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  hSizedBox6,
                ],
              ),
            ),
          ),
          Container(
            // color: Colors.white,
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(30),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
              color: MyColors.whiteColor,
            ),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),

            //  padding:  EdgeInsets.symmetric(horizontal: 20.0),
            child: searchCountry(),
            //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
          ),
        ],
      ),
    );
  }

  countryDelevery_paymentMathod() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(30),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
        color: MyColors.whiteColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      /*  decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(30),
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),bottomLeft: Radius.circular(5)),
                color: MyColors.whiteColor),*/
      child: Column(
        children: [
          hSizedBox4,
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12.0, 26.0, 12.0, 0.0),
            padding: const EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 9.0),
            decoration: BoxDecoration(
              color: MyColors.color_D8E6FA_bac,
              border: Border.all(color: MyColors.color_gray_transparent),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: fromMoneyController,
                    // keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
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

                        // var multiply =
                        //     int.parse(fromMoneyController.text) * 100;
                        // setState(() {});
                        // debugPrint("multiply....${multiply}");
                        // sendMoney = multiply.toString();
                        // debugPrint("sendmoney.......£££${sendMoney}");

                        // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));
                        //default dataset
                        recieveAmt = double.parse(fixrateAmt) * sendAmt;

                        recAmountReciever = recieveAmt;
                        debugPrint(
                          'recAmountReciever>>>>>>>$recAmountReciever',
                        );

                        var amount = double.parse(recAmountReciever.toString());

                        toMoneyController.text = (amount).toStringAsFixed(2);

                        debugPrint('amount...${toMoneyController.text}');

                        exchangeRate = double.parse(fixrateAmt);
                        debugPrint('exchangeRate before>>>>$exchangeRate');
                        exchangeRate =
                            double.parse(exchangeRate.toStringAsFixed(2));
                        debugPrint('exchangeRate>>>>$exchangeRate');

                        totalCostFee = double.parse(fixrateAmt) * sendAmt;
                        debugPrint('totalCostFee>>>>>>$totalCostFee');
                        // totalCostFee2 = totalCostFee;
                        // totalCostFee2 = totalCostFee2 / 100;
                        totalCostFee2 = sendAmt + moneytos;

                        debugPrint('totalCostFee2>>>>>>$totalCostFee2');

                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString(
                          'totalCostFee',
                          totalCostFee2.toString(),
                        );
                        debugPrint('totalCostFee2>>>>>>>$totalCostFee2');

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
                        debugPrint('receiveAmount$recAmountReciever');
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
                          if (sendAmt >= transaction_fees_free_amount_limit) {
                            send_moneytos = 0;
                            sharedPreferences.setString('monyetosfee', '0');
                          } else {
                            send_moneytos = transfer_fees > 0
                                ? 0
                                : moneytos_fees_type == 'Percentage'
                                    ? double.parse(
                                        ((moneytos * sendAmt) / 100)
                                            .toStringAsFixed(2),
                                      )
                                    : moneytos;
                            sharedPreferences.setString(
                              'monyetosfee',
                              send_moneytos.toString(),
                            );
                          }
                        } else {
                          send_moneytos = transfer_fees > 0
                              ? 0
                              : moneytos_fees_type == 'Percentage'
                                  ? double.parse(
                                      ((moneytos * sendAmt) / 100)
                                          .toStringAsFixed(2),
                                    )
                                  : moneytos;
                          sharedPreferences.setString(
                            'monyetosfee',
                            send_moneytos.toString(),
                          );
                          debugPrint(
                            'send moneytos feess>>>  $moneytos_fees_type -- $send_moneytos -- $transfer_fees -- $sendAmt -- $moneytos',
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
                      // contentPadding: EdgeInsets.zero,
                      hintStyle: TextStyle(
                        fontSize: 25,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        fontWeight: FontWeight.w800,
                        color: MyColors.color_ffF4287_text.withOpacity(0.20),
                      ),
                    ),

                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily:
                          'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                      fontWeight: FontWeight.w700,
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
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
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
            padding: const EdgeInsets.fromLTRB(16.0, 9.0, 16.0, 9.0),
            decoration: BoxDecoration(
              color: MyColors.color_D8E6FA_bac,
              border: Border.all(color: MyColors.color_gray_transparent),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: toMoneyController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    focusNode: _toamountFocus,
                    maxLines: null,
                    // enabled: false,
                    onChanged: (String value) async {
                      if (value.isEmpty) {
                        fromMoneyController.text = '';
                      } else {
                        //default dataset
                        // recieveAmt = double.parse(value)/double.parse(fixrateAmt);

                        var amount =
                            double.parse(value) / double.parse(fixrateAmt);

                        fromMoneyController.text = (amount).toStringAsFixed(2);

                        debugPrint('amount...${toMoneyController.text}');

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
                        debugPrint('sendmoney.......£££$sendMoney');

                        // WidgetsBinding.instance.addPostFrameCallback((_) =>countryWiseExchangeRateApi(context,sendMoney,destcountryCurrency_isoCode3,desticountry_isoCode3,sourceCurrencyIso3Code));

                        exchangeRate = double.parse(fixrateAmt);
                        debugPrint('exchangeRate before>>>>$exchangeRate');
                        exchangeRate =
                            double.parse(exchangeRate.toStringAsFixed(2));
                        debugPrint('exchangeRate>>>>$exchangeRate');

                        totalCostFee = double.parse(fixrateAmt) * sendAmt;
                        debugPrint('totalCostFee>>>>>>$totalCostFee');
                        // totalCostFee2 = totalCostFee;
                        // totalCostFee2 = totalCostFee2 / 100;
                        totalCostFee2 = sendAmt + moneytos;

                        debugPrint('totalCostFee2>>>>>>$totalCostFee2');

                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString(
                          'totalCostFee',
                          totalCostFee2.toString(),
                        );
                        debugPrint('totalCostFee2>>>>>>>$totalCostFee2');

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
                        debugPrint('receiveAmount$recAmountReciever');
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
                          if (sendAmt >= transaction_fees_free_amount_limit) {
                            send_moneytos = 0;
                            sharedPreferences.setString('monyetosfee', '0');
                          } else {
                            send_moneytos = transfer_fees > 0
                                ? 0
                                : moneytos_fees_type == 'Percentage'
                                    ? double.parse(
                                        ((moneytos * sendAmt) / 100)
                                            .toStringAsFixed(2),
                                      )
                                    : moneytos;
                            sharedPreferences.setString(
                              'monyetosfee',
                              send_moneytos.toString(),
                            );
                          }
                        } else {
                          send_moneytos = transfer_fees > 0
                              ? 0
                              : moneytos_fees_type == 'Percentage'
                                  ? double.parse(
                                      ((moneytos * sendAmt) / 100)
                                          .toStringAsFixed(2),
                                    )
                                  : moneytos;
                          sharedPreferences.setString(
                            'monyetosfee',
                            send_moneytos.toString(),
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
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        fontWeight: FontWeight.w500,
                        color: MyColors.color_ffF4287_text,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily:
                          'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                      fontWeight: FontWeight.w700,
                      color: MyColors.blackColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    //  SvgPicture.asset("assets/images/flag2.svg"),

                    (desticountry_isoCode3 == 'NGA' &&
                                sharedPreferences
                                        ?.getString(
                                          'select_payment_method_status',
                                        )
                                        .toString() ==
                                    'Bank') ||
                            (desticountry_isoCode3 == 'SOM' ||
                                (desticountry_isoCode3 == 'ETH'))
                        ? Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: SvgPicture.asset('assets/images/flag1.svg'),
                          )
                        : CircledFlag(
                            flag: countryFlag,
                            radius: 9,
                          ),
                    Text(
                      (desticountry_isoCode3 == 'NGA' &&
                                  sharedPreferences
                                          ?.getString(
                                            'select_payment_method_status',
                                          )
                                          .toString() ==
                                      'Bank') ||
                              (desticountry_isoCode3 == 'SOM' ||
                                  (desticountry_isoCode3 == 'ETH'))
                          ? 'USD'
                          : destcountryCurrency_isoCode3,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
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
          // hSizedBox3,
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
                      fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
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
                      fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    (desticountry_isoCode3 == 'NGA' &&
                                sharedPreferences
                                        ?.getString(
                                          'select_payment_method_status',
                                        )
                                        .toString() ==
                                    'Bank') ||
                            (desticountry_isoCode3 == 'SOM' ||
                                (desticountry_isoCode3 == 'ETH'))
                        ? 'USD'
                        : destcountryCurrency_isoCode3,
                    style: const TextStyle(
                      color: MyColors.color_text,
                      fontSize: 9,
                      fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
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
                Flexible(
                  child: Text(
                    send_moneytos.toString(),
                    style: const TextStyle(
                      color: MyColors.color_text,
                      fontSize: 12,
                      fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                      fontWeight: FontWeight.w800,
                    ),
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
          hSizedBox,
          GestureDetector(
            onTap: () {
              sendMoney = fromMoneyController.text;
              CountdownTimerState(context);

              if (sendMoney.isEmpty) {
                Utility.showFlutterToast('Please Enter Send Amount');
              } else {
                if (double.parse(sendAmount) < min_limit) {
                  Utility.showFlutterToast(
                    'Please enter a minimum of \$$min_limit',
                  );
                } else if (double.parse(sendAmount) > max_limit) {
                  Utility.showFlutterToast(
                    'Maximum limit is \$$max_limit, please contact to raise your send limit',
                  );
                } else {
                  if (document_status == 'Approved') {
                    debugPrint('document status Approved>>>>>> ');

                    if (widget.isMfs ||
                        sharedPreferences
                                ?.getString('partnerPaymentMethod')
                                .toString() ==
                            'juba') {
                      is_country = 'select_bankdetail';
                      getaccountdetailApi();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ReasonforSendingScreen(
                            status: 'already_add',
                          ),
                        ),
                      );
                    }
                  } else {
                    debugPrint('document status Blank>>>>>> ');
                    if (double.parse(sendAmount) <= 200) {
                      is_country = 'select_bankdetail';
                      getaccountdetailApi();
                    } else {
                      Utility.showFlutterToast(
                        'Please verify your account first to transfer amount more than \$200',
                      );
                    }
                  }
                }

                setState(() {});
                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddRecipientInfoScreen()));
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MyColors.lightblueColor.withOpacity(0.90),
                    MyColors.lightblueColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: MyColors.lightblueColor, width: 1),
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
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
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
    );
  }

  Future<void> AddRecipientFieldRequest(
    BuildContext context,
    var field,
    String profileimg,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    request['UserType'] = 'PERSON';
    request['dstCountryIso3Code'] = "${p.getString("country_isoCode3")}";
    request['dstCurrencyIso3Code'] =
        "${p.getString("country_Currency_isoCode3")}";
    request['transferMethod'] = 'BANK_ACCOUNT';
    request['SenderId'] = '23cab527-e802-4e49-8cc1-78e5c5c8e8df';
    request['accountNumber'] = '333000333';
    request['fields'] = field;

    // otpo
    debugPrint('request $request');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.post(
      Uri.parse(Apiservices.addrecipientfield),
      body: jsonEncode(request),
      headers: {
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('bdjkdshjgh$jsonResponse');

      String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();
      String recipientId = jsonResponse['recipientId'].toString();
      String senderId = jsonResponse['senderId'].toString();
      debugPrint('recipientId...$recipientId');
      p.setString('recipientId', recipientId);
      p.setString('senderId', senderId);
      p.setString('firstName', firstname);
      p.setString('lastname', lastname);
      p.setString('lastname', lastname);
      debugPrint("recipientId22...${p.getString("recipientId")}");
      /* message == "" || message.isEmpty || message == ""? null:*/
      p.setString('recipientId', recipientId);
      CustomLoader.ProgressloadingDialog(context, false);

      is_country = 'select_bankdetail';

      setState(() {});
    } else {
      List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast(errorres[0]['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      setState(() {});
    }
    return;
  }

  addrecipientInfobody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(30),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
        color: MyColors.whiteColor,
      ),
      child: Column(
        children: [
          hSizedBox3,
          Container(
            margin: const EdgeInsets.only(
              top: 0.0,
              bottom: 30,
            ),
            alignment: Alignment.center,
            child: const Text(
              MyString.Add_Recipient_Info,
              style: TextStyle(
                color: MyColors.color_text,
                fontSize: 18,
                fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
          ),
          hSizedBox2,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: recipientfieldsetlist.length,
            itemBuilder: (context, int i) {
              _controllers.add(TextEditingController());
              if (recipientfieldsetlist[i].fieldId == 'FIRST_NAME') {
                _controllers[i].text = recipient_firstname;
                recipientfieldsetlist[i].value = recipient_firstname;
              }
              if (recipientfieldsetlist[i].fieldId == 'LAST_NAME') {
                _controllers[i].text = recipient_lastname;
                recipientfieldsetlist[i].value = recipient_lastname;
              }
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: MyColors.color_93B9EE.withOpacity(0.1),
                  border: Border.all(color: MyColors.color_gray_transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                ),
                child: TextFormField(
                  controller: _controllers[i],
                  // firstnameController,
                  enabled: recipientfieldsetlist[i].fieldId == 'ADDRESS_COUNTRY'
                      ? false
                      : true,
                  textInputAction: TextInputAction.next,
                  onTap: () {
                    debugPrint('hvfh');
                    // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:recipientfieldsetlist[i].fieldId.toString(),type:recipientfieldsetlist[i].fieldType.toString(),value :firstnameController.text);

                    //  addfieldlist.add(addmodel);

                    debugPrint('json..${json.encode(addfieldlist)}');
                    setState(() {});
                  },
                  onChanged: (String value) {
                    recipientfieldsetlist[i].value = value;

                    setState(() {});
                  },
                  onFieldSubmitted: (String value) {
                    AddRecipientFieldModel addmodel = AddRecipientFieldModel(
                      id: recipientfieldsetlist[i].fieldId.toString(),
                      type: recipientfieldsetlist[i].fieldType.toString(),
                      value: value,
                    );
                    addfieldlist.add(addmodel);
                    debugPrint('json..${json.encode(addfieldlist)}');
                  },
                  style: const TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'assets/fonts/poppins_regular.ttf',
                  ),
                  decoration: InputDecoration(
                    hintText:
                        recipientfieldsetlist[i].fieldId == 'ADDRESS_COUNTRY'
                            ? "${p!.getString("country_Name")}"
                            : recipientfieldsetlist[i].name,
                    hintStyle: TextStyle(
                      color:
                          recipientfieldsetlist[i].fieldId == 'ADDRESS_COUNTRY'
                              ? MyColors.blackColor
                              : MyColors.color_text.withOpacity(0.4),
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
                  keyboardType: TextInputType.text,
                ),
              );
            },
          ),
          hSizedBox6,
          GestureDetector(
            onTap: () {
              firstFocusNode.unfocus();
              lastFocusNode.unfocus();
              mobileFocusNode.unfocus();
              address1FocusNode.unfocus();
              address2FocusNode.unfocus();
              cityFocusNode.unfocus();
              zipFocusNode.unfocus();
              setState(() {});
              addfieldlist.clear();
              // for(int i = 0; i < fieldsetlist.length; i++){
              for (int j = 0; j < recipientfieldsetlist.length; j++) {
                recipientfieldsetlist[j].fieldId == 'ADDRESS_COUNTRY'
                    ? recipientfieldsetlist[j].value =
                        "${p!.getString("country_isoCode3")}"
                    : '';
                setState(() {});
                // if(fieldsetlist[i].fields![j].value != null){
                //   AddRecipientFieldModel addmodel =  AddRecipientFieldModel(id:fieldsetlist[i][j].fieldId ,type:fieldsetlist[i].fields![j].fieldType,value : fieldsetlist[i].fields![j].value);

                if (recipientfieldsetlist[j].value != null) {
                  AddRecipientFieldModel addmodel = AddRecipientFieldModel(
                    id: recipientfieldsetlist[j].fieldId,
                    type: recipientfieldsetlist[j].fieldType,
                    value: recipientfieldsetlist[j].value,
                  );

                  addfieldlist.add(addmodel);
                  debugPrint('${addmodel.value}');
                  setState(() {});
                } else {}
              }
              // }
              if (frontimg.toString().isEmpty ||
                  frontimg == '' ||
                  frontimg == null) {}

              // if(frontimg.toString().isEmpty || frontimg == "" || frontimg == null){
              //  img_error = "Required*";
              //  setState((){});
              // }
              // else{
              img_error = '';
              addRecipientField();
              debugPrint('json..${json.encode(addfieldlist)}');
              // addRecipientField();
              /* for(int k= 0; k < addfieldlist.length ; k++){
                      debugPrint("value2...${addfieldlist[k].value.toString()}");
                      if(addfieldlist[k].value != null || addfieldlist[k].value.toString().isNotEmpty || addfieldlist[k].value != ""){
                        debugPrint("value...${addfieldlist[k].value.toString()}");
                        addRecipientField();
                        Fluttertoast.showToast(msg: "Error");

                      }else{
                        debugPrint("error...${addfieldlist[k].value.toString()}");
                        Fluttertoast.showToast(msg: addfieldlist[k].value.toString());
                      }*/
              // }
              // }
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectDeliveryMethodScreen()));
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MyColors.lightblueColor.withOpacity(0.90),
                    MyColors.lightblueColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: MyColors.lightblueColor, width: 1),
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
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomText(String text) {
    return Container(
      //  height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.primaryColor.withOpacity(0.03),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 12,
          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> selectCountryListApi(
    BuildContext context,
  ) async {
    selectCountryList.clear();
    Utility.ProgressloadingDialog(context, true);
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(AllApiService.Countries_List_URL),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      selectCountryListResponse =
          SelectCountryListResponse.fromJson(jsonResponse);

      for (int i = 0; i < selectCountryListResponse.data!.length; i++) {
        selectCountryList.add(selectCountryListResponse.data![i]);
      }

      Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);

      selectCountryListResponse =
          SelectCountryListResponse.fromJson(jsonResponse);
      setState(() {});
    }

    return;
  }

  SelectbankDetailBody() {
    return load == true
        ? Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 700,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.circular(30),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      color: MyColors.whiteColor,
                    ),
                    child: Container(),
                  )
                ],
              ),
              Utility.shrimmerHorizontalListLoader(150, 220)
            ],
          )
        : Container(
            // height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(30),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
              ),
              color: MyColors.whiteColor,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 20,
                      ),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(30),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                        ),
                        color: MyColors.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          hSizedBox,

                          /// create listview....,

                          SizedBox(
                            height: 150,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  bankListResponse.status == true
                                      ? SizedBox(
                                          height: 150,
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                bankListResponse.data!.length,
                                            itemBuilder: (context, int index) {
                                              return SizedBox(
                                                height: 150,
                                                width: 220,
                                                child: Container(
                                                  // padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 5,
                                                    top: 5,
                                                    bottom: 5,
                                                  ),
                                                  child: Material(
                                                    elevation: 2,
                                                    color: MyColors.whiteColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8,
                                                      ),
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        cureentindex = index;
                                                        // bordercolor = MyColors.lightblueColor;
                                                        // recipientId = accountdetaillist[index].recipientAccountId.toString();
                                                        setState(() {});
                                                        //
                                                        // getaccountitemdetailApi(receipent_id,accountdetaillist[index].recipientAccountId.toString());
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 17,
                                                          vertical: 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: MyColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8,
                                                          ),
                                                          border: Border.all(
                                                            color: cureentindex == index
                                                                ? MyColors
                                                                    .lightblueColor
                                                                : MyColors
                                                                    .whiteColor,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 8,
                                                            vertical: 10,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: 100,
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      // accountdetaillist[index].fields![0].id.toString() == "BANK" ?

                                                                      '****${bankListResponse.data![index].accountNumber.toString().substring(bankListResponse.data![index].accountNumber.toString().length - 4)}',
                                                                      //: "",
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: cureentindex ==
                                                                                index
                                                                            ? MyColors.lightblueColor
                                                                            : MyColors.blackColor.withOpacity(0.80),
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            14,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        fontFamily:
                                                                            'assets/fonts/raleway/raleway_semibold.ttf',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  /*  status == true ?    Padding(
                  padding:  EdgeInsets.only(top: 0.0,right: 1),
                  child: SvgPicture.asset(icon,color: MyColors.blackColor,height: 20,width: 20,),
                ) : Container(),
                status == true ?   Padding(
                  padding:  EdgeInsets.only(top: 0.0,right: 1),
                  child: SvgPicture.asset("assets/icons/delete.svg",height: 20,width: 20,),
                ): Container(),
*/

                                                                  // InkWell(
                                                                  //     onTap:
                                                                  //         () {
                                                                  //       // pushNewScreen(
                                                                  //       //   context,
                                                                  //       //   screen: EditSelectBankScreen(onCallback: Update, recipient_account_id: bankListResponse.data![index].id.toString(),),
                                                                  //       //   withNavBar: false,
                                                                  //       // );
                                                                  //
                                                                  //       BankDetailResponse
                                                                  //       bankdetailreponse =
                                                                  //       new BankDetailResponse();
                                                                  //       bankdetailreponse.status =
                                                                  //       true;
                                                                  //       bankdetailreponse.message =
                                                                  //       "success";
                                                                  //       BankDetailData
                                                                  //       data =
                                                                  //       new BankDetailData();
                                                                  //       data.id = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .id;
                                                                  //       data.rid = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .rid;
                                                                  //       data.uid = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .uid;
                                                                  //       data.routingCodeType1 = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .routingCodeType1;
                                                                  //       data.routingCodeValue1 = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .routingCodeValue1;
                                                                  //       data.routingCodeType2 = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .routingCodeType2;
                                                                  //       data.routingCodeValue2 = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .routingCodeValue2;
                                                                  //       data.accountNumber = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .accountNumber;
                                                                  //       data.bankAccountType = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .bankAccountType;
                                                                  //       data.bankName = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .bankName;
                                                                  //       data.bankCode = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .bankCode;
                                                                  //       data.updatedAt = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .updatedAt;
                                                                  //       data.createdAt = bankListResponse
                                                                  //           .data![cureentindex]
                                                                  //           .createdAt;
                                                                  //       bankdetailreponse.data =
                                                                  //           data;
                                                                  //       debugPrint("object" +
                                                                  //           json.encode(bankdetailreponse));
                                                                  //       sharedPreferences!.setString(
                                                                  //           "BankdetailResponse",
                                                                  //           json.encode(bankdetailreponse));
                                                                  //       pushNewScreen(
                                                                  //         context,
                                                                  //         screen:
                                                                  //         EditBankAccountNumber(
                                                                  //           bank_name: bankListResponse.data![index].bankName.toString(),
                                                                  //           bank_id: bankListResponse.data![index].id.toString(),
                                                                  //           recipient_account_id: bankListResponse.data![index].id.toString(),
                                                                  //           Oncallback: Update,
                                                                  //         ),
                                                                  //         withNavBar:
                                                                  //         false,
                                                                  //       );
                                                                  //     },
                                                                  //     child: SvgPicture
                                                                  //         .asset(
                                                                  //       "assets/icons/edit.svg",
                                                                  //       color:
                                                                  //       MyColors.blackColor,
                                                                  //     )),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      // recipientId = accountdetaillist[index].recipientAccountId.toString();
                                                                      dialogDelete(
                                                                        context,
                                                                        receipent_id,
                                                                        bankListResponse
                                                                            .data![index]
                                                                            .id
                                                                            .toString(),
                                                                      );
                                                                      setState(
                                                                        () {},
                                                                      );
                                                                      // DeleteBankAccountApi(context,  widget.recipient_id.toString(), accountdetaillist[index].recipientAccountId.toString());
                                                                    },
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/icons/delete.svg',
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              hSizedBox2,
                                                              Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  //  accountdetaillist[index].fields![i].id.toString() == "BANK_ACCOUNT_NUMBER" ?
                                                                  bankListResponse
                                                                      .data![
                                                                          index]
                                                                      .bankAccountType
                                                                      .toString(),
                                                                  //: "",
                                                                  maxLines: 2,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: MyColors
                                                                        .blackColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        12,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontFamily:
                                                                        'assets/fonts/raleway/raleway_medium.ttf',
                                                                  ),
                                                                ),
                                                              ),
                                                              hSizedBox1,
                                                              hSizedBox,
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      top: 0.0,
                                                                      right: 1,
                                                                    ),
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      'assets/icons/bank.svg',
                                                                      height:
                                                                          20,
                                                                      width: 20,
                                                                      color: cureentindex ==
                                                                              index
                                                                          ? MyColors
                                                                              .lightblueColor
                                                                          : MyColors
                                                                              .blackColor,
                                                                    ),
                                                                  ),
                                                                  wSizedBox1,
                                                                  wSizedBox,
                                                                  Container(
                                                                    width: 120,
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      bankListResponse
                                                                              .data![
                                                                                  index]
                                                                              .bankName
                                                                              .toString()
                                                                              .isEmpty
                                                                          ? 'Mobile Deposit'
                                                                          : bankListResponse
                                                                              .data![index]
                                                                              .bankName
                                                                              .toString(),
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style:
                                                                          TextStyle(
                                                                        color: cureentindex ==
                                                                                index
                                                                            ? MyColors.lightblueColor
                                                                            : MyColors.blackColor.withOpacity(0.80),
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            12,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        fontFamily:
                                                                            'assets/fonts/raleway/raleway_medium.ttf',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Container(),
                                  (sharedPreferences
                                                      ?.getString(
                                                        'partnerPaymentMethod',
                                                      )
                                                      .toString() ==
                                                  'juba' &&
                                              sharedPreferences
                                                      ?.getString(
                                                        'select_payment_method_status',
                                                      )
                                                      .toString() ==
                                                  'Cash') &&
                                          locationList.isNotEmpty
                                      ? SizedBox(
                                          height: 150,
                                          width: 220,
                                          child: Container(
                                            // padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                            padding: const EdgeInsets.only(
                                              right: 5,
                                              top: 5,
                                              bottom: 5,
                                            ),
                                            child: Material(
                                              elevation: 2,
                                              color: MyColors.whiteColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  cureentindex = 0;
                                                  // bordercolor = MyColors.lightblueColor;
                                                  // recipientId = accountdetaillist[index].recipientAccountId.toString();
                                                  setState(() {});
                                                  //
                                                  // getaccountitemdetailApi(receipent_id,accountdetaillist[index].recipientAccountId.toString());
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 17,
                                                    vertical: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: MyColors.whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      8,
                                                    ),
                                                    border: Border.all(
                                                      color: cureentindex == 0
                                                          ? MyColors
                                                              .lightblueColor
                                                          : MyColors.whiteColor,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                      vertical: 10,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 100,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                // accountdetaillist[index].fields![0].id.toString() == "BANK" ?
                                                                locationList[
                                                                        cureentindex]
                                                                    .address
                                                                    .toString(),
                                                                //: "",
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  color: cureentindex ==
                                                                          0
                                                                      ? MyColors
                                                                          .lightblueColor
                                                                      : MyColors
                                                                          .blackColor
                                                                          .withOpacity(
                                                                          0.80,
                                                                        ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontFamily:
                                                                      'assets/fonts/raleway/raleway_semibold.ttf',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        hSizedBox2,
                                                        Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: const Text(
                                                            //  accountdetaillist[index].fields![i].id.toString() == "BANK_ACCOUNT_NUMBER" ?
                                                            '',
                                                            //: "",
                                                            maxLines: 2,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color: MyColors
                                                                  .blackColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontFamily:
                                                                  'assets/fonts/raleway/raleway_medium.ttf',
                                                            ),
                                                          ),
                                                        ),
                                                        hSizedBox1,
                                                        hSizedBox,
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 0.0,
                                                                right: 1,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/cashpickup.svg',
                                                                height: 20,
                                                                width: 20,
                                                                color: cureentindex ==
                                                                        0
                                                                    ? MyColors
                                                                        .lightblueColor
                                                                    : MyColors
                                                                        .blackColor,
                                                              ),
                                                            ),
                                                            wSizedBox1,
                                                            wSizedBox,
                                                            Container(
                                                              width: 120,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                'Cash',
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  color: cureentindex ==
                                                                          0
                                                                      ? MyColors
                                                                          .lightblueColor
                                                                      : MyColors
                                                                          .blackColor
                                                                          .withOpacity(
                                                                          0.80,
                                                                        ),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontFamily:
                                                                      'assets/fonts/raleway/raleway_medium.ttf',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () async {
                                            SharedPreferences
                                                sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            debugPrint('hbdhjbdf');
                                            pushNewScreen(
                                              context,
                                              screen: widget.isMfs ||
                                                      sharedPreferences
                                                              .getString(
                                                                'partnerPaymentMethod',
                                                              )
                                                              .toString() ==
                                                          'juba'
                                                  ? sharedPreferences.getString(
                                                            'select_payment_method_status',
                                                          ) ==
                                                          'Mobile'
                                                      ? SelectOperatorScreen(
                                                          moreAdd: true,
                                                          isAlreadyRecipient:
                                                              true,
                                                          Oncallback: Update,
                                                        )
                                                      : sharedPreferences
                                                                  .getString(
                                                                'select_payment_method_status',
                                                              ) ==
                                                              'Cash'
                                                          ? const SelectLocationScreen()
                                                          :
// SelectPaymentMethodScreen(isMfs: true,selectedMethodScreen: 0,)
// SelectDeliveryAddMethodScreen(ismfsAndalready: true,)

                                                          RecipientDetailBankAccountNumber(
                                                              Oncallback:
                                                                  Update,
                                                            )
                                                  : RecipientDetailBankAccountNumber(
                                                      Oncallback: Update,
                                                    ),
                                              // screen: RecipientDetailSelectBankScreen(onCallback: Update,),
                                              withNavBar: false,
                                            );
                                            // widget.oncallback()
                                            /* pushNewScreen(
                                  context,
                                  screen: SelectPaymentMethodScreen(selectedMethodScreen: 1,),
                                  withNavBar: false,
                                );*/
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 0,
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  MyColors.lightblueColor
                                                      .withOpacity(0.70),
                                                  MyColors.lightblueColor
                                                      .withOpacity(0.90),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: MyColors.lightblueColor,
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        MyColors.whiteColor,
                                                        MyColors.whiteColor
                                                      ],
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5,
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    CupertinoIcons.add,
                                                    color:
                                                        MyColors.lightblueColor,
                                                  ),
                                                ),
                                                hSizedBox2,
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    MyString.add_new_method,
                                                    style: TextStyle(
                                                      color:
                                                          MyColors.whiteColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'assets/fonts/raleway/raleway_bold.ttf',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),

                          bankListResponse.status == true
                              ? Column(
                                  children: [
                                    hSizedBox2,

                                    Container(
                                      margin: const EdgeInsets.only(left: 14),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: const Text(
                                              MyString.receive_methods,
                                              style: TextStyle(
                                                color: MyColors.color_text_a,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                fontFamily:
                                                    'assets/fonts/raleway/raleway_medium.ttf',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 12.0,
                                        left: 14,
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/bank.svg',
                                            height: 20,
                                            width: 20,
                                            color: MyColors.blackColor,
                                          ),
                                          wSizedBox1,
                                          Text(
                                            widget.isMfs ||
                                                    sharedPreferences
                                                            ?.getString(
                                                              'partnerPaymentMethod',
                                                            )
                                                            .toString() ==
                                                        'juba'
                                                ? sharedPreferences!
                                                    .getString(
                                                      'select_payment_method_status',
                                                    )
                                                    .toString()
                                                : 'Bank Account',
                                            // bankListResponse.status==true?bankListResponse.data![cureentindex].routingCodeType1.toString():"",
                                            // MyString.bank_deposite,
                                            style: const TextStyle(
                                              color: MyColors.color_text,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              fontFamily:
                                                  'assets/fonts/raleway/raleway_medium.ttf',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    hSizedBox2,
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 1,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      //accountdetailfieldsetlist2.length,
                                      itemBuilder: (context, int index) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 12.0,
                                                    left: 14,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        sharedPreferences!
                                                                    .getString(
                                                                      'select_payment_method_status',
                                                                    )
                                                                    .toString() ==
                                                                'Mobile'
                                                            ? 'Operator'
                                                            : 'Bank Name',
                                                        style: const TextStyle(
                                                          color: MyColors
                                                              .color_text_a,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'assets/fonts/raleway/raleway_medium.ttf',
                                                        ),
                                                      ),
                                                      hSizedBox1,
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/icons/bank4.svg',
                                                            height: 26,
                                                            width: 26,
                                                          ),
                                                          wSizedBox1,
                                                          SizedBox(
                                                            width: 160,
                                                            child: Text(
                                                              bankListResponse
                                                                          .status ==
                                                                      true
                                                                  ? sharedPreferences!
                                                                              .getString(
                                                                                'select_payment_method_status',
                                                                              )
                                                                              .toString() ==
                                                                          'Mobile'
                                                                      ? bankListResponse
                                                                          .data![
                                                                              cureentindex]
                                                                          .mobileOperator
                                                                          .toString()
                                                                      : bankListResponse
                                                                          .data![
                                                                              cureentindex]
                                                                          .bankName
                                                                          .toString()
                                                                  : '',
                                                              style:
                                                                  const TextStyle(
                                                                color: MyColors
                                                                    .color_text,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'assets/fonts/raleway/raleway_bold.ttf',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                sharedPreferences!
                                                            .getString(
                                                              'select_payment_method_status',
                                                            )
                                                            .toString() ==
                                                        'Mobile'
                                                    ? Container()
                                                    : Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                          top: 0.0,
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          right: 14,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'Account Type',
                                                              //  MyString.Swift_Code,
                                                              style: TextStyle(
                                                                color: MyColors
                                                                    .color_text_a,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'assets/fonts/raleway/raleway_medium.ttf',
                                                              ),
                                                            ),
                                                            hSizedBox1,
                                                            Text(
                                                              // accountdetaillist[index].fields![1].value.toString() == "p" ? "Saving": "Checking" ,
                                                              //  accountdetailfieldsetlist2[index].id.toString()=="BANK_ACCOUNT_TYPE"?accountdetailfieldsetlist2[index].value.toString():"",
                                                              bankListResponse
                                                                          .status ==
                                                                      true
                                                                  ? bankListResponse
                                                                      .data![
                                                                          cureentindex]
                                                                      .bankAccountType
                                                                      .toString()
                                                                  : '' == 'P'
                                                                      ? 'Saving'
                                                                      : 'Checking',
                                                              style:
                                                                  const TextStyle(
                                                                color: MyColors
                                                                    .color_text,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    'assets/fonts/raleway/raleway_semibold.ttf',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.only(
                                                top: 24.0,
                                                left: 14,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    sharedPreferences!
                                                                .getString(
                                                                  'select_payment_method_status',
                                                                )
                                                                .toString() ==
                                                            'Mobile'
                                                        ? 'Mobile Number'
                                                        : 'BANK ACCOUNT NUMBER',
                                                    // MyString.iban_code,
                                                    style: const TextStyle(
                                                      color:
                                                          MyColors.color_text_a,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'assets/fonts/raleway/raleway_medium.ttf',
                                                    ),
                                                  ),
                                                  hSizedBox1,

                                                  Text(
                                                    bankListResponse.status ==
                                                            true
                                                        ? '****${bankListResponse.data![cureentindex].accountNumber.toString().substring(bankListResponse.data![cureentindex].accountNumber.toString().length - 4)}'
                                                        : '',
                                                    style: const TextStyle(
                                                      color:
                                                          MyColors.color_text,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'assets/fonts/raleway/raleway_semibold.ttf',
                                                    ),
                                                  ),

                                                  // hSizedBox3,
                                                  // Container(
                                                  //   margin: EdgeInsets.only(left: 0),
                                                  //   alignment: Alignment.centerLeft,
                                                  //   child: Text(
                                                  //     MyString.Reason,
                                                  //     style: TextStyle(
                                                  //         color: MyColors.color_text_a,
                                                  //         fontWeight: FontWeight.w500,
                                                  //         fontSize: 12,
                                                  //         fontFamily:
                                                  //         "assets/fonts/raleway/Raleway-Medium.ttf"),
                                                  //   ),
                                                  // ),
                                                  // SizedBox(height: 12,),
                                                  // InkWell(
                                                  //   onTap: (){
                                                  //     dialogReason(context);
                                                  //   },
                                                  //   child: Container(
                                                  //     width: double.infinity,
                                                  //     margin: EdgeInsets.fromLTRB(
                                                  //         0.0, 0.0, 14.0, 0.0),
                                                  //     decoration: BoxDecoration(
                                                  //       color: MyColors.color_93B9EE
                                                  //           .withOpacity(0.1),
                                                  //       border: Border.all(
                                                  //           color: MyColors
                                                  //               .color_gray_transparent),
                                                  //       borderRadius: BorderRadius.all(
                                                  //           Radius.circular(12.0)),
                                                  //     ),
                                                  //     child: TextFormField(
                                                  //       enabled: false,
                                                  //       controller:
                                                  //       reasonController,
                                                  //       textInputAction:
                                                  //       TextInputAction.next,
                                                  //       onTap: () {
                                                  //         debugPrint("hvfh");
                                                  //         // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);
                                                  //
                                                  //         //  addfieldlist.add(addmodel);
                                                  //         //  debugPrint("json..${json.encode(addfieldlist)}");
                                                  //         setState(() {});
                                                  //       },
                                                  //
                                                  //       style: TextStyle(
                                                  //           color: MyColors.blackColor,
                                                  //           fontSize: 12,
                                                  //           fontWeight: FontWeight.w400,
                                                  //           fontFamily:
                                                  //           "assets/fonts/poppins_regular.ttf"),
                                                  //       decoration: InputDecoration(
                                                  //         hintText:
                                                  //         // fieldsetlistAccount[index]
                                                  //         //     .fields![i]
                                                  //         //     .placeholderText,
                                                  //         "Bank Account Type",
                                                  //         hintStyle: TextStyle(
                                                  //             color: MyColors.color_text
                                                  //                 .withOpacity(0.4),
                                                  //             fontSize: 12,
                                                  //             fontFamily:
                                                  //             "assets/fonts/raleway/Raleway-Medium.ttf",
                                                  //             fontWeight:
                                                  //             FontWeight.w500),
                                                  //
                                                  //         border: InputBorder.none,
                                                  //
                                                  //         // fillColor: MyColors.color_gray_transparent,
                                                  //         contentPadding:
                                                  //         EdgeInsets.symmetric(
                                                  //             horizontal: 16,
                                                  //             vertical: 12),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),

                                    // hSizedBox1,

                                    // SizedBox(height: 10,),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () async {
                                          SharedPreferences sharedPreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharedPreferences.setString(
                                            'recipientReceiveBankNameOrOperatorName',
                                            bankListResponse.data![cureentindex]
                                                    .mobileOperator
                                                    .toString()
                                                    .isEmpty
                                                ? bankListResponse
                                                    .data![cureentindex]
                                                    .bankName
                                                    .toString()
                                                : bankListResponse
                                                    .data![cureentindex]
                                                    .mobileOperator
                                                    .toString(),
                                          );
                                          BankDetailResponse bankdetailreponse =
                                              BankDetailResponse();
                                          bankdetailreponse.status = true;
                                          bankdetailreponse.message = 'success';
                                          BankDetailData data =
                                              BankDetailData();
                                          data.id = bankListResponse
                                              .data![cureentindex].id;
                                          data.rid = bankListResponse
                                              .data![cureentindex].rid;
                                          data.uid = bankListResponse
                                              .data![cureentindex].uid;
                                          data.routingCodeType1 =
                                              bankListResponse
                                                  .data![cureentindex]
                                                  .routingCodeType1;
                                          data.routingCodeValue1 =
                                              bankListResponse
                                                  .data![cureentindex]
                                                  .routingCodeValue1;
                                          data.routingCodeType2 =
                                              bankListResponse
                                                  .data![cureentindex]
                                                  .routingCodeType2;
                                          data.routingCodeValue2 =
                                              bankListResponse
                                                  .data![cureentindex]
                                                  .routingCodeValue2;
                                          data.accountNumber = bankListResponse
                                              .data![cureentindex]
                                              .accountNumber;
                                          data.bankAccountType =
                                              bankListResponse
                                                  .data![cureentindex]
                                                  .bankAccountType;
                                          data.bankName = bankListResponse
                                              .data![cureentindex].bankName;
                                          data.bankCode = bankListResponse
                                              .data![cureentindex].bankCode;
                                          data.updatedAt = bankListResponse
                                              .data![cureentindex].updatedAt;
                                          data.createdAt = bankListResponse
                                              .data![cureentindex].createdAt;
                                          bankdetailreponse.data = data;
                                          debugPrint(
                                            'object${json.encode(bankdetailreponse)}',
                                          );
                                          sharedPreferences.setString(
                                            'BankdetailResponse',
                                            json.encode(bankdetailreponse),
                                          );

                                          sharedPreferences.setString(
                                            'partnerPaymentMethod',
                                            bankListResponse.data![cureentindex]
                                                .partnerPaymentMethod
                                                .toString(),
                                          );
                                          sharedPreferences.setString(
                                            'select_payment_method_status',
                                            bankListResponse.data![cureentindex]
                                                .deliveryMethodType
                                                .toString(),
                                          );
                                          sharedPreferences.setString(
                                            'recipientReceiveBankNameOrOperatorName',
                                            bankListResponse.data![cureentindex]
                                                        .deliveryMethodType
                                                        .toString() ==
                                                    'Mobile'
                                                ? bankListResponse
                                                    .data![cureentindex]
                                                    .mobileOperator
                                                    .toString()
                                                : bankListResponse
                                                    .data![cureentindex]
                                                    .bankName
                                                    .toString(),
                                          );
                                          sharedPreferences.setString(
                                            'recipientReceiveBankOrMobileNo',
                                            bankListResponse.data![cureentindex]
                                                .accountNumber
                                                .toString(),
                                          );
                                          sharedPreferences.setString(
                                            'juba_NominatedCode',
                                            bankListResponse.data![cureentindex]
                                                .jubaNominatedCode
                                                .toString(),
                                          );

                                          widget.isMfs ||
                                                  sharedPreferences
                                                          .getString(
                                                            'partnerPaymentMethod',
                                                          )
                                                          .toString() ==
                                                      'juba'
                                              ? checkMethod(
                                                  context: context,
                                                  status: bankListResponse
                                                      .data![cureentindex]
                                                      .deliveryMethodType
                                                      .toString(),
                                                  isAlreadyRecipient: true,
                                                )
                                              : is_country = 'delivery_method';

                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 30,
                                            vertical: 40,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                MyColors.lightblueColor
                                                    .withOpacity(0.90),
                                                MyColors.lightblueColor,
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: MyColors.lightblueColor,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                    ),
                                  ],
                                )
                              : (sharedPreferences
                                              ?.getString(
                                                'partnerPaymentMethod',
                                              )
                                              .toString() ==
                                          'juba' &&
                                      sharedPreferences
                                              ?.getString(
                                                'select_payment_method_status',
                                              )
                                              .toString() ==
                                          'Cash')
                                  ? Column(
                                      children: [
                                        Column(
                                          children: [
                                            hSizedBox2,

                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 14,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: const Text(
                                                      MyString.receive_methods,
                                                      style: TextStyle(
                                                        color: MyColors
                                                            .color_text_a,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'assets/fonts/raleway/raleway_medium.ttf',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              margin: const EdgeInsets.only(
                                                top: 12.0,
                                                left: 14,
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/bank.svg',
                                                    height: 20,
                                                    width: 20,
                                                    color: MyColors.blackColor,
                                                  ),
                                                  wSizedBox1,
                                                  const Text(
                                                    'Cash',
                                                    // bankListResponse.status==true?bankListResponse.data![cureentindex].routingCodeType1.toString():"",
                                                    // MyString.bank_deposite,
                                                    style: TextStyle(
                                                      color:
                                                          MyColors.color_text,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'assets/fonts/raleway/raleway_medium.ttf',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            hSizedBox2,
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                        top: 12.0,
                                                        left: 14,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Operator',
                                                            style: TextStyle(
                                                              color: MyColors
                                                                  .color_text_a,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'assets/fonts/raleway/raleway_medium.ttf',
                                                            ),
                                                          ),
                                                          hSizedBox1,
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                'assets/icons/bank4.svg',
                                                                height: 26,
                                                                width: 26,
                                                              ),
                                                              wSizedBox1,
                                                              const SizedBox(
                                                                width: 160,
                                                                child: Text(
                                                                  'Juba Express',
                                                                  style:
                                                                      TextStyle(
                                                                    color: MyColors
                                                                        .color_text,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        'assets/fonts/raleway/raleway_bold.ttf',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            // hSizedBox1,

                                            // SizedBox(height: 10,),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2,
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 100,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      SharedPreferences
                                                          sharedPreferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      sharedPreferences
                                                          .setString(
                                                        'mfs_mobile_operator_name',
                                                        locationList[
                                                                cureentindex]
                                                            .address
                                                            .toString(),
                                                      );
                                                      sharedPreferences
                                                          .setString(
                                                        'recipientReceiveBankNameOrOperatorName',
                                                        locationList[
                                                                cureentindex]
                                                            .agentName
                                                            .toString(),
                                                      );
                                                      sharedPreferences
                                                          .setString(
                                                        'juba_NominatedCode',
                                                        locationList[
                                                                cureentindex]
                                                            .agentCode
                                                            .toString(),
                                                      );

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SendMoneyQuotationFromNewRecipient(),
                                                        ),
                                                      );

                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 50,
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.width /
                                                                4,
                                                      ),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 30,
                                                        vertical: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            MyColors
                                                                .lightblueColor
                                                                .withOpacity(
                                                              0.90,
                                                            ),
                                                            MyColors
                                                                .lightblueColor,
                                                          ],
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          14,
                                                        ),
                                                        border: Border.all(
                                                          color: MyColors
                                                              .lightblueColor,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Text(
                                                              MyString.Next,
                                                              style: TextStyle(
                                                                color: MyColors
                                                                    .whiteColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      color: Colors.white,
                                    ),
                        ],
                      ),
                    ),
                    hSizedBox4,
                  ],
                ),
                load == true || itemload == true
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white,
                        child: const Center(
                          child: GFLoader(
                            type: GFLoaderType.custom,
                            child: Image(
                              image: AssetImage(
                                'assets/logo/progress_image.png',
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          );
  }

  Future<void> checkMethod({
    required BuildContext context,
    required String status,
    required bool isAlreadyRecipient,
  }) async {
    // clearAllTransactionValue();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('select_payment_method_status', status);
    bool isMobileMoney = status == 'Mobile';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => (isAlreadyRecipient)
            ?
            // status == 'Mobile'?
            SendMoneyQuotationFromNewRecipient(
                isMobileMoney: isMobileMoney,
                isAlreadyRecipient: isAlreadyRecipient,
              )
            :
            // BankAccountNumber():
            SendMoneyQuotationFromNewRecipient(
                isMobileMoney: isMobileMoney,
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
    sharedPreferences.setString('BankdetailResponse', 'null').toString();
    // sharedPreferences.setString("exchangerate","").toString();
    // sharedPreferences.setString("fees","").toString();
    sharedPreferences.setString('reasonsending_id', '').toString();
    sharedPreferences.setString('reasonsending_name', '').toString();
    // sharedPreferences.setString("u_first_name","").toString();
    // sharedPreferences.setString("u_last_name","").toString();
    // sharedPreferences.setString("u_profile_img","").toString();
    // sharedPreferences.setString("receiveAmount","").toString();
    setState(() {});
  }

  dialogReason(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: purposeCodesResponse.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setString(
                                  'reasonsending_name',
                                  purposeCodesResponse
                                      .data![index].purposeCodeDescription
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'reasonsending_id',
                                  purposeCodesResponse.data![index].purposeCode
                                      .toString(),
                                );
                                reasonController.text = purposeCodesResponse
                                    .data![index].purposeCodeDescription
                                    .toString();
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.radio_button_off_sharp,
                                    color: MyColors.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${purposeCodesResponse.data![index].purposeCodeDescription}',
                                    ),
                                  ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> niumPurposeCodesApi(BuildContext context) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(Apiservices.niumPurposeCodesapi),
      headers: {
        'X-CLIENT': AllApiService.x_client,
        'content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == true) {
        purposeCodesResponse = PurposeCodesResponse.fromJson(jsonResponse);
      }
      setState(() {});
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      // Fluttertoast.showToast(msg: errorres[0]["message"]);
      //Fluttertoast.showToast(msg: "Minimum amount was not met for this transaction.");

      setState(() {});
    }
  }

  dialogDelete(
    BuildContext context,
    String recipientId,
    String recipientAccountId,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Are you sure, you want to Delete?',
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                      25.0,
                                      12.0,
                                      25.0,
                                      12.0,
                                    ),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColors.darkbtncolor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                // color: MyColors.darkbtncolor,
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_regular.ttf',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                      25.0,
                                      12.0,
                                      25.0,
                                      12.0,
                                    ),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColors.darkbtncolor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  // DeleteRequest(context, payment_method_id);
                                  DeleteBankAccountApi(
                                    context,
                                    recipientId,
                                    recipientAccountId,
                                  );

                                  setState(() {});
                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                // color: MyColors.darkbtncolor,
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_regular.ttf',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> DeleteBankAccountApi(
    BuildContext context,
    String recipientId,
    String recipientAccountId,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    // setState((){
    //   load = true;
    // });
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['recipient_id'] = p.getString('recpi_id').toString();
    request['account_id'] = recipientAccountId;
    debugPrint('request $request');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.post(
      Uri.parse(AllApiService.deleteRecipientBankAccountURL),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('bdjkdshjgh$jsonResponse');

      setState(() {});
      /* String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();*/

      p.setString('BankdetailResponse', response.body);
      /* message == "" || message.isEmpty || message == ""? null:*/
      //  createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId);

      Navigator.pop(context);
      CustomLoader.ProgressloadingDialog(context, false);
      getaccountdetailApi();
    } else {
      setState(() {});
      List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast(errorres[0]['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      getaccountdetailApi();
    }
    Update();
    setState(() {});
    return;
  }

  searchCountry() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: MyColors.blueColor.withOpacity(0.02),
        borderRadius: BorderRadius.circular(5),
      ),
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
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          hintText: MyString.select_country,
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.30),
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  void _searchCountryFilter(String enteredKeyword) {
    // selectCountryList.clear();
    List<SelectCountryList> results = <SelectCountryList>[];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = selectCountryList;
    } else {
      results = selectCountryList
          .where(
            (user) => user.name
                .toString()
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      selectCountryList = results;
    });
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
    debugPrint('authToken?>>>>>>Bearer  $auhtToken');
    https: //sandbox-api.readyremit.com/v1/Quote?dstCountryIso3Code=IND&dstCurrencyIso3Code=INR&srcCurrencyIso3Code=USD&transferMethod=BANK_ACCOUNT&quoteBy=SEND_AMOUNT&amount=5000

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // sendMoneyQuatationNewRecipResponse =
      // await SendMoneyQuatationNewRecipResponse.fromJson(jsonResponse);
      // fixrateAmt = jsonResponse['data']['fx_rate'].toString();

      // recieveAmt =
      //     double.parse(jsonResponse['data']['fx_rate'].toString()) * sendAmt;

      // toMoneyController.text = (amount).toString();

      debugPrint('amount...${toMoneyController.text}');

      if ((desticountryIsocode3 == 'NGA' &&
              p?.getString('select_payment_method_status').toString() ==
                  'Bank') ||
          (desticountryIsocode3 == 'SOM') ||
          (desticountryIsocode3 == 'ETH')) {
        exchangeRate = double.parse('1');
        recieveAmt = double.parse('1');
        fixrateAmt = '1';
      } else {
        exchangeRate = double.parse(jsonResponse['data']['fx_rate'].toString());
        fixrateAmt = jsonResponse['data']['fx_rate'].toString();
        recieveAmt =
            double.parse(jsonResponse['data']['fx_rate'].toString()) * sendAmt;
      }
      recAmountReciever = recieveAmt;
      debugPrint('recAmountReciever>>>>>>>$recAmountReciever');

      var amount = double.parse(recAmountReciever.toString());
      // exchangeRate = double.parse(jsonResponse['data']['fx_rate'].toString());
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
      loadPref();
      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast(jsonResponse['message']);
      //  Utility.ProgressloadingDialog(context, false);
      loadPref();
      setState(() {});
    }
    return;
  }

  Future<void> feesbuyapi(BuildContext context, String countryIso3) async {
    CustomLoader.ProgressloadingDialog(context, true);
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
        'Authorization': 'Bearer $auhtToken',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog6(context, false);
      // referlistResponse = await ReferlistResponse.fromJson(jsonResponse);

      debugPrint("money tos fees>>> ${jsonResponse['data']['monyetosfee']}");

      debugPrint(
        "Is_transaction_fees_free>>> ${jsonResponse['data']['Is_transaction_fees_free']}",
      );

      debugPrint(
        "transaction_fees_free_amount_limit>>> ${sharedPreferences.getString("select_payment_method_status")}",
      );

      moneytos_fees_type = sharedPreferences
                  .getString('select_payment_method_status')
                  .toString() ==
              'Mobile'
          ? jsonResponse['data']['mobile_moneytosfee_type'].toString()
          : sharedPreferences
                      .getString('select_payment_method_status')
                      .toString() ==
                  'Cash'
              ? jsonResponse['data']['cash_moneytosfee_type'].toString()
              : jsonResponse['data']['bank_moneytosfee_type'].toString();

      Is_transaction_fees_free = sharedPreferences
                  .getString('select_payment_method_status')
                  .toString() ==
              'Mobile'
          ? jsonResponse['data']['mobile_Is_transaction_fees_free'].toString()
          : sharedPreferences
                      .getString('select_payment_method_status')
                      .toString() ==
                  'Cash'
              ? jsonResponse['data']['cash_Is_transaction_fees_free'].toString()
              : jsonResponse['data']['Is_transaction_fees_free'].toString();

      transaction_fees_free_amount_limit = sharedPreferences
                  .getString('select_payment_method_status')
                  .toString() ==
              'Mobile'
          ? double.parse(
              jsonResponse['data']['mobile_transaction_fees_free_amount_limit']
                  .toString(),
            )
          : sharedPreferences
                      .getString('select_payment_method_status')
                      .toString() ==
                  'Cash'
              ? double.parse(
                  jsonResponse['data']
                          ['cash_transaction_fees_free_amount_limit']
                      .toString(),
                )
              : double.parse(
                  jsonResponse['data']['transaction_fees_free_amount_limit']
                      .toString(),
                );

      moneytos = sharedPreferences
                  .getString('select_payment_method_status')
                  .toString() ==
              'Mobile'
          ? double.parse(jsonResponse['data']['mobile_monyetosfee'].toString())
          : sharedPreferences
                      .getString('select_payment_method_status')
                      .toString() ==
                  'Cash'
              ? double.parse(
                  jsonResponse['data']['cash_monyetosfee'].toString(),
                )
              : double.parse(jsonResponse['data']['monyetosfee'].toString());

      send_moneytos = transfer_fees > 0 ? 0 : moneytos;
      sharedPreferences.setString('monyetosfee', send_moneytos.toString());
      // if(Is_transaction_fees_free == "1"){
      //   if(sendAmt >= transaction_fees_free_amount_limit){
      //     send_moneytos = 0;
      //     sharedPreferences.setString("monyetosfee", "0");
      //   }else{
      //     send_moneytos = transfer_fees>0?0:moneytos;
      //     sharedPreferences.setString("monyetosfee", send_moneytos.toString());
      //   }
      // }else{
      //   send_moneytos = transfer_fees>0?0:moneytos;
      //   sharedPreferences.setString("monyetosfee", send_moneytos.toString());
      // }

      setState(() {});
    } else {
      CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {});
    }
    return;
  }

  Future<void> getLocationListApi(
    BuildContext context,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    CustomLoader.ProgressloadingDialog6(context, true);

    load = true;
    setState(() {});
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var iso3 = sharedPreferences.getString('iso3');
    var request = {'country_iso2': iso3};
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        '${AllApiService.pickuplocationsbycountryiso3URL}?country_iso3=$iso3',
      ),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );
    CustomLoader.ProgressloadingDialog6(context, false);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      LocationResponse locationResponse =
          LocationResponse.fromJson(jsonResponse);
      locationList = locationResponse.data!.locationdata!;
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
    }
    load = false;
    setState(() {});
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

      // debugPrint("money tos fees>>> "+jsonResponse['data']['monyetosfee'].toString());
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
