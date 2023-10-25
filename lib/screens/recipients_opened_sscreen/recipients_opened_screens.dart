import 'package:flutter/cupertino.dart';
import 'package:moneytos/screens/add_new_recipients_dashboard/recipient_detail_bank_accountNumber.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/BankDetailResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/BankListResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/LatestTransferResponse.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../model/account_detailsModel.dart';
import '../home/s_home/sendmoneyquatationfromNewRecipient/sendmoneyquatationfromNewRecipient.dart';
import '../mfs_select_payment_method.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';

class RecipientsOpenedScreen extends StatefulWidget {
  final String recipient_id;
  final Recipientlist recipientlist;

  const RecipientsOpenedScreen({
    Key? key,
    required this.recipient_id,
    required this.recipientlist,
  }) : super(key: key);

  @override
  State<RecipientsOpenedScreen> createState() => _RecipientsOpenedScreenState();
}

class _RecipientsOpenedScreenState extends State<RecipientsOpenedScreen> {
  bool _enabled = true;
  bool _enabled1 = true;
  BankListResponse bankListResponse = BankListResponse();
  List<AccountsDetailModel> accountdetaillist = [];
  List<AccountDetailFieldsModel> accountdetailfieldsetlist = [];
  bool load = false;
  int cureentindex = 0;
  Color bordercolor = MyColors.whiteColor;
  String? recipientId;
  String doucument_status = '';
  bool state_verified = false;
  bool is_delete = false;
  LatestTransferResponse latestTransferResponse = LatestTransferResponse();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefData();
    getaccountdetailApi();
    latesttransferApi(context);
  }

  void Update() {
    debugPrint('cnkjdnjdn');
    getaccountdetailApi();
    latesttransferApi(context);
    setState(() {});
  }

  prefData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    doucument_status = sharedPreferences.getString('document_status')!;
    state_verified = sharedPreferences.getBool('state_verified')!;
    setState(() {});
  }

  Future<bool> _willPopCallback() async {
    // this.widget.Oncallback();
    Navigator.pop(context);
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    //     DashboardScreen(currentpage_index:2)), (Route<dynamic> route) => false);
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: MyColors.color_03153B,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(270),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.color_03153B,
            flexibleSpace: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 50, left: 20, right: 40),
              // margin: EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // Navigator.pop(context);
                      _willPopCallback();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/arrow_back.svg',
                      height: 32,
                      width: 32,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.topRight,
                      // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                      child: Column(
                        children: [
                          /// Profile image

                          hSizedBox1,

                          CircleAvatar(
                            backgroundColor: MyColors.divider_color,
                            radius: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FadeInImage(
                                height: 156,
                                width: 149,
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  widget.recipientlist.profileImage.toString(),
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
                                      widget.recipientlist.firstName
                                          .toString()[0]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        color: MyColors.shedule_color,
                                        fontSize: 18,
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

                          /// recipent name

                          hSizedBox1,
                          Container(
                            margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                            child: Text(
                              '${widget.recipientlist.firstName} ${widget.recipientlist.lastName}',
                              style: const TextStyle(
                                color: MyColors.whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_semibold.ttf',
                              ),
                            ),
                          ),
                          hSizedBox,

                          Container(
                            margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                            child: Text(
                              '(+${widget.recipientlist.phonecode}) ${widget.recipientlist.phoneNumber}',
                              style: TextStyle(
                                color: MyColors.whiteColor.withOpacity(0.50),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                              ),
                            ),
                          ),

                          hSizedBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding:
                              //   EdgeInsets.only(top: 4.0, right: 1),
                              //   child: SvgPicture.asset(
                              //     "assets/icons/au_australia.svg",
                              //     height: 20,
                              //     width: 20,
                              //   ),
                              // ),
                              wSizedBox,
                              Container(
                                margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                                child: Text(
                                  '${widget.recipientlist.countryEmoji}  ${widget.recipientlist.countryName}',
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
                    ),
                  ),
                  Container(
                      // child: GestureDetector(
                      //   behavior: HitTestBehavior.translucent,
                      //   onTap: () {
                      //     // pushNewScreen(
                      //     //   context,
                      //     //   screen: EditRecipientScreen(),
                      //     //   withNavBar: false,
                      //     // );
                      //     // Navigator.push(
                      //     //     context,
                      //     //     MaterialPageRoute(
                      //     //         builder: (_) => EditRecipientScreen()));
                      //   },
                      //   child: Container(
                      //     //width: 50,
                      //     alignment: Alignment.topRight,
                      //     child: SvgPicture.asset(
                      //         "assets/icons/edit_recipient.svg"),
                      //   ),
                      // ),
                      )
                ],
              ),
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.color_03153B,
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            /*  actions: [
              Container(
                padding: EdgeInsets.only(top: 5,right: 20),
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  "assets/icons/notification.svg",
                  height: 30,
                  width: 30,
                ),
              ),
            ],*/
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: MyColors.color_03153B,
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: MyColors.whiteColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hSizedBox3,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 14),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            MyString.receive_methods,
                            style: TextStyle(
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 14),
                          child: InkWell(
                            onTap: () async {
                              if (bankListResponse.status == true) {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                debugPrint(
                                  "widget.recipientlist.partnerPaymentMethod.toString()>>>>  ${sharedPreferences.getString("select_payment_method_status")}",
                                );

                                !state_verified
                                    ? Utility().stateDialog(context)
                                    : doucument_status == 'Approved'
                                        ? widget.recipientlist
                                                    .partnerPaymentMethod
                                                    .toString() ==
                                                'nium'
                                            ? pushNewScreen(
                                                context,
                                                screen:
                                                    const SendMoneyQuotationFromNewRecipient(
                                                  isMobileMoney: false,
                                                  isAlreadyRecipient: true,
                                                ),
                                                // NewSelectRecipientHomeDetailScreen(
                                                //
                                                //     widget.recipientlist.partnerPaymentMethod.toString() == 'mfs'
                                                //
                                                //
                                                // ),
                                                withNavBar: false,
                                              )
                                            : pushNewScreen(
                                                context,
                                                screen:
                                                    SendMoneyQuotationFromNewRecipient(
                                                  isMobileMoney:
                                                      sharedPreferences
                                                                  .getString(
                                                                    'select_payment_method_status',
                                                                  )
                                                                  .toString() ==
                                                              'Mobile'
                                                          ? true
                                                          : false,
                                                  isAlreadyRecipient: true,
                                                ),
                                                withNavBar: false,
                                              )

                                        // pushNewScreen(
                                        //         context,
                                        //         screen:
                                        //             NewSelectRecipientHomeDetailScreen(
                                        //                 widget.recipientlist.firstName
                                        //                     .toString(),
                                        //                 widget.recipientlist.lastName
                                        //                     .toString(),
                                        //                 widget.recipientlist.profileImage
                                        //                     .toString(),
                                        //                 widget
                                        //                     .recipientlist.countryIso3Code
                                        //                     .toString(),
                                        //                 widget.recipientlist.phonecode
                                        //                     .toString(),
                                        //                 widget.recipientlist.phoneNumber
                                        //                     .toString(),
                                        //                 widget.recipientlist.countryName
                                        //                     .toString(),
                                        //                 widget.recipientlist.recipientId
                                        //                     .toString(),
                                        //                 widget.recipientlist
                                        //                     .currencyIso3Code
                                        //                     .toString(),
                                        //                 widget.recipientlist.countryEmoji
                                        //                     .toString(),
                                        //               widget.recipientlist.partnerPaymentMethod.toString()=='mfs',
                                        //             ),
                                        //         withNavBar: false,
                                        //       )
                                        : verifyDialog(
                                            context,
                                            '',
                                            doucument_status,
                                          );

                                BankDetailResponse bankdetailreponse =
                                    BankDetailResponse();
                                bankdetailreponse.status = true;
                                bankdetailreponse.message = 'success';
                                BankDetailData data = BankDetailData();
                                data.id =
                                    bankListResponse.data![cureentindex].id;
                                data.rid =
                                    bankListResponse.data![cureentindex].rid;
                                data.uid =
                                    bankListResponse.data![cureentindex].uid;
                                data.routingCodeType1 = bankListResponse
                                    .data![cureentindex].routingCodeType1;
                                data.routingCodeValue1 = bankListResponse
                                    .data![cureentindex].routingCodeValue1;
                                data.routingCodeType2 = bankListResponse
                                    .data![cureentindex].routingCodeType2;
                                data.routingCodeValue2 = bankListResponse
                                    .data![cureentindex].routingCodeValue2;
                                data.accountNumber = bankListResponse
                                    .data![cureentindex].accountNumber;
                                data.bankAccountType = bankListResponse
                                    .data![cureentindex].bankAccountType;
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
                                  bankListResponse
                                      .data![cureentindex].partnerPaymentMethod
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'select_payment_method_status',
                                  bankListResponse
                                      .data![cureentindex].deliveryMethodType
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'recipientReceiveBankNameOrOperatorName',
                                  bankListResponse.data![cureentindex]
                                              .deliveryMethodType
                                              .toString() ==
                                          'Mobile'
                                      ? bankListResponse
                                          .data![cureentindex].mobileOperator
                                          .toString()
                                      : bankListResponse
                                          .data![cureentindex].bankName
                                          .toString(),
                                );
                                sharedPreferences.setString(
                                  'recipientReceiveBankOrMobileNo',
                                  bankListResponse
                                      .data![cureentindex].accountNumber
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'recpi_id',
                                  widget.recipientlist.id.toString(),
                                );
                                sharedPreferences.setString(
                                  'recpi_userId',
                                  widget.recipientlist.userId.toString(),
                                );
                                sharedPreferences.setString(
                                  'recipientId',
                                  widget.recipientlist.recipientId.toString(),
                                );
                                sharedPreferences.setString(
                                  'iso2',
                                  widget.recipientlist.countryIso2Code
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'currency',
                                  widget.recipientlist.currencyIso3Code
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'rec_address',
                                  widget.recipientlist.address.toString(),
                                );
                                sharedPreferences.setString(
                                  'rec_city',
                                  widget.recipientlist.city.toString(),
                                );
                                sharedPreferences.setString(
                                  'postcode',
                                  widget.recipientlist.postcode.toString(),
                                );
                                sharedPreferences.setString(
                                  'relationship',
                                  widget.recipientlist.relationship.toString(),
                                );
                                sharedPreferences.setString(
                                  'country_Name',
                                  widget.recipientlist.countryName.toString(),
                                );
                                sharedPreferences.setString(
                                  'country_Flag',
                                  widget.recipientlist.countryEmoji.toString(),
                                );
                                sharedPreferences.setString(
                                  'iso3',
                                  widget.recipientlist.countryIso3Code
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'iso2',
                                  widget.recipientlist.countryIso2Code
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'country_isoCode3',
                                  widget.recipientlist.countryIso3Code
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'country_Currency_isoCode3',
                                  widget.recipientlist.currencyIso3Code
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'phonecode',
                                  widget.recipientlist.phonecode.toString(),
                                );
                                sharedPreferences.setString(
                                  'phonenumber_min_max_validation',
                                  '',
                                );
                                sharedPreferences.setString(
                                  'currency',
                                  widget.recipientlist.currencyIso3Code
                                      .toString(),
                                );
                                sharedPreferences.setString(
                                  'recipientId',
                                  widget.recipientlist.recipientId.toString(),
                                );
                                sharedPreferences.setString(
                                  'senderId',
                                  '23cab527-e802-4e49-8cc1-78e5c5c8e8df',
                                );
                                sharedPreferences.setString(
                                  'firstName',
                                  widget.recipientlist.firstName.toString(),
                                );
                                sharedPreferences.setString(
                                  'lastname',
                                  widget.recipientlist.lastName.toString(),
                                );
                                sharedPreferences.setString(
                                  'u_first_name',
                                  widget.recipientlist.firstName.toString(),
                                );
                                sharedPreferences.setString(
                                  'u_last_name',
                                  widget.recipientlist.lastName.toString(),
                                );
                                sharedPreferences.setString(
                                  'u_phone_number',
                                  widget.recipientlist.phoneNumber.toString(),
                                );
                                sharedPreferences.setString(
                                  'u_profile_img',
                                  widget.recipientlist.profileImage.toString(),
                                );
                              } else {
                                Utility.showFlutterToast(
                                  'Please Select Payment Method',
                                );
                              }
                            },
                            child: SvgPicture.asset(
                              'assets/icons/send_blue.svg',
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// create listview....

                    hSizedBox2,
                    _enabled == true
                        ? Utility.shrimmerHorizontalListLoader(150, 220)
                        : SizedBox(
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

                                                                      bankListResponse
                                                                          .data![
                                                                              index]
                                                                          .accountNumber
                                                                          .toString(),
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
                                                                  //         () async {
                                                                  //       // pushNewScreen(
                                                                  //       //   context,
                                                                  //       //   screen: EditSelectBankScreen(onCallback: Update, recipient_account_id: accountdetaillist[index].recipientAccountId.toString(),),
                                                                  //       //   withNavBar: false,
                                                                  //       // );
                                                                  //       SharedPreferences
                                                                  //           sharedPreferences =
                                                                  //           await SharedPreferences.getInstance();
                                                                  //       BankDetailResponse
                                                                  //           bankdetailreponse =
                                                                  //           new BankDetailResponse();
                                                                  //       bankdetailreponse.status =
                                                                  //           true;
                                                                  //       bankdetailreponse.message =
                                                                  //           "success";
                                                                  //       BankDetailData
                                                                  //           data =
                                                                  //           new BankDetailData();
                                                                  //       data.id = bankListResponse
                                                                  //           .data![index]
                                                                  //           .id;
                                                                  //       data.rid = bankListResponse
                                                                  //           .data![index]
                                                                  //           .rid;
                                                                  //       data.uid = bankListResponse
                                                                  //           .data![index]
                                                                  //           .uid;
                                                                  //       data.routingCodeType1 = bankListResponse
                                                                  //           .data![index]
                                                                  //           .routingCodeType1;
                                                                  //       data.routingCodeValue1 = bankListResponse
                                                                  //           .data![index]
                                                                  //           .routingCodeValue1;
                                                                  //       data.routingCodeType2 = bankListResponse
                                                                  //           .data![index]
                                                                  //           .routingCodeType2;
                                                                  //       data.routingCodeValue2 = bankListResponse
                                                                  //           .data![index]
                                                                  //           .routingCodeValue2;
                                                                  //       data.accountNumber = bankListResponse
                                                                  //           .data![index]
                                                                  //           .accountNumber;
                                                                  //       data.bankAccountType = bankListResponse
                                                                  //           .data![index]
                                                                  //           .bankAccountType;
                                                                  //       data.bankName = bankListResponse
                                                                  //           .data![index]
                                                                  //           .bankName;
                                                                  //       data.bankCode = bankListResponse
                                                                  //           .data![index]
                                                                  //           .bankCode;
                                                                  //       data.updatedAt = bankListResponse
                                                                  //           .data![index]
                                                                  //           .updatedAt;
                                                                  //       data.createdAt = bankListResponse
                                                                  //           .data![index]
                                                                  //           .createdAt;
                                                                  //       bankdetailreponse.data =
                                                                  //           data;
                                                                  //       debugPrint("object" +
                                                                  //           json.encode(bankdetailreponse));
                                                                  //       sharedPreferences.setString(
                                                                  //           "BankdetailResponse",
                                                                  //           json.encode(bankdetailreponse));
                                                                  //       pushNewScreen(
                                                                  //         context,
                                                                  //         screen:
                                                                  //             EditBankAccountNumber(
                                                                  //           bank_name: bankListResponse.data![index].bankName.toString(),
                                                                  //           bank_id: bankListResponse.data![index].id.toString(),
                                                                  //           recipient_account_id: bankListResponse.data![index].id.toString(),
                                                                  //           Oncallback: Update,
                                                                  //         ),
                                                                  //         withNavBar:
                                                                  //             false,
                                                                  //       );
                                                                  //     },
                                                                  //     child: SvgPicture
                                                                  //         .asset(
                                                                  //       "assets/icons/edit.svg",
                                                                  //       color:
                                                                  //           MyColors.blackColor,
                                                                  //     )),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      // recipientId = accountdetaillist[index].recipientAccountId.toString();
                                                                      cureentindex =
                                                                          index;
                                                                      debugPrint(
                                                                        'recipient_account_id${bankListResponse.data![index].id}',
                                                                      );
                                                                      // deletedilogui(context, widget.recipient_id.toString(), bankListResponse.data![index].id.toString());
                                                                      is_delete =
                                                                          true;
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
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () async {
                                      debugPrint('hbdhjbdf');
                                      // ignore: unused_local_variable
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      widget.recipientlist.partnerPaymentMethod
                                                      .toString() ==
                                                  'mfs' ||
                                              widget.recipientlist
                                                      .partnerPaymentMethod
                                                      .toString() ==
                                                  'juba'
                                          ? pushNewScreen(
                                              context,
                                              screen: SelectPaymentMethodScreen(
                                                recipientdtl: true,
                                                Oncallback: Update,
                                                isMfs: true,
                                              ),
//                                         sharedPreferences.getString("select_payment_method_status")=="Mobile"?
//                                         SelectOperatorScreen(moreAdd: true,isAlreadyRecipient: true,Oncallback: Update,):
// // SelectPaymentMethodScreen(isMfs: true,selectedMethodScreen: 0,)
// // SelectDeliveryAddMethodScreen(ismfsAndalready: true,)
//
//                                         RecipientDetailBankAccountNumber(
//                                           Oncallback: Update,
//                                         ),
                                              // screen: RecipientDetailSelectBankScreen(onCallback: Update,),
                                              withNavBar: false,
                                            )
                                          : pushNewScreen(
                                              context,
                                              screen:
                                                  RecipientDetailBankAccountNumber(
                                                Oncallback: Update,
                                              ),
                                              // screen: RecipientDetailSelectBankScreen(onCallback: Update,),
                                              withNavBar: false,
                                            );
                                      // pushNewScreen(
                                      //   context,
                                      //   screen: RecipientDetailSelectBankScreen(onCallback: Update,),
                                      //   withNavBar: false,
                                      // );
                                      // widget.oncallback()
                                      /* pushNewScreen(
                                  context,
                                  screen: SelectPaymentMethodScreen(selectedMethodScreen: 1,),
                                  withNavBar: false,
                                );*/
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
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
                                        borderRadius: BorderRadius.circular(8),
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
                                              gradient: const LinearGradient(
                                                colors: [
                                                  MyColors.whiteColor,
                                                  MyColors.whiteColor
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: const Icon(
                                              CupertinoIcons.add,
                                              color: MyColors.lightblueColor,
                                            ),
                                          ),
                                          hSizedBox2,
                                          Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              MyString.add_new_method,
                                              style: TextStyle(
                                                color: MyColors.whiteColor,
                                                fontWeight: FontWeight.w600,
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
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(children: [
                    //     //CustomList.countrylist.map((String url) {
                    //     // return
                    //     Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 8, vertical: 10),
                    //       child: CustomRecipientOpenedCardList(
                    //         title: MyString.qnb_ba,
                    //         icon: "assets/icons/edit.svg",
                    //         subtitle: MyString.bank_deposit,
                    //         bordercolor: MyColors.lightblueColor,
                    //         status: true,
                    //       ),
                    //     ),
                    //
                    //     Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 8, vertical: 10),
                    //       child: CustomRecipientOpenedCardList(
                    //         title: "Vodafone",
                    //         icon: "assets/icons/edit.svg",
                    //         subtitle: "Mobile Money",
                    //         bordercolor:
                    //         MyColors.lightblueColor.withOpacity(0.05),
                    //       ),
                    //     ),
                    //
                    //
                    //     GestureDetector(
                    //       behavior: HitTestBehavior.translucent,
                    //       onTap: (){
                    //         debugPrint("hbdhjbdf");
                    //         pushNewScreen(
                    //           context,
                    //           screen: SelectPaymentMethodScreen(selectedMethodScreen: 1,),
                    //           withNavBar: false,
                    //         );
                    //       },
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         width: size.width * 0.45,
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 15, vertical: 30),
                    //         decoration: BoxDecoration(
                    //             gradient: LinearGradient(colors: [
                    //               MyColors.lightblueColor.withOpacity(0.70),
                    //               MyColors.lightblueColor.withOpacity(0.90),
                    //             ]),
                    //             borderRadius: BorderRadius.circular(8),
                    //             border: Border.all(
                    //                 color: MyColors.lightblueColor,
                    //                 width: 1)),
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //                 alignment: Alignment.center,
                    //                 width: 30,
                    //                 height: 30,
                    //                 decoration: BoxDecoration(
                    //                   gradient: LinearGradient(colors: [
                    //                     MyColors.whiteColor,
                    //                     MyColors.whiteColor
                    //                   ]),
                    //                   borderRadius: BorderRadius.circular(5),
                    //                 ),
                    //                 child: Icon(
                    //                   CupertinoIcons.add,
                    //                   color: MyColors.lightblueColor,
                    //                 )),
                    //             hSizedBox2,
                    //             Container(
                    //                 alignment: Alignment.center,
                    //                 child: Text(
                    //                   MyString.add_new_method,
                    //                   style: TextStyle(
                    //                       color: MyColors.whiteColor,
                    //                       fontWeight: FontWeight.w600,
                    //                       fontSize: 16,
                    //                       fontFamily:
                    //                       "assets/fonts/raleway/Raleway-Bold.ttf"),
                    //                 )),
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ]
                    //     //}).toList(),
                    //   ),
                    // ),

                    hSizedBox2,

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 14),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            MyString.transactions_history,
                            style: TextStyle(
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 14),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  MyColors.lightblueColor.withOpacity(0.05),
                                  MyColors.lightblueColor.withOpacity(0.10)
                                ],
                              ),
                              // color: MyColors.lightblueColor.withOpacity(0.10)
                            ),
                            child: Center(
                              child: Text(
                                latestTransferResponse.status == true
                                    ? latestTransferResponse
                                        .data!.txnData!.data!.length
                                        .toString()
                                    : '0',
                                style: TextStyle(
                                  color: MyColors.blackColor.withOpacity(0.80),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    hSizedBox1,

                    /// Transaction List...
                    _enabled1 == true
                        ? Utility.shrimmerHorizontalListLoader(150, 220)
                        : latestTransferResponse.status == true
                            ? latestTransferResponse
                                    .data!.txnData!.data!.isNotEmpty
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: List.generate(
                                          latestTransferResponse.data!.txnData!
                                              .data!.length, (index) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 20),
                                          padding: const EdgeInsets.only(
                                            left: 0,
                                            top: 10,
                                          ),
                                          child: CustomTransactionList(
                                            latestTransferResponse
                                                .data!.txnData!.data![index],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                : Container(
                                    height: 200,
                                  )
                            : Container(
                                height: 200,
                              ),

                    hSizedBox6,
                  ],
                ),
              ),
            ),
            is_delete == true
                ? Container(
                    height: size.height,
                    color: MyColors.blackColor.withOpacity(0.10),
                    child: Center(
                      child: deletedilogui(
                        context,
                        widget.recipient_id.toString(),
                        bankListResponse.data![cureentindex].id.toString(),
                      ),
                    ),
                  )
                : Container(),
            load == true
                ? Container(
                    height: size.height,
                    color: Colors.white.withOpacity(0.40),
                    child: const Center(
                      child: GFLoader(
                        type: GFLoaderType.custom,
                        child: Image(
                          image: AssetImage('assets/logo/progress_image.png'),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  CustomTransactionList(TxnSubData txnSubData) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      width: MediaQuery.of(context).size.width * 0.43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: MyColors.lightblueColor.withOpacity(0.03),
          width: 1,
        ),
      ),
      child: Material(
        color: MyColors.whiteColor,
        elevation: 2,
        shadowColor: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 40),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.whiteColor,
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  txnSubData.deliveryMethodType == 'Bank'
                      ? 'Bank Deposit'
                      : 'Mobile Deposit',
                  style: const TextStyle(
                    color: MyColors.color_text,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                  ),
                ),
              ),
              hSizedBox1,
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  txnSubData.createdAt.toString(),
                  // Utility.CurrentDate()==(txnSubData.createdAt.toString().split("T")[0])?"Today "+Utility.DatefomatToTime(txnSubData.createdAt.toString()):Utility.DatefomatToDateTime(txnSubData.createdAt.toString()),
                  style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.30),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                  ),
                ),
              ),
              hSizedBox2,
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      txnSubData.sendAmount.toString(),
                      style: const TextStyle(
                        color: MyColors.lightblueColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        fontFamily:
                            'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                      ),
                    ),
                  ),
                  wSizedBox,
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      MyString.usd,
                      style: TextStyle(
                        color: MyColors.lightblueColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                      ),
                    ),
                  ),
                ],
              ),
              hSizedBox2,
              Container(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: txnSubData.readyremitStatus == 'Approved'
                        ? MyColors.greenColor1.withOpacity(0.08)
                        : MyColors.lightorange.withOpacity(0.08),
                  ),
                  child: Center(
                    child: Text(
                      txnSubData.readyremitStatus.toString(),
                      style: TextStyle(
                        color: txnSubData.readyremitStatus == 'Approved'
                            ? MyColors.greenColor1
                            : MyColors.lightorange,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
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

  deletedilogui(
    BuildContext context,
    String recipientId,
    String recipient_account_id,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 4),
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
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
                                padding: MaterialStateProperty.all<EdgeInsets>(
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
                                is_delete = false;
                                setState(() {});
                                // Navigator.pop(context);
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
                                padding: MaterialStateProperty.all<EdgeInsets>(
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
                                DeleteBankAccountApi(
                                  context,
                                  recipientId,
                                  recipient_account_id,
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
    );
  }

  verifyDialog(BuildContext context, String msg, String status) {
    String document_status = status;
    String actual_status = status;
    document_status = document_status == 'pending'
        ? 'Incomplete'
        : document_status == 'completed'
            ? 'pending'
            : document_status;

    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset('assets/images/closesquare.svg'),
                ),
              ),
              document_status == 'Blank'
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Verification status : $document_status',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily:
                              'assets/fonts/raleway/raleway_regular.ttf',
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              actual_status == 'expired' ||
                      actual_status == 'Rejected' ||
                      actual_status == 'declined'
                  ? Column(
                      children: [
                        const Text(
                          'Please re upload verification.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
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
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'If you want to update verification Click Here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              actual_status == 'Blank'
                  ? Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
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
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'Verify Your Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              document_status == 'Incomplete'
                  ? Column(
                      children: [
                        const Text(
                          'Your Verification is incomplete , Please re upload verification.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
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
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'If you want to update verification Click Here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              document_status == 'pending'
                  ? const Column(
                      children: [
                        Text(
                          'We will notify you as soon as you’re approved.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Future<void> DeleteBankAccountApi(
    BuildContext context,
    String recipientId,
    String recipient_account_id,
  ) async {
    CustomLoader.progressloadingDialog5(context, true);
    setState(() {
      load = true;
    });
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['recipient_id'] = recipientId;
    request['account_id'] = recipient_account_id;

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
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == true) {
      debugPrint('bdjkdshjgh$jsonResponse');
      Utility.showFlutterToast(jsonResponse['message']);
      is_delete = false;
      setState(() {});
      /* String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();*/

      p.setString('BankdetailResponse', response.body);
      /* message == "" || message.isEmpty || message == ""? null:*/
      //  createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId);

      CustomLoader.progressloadingDialog5(context, false);
      getaccountdetailApi();
    } else {
      is_delete = false;
      setState(() {});
      // List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.progressloadingDialog5(context, false);
      getaccountdetailApi();
    }

    setState(() {});
    return;
  }

  getaccountdetailApi() async {
    // accountdetaillist.clear();
    // accountdetailfieldsetlist.clear();

    setState(() {
      load = true;
    });
    // String receipent_id = sharedPreferences!.getString("recipientId").toString();
    // await Webservices.AccountDetailsRequest(context,accountdetaillist,accountdetailfieldsetlist,"${widget.recipient_id}");
    WidgetsBinding.instance
        .addPostFrameCallback((_) => recipientBankAccountsapi(context));
    // recipientBankAccountsapi(context);
    // setState((){});
    setState(() {
      load = false;
    });
    debugPrint('dhghfgfj${accountdetailfieldsetlist.length}');
  }

  Future<void> recipientBankAccountsapi(BuildContext context) async {
    // CustomLoader.ProgressloadingDialog6(context, true);
    _enabled = true;
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
      Uri.parse(
        '${Apiservices.recipientBankAccountsapi}?recipient_id=${widget.recipient_id}',
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
    // CustomLoader.ProgressloadingDialog6(context, false);
    _enabled = false;
    if (jsonResponse['status'] == true) {
      bankListResponse = BankListResponse.fromJson(jsonResponse);

      setState(() {});
    } else {
      bankListResponse = BankListResponse.fromJson(jsonResponse);
      setState(() {});
    }
    return;
  }

  Future<void> latesttransferApi(
    BuildContext context,
  ) async {
    _enabled1 = true;
    // Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
    var request = {};
    request['recipient_id'] = widget.recipient_id;

    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.latesttransferapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    _enabled1 = false;
    if (jsonResponse['status'] == true) {
      latestTransferResponse = LatestTransferResponse.fromJson(jsonResponse);

      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);

      latestTransferResponse = LatestTransferResponse.fromJson(jsonResponse);
      setState(() {});
    }
    return;
  }
}
