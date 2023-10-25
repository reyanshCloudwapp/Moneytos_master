import 'package:dotted_border/dotted_border.dart';
import 'package:moneytos/model/txn_detail_response.dart';
import 'package:moneytos/screens/home_history/download_receipt_screen.dart';
import 'package:moneytos/screens/home_history_screens/sendagainmoneyquatationfromNewRecipient.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/BankDetailResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/GetStatusResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/LatestTransferResponse.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TransferBottomsheet extends StatefulWidget {
  final String readyremit_transferId;
  final String selected_acc_id;
  final String selected_payment_type;
  final String selected_acc_name;
  final String selected_last4;
  final TxnSubData txnSubData;
  final bool isMfs;

  const TransferBottomsheet({
    Key? key,
    required this.isMfs,
    required this.readyremit_transferId,
    required this.selected_acc_id,
    required this.selected_payment_type,
    required this.selected_acc_name,
    required this.selected_last4,
    required this.txnSubData,
  }) : super(key: key);

  @override
  State<TransferBottomsheet> createState() => _TransferBottomsheetState();
}

class _TransferBottomsheetState extends State<TransferBottomsheet> {
  String first_name = '',
      last_name = '',
      rec_image = '',
      phone_code = '',
      phone_number = '',
      will_recieve = '',
      currency_code = '',
      transfer_reason = '',
      delivery_method = '',
      bank_name = '',
      account_number = '',
      exchange_rate = '',
      created_at = '',
      mtin_number = '',
      you_send = '',
      fees = '',
      total_amount = '';

  bool is_load = true;
  TxnDetailResponse txnDetailResponse = TxnDetailResponse();

  GetStatusResponse getStatusResponse = GetStatusResponse();
  String txn_status = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => txnDetailapi(context));

    // gettxnstatusURLApi(context, widget.readyremit_transferId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return is_load
        ? SizedBox(
            height: size.width,
            width: size.height,
            child: const Center(
              child: GFLoader(
                type: GFLoaderType.custom,
                child: Image(
                  image: AssetImage('assets/logo/progress_image.png'),
                ),
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                hSizedBox3,
                stepprogressbar(),
                hSizedBox3,
                usercard(),
                hSizedBox2,
                deliveryMethid(),
                hSizedBox3,

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          MyString.transaction_detail,
                          style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: DownloadReceiptScreen(
                              txnId: widget.txnSubData.id.toString(),
                              transfer_reason:
                                  widget.txnSubData.trasnsferReason.toString(),
                              fees:
                                  widget.txnSubData.transactionFees.toString(),
                            ),
                            withNavBar: false,
                          );
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            MyString.view_detail,
                            style: TextStyle(
                              color: MyColors.lightblueColor,
                              fontSize: 12,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_semibold.ttf',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                hSizedBox3,

                ///
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyString.exchange_rate,
                          style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.30),
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              '01.00',
                              style: TextStyle(
                                color: MyColors.lightblueColor,
                                fontSize: 14,
                                fontFamily:
                                    'assets/fonts/montserrat/MontserratAlternates-SemiBold.otf',
                                fontWeight: FontWeight.w600,
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
                                fontSize: 9,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          wSizedBox1,
                          SvgPicture.asset(
                            'assets/icons/small_swap.svg',
                          ),
                          wSizedBox1,
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              exchange_rate,
                              style: const TextStyle(
                                color: MyColors.lightblueColor,
                                fontSize: 14,
                                fontFamily:
                                    'assets/fonts/montserrat/MontserratAlternates-SemiBold.otf',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          wSizedBox,
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              currency_code,
                              style: const TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 9,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                hSizedBox1,
                hSizedBox,

                ///
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyString.created_at,
                          style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.30),
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          created_at == '' ? '' : created_at,
                          style: const TextStyle(
                            letterSpacing: 0.5,
                            color: MyColors.blackColor,
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                hSizedBox1,
                hSizedBox,

                ///
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyString.mtin,
                          style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.30),
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          mtin_number,
                          style: const TextStyle(
                            letterSpacing: 0.5,
                            color: MyColors.blackColor,
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                hSizedBox4,

                ///
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              double.parse(you_send).toStringAsFixed(2),
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
                                fontFamily:
                                    'assets/fonts/raleway/raleway_semibold.ttf',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                hSizedBox2,

                ///
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              fees,
                              // fees,
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
                                fontFamily:
                                    'assets/fonts/raleway/raleway_semibold.ttf',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                hSizedBox3,

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 0.5,
                  child: DottedBorder(
                    color: Colors.black.withOpacity(0.50),
                    strokeWidth: 0.5,
                    dashPattern: const [8, 4],
                    child: Container(),
                  ),
                ),
                hSizedBox3,

                ///
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
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
                                fontFamily:
                                    'assets/fonts/raleway/raleway_semibold.ttf',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                hSizedBox2,
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         "assets/logo/bank2.png",
                //       ),
                //
                //       wSizedBox1,
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             alignment: Alignment.topLeft,
                //             child: Text(MyString.rbl_banl,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "assets/fonts/montserrat/Montserrat-Bold.otf",color: MyColors.blackColor),),
                //           ),
                //
                //           hSizedBox,
                //           Container(
                //             alignment: Alignment.topLeft,
                //             child: Text("Account - 9560",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "assets/fonts/montserrat/MontserratAlternates-Medium.otf",color: MyColors.blackColor),),
                //           ),
                //         ],
                //       ),
                //
                //     ],
                //   ),
                // ),
                // hSizedBox2,

                /// alert strings................

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Times may vary but we estimate that the recipient will receive the funds within 24 hours. Some receiving financial institutions may charge additional fees; foreign taxes may apply.\nToll Free No: (855) 411-237\n\nMoneytos may earn revenue from the conversion of USD to other countries.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily:
                          'assets/fonts/montserrat/MontserratAlternates-Medium.otf',
                      color: MyColors.blackColor,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),

                hSizedBox3,

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pushNewScreen(
                            context,
                            screen: DownloadReceiptScreen(
                              txnId: widget.txnSubData.id.toString(),
                              transfer_reason:
                                  widget.txnSubData.trasnsferReason.toString(),
                              fees:
                                  widget.txnSubData.transactionFees.toString(),
                            ),
                            withNavBar: false,
                          );
                        },
                        child: SizedBox(
                          width: 150,
                          child: Material(
                            shadowColor:
                                MyColors.lightblueColor.withOpacity(0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  //  stops: [0.0, 1.0],
                                  colors: [
                                    MyColors.lightblueColor.withOpacity(0.10),
                                    MyColors.lightblueColor.withOpacity(0.36),
                                  ],
                                ),
                                //    border: Border.all(color: bordercolor,width: 1.4)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/download_icon.svg',
                                  ),
                                  wSizedBox1,
                                  const Text(
                                    'Receipt',
                                    style: TextStyle(
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_bold.ttf',
                                      color: MyColors.lightblueColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.7,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          debugPrint(
                            'widget.txnSubData.partnerPaymentMethod.toString()>>>  ${widget.txnSubData.partnerPaymentMethod}',
                          );
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>GotoreviewScreen(selected_acc_id: widget.selected_acc_id, selected_payment_type: widget.selected_payment_type, selected_acc_name: widget.selected_acc_name, selected_last4: widget.selected_last4,)));
                          pushNewScreen(
                            context,
                            screen: SendAgainMoneyQuatationFromNewRecipient(
                              isMfs: widget.txnSubData.partnerPaymentMethod
                                          .toString() ==
                                      'mfs'
                                  ? true
                                  : false,
                              selected_acc_id: widget.selected_acc_id,
                              selected_payment_type:
                                  widget.selected_payment_type,
                              selected_acc_name: widget.selected_acc_name,
                              selected_last4: widget.selected_last4,
                            ),
                            withNavBar: false,
                          );
                          // pushNewScreen(
                          //   context,
                          //   screen: GotoreviewScreen(selected_acc_id: widget.selected_acc_id, selected_payment_type: widget.selected_payment_type, selected_acc_name: widget.selected_acc_name, selected_last4: widget.selected_last4,),
                          //   withNavBar: false,
                          // );
                          gotoreviewdataset(widget.txnSubData);
                        },
                        child: const SizedBox(
                          width: 150,
                          child: CustomButton2(
                            bordercolor: MyColors.lightblueColor,
                            btnname: MyString.send_again,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                hSizedBox6,
              ],
            ),
          );
  }

  stepprogressbar() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: MyColors.light_primarycolor2,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/tick.svg',
                    height: 16,
                    width: 16,
                  ),
                ),
              ),
              Container(
                height: 1,
                width: 100,
                decoration: const BoxDecoration(
                  color: MyColors.light_primarycolor2,
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: MyColors.light_primarycolor2,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/tick.svg',
                    height: 16,
                    width: 16,
                  ),
                ),
              ),
              Container(
                height: 1,
                width: 100,
                decoration: const BoxDecoration(
                  color: MyColors.light_primarycolor2,
                  shape: BoxShape.rectangle,
                ),
              ),
              txn_status == 'Completed'
                  ? Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        color: MyColors.light_primarycolor2,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/images/tick.svg',
                          height: 16,
                          width: 16,
                        ),
                      ),
                    )
                  : Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        color: MyColors.color_F3F3F3,
                        shape: BoxShape.circle,
                      ),
                    ),
            ],
          ),
          hSizedBox2,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 32,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: MyColors.color_linecolor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'On Its Way',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: ' assets/fonts/raleway/raleway_bold.ttf',
                        fontWeight: FontWeight.w600,
                        color: MyColors.light_primarycolor2,
                      ),
                    ),
                  ),
                ),
                wSizedBox2,
                Container(
                  height: 32,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: MyColors.color_linecolor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      txn_status,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: ' assets/fonts/raleway/raleway_bold.ttf',
                        fontWeight: FontWeight.w600,
                        color: txn_status == 'Completed'
                            ? MyColors.color_gray_707070
                            : MyColors.light_primarycolor2,
                      ),
                    ),
                  ),
                ),
                wSizedBox2,
                Container(
                  height: 32,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: MyColors.color_linecolor,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Completed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: ' assets/fonts/raleway/raleway_bold.ttf',
                        fontWeight: FontWeight.w600,
                        color: txn_status == 'Completed'
                            ? MyColors.light_primarycolor2
                            : MyColors.color_gray_707070.withOpacity(0.30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    //   Container(
    //   padding: EdgeInsets.symmetric(horizontal: 20),
    //   child: SingleChildScrollView(
    //     //scrollDirection: Axis.horizontal,
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding:  EdgeInsets.symmetric(horizontal: 11),
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //
    //               SvgPicture.asset(
    //                 "assets/logo/check_mark.svg",
    //                 // height: 20,
    //                 // width: 20,
    //                 //height: 100,
    //               ),
    //              wSizedBox,
    //               Container(
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10)
    //                 ),
    //                 width: MediaQuery.of(context).size.width * 0.3 ,
    //                 child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(10),
    //                   child: LinearProgressIndicator(
    //
    //                     color: MyColors.lightblueColor.withOpacity(0.90),
    //                   value: 0.60,),
    //                 ),
    //               ),
    //
    //
    //               wSizedBox,
    //               Container(
    //                 height: 20,
    //                 width: 20,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(100),
    //                   color: MyColors.yellow,
    //                 ),
    //                 child: Center(child: Icon(CupertinoIcons.checkmark_alt,color: MyColors.whiteColor,size: 15,),),
    //               ),
    //
    //
    //               wSizedBox,
    //               Container(
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10)
    //                 ),
    //                 width: MediaQuery.of(context).size.width * 0.3,
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(10),
    //                   child: LinearProgressIndicator(
    //
    //                     color: MyColors.lightblueColor.withOpacity(0.90),
    //                     value: 0.60,),
    //                 ),
    //               ),
    //
    //               wSizedBox,
    //               SvgPicture.asset(
    //                 "assets/logo/light_checkmark.svg",
    //                 height: 20,
    //                 width: 20,
    //                 //height: 100,
    //               ),
    //
    //             ],
    //           ),
    //         ),
    //
    //         hSizedBox,
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Container(
    //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(50),
    //                 color: MyColors.lightblueColor.withOpacity(0.20),
    //               ),
    //               child: Text(
    //                 MyString.on_its_way,
    //                 style: TextStyle(
    //                     color: MyColors.primaryColor.withOpacity(
    //                         0.60),
    //                     fontWeight: FontWeight.w600,
    //                     fontSize: 10,
    //                     fontFamily: "assets/fonts/raleway/raleway_bold.ttf"),
    //               ),
    //             ),
    //
    //
    //             Container(
    //               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(50),
    //                 color: MyColors.yellow.withOpacity(0.20),
    //               ),
    //               child: Text(
    //                 MyString.with_partner,
    //                 style: TextStyle(
    //                     color: MyColors.yellow.withOpacity(
    //                         0.70),
    //                     fontWeight: FontWeight.w600,
    //                     fontSize: 10,
    //                     fontFamily: "assets/fonts/raleway/raleway_bold.ttf"),
    //               ),
    //             ),
    //
    //             Container(
    //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(50),
    //                 color: MyColors.greenColor.withOpacity(0.20),
    //               ),
    //               child: Text(
    //                 MyString.completed,
    //                 style: TextStyle(
    //                     color: MyColors.greenColor.withOpacity(
    //                         0.70),
    //                     fontWeight: FontWeight.w600,
    //                     fontSize: 10,
    //                     fontFamily: "assets/fonts/raleway/raleway_bold.ttf"),
    //               ),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  /// usercard...
  usercard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.lightblueColor.withOpacity(0.03),
      ),
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
                      first_name,
                    ),
                    placeholder:
                        const AssetImage('assets/logo/progress_image.png'),
                    placeholderFit: BoxFit.scaleDown,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Text(first_name.toString()[0].toUpperCase());
                    },
                  ),
                ),
              ),
              wSizedBox1,
              wSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '$first_name $last_name',
                      style: const TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox,
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '(+$phone_code) $phone_number',
                      style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.50),
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),

          hSizedBox1,
          hSizedBox,

          /// bottom

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// left text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Will Receive',
                      style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.50),
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox,
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          double.parse(will_recieve).toStringAsFixed(2),
                          style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily:
                                'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      wSizedBox,

                      /// aud
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          currency_code,
                          style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 8,
                            fontFamily:
                                'assets/fonts/raleway/raleway_semibold.ttf',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// right text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Transfer Reason',
                      style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.50),
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox,
                  Row(
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.txnSubData.trasnsferReason.toString(),
                          style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  /// Delivery Method..

  deliveryMethid() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.lightblueColor.withOpacity(0.03),
      ),
      child: Column(
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
          hSizedBox2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                      delivery_method,
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

              // new Container( // gray box
              //   child: new Center(
              //     child:  new Transform(
              //       child:  SvgPicture.asset(
              //         "assets/icons/arrow_left.svg",color: MyColors.blackColor.withOpacity(0.10),
              //       ),
              //       alignment: FractionalOffset.center,
              //       transform: new Matrix4.identity()
              //         ..rotateZ(10 * 3.1415927 / 150),
              //     ),
              //   ),
              // )
            ],
          ),
          hSizedBox2,
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bank4.svg',
                height: 35,
                width: 35,
              ),
              wSizedBox1,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        bank_name,
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
                        account_number,
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> txnDetailapi(BuildContext context) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    is_load = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
    var request = {};
    request['recipient_id'] = widget.txnSubData.recipientId.toString();

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse('${Apiservices.txnDetailapi}?txn_id=${widget.txnSubData.id}'),
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
    is_load = false;
    if (jsonResponse['status'] == true) {
      txnDetailResponse = TxnDetailResponse.fromJson(jsonResponse);
      first_name = txnDetailResponse.data!.recipientName.toString();
      // last_name = txnDetailResponse.data!.recipientName.toString();
      rec_image = txnDetailResponse.data!.recipientImage.toString();
      phone_number = txnDetailResponse.data!.recipientPhoneNumber.toString();
      phone_code = txnDetailResponse.data!.recipientPhonecode.toString();

      will_recieve = txnDetailResponse.data!.recipientRecivedAmout.toString();
      // transfer_reason = jsonResponse["quote"]["sendAmount"]["value"];
      delivery_method = txnDetailResponse.data!.deliveryMethodType.toString();
      // delivery_method = txnDetailResponse.data!.senderSendMethod.toString()=="check"?'Bank Account' : txnDetailResponse.data!.senderSendMethod.toString();
      bank_name = txnDetailResponse.data!.recipientReceiveMethod.toString();
      account_number =
          txnDetailResponse.data!.recipientReceiveMethodLast4digit.toString();

      exchange_rate = txnDetailResponse.data!.exchangeRate.toString();
      created_at = txnDetailResponse.data!.newCreatedAt.toString();
      mtin_number = txnDetailResponse.data!.confirmationNumber.toString();
      you_send = txnDetailResponse.data!.sendAmount.toString();
      currency_code = txnDetailResponse.data!.receivingCurrency.toString();
      fees = txnDetailResponse.data!.monyetosfee.toString();

      you_send = txnDetailResponse.data!.sendAmount.toString();
      // fees = txnDetailResponse.data!.transactionFees.toString();
      will_recieve = txnDetailResponse.data!.recipientRecivedAmout.toString();
      total_amount =
          (double.parse(txnDetailResponse.data!.sendAmount.toString()) +
                  double.parse(txnDetailResponse.data!.monyetosfee.toString()))
              .toString();
      total_amount = double.parse(double.parse(total_amount).toStringAsFixed(2))
          .toString();
      txn_status = txnDetailResponse.data!.readyremitStatus.toString();

      setState(() {});
    } else {
      setState(() {});
    }
    return;
  }

  Future<void> TransfersApi(
    BuildContext context,
    String readyremitTransferid,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    is_load = true;
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse('${AllApiService.TransfersURL}/$readyremitTransferid'),
      // body: jsonEncode(request),
      headers: {
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Utility.ProgressloadingDialog(context, false);

      var recipientDetailsfieldsList =
          jsonResponse['recipientDetails']['fields'];
      first_name = jsonResponse['recipientDetails']['firstName'];
      last_name = jsonResponse['recipientDetails']['lastName'];
      for (int i = 0; i < recipientDetailsfieldsList.length; i++) {
        debugPrint(
          "fields response>>>> ${recipientDetailsfieldsList[i]["id"]}",
        );
        if (recipientDetailsfieldsList[i]['id'] == 'PHONE_NUMBER') {
          phone_number =
              recipientDetailsfieldsList[i]['value']['number'].toString();
          phone_code = recipientDetailsfieldsList[i]['value']
                  ['countryPhoneCode']
              .toString();
        }
      }

      will_recieve = jsonResponse['quote']['receiveAmount']['value'].toString();
      // transfer_reason = jsonResponse["quote"]["sendAmount"]["value"];
      delivery_method =
          jsonResponse['recipientAccountDetails']['transferMethod'].toString();

      var recipientAccountDetailsfieldsList =
          jsonResponse['recipientAccountDetails']['fields'];
      final responseJson = json.decode(response.body);
      debugPrint(
        "recipientAccountDetails>>>> ${json.encode(responseJson['recipientAccountDetails'])}",
      );
      p.setString(
        'BankdetailResponse',
        json.encode(responseJson['recipientAccountDetails']).toString(),
      );
      p.setString(
        'sourceCurrencyIso3Code',
        jsonResponse['quote']['sourceCurrencyIso3Code'].toString(),
      );

      for (int i = 0; i < recipientAccountDetailsfieldsList.length; i++) {
        debugPrint(
          "fields response>>>> ${recipientAccountDetailsfieldsList[i]["id"]}",
        );
        if (recipientAccountDetailsfieldsList[i]['id'] == 'BANK_NAME') {
          bank_name = recipientAccountDetailsfieldsList[i]['value'].toString();
        }
        if (recipientAccountDetailsfieldsList[i]['id'] ==
            'BANK_ACCOUNT_NUMBER') {
          account_number =
              recipientAccountDetailsfieldsList[i]['value'].toString();
        }
      }

      exchange_rate = jsonResponse['quote']['rate'].toString();
      try {
        exchange_rate = double.parse(exchange_rate).toStringAsFixed(2);
      } on Exception {
        exchange_rate = jsonResponse['quote']['rate'].toString();
      }

      created_at = jsonResponse['createdAt'].toString();
      mtin_number = jsonResponse['confirmationNumber'].toString();
      you_send = jsonResponse['quote']['sendAmount']['value'].toString();
      currency_code =
          jsonResponse['quote']['destinationCurrencyISO3Code'].toString();

      var quoteadjustmentsList = jsonResponse['quote']['adjustments'];

      for (int i = 0; i < quoteadjustmentsList.length; i++) {
        if (quoteadjustmentsList[i]['label'] == 'Transfer Fee') {
          fees = quoteadjustmentsList[i]['amount']['value'].toString();
        }
      }

      you_send = (double.parse(you_send) / 100).toString();
      fees = (double.parse(fees) / 100).toString();
      will_recieve = (double.parse(will_recieve) / 100).toString();
      total_amount = (double.parse(you_send) +
              double.parse(widget.txnSubData.transactionFees.toString()))
          .toString();

      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);

      setState(() {});
    }
    is_load = false;
    setState(() {});
    return;
  }

  Future<void> gettxnstatusURLApi(
    BuildContext context,
    String readyremitTxtId,
  ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        '${AllApiService.get_txn_status_URL}$readyremitTxtId/statuses',
      ),
      // body: jsonEncode(request),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    getStatusResponse = GetStatusResponse.fromJson(jsonResponse);
    txn_status = response.statusCode == 200
        ? getStatusResponse.statuses![0].status.toString()
        : '';

    debugPrint('jsonResponse >>> $jsonResponse');

    setState(() {});

    return;
  }

  Future<void> gotoreviewdataset(TxnSubData txnSubData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    //--------------------------------send again  -----------------------------

    if (txnDetailResponse.data!.recipientBankData?.id != null) {
      BankDetailResponse bankdetailreponse = BankDetailResponse();
      bankdetailreponse.status = true;
      bankdetailreponse.message = 'success';
      BankDetailData data = BankDetailData();
      data.id =
          int.parse(txnDetailResponse.data!.recipientBankData!.id.toString());
      data.rid = txnDetailResponse.data!.recipientBankData!.rid;
      data.uid = txnDetailResponse.data!.recipientBankData!.uid;
      data.routingCodeType1 =
          txnDetailResponse.data!.recipientBankData!.routingCodeType1;
      data.routingCodeValue1 =
          txnDetailResponse.data!.recipientBankData!.routingCodeValue1;
      data.routingCodeType2 =
          txnDetailResponse.data!.recipientBankData!.routingCodeType2;
      data.routingCodeValue2 =
          txnDetailResponse.data!.recipientBankData!.routingCodeValue2;
      data.accountNumber =
          txnDetailResponse.data!.recipientBankData!.accountNumber;
      data.bankAccountType =
          txnDetailResponse.data!.recipientBankData!.bankAccountType;
      data.bankName = txnDetailResponse.data!.recipientBankData!.bankName;
      data.bankCode = txnDetailResponse.data!.recipientBankData!.bankCode;
      data.updatedAt = txnDetailResponse.data!.recipientBankData!.updatedAt;
      data.createdAt = txnDetailResponse.data!.recipientBankData!.createdAt;
      bankdetailreponse.data = data;
      debugPrint('object${json.encode(bankdetailreponse)}');
      sharedPreferences.setString(
        'BankdetailResponse',
        json.encode(bankdetailreponse),
      );
    }

    //--------------------------------------------------------------------------
    sharedPreferences.setString(
      'dstCurrencyIso3Code',
      txnSubData.receivingCurrency.toString(),
    );
    sharedPreferences.setString(
      'dstCountryIso3Code',
      txnSubData.countryIso3Code.toString(),
    );

    sharedPreferences.setString('sendAmount', txnSubData.sendAmount.toString());
    sharedPreferences.setString(
      'receiveAmount',
      txnSubData.recipientRecivedAmout.toString(),
    );
    sharedPreferences.setString(
      'recipientId',
      txnSubData.recipientId.toString(),
    );
    sharedPreferences.setString(
      'senderId',
      txnSubData.senderSendMethodId.toString(),
    );
    sharedPreferences.setString(
      'exchangerate',
      txnSubData.exchangeRate.toString(),
    );
    sharedPreferences.setString('fees', txnSubData.transactionFees.toString());
    sharedPreferences.setString(
      'reasonsending_id',
      txnSubData.trasnsferReasonId.toString(),
    );
    sharedPreferences.setString(
      'reasonsending_name',
      txnSubData.trasnsferReason.toString(),
    );
    sharedPreferences.setString(
      'u_first_name',
      txnSubData.recipientName.toString().split(' ')[0].toString().trim(),
    );
    try {
      sharedPreferences.setString(
        'u_last_name',
        txnSubData.recipientName.toString().split(' ')[1].toString().trim(),
      );
    } catch (ex) {
      sharedPreferences.setString('u_last_name', '');
    }

    sharedPreferences.setString(
      'u_phone_number',
      txnSubData.phoneNumber.toString(),
    );
    sharedPreferences.setString(
      'u_profile_img',
      txnSubData.recipientImage.toString(),
    );

    sharedPreferences.setString(
      'country_Name',
      txnSubData.countryName.toString(),
    );
    sharedPreferences.setString(
      'country_Flag',
      txnSubData.countryEmoji.toString(),
    );
    sharedPreferences.setString(
      'country_isoCode3',
      txnSubData.countryIso3Code.toString(),
    );
    sharedPreferences.setString(
      'country_Currency_isoCode3',
      txnSubData.receivingCurrency.toString(),
    );
    sharedPreferences.setString(
      'select_payment_method_status',
      txnDetailResponse.data!.deliveryMethodType.toString(),
    );
    debugPrint(
      'select_payment_method_status>>>>> +++  ${txnDetailResponse.data!.deliveryMethodType.toString()}',
    );
    sharedPreferences.setString(
      'partnerPaymentMethod',
      txnSubData.partnerPaymentMethod.toString(),
    );
    sharedPreferences.setString(
      'recipientReceiveBankNameOrOperatorName',
      txnSubData.deliveryMethodType.toString() == 'Mobile'
          ? txnDetailResponse.data!.recipientBankData!.mobileOperator.toString()
          : txnDetailResponse.data!.recipientBankData!.bankName.toString(),
    );
    sharedPreferences.setString(
      'recipientReceiveBankOrMobileNo',
      txnDetailResponse.data!.recipientBankData!.accountNumber.toString(),
    );
    sharedPreferences.setString('recpi_id', txnSubData.recipientId.toString());
    feesbuyapi(
      context,
      txnSubData.countryIso3Code.toString(),
      double.parse(txnSubData.sendAmount.toString()),
    );
  }

  Future<void> feesbuyapi(
    BuildContext context,
    String countryIso3,
    double sendAmt,
  ) async {
    CustomLoader.progressloadingDialog(context, true);
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
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CustomLoader.progressloadingDialog6(context, false);
      // referlistResponse = await ReferlistResponse.fromJson(jsonResponse);

      debugPrint("money tos fees>>> ${jsonResponse['data']['monyetosfee']}");
      double moneytos =
          double.parse(jsonResponse['data']['monyetosfee'].toString());
      String isTransactionFeesFree =
          jsonResponse['data']['Is_transaction_fees_free'].toString();
      double transactionFeesFreeAmountLimit = double.parse(
        jsonResponse['data']['transaction_fees_free_amount_limit'].toString(),
      );
      if (isTransactionFeesFree == '1') {
        if (sendAmt >= transactionFeesFreeAmountLimit) {
          sharedPreferences.setString('monyetosfee', '0');
        } else {
          sharedPreferences.setString('monyetosfee', moneytos.toString());
        }
      } else {
        sharedPreferences.setString('monyetosfee', moneytos.toString());
      }
      setState(() {});
    } else {
      CustomLoader.progressloadingDialog6(context, false);
      setState(() {});
    }
    return;
  }
}
