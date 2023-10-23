import 'dart:async';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/BankDetailResponse.dart';
import 'package:moneytos/services/s_Api/S_Request/TransactionChargeRequest.dart';
import 'package:moneytos/services/s_Api/s_utils/timer_change_notifier.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../model/nium_payout_request.dart';
import '../../../transfers_scheduled_screens/face_and_touchid_screen.dart';
import '../sendsuccessfullytransferscreen/sendsuccessfulyscreen.dart';

class GotoreviewScreen extends StatefulWidget {
  final String selected_acc_id;
  final String selected_acc_name;
  final String selected_payment_type;
  final String selected_last4;
  final String cvv;
  final String avs_address;
  final String avs_zipcode;
  final MfsRecipientParam? mfsRecipientParam;
  final bool isMfs;

  const GotoreviewScreen({
    Key? key,
    required this.selected_acc_id,
    required this.selected_acc_name,
    required this.selected_payment_type,
    required this.selected_last4,
    required this.isMfs,
    this.mfsRecipientParam,
    this.cvv = '',
    this.avs_address = '',
    this.avs_zipcode = '',
  }) : super(key: key);

  @override
  State<GotoreviewScreen> createState() => _GotoreviewScreenState();
}

class _GotoreviewScreenState extends State<GotoreviewScreen> {
  String ipaddress = '';
  String dstCurrencyIso3Code = '';
  String dstCountryIso3Code = '';
  String sourceCurrencyIso3Code = '';
  String sendAmount = '';
  String recipient_recieve_amount = '';
  String recipientId = '';
  String senderId = '';
  String s_BankdetailResponse = '';
  String exchangerate = '';
  String fees = '';
  BankDetailResponse bankDetailResponse = BankDetailResponse();
  String BankName = '';
  String BankAccNumber = '';
  String reasonsending_id = '';
  String reasonsending_name = '';
  String u_first_name = '';
  String u_last_name = '';
  String u_profile_img = '';
  AccountSettingResponse accountSettingResponse = AccountSettingResponse();
  String total_amount = '0';
  String is_pin_enabled = '';
  String is_face_enabled = '';
  String document_status = '';
  String monyetosfee = '';
  String relationship = '';
  String select_payment_method_status = '';
  SharedPreferences? prefData;

  @override
  void initState() {
    super.initState();
    pref();
    setState(() {});
  }

  pref() async {
    prefData = await SharedPreferences.getInstance();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    select_payment_method_status =
        sharedPreferences.getString('select_payment_method_status').toString();
    debugPrint('selected_method is >> $select_payment_method_status');
    dstCurrencyIso3Code =
        sharedPreferences.getString('dstCurrencyIso3Code').toString();
    if (dstCurrencyIso3Code == 'NGN' &&
        select_payment_method_status == 'Bank') {
      dstCurrencyIso3Code = 'USD';
    }

    dstCountryIso3Code =
        sharedPreferences.getString('dstCountryIso3Code').toString();
    sourceCurrencyIso3Code =
        sharedPreferences.getString('sourceCurrencyIso3Code').toString();
    sendAmount = sharedPreferences.getString('sendAmount').toString();
    recipient_recieve_amount =
        sharedPreferences.getString('receiveAmount').toString();
    recipientId = sharedPreferences.getString('recpi_id').toString();
    senderId = sharedPreferences.getString('senderId').toString();
    s_BankdetailResponse =
        sharedPreferences.getString('BankdetailResponse').toString();
    exchangerate = sharedPreferences.getString('exchangerate').toString();
    fees = sharedPreferences.getString('fees').toString();
    monyetosfee = sharedPreferences.getString('monyetosfee').toString();
    reasonsending_id =
        sharedPreferences.getString('reasonsending_id').toString();
    reasonsending_name =
        sharedPreferences.getString('reasonsending_name').toString();
    u_first_name = sharedPreferences.getString('u_first_name').toString();
    u_last_name = sharedPreferences.getString('u_last_name').toString();
    u_profile_img = sharedPreferences.getString('u_profile_img').toString();
    relationship = sharedPreferences.getString('relationship').toString();

    debugPrint('CVV::: ${widget.cvv}');
    debugPrint('reasonsending_name>>>> $reasonsending_name');
    debugPrint('reasonsending_id>>>> $reasonsending_id');
    debugPrint('selected_acc_id>>>> ${widget.selected_acc_id}');
    debugPrint('selected_acc_name>>>> ${widget.selected_acc_name}');
    debugPrint('selected_payment_type>>>> ${widget.selected_payment_type}');
    debugPrint('selected_last4>>>> ${widget.selected_last4}');
    debugPrint('dstCurrencyIso3Code>>>> $dstCurrencyIso3Code');
    debugPrint('dstCountryIso3Code>>>> $dstCountryIso3Code');
    debugPrint('sourceCurrencyIso3Code>>>> $sourceCurrencyIso3Code');
    debugPrint('sendAmount>>>> $sendAmount');
    debugPrint('recipient_recieve_amount>>>> $recipient_recieve_amount');
    debugPrint('recipientId>>>> $recipientId');
    debugPrint('senderId>>>> $senderId');
    debugPrint('s_BankdetailResponse>>>> $s_BankdetailResponse');
    debugPrint('exchangerate>>>> $exchangerate');
    debugPrint('fees>>>> $fees');
    debugPrint('monyetosfee>>>> $monyetosfee');
    debugPrint('u_first_name>>>> $u_first_name');
    debugPrint('u_last_name>>>> $u_last_name');
    debugPrint('relationship>>>> $relationship');
    debugPrint(
      "select_payment_method_status>>>> ${sharedPreferences.getString("select_payment_method_status")}",
    );

    if (sharedPreferences.get('BankdetailResponse').toString() != 'null') {
      Timer(const Duration(seconds: 1), () {
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

        BankAccNumber = bankDetailResponse.data!.accountNumber.toString();
        BankName = (widget.isMfs &&
                widget.mfsRecipientParam?.deliveryMethodType == 'Mobile'
            ? widget.mfsRecipientParam?.recipientReceiveBankNameOrOperatorName
                .toString()
            : bankDetailResponse.data!.bankName.toString())!;
        debugPrint('bank name>>> $BankName');

        setState(() {});
        // } else {
        //   // Utility.ProgressloadingDialog(context, false);
        //   // isLoading = false;
        //   setState(() {
        //
        //   });
        // }
      });
    } else {
      // BankAccNumber = (sharedPreferences.getString("partnerPaymentMethod").toString()=="juba" ? widget.mfsRecipientParam?.recipientReceiveBankOrMobileNo.toString():"")!;
      BankName =
          (sharedPreferences.getString('partnerPaymentMethod').toString() ==
                  'juba'
              ? widget.mfsRecipientParam?.recipientReceiveBankNameOrOperatorName
                  .toString()
              : '')!;
    }

    WidgetsBinding.instance
        .addPostFrameCallback((_) => accountSettingApi(context));

    Future.delayed(Duration.zero, () {
      printIps();
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: MyColors.color_03153B,
          elevation: 0,
          centerTitle: true,

          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 25, top: 27),
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
                      'assets/images/leftarrow.svg',
                      height: 32,
                      width: 32,
                    ),
                  ),
                ),
                // wSizedBox3,
                // wSizedBox3,
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.review_and_confirm,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      fontFamily: 'assets/fonts/raleway/raleway_extrabold.ttf',
                    ),
                  ),
                ),
                Container(
                  width: 50,
                )
              ],
            ),
          ),
          automaticallyImplyLeading: false,

          //backgroundColor: MyColors.primaryColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: MyColors.color_03153B,
              height: size.height * 1.5,
            ),
            Container(
              height: size.height,
              margin: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: MyColors.whiteColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox2,
                    usercard(),
                    hSizedBox1,
                    deliveryMethid(),
                    hSizedBox1,
                    bankcard(),
                    hSizedBox2,
                    exchangeRatecard(),
                    hSizedBox2,
                    GestureDetector(
                      onTap: () {
                        // pushNewScreen(
                        //   context,
                        //   screen: HomeScreen(),
                        //   // screen: TransferVerificationTouchFaceId(),
                        //   withNavBar: true,
                        // );
                        //  transferbottomsheet(context);
                        // debugPrint("is_pin_enabled>>> " + is_pin_enabled);
                        // debugPrint("document_status>>> " + document_status);
                        // if(document_status.isEmpty){
                        //   debugPrint("document status empty>>>>>> ");
                        //   Fluttertoast.showToast(msg: "Please verify your account first to transfer amount");
                        // }

                        if (document_status == 'Approved') {
                          // debugPrint("document status Approved>>>>>> ");
                          if (is_pin_enabled == '') {
                          } else {
                            if (is_pin_enabled == '1' ||
                                is_face_enabled == '1') {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FaceAndTouchScreen(
                                    isMfs: widget.isMfs,
                                    mfsRecipientParam: widget.mfsRecipientParam,
                                    selected_acc_id: widget.selected_acc_id,
                                    selected_acc_name: widget.selected_acc_name,
                                    selected_payment_type:
                                        widget.selected_payment_type,
                                    selected_last4: widget.selected_last4,
                                    cvv2: widget.cvv,
                                    avs_zipcode: widget.avs_zipcode,
                                    avs_address: widget.avs_address,
                                  ),
                                ),
                              );
                            } else {
                              // transaction_chargeRequest(context);
                              submitPaymentapi(context);
                            }
                          }
                        } else {
                          debugPrint('document status Blank>>>>>> ');
                          if (double.parse(sendAmount) <= 200) {
                            if (is_pin_enabled == '') {
                            } else {
                              if (is_pin_enabled == '1' ||
                                  is_face_enabled == '1') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FaceAndTouchScreen(
                                      isMfs: widget.isMfs,
                                      mfsRecipientParam:
                                          widget.mfsRecipientParam,
                                      selected_acc_id: widget.selected_acc_id,
                                      selected_acc_name:
                                          widget.selected_acc_name,
                                      selected_payment_type:
                                          widget.selected_payment_type,
                                      selected_last4: widget.selected_last4,
                                    ),
                                  ),
                                );
                              } else {
                                // transaction_chargeRequest(context);
                                submitPaymentapi(context);
                              }
                            }
                          } else {
                            Utility.showFlutterToast(
                              'Please verify your account first to transfer amount more than \$200',
                            );
                          }
                        }
                        // if(document_status == "Blank"){
                        //   debugPrint("document status Blank>>>>>> ");
                        //   if(double.parse(sendAmount)<=200){
                        //     if(is_pin_enabled==""){
                        //
                        //     }else{
                        //       if(is_pin_enabled=="1" || is_face_enabled=="1"){
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => FaceAndTouchScreen(selected_acc_id: widget.selected_acc_id, selected_acc_name: widget.selected_acc_name, selected_payment_type: widget.selected_payment_type, selected_last4: widget.selected_last4,),
                        //         ));
                        //       }else{
                        //         transaction_chargeRequest(context);
                        //       }
                        //     }
                        //   }else{
                        //     Fluttertoast.showToast(msg: "Please verify your account first to transfer amount more than \$200");
                        //   }
                        //
                        //
                        // }
                        // else if(document_status == "Pending"){
                        //   debugPrint("document status Pending>>>>>> ");
                        //   if(double.parse(sendAmount)<=200){
                        //     if(is_pin_enabled==""){
                        //
                        //     }else{
                        //       if(is_pin_enabled=="1" || is_face_enabled=="1"){
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => FaceAndTouchScreen(selected_acc_id: widget.selected_acc_id, selected_acc_name: widget.selected_acc_name, selected_payment_type: widget.selected_payment_type, selected_last4: widget.selected_last4,),
                        //         ));
                        //       }else{
                        //         transaction_chargeRequest(context);
                        //       }
                        //     }
                        //   }else{
                        //     Fluttertoast.showToast(msg: "Please verify your account first to transfer amount more than \$200");
                        //   }
                        //
                        //
                        // }else if(document_status == "Approved"){
                        //   debugPrint("document status Approved>>>>>> ");
                        //   if(is_pin_enabled==""){
                        //
                        //   }else{
                        //     if(is_pin_enabled=="1" || is_face_enabled=="1"){
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => FaceAndTouchScreen(selected_acc_id: widget.selected_acc_id, selected_acc_name: widget.selected_acc_name, selected_payment_type: widget.selected_payment_type, selected_last4: widget.selected_last4,),
                        //       ));
                        //     }else{
                        //       transaction_chargeRequest(context);
                        //     }
                        //   }
                        // }
                        // else{
                        //   debugPrint("document status Other>>>>>> ");
                        //   Fluttertoast.showToast(msg: "Please verify your account first to transfer amount");
                        //   // if(is_pin_enabled==""){
                        //   //
                        //   // }else{
                        //   //   if(is_pin_enabled=="1" || is_face_enabled=="1"){
                        //   //     Navigator.of(context).push(MaterialPageRoute(
                        //   //       builder: (context) => FaceAndTouchScreen(),
                        //   //     ));
                        //   //   }else{
                        //   //     transaction_chargeRequest(context);
                        //   //   }
                        //   // }
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 30,
                        ),
                        child: const CustomButton2(
                          btnname: 'Transfer Now',
                          bordercolor: MyColors.lightblueColor,
                        ),
                      ),
                    ),
                    hSizedBox5,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// usercard...
  usercard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Material(
        elevation: 10,
        shadowColor: MyColors.lightblueColor.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.whiteColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              /// top
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: MyColors.lightblueColor.withOpacity(0.09),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: FadeInImage(
                        height: 156,
                        width: 149,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          u_profile_img,
                        ),
                        placeholder: const AssetImage(
                          'assets/logo/progress_image.png',
                        ),
                        placeholderFit: BoxFit.scaleDown,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Text(
                            u_first_name.toString()[0].toUpperCase(),
                          );
                        },
                      ),
                    ),
                  ),
                  wSizedBox1,
                  wSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            width: 220.0,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                '$u_first_name $u_last_name',
                                style: const TextStyle(
                                  color: MyColors.blackColor,
                                  fontSize: 14,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_semibold.ttf',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          // wSizedBox4,
                          // wSizedBox,
                          // SvgPicture.asset(
                          //   "assets/icons/edit.svg",
                          //   color: MyColors.blackColor,
                          // )
                        ],
                      ),
                      // hSizedBox,
                      // Container(
                      //   alignment: Alignment.topLeft,
                      //   child: Text(
                      //     "(+61) 124-335-547",
                      //     style: TextStyle(
                      //         color: MyColors.blackColor.withOpacity(0.50),
                      //         fontSize: 12,
                      //         fontFamily:
                      //         "assets/fonts/raleway/Raleway-Medium.ttf",
                      //         fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),

              hSizedBox1,
              hSizedBox,
            ],
          ),
        ),
      ),
    );
  }

  /// deleviry method
  deliveryMethid() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Material(
        elevation: 10,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.whiteColor,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyString.delivery_method,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                                'assets/fonts/montserrat/MontserratAlternates-Medium.otf',
                            color: MyColors.blackColor.withOpacity(0.30),
                          ),
                        ),
                      ),
                      hSizedBox1,
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/bank.svg',
                            color: MyColors.blackColor,
                          ),
                          wSizedBox1,
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.isMfs ||
                                      prefData!
                                              .getString(
                                                'partnerPaymentMethod',
                                              )
                                              .toString() ==
                                          'juba'
                                  ? widget.mfsRecipientParam!.deliveryMethodType
                                      .toString()
                                  : 'Bank Account',
                              // widget.selected_payment_type == "check"
                              //     ? "Bank Account"
                              //     : widget.selected_payment_type,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    'assets/fonts/montserrat/MontserratAlternates-Medium.otf',
                                color: MyColors.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      hSizedBox2,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyString.Recipient_Receive,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                                'assets/fonts/montserrat/MontserratAlternates-Medium.otf',
                            color: MyColors.blackColor.withOpacity(0.30),
                          ),
                        ),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                double.parse(recipient_recieve_amount)
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  fontFamily:
                                      '  assets/fonts/montserrat/MontserratAlternates-ExtraBold.otf',
                                  color: MyColors.blackColor,
                                ),
                              ),
                            ),
                            wSizedBox,
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                dstCurrencyIso3Code == 'NGN' &&
                                        select_payment_method_status == 'Bank'
                                    ? 'USD'
                                    : dstCurrencyIso3Code,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_semibold.ttf',
                                  color: MyColors.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      hSizedBox2,
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bank4.svg',
                      ),
                      wSizedBox1,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            alignment: Alignment.topLeft,
                            child: Text(
                              BankName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    'assets/fonts/montserrat/Montserrat-Bold.otf',
                                color: MyColors.blackColor,
                              ),
                            ),
                          ),
                          hSizedBox,
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              BankAccNumber.isEmpty
                                  ? ''
                                  : '****${BankAccNumber.substring(BankAccNumber.length - 4)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    'assets/fonts/montserrat/MontserratAlternates-Medium.otf',
                                color: MyColors.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
//                    wSizedBox5,
                      /* wSizedBox2,
                      Container(
                        alignment: Alignment.centerRight,
                          child: SvgPicture.asset("assets/icons/edit.svg",color: MyColors.blackColor,)),
*/
                    ],
                  ),

                  // Container(
                  //     alignment: Alignment.centerRight,
                  //     child: SvgPicture.asset("assets/icons/edit.svg",color: MyColors.blackColor,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// bank Card
  bankcard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Material(
        elevation: 10,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.selected_payment_type == 'card'
                      ? SvgPicture.asset(
                          'assets/icons/debit_card.svg',
                          height: 30,
                          width: 30,
                          color: MyColors.primaryColor,
                        )
                      : Image.asset(
                          'assets/logo/bank2.png',
                        ),
                  wSizedBox1,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.selected_acc_name.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/montserrat/Montserrat-Bold.otf',
                            color: MyColors.blackColor,
                          ),
                        ),
                      ),
                      hSizedBox,
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '****${widget.selected_last4}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                                'assets/fonts/montserrat/MontserratAlternates-Medium.otf',
                            color: MyColors.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // wSizedBox5,
                ],
              ),
              // SvgPicture.asset("assets/icons/edit.svg",color: MyColors.blackColor,),
            ],
          ),
        ),
      ),
    );
  }

  ///exchangeRate
  exchangeRatecard() {
    return Container(
      decoration: const BoxDecoration(
        color: MyColors.whiteColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 14.0),
                alignment: Alignment.topLeft,
                child: Text(
                  MyString.exchange_rate,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.30),
                    fontSize: 12,
                    fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/upsanddown.svg',
                      height: 16,
                      width: 16,
                    ),
                    wSizedBox1,
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  '01.00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        ' assets/fonts/raleway/raleway_semibold.ttf',
                                    color: MyColors.blackColor,
                                  ),
                                ),
                              ),
                              wSizedBox,
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  MyString.usd,
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_medium.ttf',
                                    color: MyColors.blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        hSizedBox,
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  exchangerate,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                        ' assets/fonts/raleway/raleway_semibold.ttf',
                                    color: MyColors.blackColor,
                                  ),
                                ),
                              ),
                              wSizedBox,
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  dstCurrencyIso3Code == 'NGN' &&
                                          select_payment_method_status == 'Bank'
                                      ? 'USD'
                                      : dstCurrencyIso3Code,
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_medium.ttf',
                                    color: MyColors.blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSizedBox2,

          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  MyString.you_send,
                  style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.30),
                    fontSize: 12,
                    fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      double.parse(sendAmount).toStringAsFixed(2),
                      style: const TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 14,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  wSizedBox,
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      MyString.usd,
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 8,
                        fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          hSizedBox2,

          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  MyString.fees,
                  style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.30),
                    fontSize: 12,
                    fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      monyetosfee,
                      style: const TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 14,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  wSizedBox,
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      MyString.usd,
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 8,
                        fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // hSizedBox3,
          // Container(
          //   child:  Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //
          //       Container(
          //         alignment: Alignment.topLeft,
          //         child: Text(
          //          "MTIN",
          //           style: TextStyle(
          //               color: MyColors.blackColor.withOpacity(0.30),
          //               fontSize: 12,
          //               fontFamily: "assets/fonts/raleway/Raleway-Medium.ttf",
          //               fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //
          //       Row(
          //         children: [
          //           Container(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               "000-00-0000",
          //               style: TextStyle(
          //                   color: MyColors.blackColor,
          //                   fontSize: 14,
          //                   fontFamily: "assets/fonts/raleway/Raleway-ExtraBold.ttf",
          //                   fontWeight: FontWeight.w800),
          //             ),
          //           ),
          //
          //           wSizedBox,
          //
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          hSizedBox3,

          SizedBox(
            height: 0.5,
            child: DottedBorder(
              color: const Color(0xffE9EDF2),
              strokeWidth: 0.5,
              dashPattern: const [8, 4],
              child: Container(),
            ),
          ),
          hSizedBox2,

          ///
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  MyString.total,
                  style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.30),
                    fontSize: 12,
                    fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      total_amount,
                      style: const TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 20,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  wSizedBox,
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      MyString.usd,
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 10,
                        fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          hSizedBox2,
        ],
      ),
    );
  }

  Future<void> transaction_chargeRequest(BuildContext context) async {
    Utility.transactionloadingDialog(context, true);
    TransactionChargeRequest transactionChargeRequest =
        TransactionChargeRequest();
    // transactionChargeRequest.amount = double.parse("15");//Please uncomment below line when we will do live testing
    transactionChargeRequest.amount = double.parse(total_amount);
    AmountDetails amountDetails = AmountDetails();
    amountDetails.tax = 0;
    amountDetails.surcharge = 0;
    amountDetails.shipping = 0;
    amountDetails.tip = 0;
    amountDetails.discount = 0;
    transactionChargeRequest.amountDetails = amountDetails;
    // transactionChargeRequest.name = accountSettingResponse.data!.userData!.name.toString();
    // Customer customer = new Customer();
    // customer.sendReceipt = false;
    // customer.email = accountSettingResponse.data!.userData!.email.toString();
    // customer.fax = "String";
    // customer.identifier = "String";
    // customer.customerId = accountSettingResponse.data!.userData!.magicpayCustomerId!.isEmpty?0:int.parse(accountSettingResponse.data!.userData!.magicpayCustomerId.toString());
    // transactionChargeRequest.customer = customer;
    if (widget.selected_payment_type == 'card') {
      BillingInfo billingInfo = BillingInfo();
      billingInfo.firstName = accountSettingResponse.data!.userData!.name
          .toString()
          .split(' ')[0]
          .toString()
          .trim();
      try {
        billingInfo.lastName = accountSettingResponse.data!.userData!.name
            .toString()
            .toString()
            .split(' ')[1]
            .toString()
            .trim();
      } catch (ex) {
        billingInfo.lastName = '';
      }

      billingInfo.company = 'String';
      billingInfo.street = 'String';
      billingInfo.street2 = 'String';
      billingInfo.state = 'String';
      billingInfo.city = 'String';
      billingInfo.zip = 'String';
      billingInfo.country =
          accountSettingResponse.data!.userData!.country.toString();
      billingInfo.phone =
          accountSettingResponse.data!.userData!.mobileNumber.toString();
      transactionChargeRequest.billingInfo = billingInfo;
    }

    // transactionChargeRequest.expiryMonth = 4;
    // transactionChargeRequest.expiryYear = 2023;
    // transactionChargeRequest.card = "4111111111111111";
    transactionChargeRequest.source = 'pm-${widget.selected_acc_id}';
    transactionChargeRequest.cvv2 = widget.cvv;
    transactionChargeRequest.capture = true;
    // transactionChargeRequest.saveCard = true;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.transaction_chargeURL),
      body: jsonEncode(transactionChargeRequest),
      headers: {
        // "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
        // "X-USERID": "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': AllApiService.client_id,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('transaction_chargeURL>>>> $jsonResponse');
      if (jsonResponse['status'].toString() == 'Error') {
        Utility.transactionloadingDialog(context, false);
      } else {
        debugPrint("transaction>>> id${jsonResponse['transaction']['id']}");
        debugPrint("jsonResponse>>> status${jsonResponse['status']}");
        String magicpayTxnid = jsonResponse['transaction']['id'].toString();
        String magicpayTxnstatus = jsonResponse['status'].toString();
        createMagicpayTxnapi(
          context,
          sendAmount,
          magicpayTxnid,
          magicpayTxnstatus,
        );
      }
    } else {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      debugPrint('jsonResponse>>> else$jsonResponse');
      Utility.showFlutterToast(jsonResponse['error_details'].toString());
    }
    setState(() {});
    return;
  }

  Future<void> createMagicpayTxnapi(
    BuildContext context,
    String sendAmount,
    String magicpayTxnid,
    String magicpayTxnstatus,
  ) async {
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['send_amount'] = sendAmount;
    request['magicpay_txnid'] = magicpayTxnid;
    request['magicpay_txnstatus'] = magicpayTxnstatus;
    //add new fields
    request['recipient_receive_method'] = BankName;
    request['recipient_receive_method_last4digit'] = BankAccNumber;
    request['sender_send_method'] = widget.selected_payment_type;
    request['sender_send_method_id'] = widget.selected_acc_id;
    request['sender_send_method_last4digit'] = widget.selected_last4;
    request['exchange_rate'] = exchangerate;
    request['delivery_method_type'] = widget.selected_payment_type;
    request['transaction_fees'] = fees;
    request['sending_currency'] = 'USD';
    request['receiving_currency'] = dstCurrencyIso3Code;
    request['trasnsfer_reason'] = reasonsending_name;
    request['trasnsfer_reason_id'] = reasonsending_id;
    request['recipient_recived_amout'] = recipient_recieve_amount;
    request['monyetosfee'] = int.parse(
              accountSettingResponse.data!.userData!.freeTransation.toString(),
            ) >
            0
        ? '0'
        : monyetosfee;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.createMagicpayTxnapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint('createMagicpayTxnapi>>>> $jsonResponse');
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      TransfersApi(context, magicpayTxnid);

      setState(() {});
    } else {
      Utility.showFlutterToast(jsonResponse['message']);

      setState(() {});
    }
    return;
  }

  Future<void> TransfersApi(BuildContext context, String magicpayTxnid) async {
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    // request['transferMethod'] = bankDetailResponse.data!.bankAccountType.toString();
    // request['quoteBy'] = "SEND_AMOUNT";
    // request['purposeOfRemittance'] = int.parse(reasonsending_id);
    // request['dstCurrencyIso3Code'] = dstCurrencyIso3Code;
    // request['dstCountryIso3Code'] = dstCountryIso3Code;
    // request['srcCurrencyIso3Code'] = sourceCurrencyIso3Code;
    // // request['amount'] = (double.parse(sendAmount)*100);
    // request['amount'] = (double.parse(sendAmount)*100).toString().split(".")[0];
    // request['sendAmount'] = (double.parse(sendAmount)*100).toString().split(".")[0];
    // request['senderId'] = "23cab527-e802-4e49-8cc1-78e5c5c8e8df";
    // request['recipientId'] = recipientId;
    // request['recipientAccountId'] = bankDetailResponse.data!.rid.toString();

    //Nium Request-----------
    NiumPayoutsRequest niumPayoutsRequest = NiumPayoutsRequest();
    niumPayoutsRequest.requestId = Apiservices.nium_request_id;
    niumPayoutsRequest.transactionNumber = magicpayTxnid;
    niumPayoutsRequest.destinationAccount =
        double.parse(recipient_recieve_amount);
    niumPayoutsRequest.destinationCurrency = p.getString('currency');
    niumPayoutsRequest.localConversionCurrency = 'USD';
    niumPayoutsRequest.statementNarrative = reasonsending_name;
    niumPayoutsRequest.originalRemitterFi = '';
    niumPayoutsRequest.sourceAccount =
        int.parse(Apiservices.nium_source_account);
    niumPayoutsRequest.feePayer = 'BEN';
    Beneficiary beneficiary = Beneficiary();
    beneficiary.name =
        "${p.getString("u_first_name")} ${p.getString("u_last_name")}";
    beneficiary.address = p.getString('rec_address');
    beneficiary.city = p.getString('rec_city');
    beneficiary.countryCode = p.getString('iso2');
    beneficiary.email = '';
    beneficiary.accountType = 'Individual';
    beneficiary.contactNumber =
        accountSettingResponse.data!.userData!.mobileNumber;
    beneficiary.state = '';
    beneficiary.postcode = p.getString('postcode').toString();
    // beneficiary.walletId = "";
    beneficiary.accountNumber =
        bankDetailResponse.data!.accountNumber.toString();
    beneficiary.bankAccountType =
        bankDetailResponse.data!.bankAccountType.toString();
    beneficiary.bankName = bankDetailResponse.data!.bankName.toString();
    beneficiary.bankCode = '';
    // beneficiary.identificationType = "";
    // beneficiary.identificationValue = "";
    // beneficiary.cardNumber = "";
    // beneficiary.encryptedCardNumber = "";
    // beneficiary.cardExpiryDate = "";
    beneficiary.relationship = relationship;
    beneficiary.accountIdentifierType = 'MOBILE';
    beneficiary.accountIdentifierValue = p.getString('u_phone_number');
    beneficiary.contactCountryCode =
        accountSettingResponse.data!.userData!.countryCode;
    beneficiary.nameLocalLanguage = 'en';
    niumPayoutsRequest.beneficiary = beneficiary;

    Remitter remitter = Remitter();
    remitter.name = 'Money Tos';
    remitter.givenName = true;
    remitter.accountType = 'Individual';
    remitter.bankAccountNumber = Apiservices.nium_source_account;
    remitter.identificationType = Apiservices.nium_identification_type;
    remitter.identificationNumber = Apiservices.nium_identification_number;
    remitter.countryCode = 'US';
    remitter.address = '2355 Hwy 36 West, Suite 400';
    remitter.purposeCode = 'IR001';
    remitter.sourceOfIncome = 'Cross border remittence';
    remitter.contactNumber = Apiservices.nium_contact_number;
    remitter.dob = '1980-01-01';
    remitter.city = 'Minneapolis';
    remitter.postcode = '55113';
    remitter.state = 'MN';
    remitter.sourceOfFunds = Apiservices.nium_source_account;
    remitter.placeOfBirth = 'US';
    remitter.nationality = 'US';
    remitter.occupation = 'EXECUTIVE';
    niumPayoutsRequest.remitter = remitter;

    AdditionalInfo additionalInfo = AdditionalInfo();
    additionalInfo.tradeOrderId = '';
    additionalInfo.tradeTime = '';
    additionalInfo.tradeCurrency = '';
    additionalInfo.tradeAmount = '';
    additionalInfo.tradeName = '';
    additionalInfo.tradeCount = '';
    additionalInfo.goodsCarrier = '';
    additionalInfo.serviceDetail = '';
    additionalInfo.serviceTime = '';
    additionalInfo.cashPickup = '';
    additionalInfo.tradePlatformName = '';
    niumPayoutsRequest.additionalInfo = additionalInfo;

    niumPayoutsRequest.routingCodeType1 =
        bankDetailResponse.data!.routingCodeType1.toString();
    niumPayoutsRequest.routingCodeValue1 =
        bankDetailResponse.data!.routingCodeValue1.toString();
    niumPayoutsRequest.routingCodeType2 =
        bankDetailResponse.data!.routingCodeType2.toString();
    niumPayoutsRequest.routingCodeValue2 =
        bankDetailResponse.data!.routingCodeValue2.toString();
    niumPayoutsRequest.routingCodeType3 = '';
    niumPayoutsRequest.routingCodeValue3 = '';

    niumPayoutsRequest.payoutMethod = '';
    niumPayoutsRequest.swiftFeePayer = '';
    niumPayoutsRequest.documentReference = '';

    //mfs Request-----------
    NiumPayoutsRequest mfsPayoutsRequest = NiumPayoutsRequest();
    mfsPayoutsRequest.requestId = Apiservices.nium_request_id;
    mfsPayoutsRequest.transactionNumber = magicpayTxnid;
    mfsPayoutsRequest.destinationAccount =
        double.parse(recipient_recieve_amount);
    mfsPayoutsRequest.destinationCurrency = p.getString('currency');
    mfsPayoutsRequest.localConversionCurrency = 'USD';
    mfsPayoutsRequest.statementNarrative = reasonsending_name;
    mfsPayoutsRequest.originalRemitterFi = '';
    mfsPayoutsRequest.sourceAccount =
        int.parse(Apiservices.nium_source_account);
    mfsPayoutsRequest.feePayer = 'BEN';
    Beneficiary mfsBeneficiary = Beneficiary();
    mfsBeneficiary.name =
        "${p.getString("u_first_name")} ${p.getString("u_last_name")}";
    mfsBeneficiary.address = p.getString('rec_address');
    mfsBeneficiary.city = p.getString('rec_city');
    mfsBeneficiary.countryCode = p.getString('iso2');
    mfsBeneficiary.email = '';
    mfsBeneficiary.accountType = 'Individual';
    mfsBeneficiary.contactNumber =
        accountSettingResponse.data!.userData!.mobileNumber;
    mfsBeneficiary.state = '';
    mfsBeneficiary.postcode = p.getString('postcode').toString();
    // beneficiary.walletId = "";
    mfsBeneficiary.accountNumber =
        bankDetailResponse.data!.accountNumber.toString();
    mfsBeneficiary.bankAccountType =
        bankDetailResponse.data!.bankAccountType.toString();
    mfsBeneficiary.bankName = bankDetailResponse.data!.bankName.toString();
    mfsBeneficiary.bankCode = '';
    // beneficiary.identificationType = "";
    // beneficiary.identificationValue = "";
    // beneficiary.cardNumber = "";
    // beneficiary.encryptedCardNumber = "";
    // beneficiary.cardExpiryDate = "";
    mfsBeneficiary.relationship = relationship;
    mfsBeneficiary.accountIdentifierType = 'MOBILE';
    mfsBeneficiary.accountIdentifierValue = p.getString('u_phone_number');
    mfsBeneficiary.contactCountryCode =
        accountSettingResponse.data!.userData!.countryCode;
    mfsBeneficiary.nameLocalLanguage = 'en';
    mfsPayoutsRequest.beneficiary = beneficiary;

    Remitter mfsRemitter = Remitter();
    mfsRemitter.name = 'Money Tos';
    mfsRemitter.givenName = true;
    mfsRemitter.accountType = 'Individual';
    mfsRemitter.bankAccountNumber = Apiservices.nium_source_account;
    mfsRemitter.identificationType = Apiservices.nium_identification_type;
    mfsRemitter.identificationNumber = Apiservices.nium_identification_number;
    mfsRemitter.countryCode = 'US';
    mfsRemitter.address = '2355 Hwy 36 West, Suite 400';
    mfsRemitter.purposeCode = 'IR001';
    mfsRemitter.sourceOfIncome = 'Cross border remittence';
    mfsRemitter.contactNumber = Apiservices.nium_contact_number;
    mfsRemitter.dob = '1980-01-01';
    mfsRemitter.city = 'Minneapolis';
    mfsRemitter.postcode = '55113';
    mfsRemitter.state = 'MN';
    mfsRemitter.sourceOfFunds = Apiservices.nium_source_account;
    mfsRemitter.placeOfBirth = 'US';
    mfsRemitter.nationality = 'US';
    mfsRemitter.occupation = 'EXECUTIVE';
    mfsPayoutsRequest.remitter = remitter;

    AdditionalInfo mfsAdditionalInfo = AdditionalInfo();
    mfsAdditionalInfo.tradeOrderId = '';
    mfsAdditionalInfo.tradeTime = '';
    mfsAdditionalInfo.tradeCurrency = '';
    mfsAdditionalInfo.tradeAmount = '';
    mfsAdditionalInfo.tradeName = '';
    mfsAdditionalInfo.tradeCount = '';
    mfsAdditionalInfo.goodsCarrier = '';
    mfsAdditionalInfo.serviceDetail = '';
    mfsAdditionalInfo.serviceTime = '';
    mfsAdditionalInfo.cashPickup = '';
    mfsAdditionalInfo.tradePlatformName = '';
    mfsPayoutsRequest.additionalInfo = additionalInfo;

    mfsPayoutsRequest.routingCodeType1 =
        bankDetailResponse.data!.routingCodeType1.toString();
    mfsPayoutsRequest.routingCodeValue1 =
        bankDetailResponse.data!.routingCodeValue1.toString();
    mfsPayoutsRequest.routingCodeType2 =
        bankDetailResponse.data!.routingCodeType2.toString();
    mfsPayoutsRequest.routingCodeValue2 =
        bankDetailResponse.data!.routingCodeValue2.toString();
    mfsPayoutsRequest.routingCodeType3 = '';
    mfsPayoutsRequest.routingCodeValue3 = '';

    mfsPayoutsRequest.payoutMethod = '';
    mfsPayoutsRequest.swiftFeePayer = '';
    mfsPayoutsRequest.documentReference = '';
    debugPrint('-----$niumPayoutsRequest----');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var body = jsonEncode(niumPayoutsRequest);
    if (widget.isMfs) {
      body = jsonEncode(mfsPayoutsRequest);
    }
    var response = await http.post(
      Uri.parse(Apiservices.niumpayoutsapi),
      body: body,
      headers: {
        'X-CLIENT-ID': Apiservices.x_client_id,
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    debugPrint('TransfersURL>>>> $jsonResponse');
    if (response.statusCode == 200) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.transactionloadingDialog(context, false);
      Utility.transactionfinishloadingDialog(context, true);
      createRTxnbyMtxnidApi(
        context,
        magicpayTxnid,
        jsonResponse['reference_number'],
        jsonResponse['payment_id'],
        sendAmount,
      );
      setState(() {});
    } else {
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      setState(() {});
    }

    return;
  }

  Future<void> createRTxnbyMtxnidApi(
    BuildContext context,
    String magicpayTxnid,
    String readyremitTransferid,
    String confirmationNumber,
    String sendAmount,
  ) async {
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['magicpay_txnid'] = magicpayTxnid;
    request['reference_number'] = readyremitTransferid;
    request['payment_id'] = confirmationNumber;
    request['recipientId'] = recipientId;
    request['recipientAccountId'] = bankDetailResponse.data!.id.toString();
    request['recipient_name'] = '$u_first_name $u_last_name';
    request['recipient_image'] = u_profile_img;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.createRTxnbyMtxnidapi),
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
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.transactionfinishloadingDialog(context, false);
      pushNewScreen(
        context,
        screen: SendSuccessfullyTransferScreen(
          readyremit_transferId: jsonResponse['data']['id'].toString(),
          sendAmount: sendAmount,
          transfer_reason: reasonsending_name,
          fees: fees,
        ),
        withNavBar: false,
      );
      setState(() {});
    } else {
      Utility.showFlutterToast(jsonResponse['message']);

      setState(() {});
    }
    return;
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
      accountSettingResponse = AccountSettingResponse.fromJson(jsonResponse);
      is_pin_enabled =
          accountSettingResponse.data!.userData!.isPinEnabled.toString();
      is_face_enabled =
          accountSettingResponse.data!.userData!.isFaceEnabled.toString();
      document_status =
          accountSettingResponse.data!.userData!.documentStatus.toString();
      fees = int.parse(
                accountSettingResponse.data!.userData!.freeTransation
                    .toString(),
              ) >
              0
          ? '0'
          : fees;
      total_amount =
          (double.parse(sendAmount) + double.parse(monyetosfee)).toString();
      total_amount = double.parse(double.parse(total_amount).toStringAsFixed(2))
          .toString();
      debugPrint('total_amount>>>> $total_amount');
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

  Future printIps() async {
    // for (var interface in await NetworkInterface.list()) {
    //   debugPrint('== Interface: ${interface.name} ==');
    //   for (var addr in interface.addresses) {
    //     debugPrint(
    //         '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
    //     ipaddress = interface.addresses.first.address;
    //     setState(() {});
    //   }
    // }

    final ipv4 = await Ipify.ipv4();
    debugPrint('ipv4>>>>>> $ipv4'); // 98.207.254.136

    final ipv6 = await Ipify.ipv64();
    debugPrint(
      'ipv6>>>>>> $ipv6',
    ); // 98.207.254.136 or 2a00:1450:400f:80d::200e

    final ipv4json = await Ipify.ipv64(format: Format.JSON);
    debugPrint('ipv4json>>>>>> $ipv4json'); //{"ip
    ipaddress = ipv4.toString();
  }

  Future<void> submitPaymentapi(BuildContext context) async {
    Utility.transactionloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['send_amount'] = sendAmount;
    request['recipientId'] = recipientId;
    request['recipientAccountId'] =
        bankDetailResponse.data?.id.toString() ?? '';
    request['recipient_receive_method'] = BankName;
    request['recipient_receive_method_last4digit'] = BankAccNumber;
    request['sender_send_method'] = widget.selected_payment_type;
    request['sender_send_method_id'] = widget.selected_acc_id;
    request['sender_send_method_last4digit'] = widget.selected_last4;
    request['trasnsfer_reason'] = reasonsending_name;
    request['trasnsfer_reason_id'] = reasonsending_id;
    request['sending_currency'] = 'USD';
    request['receiving_currency'] = dstCurrencyIso3Code;
    // request['delivery_method_type'] = widget.selected_payment_type;
    request['delivery_method_type'] = 'Bank';
    request['recipient_recived_amout'] = recipient_recieve_amount;
    request['exchange_rate'] = exchangerate;
    request['transaction_fees'] = fees;
    request['monyetosfee'] = int.parse(
              accountSettingResponse.data!.userData!.freeTransation.toString(),
            ) >
            0
        ? '0'
        : monyetosfee;
    request['client_ip'] = ipaddress;
    request['avs_address'] = widget.avs_address;
    request['avs_zip'] = widget.avs_zipcode;
    request['cvv2'] = widget.cvv;

    var mfsRequest = {};
    mfsRequest['send_amount'] = sendAmount;
    mfsRequest['recipientId'] = recipientId;
    mfsRequest['recipientAccountId'] =
        bankDetailResponse.data?.id.toString() ?? '';
    mfsRequest['recipient_receive_method'] =
        widget.mfsRecipientParam?.recipientReceiveBankNameOrOperatorName;
    mfsRequest['recipient_receive_method_last4digit'] =
        widget.mfsRecipientParam?.recipientReceiveBankOrMobileNo;
    mfsRequest['sender_send_method'] = widget.selected_payment_type;
    mfsRequest['sender_send_method_id'] = widget.selected_acc_id;
    mfsRequest['sender_send_method_last4digit'] = widget.selected_last4;
    mfsRequest['trasnsfer_reason'] = reasonsending_name;
    mfsRequest['trasnsfer_reason_id'] = reasonsending_id;
    mfsRequest['sending_currency'] = 'USD';
    mfsRequest['receiving_currency'] = dstCurrencyIso3Code;
    mfsRequest['delivery_method_type'] =
        (widget.mfsRecipientParam?.deliveryMethodType?.isNotEmpty ?? false)
            ? widget.mfsRecipientParam?.deliveryMethodType.toString()
            : widget.selected_payment_type;
    mfsRequest['recipient_recived_amout'] = recipient_recieve_amount;
    mfsRequest['exchange_rate'] = exchangerate;
    mfsRequest['transaction_fees'] = int.parse(
              accountSettingResponse.data!.userData!.freeTransation.toString(),
            ) >
            0
        ? '0'
        : monyetosfee;
    mfsRequest['monyetosfee'] = int.parse(
              accountSettingResponse.data!.userData!.freeTransation.toString(),
            ) >
            0
        ? '0'
        : monyetosfee;
    mfsRequest['client_ip'] = ipaddress;
    mfsRequest['avs_address'] = widget.avs_address;
    mfsRequest['avs_zip'] = widget.avs_zipcode;
    mfsRequest['cvv2'] = widget.cvv;

    var jubaRequest = {};
    jubaRequest['send_amount'] = sendAmount;
    jubaRequest['recipientId'] = recipientId;
    jubaRequest['recipientAccountId'] =
        bankDetailResponse.data?.id.toString() ?? '';
    jubaRequest['recipient_receive_method'] =
        widget.mfsRecipientParam?.recipientReceiveBankNameOrOperatorName;
    if (select_payment_method_status == 'Cash') {
    } else {
      jubaRequest['recipient_receive_method_last4digit'] =
          widget.mfsRecipientParam?.recipientReceiveBankOrMobileNo;
    }

    jubaRequest['sender_send_method'] = widget.selected_payment_type;
    jubaRequest['sender_send_method_id'] = widget.selected_acc_id;
    jubaRequest['sender_send_method_last4digit'] = widget.selected_last4;
    jubaRequest['trasnsfer_reason'] = reasonsending_name;
    jubaRequest['trasnsfer_reason_id'] = reasonsending_id;
    jubaRequest['sending_currency'] = 'USD';
    jubaRequest['receiving_currency'] = dstCurrencyIso3Code;
    jubaRequest['delivery_method_type'] =
        (widget.mfsRecipientParam?.deliveryMethodType?.isNotEmpty ?? false)
            ? widget.mfsRecipientParam?.deliveryMethodType.toString()
            : widget.selected_payment_type;
    jubaRequest['recipient_recived_amout'] = recipient_recieve_amount;
    jubaRequest['exchange_rate'] = exchangerate;
    jubaRequest['transaction_fees'] = int.parse(
              accountSettingResponse.data!.userData!.freeTransation.toString(),
            ) >
            0
        ? '0'
        : monyetosfee;
    jubaRequest['monyetosfee'] = int.parse(
              accountSettingResponse.data!.userData!.freeTransation.toString(),
            ) >
            0
        ? '0'
        : monyetosfee;
    jubaRequest['client_ip'] = ipaddress;
    jubaRequest['avs_address'] = widget.avs_address;
    jubaRequest['avs_zip'] = widget.avs_zipcode;
    jubaRequest['cvv2'] = widget.cvv;
    jubaRequest['juba_NominatedCode'] =
        p.getString('juba_NominatedCode').toString();

    var body = jsonEncode(request);
    if (widget.isMfs) {
      debugPrint('mfs request>>>>');
      body = jsonEncode(mfsRequest);
    }
    if (p.getString('partnerPaymentMethod').toString() == 'juba') {
      debugPrint('juba request>>>>');
      body = jsonEncode(jubaRequest);
    }
    debugPrint('-----$jubaRequest----');

    // Utility.transactionloadingDialog(context, false);

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.submitPaymentapi),
      body: body,
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    debugPrint('submitPaymentapi>>>> $jsonResponse');
    Utility.transactionloadingDialog(context, false);

    Utility.transactionfinishloadingDialog(context, true);
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.transactionfinishloadingDialog(context, false);

      CountdownTimerState(context).stopTimer();

      pushNewScreen(
        context,
        screen: SendSuccessfullyTransferScreen(
          readyremit_transferId: jsonResponse['data']['id'].toString(),
          sendAmount: sendAmount,
          transfer_reason: reasonsending_name,
          fees: fees,
        ),
        withNavBar: false,
      );
      setState(() {});
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      Utility.transactionfinishloadingDialog(context, false);

      setState(() {});
    }

    return;
  }
}

class MfsRecipientParam {
  String? deliveryMethodType;
  String? recipientReceiveBankNameOrOperatorName;
  String? recipientReceiveBankOrMobileNo;

  MfsRecipientParam({
    this.deliveryMethodType,
    this.recipientReceiveBankNameOrOperatorName,
    this.recipientReceiveBankOrMobileNo,
  });
}
