import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:moneytos/screens/transfers_scheduled_screens/sheduled_successfully_screen.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/BankDetailResponse.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ScheduledGotoreviewScreen extends StatefulWidget {
  final String selected_acc_id;
  final String selected_acc_name;
  final String selected_payment_type;
  final String selected_last4;

  const ScheduledGotoreviewScreen({
    Key? key,
    required this.selected_acc_id,
    required this.selected_acc_name,
    required this.selected_payment_type,
    required this.selected_last4,
  }) : super(key: key);

  @override
  State<ScheduledGotoreviewScreen> createState() =>
      _ScheduledGotoreviewScreenState();
}

class _ScheduledGotoreviewScreenState extends State<ScheduledGotoreviewScreen> {
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
  String monyetosfee = '';
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
  String schedule_date = '';
  String schedule_end_date = '';
  String schedule_type = '';
  String recipient_server_id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => accountSettingApi(context));
    // accountSettingApi(context);
    debugPrint('Scheduled Flow check>>>>  ');
    pref();
    setState(() {});
  }

  pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dstCurrencyIso3Code =
        sharedPreferences.getString('dstCurrencyIso3Code').toString();
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
    schedule_date = sharedPreferences.getString('ScheduleStartDate').toString();
    schedule_end_date =
        sharedPreferences.getString('ScheduleEndDate').toString();
    schedule_type = sharedPreferences.getString('ScheduleType').toString();
    recipient_server_id = sharedPreferences.getString('recpi_id').toString();

    debugPrint('recipient_server_id>>>> $recipient_server_id');
    debugPrint('schedule_date>>>> $schedule_date');
    debugPrint('schedule_end_date>>>> $schedule_end_date');
    debugPrint('schedule_type>>>> $schedule_type');
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

    total_amount =
        (double.parse(sendAmount) + double.parse(monyetosfee)).toString();
    total_amount =
        double.parse(double.parse(total_amount).toStringAsFixed(2)).toString();
    debugPrint('total_amount>>>> $total_amount');

    if (sharedPreferences.get('BankdetailResponse').toString() != 'null') {
      Timer(const Duration(seconds: 1), () {
        var response = sharedPreferences.get('BankdetailResponse').toString();
        Map<String, dynamic> jsonResponse = jsonDecode(response);

        debugPrint('jsonResponse>>>>  $jsonResponse');

        // if (jsonResponse['status'] == true) {
        // Utility.ProgressloadingDialog(context, false);
        bankDetailResponse = BankDetailResponse.fromJson(jsonResponse);
        // for(int i = 0 ; i<bankDetailResponse.fields!.length;i++){
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
        BankName = bankDetailResponse.data!.bankName.toString();
        setState(() {});
        // } else {
        //   // Utility.ProgressloadingDialog(context, false);
        //   // isLoading = false;
        //   setState(() {
        //
        //   });
        // }
      });
    } else {}

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
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
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
                        debugPrint('is_pin_enabled>>> $is_pin_enabled');
                        debugPrint('document_status>>> $document_status');

                        // if(document_status == "Approved"){
                        //   debugPrint("document status Approved>>>>>> ");
                        //   if(is_pin_enabled==""){
                        //
                        //   }else{
                        //     if(is_pin_enabled=="1" || is_face_enabled=="1"){
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => ScheduledFaceAndTouchScreen(selected_acc_id: widget.selected_acc_id, selected_acc_name: widget.selected_acc_name, selected_payment_type: widget.selected_payment_type, selected_last4: widget.selected_last4,),
                        //       ));
                        //     }else{
                        //       saveScheduleApi(context);
                        //     }
                        //   }
                        // }
                        // else{
                        //   debugPrint("document status Blank>>>>>> ");
                        //   if(double.parse(sendAmount)<=200){
                        //     if(is_pin_enabled==""){
                        //
                        //     }else{
                        //       if(is_pin_enabled=="1" || is_face_enabled=="1"){
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => ScheduledFaceAndTouchScreen(selected_acc_id: widget.selected_acc_id, selected_acc_name: widget.selected_acc_name, selected_payment_type: widget.selected_payment_type, selected_last4: widget.selected_last4,),
                        //         ));
                        //       }else{
                        //         saveScheduleApi(context);
                        //
                        //       }
                        //     }
                        //   }else{
                        //     Fluttertoast.showToast(msg: "Please verify your account first to transfer amount more than \$200");
                        //   }
                        // }

                        comingsoonDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 30,
                        ),
                        child: CustomButton2(
                          btnname:
                              'Schedule From ${Utility.DatefomatToDDMMM(schedule_date)}',
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

  comingsoonDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset('assets/icons/clear_red.svg'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Schedule is coming soon check back later',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'assets/fonts/raleway/raleway_regular.ttf',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
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
                    backgroundColor: MyColors.divider_color,
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
                            style: const TextStyle(
                              color: MyColors.shedule_color,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                            ),
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
                              widget.selected_payment_type == 'check'
                                  ? 'Bank Account'
                                  : widget.selected_payment_type,
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
                          'Receive (Approx.)',
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
                                recipient_recieve_amount.toString(),
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
                                dstCurrencyIso3Code,
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
                  Image.asset(
                    'assets/logo/bank2.png',
                  ),
                  wSizedBox1,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                child: const Text(
                  MyString.depend_on_day_of_transfer,
                  style: TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 12,
                    fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                    fontWeight: FontWeight.w500,
                  ),
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
                      sendAmount,
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

  Future<void> saveScheduleApi(BuildContext context) async {
    Utility.transactionloadingDialog(context, true);
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['schedule_date'] = schedule_date;
    request['schedule_exp_date'] = schedule_end_date;
    request['schedule_type'] = schedule_type;
    request['dstCountryIso3Code'] = dstCountryIso3Code;
    request['recipientId'] = recipientId;
    request['recipient_server_id'] = recipient_server_id;
    request['recipient_name'] = '$u_first_name $u_last_name';
    request['recipient_image'] = u_profile_img;
    request['recipient_recived_amount'] = recipient_recieve_amount;
    request['transaction_fees'] = fees;
    request['exchange_rate'] = exchangerate;
    request['recipient_receive_method'] = BankName;
    request['delivery_method_type'] =
        bankDetailResponse.data!.bankAccountType.toString();
    request['recipient_receive_method_last4digit'] = BankAccNumber;
    request['sender_send_method'] = widget.selected_payment_type;
    request['sender_send_method_id'] = widget.selected_acc_id;
    request['sender_send_method_last4digit'] = widget.selected_last4;
    request['trasnsfer_reason'] = reasonsending_name;
    // request['trasnsfer_reason_id'] = "1";
    request['trasnsfer_reason_id'] = reasonsending_id;
    request['sending_currency'] = 'USD';
    request['receiving_currency'] = dstCurrencyIso3Code;
    request['recipientAccountId'] = bankDetailResponse.data!.id.toString();
    request['send_amount'] = sendAmount;
    request['monyetosfee'] = monyetosfee;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(Apiservices.saveScheduleapi),
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
        screen: SheduledSuccessfullyScreen(
          amount: sendAmount,
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
}
