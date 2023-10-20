import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

import '../model/txn_detail_response.dart';
import '../s_Api/AllApi/ApiService.dart';
import 'dart:convert' as convert;

import '../s_Api/s_utils/Utility.dart';
import 'package:pdf/widgets.dart' as pw;

import '../services/Apiservices.dart';
class DownloadReceiptScreen extends StatefulWidget {
  String txnId;
  String transfer_reason;
  String fees;
  DownloadReceiptScreen({Key? key,required this.txnId,required this.transfer_reason,required this.fees}) : super(key: key);

  @override
  _DownloadReceiptScreenState createState() => _DownloadReceiptScreenState();
}

class _DownloadReceiptScreenState extends State<DownloadReceiptScreen> {
  TxnDetailResponse txnDetailResponse = new  TxnDetailResponse();
  String first_name="",last_name="",rec_image="",phone_code="",phone_number="",will_recieve="",currency_code="",transfer_reason="",delivery_method="",bank_name="",account_number="",
      exchange_rate="",created_at="",mtin_number="",you_send="",fees="",total_amount="";

  bool is_load = true;
  ScreenshotController screenshotController = ScreenshotController();


  Future<void> mainpdfave() async {

    var assetImage = pw.MemoryImage(
      (await rootBundle.load('a_assets/icons/bankpng.png'))
          .buffer
          .asUint8List(),
    );

    var assetImageBank = pw.MemoryImage(
      (await rootBundle.load('a_assets/icons/bank4png.png'))
          .buffer
          .asUint8List(),
    );

    var assetImageexc = pw.MemoryImage(
      (await rootBundle.load('a_assets/icons/small_swappng.png'))
          .buffer
          .asUint8List(),
    );
    final pdf = pw.Document();


    pdf.addPage(
      pw.MultiPage(
        // pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => <pw.Widget>[

          pw.Container(
            //margin: EdgeInsets.only(top: size.height /9),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: MyColors.whiteColor),
              child: pw.Container(
                padding: pw.EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                margin: pw.EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: MyColors.lightblueColor.withOpacity(0.06)),
                child: pw.Column(
                  children: [
                    /// top
                    pw.Row(
                      children: [
                        pw.ClipRRect(
                          // borderRadius: pw.BorderRadius.circular(200),
                          child: pw.Container(
                              padding: pw.EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                              // color: PdfColors.grey,
                  decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      color: PdfColors.blue),
                              alignment:pw.Alignment.center,child: pw.Text(first_name.toString()[0].toUpperCase(),style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 14,
                            // fontFamily:
                            // "s_asset/font/raleway/Raleway-SemiBold.ttf",
                            // fontWeight: FontWeight.w500
                          ))),
                        ),
                        pw.SizedBox(width: 15),

                        pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  "${first_name} ${last_name}",
                                  style: pw.TextStyle(
                                    // color: MyColors.blackColor,
                                    fontSize: 14,
                                    // fontFamily:
                                    // "s_asset/font/raleway/Raleway-SemiBold.ttf",
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              pw.SizedBox(height: 5),
                              pw.Container(
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  "(+${phone_code}) ${phone_number}",
                                  // style: TextStyle(
                                  //     color: MyColors.blackColor.withOpacity(0.50),
                                  //     fontSize: 12,
                                  //     fontFamily:
                                  //     "s_asset/font/raleway/Raleway-Medium.ttf",
                                  //     fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    pw.SizedBox(height: 15),

                    /// bottom

                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        /// left text
                        pw.Container(
                          child: pw.Column(
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  "Will Receive",
                                  // style: TextStyle(
                                  //     color: MyColors.blackColor.withOpacity(0.50),
                                  //     fontSize: 12,
                                  //     fontFamily:
                                  //     "s_asset/font/raleway/Raleway-Medium.ttf",
                                  //     fontWeight: FontWeight.w500),
                                ),
                              ),
                              pw.SizedBox(height: 5),
                              pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.topLeft,
                                    child: pw.Text(
                                      "${will_recieve}",
                                      // style: TextStyle(
                                      //     color: MyColors.blackColor,
                                      //     fontSize: 14,
                                      //     fontFamily:
                                      //     "s_asset/font/montserrat/Montserrat-ExtraBold.otf",
                                      //     fontWeight: FontWeight.w800
                                    ),

                                  ),
                                  pw.SizedBox(height: 5),

                                  /// aud
                                  pw.Container(
                                    alignment: pw.Alignment.topLeft,
                                    child: pw.Text(
                                      currency_code,
                                      // style: TextStyle(
                                      //     color: MyColors.blackColor,
                                      //     fontSize: 8,
                                      //     fontFamily:
                                      //     "s_asset/font/raleway/Raleway-SemiBold.ttf",
                                      //     fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// right text
                        pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                alignment: pw.Alignment.topLeft,
                                child: pw.Text(
                                  "Transfer Reason",
                                  // style: TextStyle(
                                  //     color: MyColors.blackColor.withOpacity(0.50),
                                  //     fontSize: 12,
                                  //     fontFamily:
                                  //     "s_asset/font/raleway/Raleway-Medium.ttf",
                                  //     fontWeight: FontWeight.w500),
                                ),
                              ),
                              pw.SizedBox(height: 5),
                              pw.Row(
                                children: [
                                  pw.Container(
                                    width: 120,
                                    alignment: pw.Alignment.topLeft,
                                    child: pw.Text(
                                      widget.transfer_reason,
                                      // style: TextStyle(
                                      //     color: MyColors.blackColor,
                                      //     fontSize: 14,
                                      //     fontFamily:
                                      //     "s_asset/font/raleway/Raleway-Medium.ttf",
                                      //     fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),


                    pw.Container(
                      width: double.infinity,
                      padding: pw.EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                      margin: pw.EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: MyColors.lightblueColor.withOpacity(0.06)),
                      child: pw.Column(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.topLeft,
                            child: pw.Text(
                              MyString.delivery_method,
                              // style: TextStyle(
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.w500,
                              //     fontFamily:
                              //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              //     color: MyColors.blackColor.withOpacity(0.30)),

                            ),
                          ),
                          pw.SizedBox(height: 20),
                          pw.Container(
                            child: pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Row(
                                  children: [
                                    // SvgPicture.asset(
                                    //   "a_assets/icons/bank.svg",
                                    //   color: MyColors.blackColor,
                                    // ),
                                    // wSizedBox1,
                                    pw.Container(
                                        width: 16,
                                        height: 18, child: pw.Image(assetImage)),
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      alignment: pw.Alignment.topLeft,
                                      child: pw.Text(
                                        delivery_method,
                                        // style: TextStyle(
                                        //     fontSize: 14,
                                        //     fontWeight: FontWeight.w500,
                                        //     fontFamily:
                                        //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                        //     color: MyColors.blackColor),
                                      ),
                                    ),
                                  ],
                                ),
                                /*     new Container(
                  // gray box
                  child: new Center(
                    child: new Transform(
                      child: SvgPicture.asset(
                        "a_assets/icons/arrow_left.svg",
                        color: MyColors.blackColor.withOpacity(0.10),
                      ),
                      alignment: FractionalOffset.center,
                      transform: new Matrix4.identity()
                        ..rotateZ(10 * 3.1415927 / 150),
                    ),
                  ),
                )*/
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 20),
                          pw.Container(
                            child: pw.Row(
                              children: [
                                // SvgPicture.asset(
                                //   "a_assets/icons/bank.svg",color: MyColors.blackColor,
                                // ),
                                pw.Container(
                                    width: 36,
                                    height: 36, child: pw.Image(assetImageBank)),
                                pw.SizedBox(width: 10),
                                pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      // width: MediaQuery.of(context).size.width/1.5,
                                      alignment: pw.Alignment.topLeft,
                                      child: pw.Text(
                                        bank_name,
                                        // style: TextStyle(
                                        //     fontSize: 16,
                                        //     fontWeight: FontWeight.w700,
                                        //     fontFamily:
                                        //     "s_asset/font/montserrat/Montserrat-Bold.otf",
                                        //     color: MyColors.blackColor),
                                      ),
                                    ),
                                    pw.SizedBox(height: 10),
                                    pw.Container(
                                      alignment: pw.Alignment.topLeft,
                                      child: pw.Text(
                                        account_number,
                                        // style: TextStyle(
                                        //     fontSize: 12,
                                        //     fontWeight: FontWeight.w500,
                                        //     fontFamily:
                                        //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                        //     color: MyColors.blackColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              )
          ),

          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    MyString.transaction_detail,
                    // style: TextStyle(
                    //     color: MyColors.blackColor,
                    //     fontSize: 14,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
                // Container(
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     MyString.view_detail,
                //     style: TextStyle(
                //         color: MyColors.lightblueColor,
                //         fontSize: 12,
                //         fontFamily:
                //             "s_asset/font/raleway/Raleway-SemiBold.ttf",
                //         fontWeight: FontWeight.w600),
                //   ),
                // ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),

          ///
          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    MyString.exchange_rate,
                    // style: TextStyle(
                    //     color: MyColors.blackColor.withOpacity(0.30),
                    //     fontSize: 12,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text(
                        "01.00",
                        // style: TextStyle(
                        //     color: MyColors.lightblueColor,
                        //     fontSize: 14,
                        //     fontFamily:
                        //     "s_asset/font/montserrat/MontserratAlternates-SemiBold.otf",
                        //     fontWeight: FontWeight.w600),
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text(
                        MyString.usd,
                        // style: TextStyle(
                        //     color: MyColors.blackColor,
                        //     fontSize: 9,
                        //     fontFamily:
                        //     "s_asset/font/raleway/Raleway-Medium.ttf",
                        //     fontWeight: FontWeight.w500),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    // SvgPicture.asset(
                    //   "a_assets/icons/small_swap.svg",
                    // ),
                    // wSizedBox1,
                    pw.Container(
                        width: 8,
                        height: 9, child: pw.Image(assetImageexc)),
                    pw.SizedBox(width: 10),
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text(
                        "${exchange_rate}",
                        // style: TextStyle(
                        //     color: MyColors.lightblueColor,
                        //     fontSize: 14,
                        //     fontFamily:
                        //     "s_asset/font/montserrat/MontserratAlternates-SemiBold.otf",
                        //     fontWeight: FontWeight.w600),
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text(
                        currency_code,
                        // style: TextStyle(
                        //     color: MyColors.blackColor,
                        //     fontSize: 9,
                        //     fontFamily:
                        //     "s_asset/font/raleway/Raleway-Medium.ttf",
                        //     fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 15),

          ///
          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    MyString.created_at,
                    // style: TextStyle(
                    //     color: MyColors.blackColor.withOpacity(0.30),
                    //     fontSize: 12,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    created_at==""?"":"${Utility.DatefomatToDateTime(created_at)}",
                    // style: TextStyle(
                    //     letterSpacing: 0.5,
                    //     color: MyColors.blackColor,
                    //     fontSize: 12,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 15),

          ///
          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    MyString.mtin,
                    // style: pw.TextStyle(
                    //     color: MyColors.blackColor.withOpacity(0.30),
                    //     fontSize: 12,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    mtin_number,
                    // style: TextStyle(
                    //     letterSpacing: 0.5,
                    //     color: MyColors.blackColor,
                    //     fontSize: 12,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),

          ///
          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    MyString.you_send,
                    // style: TextStyle(
                    //     color: MyColors.blackColor.withOpacity(0.30),
                    //     fontSize: 12,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
                pw. Row(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child:pw. Text(
                        you_send,
                        // style: TextStyle(
                        //     color: MyColors.blackColor,
                        //     fontSize: 14,
                        //     fontFamily:
                        //     "s_asset/font/raleway/Raleway-ExtraBold.ttf",
                        //     fontWeight: FontWeight.w800),
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text(
                        MyString.usd,
                        // style: TextStyle(
                        //     color: MyColors.blackColor,
                        //     fontSize: 8,
                        //     fontFamily:
                        //     "s_asset/font/raleway/Raleway-SemiBold.ttf",
                        //     fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          pw.SizedBox(height: 10),

          ///
          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    MyString.fees,
                    // style: TextStyle(
                    //     color: MyColors.blackColor.withOpacity(0.30),
                    //     fontSize: 12,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text(
                        widget.fees,
                        // fees,
                        // style: TextStyle(
                        //     color: MyColors.blackColor,
                        //     fontSize: 14,
                        //     fontFamily:
                        //     "s_asset/font/raleway/Raleway-ExtraBold.ttf",
                        //     fontWeight: FontWeight.w800),
                      ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Text(
                        MyString.usd,
                        // style: TextStyle(
                        //     color: MyColors.blackColor,
                        //     fontSize: 8,
                        //     fontFamily:
                        //     "s_asset/font/raleway/Raleway-SemiBold.ttf",
                        //     fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),

          // pw.Container(
          //   padding: pw.EdgeInsets.symmetric(horizontal: 20),
          //   height: 0.5,
          //   child: pw.DottedBorder(
          //     color: Color(0xffE9EDF2),
          //     strokeWidth: 0.5,
          //     dashPattern: [8, 4],
          //     child: Container(),
          //   ),
          // ),
          // hSizedBox3,

          ///
          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    MyString.total,
                    // style: TextStyle(
                    //     color: MyColors.blackColor.withOpacity(0.30),
                    //     fontSize: 12,
                    //     fontFamily:
                    //     "s_asset/font/raleway/Raleway-Medium.ttf",
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
                pw.Row(children: [
                  pw.Container(
                    alignment: pw.Alignment.topLeft,
                    child: pw.Text(
                      "${total_amount}",
                      // style: TextStyle(
                      //     color: MyColors.blackColor,
                      //     fontSize: 20,
                      //     fontFamily:
                      //     "s_asset/font/raleway/Raleway-ExtraBold.ttf",
                      //     fontWeight: FontWeight.w800),
                    ),
                  ),
                  pw.SizedBox(width: 5),
                  pw.Container(
                    alignment: pw.Alignment.topLeft,
                    child: pw.Text(
                      MyString.usd,
                      // style: TextStyle(
                      //     color: MyColors.blackColor,
                      //     fontSize: 10,
                      //     fontFamily:
                      //     "s_asset/font/raleway/Raleway-SemiBold.ttf",
                      //     fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
              ],
            ),
          ),

          // hSizedBox2,
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     children: [
          //       Image.asset(
          //         "a_assets/logo/bank2.png",
          //       ),
          //       wSizedBox1,
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Container(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               MyString.rbl_banl,
          //               style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w700,
          //                   fontFamily:
          //                       "s_asset/font/montserrat/Montserrat-Bold.otf",
          //                   color: MyColors.blackColor),
          //             ),
          //           ),
          //           hSizedBox,
          //           Container(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               "Account - 9560",
          //               style: TextStyle(
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w500,
          //                   fontFamily:
          //                       "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
          //                   color: MyColors.blackColor),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // hSizedBox2,

          pw.SizedBox(height: 20),

          /// alert strings................

          pw.Container(
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(
                "Times may vary but we estimate the recipient will receive funds 2 business days, Some receiving financial institutions may charge additional fees; foreign taxes may apply\nToll Free No: (855) 411-237\n\nMoneytos may earn revenue from the conversion of USD to other countries.",
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor,
                //     letterSpacing: 0.7)),
          ),
          ),
    pw.SizedBox(height: 20),

          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.consumer_fraud_alert,
                // style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w500,
                //     fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",
                //     color: MyColors.blackColor,
                //     letterSpacing: 0.7)
        ),
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.consumer_fraud_alert_des,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.consumer_fraud_alert_des1,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.lightblueColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),

          ///
          pw.SizedBox(height: 20),

          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.minnesota_dept_of_commerce,
                // style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w500,
                //     fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",
                //     color: MyColors.blackColor,
                //     letterSpacing: 0.7)
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.minnesota_dept_of_commerce_des1,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw. Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.minnesota_dept_of_commerce_des2,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.minnesota_dept_of_commerce_des3,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.lightblueColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),

          pw.SizedBox(
            height: 5,
          ),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.minnesota_dept_of_commerce_des4,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.lightblueColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.minnesota_dept_of_commerce_des5,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.minnesota_dept_of_commerce_des6,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),

          pw.SizedBox(
            height: 5,
          ),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.minnesota_dept_of_commerce_des7,
                // style: pw.TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),

          ///
          pw.SizedBox(height: 20),

          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.consumer_Financial_Protection_Bureau,
                style: pw.TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.7)),
          ),
          pw.SizedBox(height: 10),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(
                MyString.consumer_finencial_legal_des,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),

          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(
                MyString.consumer_Financial_Protection_Bureau_des1,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.lightblueColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),

          ///
          ///

          ///
          pw.SizedBox(height: 10),

          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(MyString.Moneytos_llc,
                // style: TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w500,
                //     fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",
                //     color: MyColors.blackColor,
                //     letterSpacing: 0.7)
            ),
          ),
          // hSizedBox1,
          pw. Container(
            alignment:pw. Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(
                MyString.Moneytos_llc_des1,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.blackColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(
                MyString.phone_not_available,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.lightblueColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),
          pw.SizedBox(
            height: 5,
          ),
          pw.Container(
            alignment: pw.Alignment.topLeft,
            padding: pw.EdgeInsets.symmetric(horizontal: 20),
            child: pw.Text(
                MyString.Moneytos_llc_des2,
                // style: TextStyle(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w500,
                //     fontFamily:
                //     "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                //     color: MyColors.lightblueColor.withOpacity(0.70),
                //     letterSpacing: 0.7)
            ),
          ),

          /* hSizedBox2,

                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(MyString.consumer_Financial_Protection_Bureau,
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",color: MyColors.blackColor,letterSpacing: 0.7)),
                          ),
                          hSizedBox1,
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(MyString.consumer_Financial_Protection_Bureau_des,
                                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/montserrat/MontserratAlternates-Medium.otf",color: MyColors.blackColor.withOpacity(0.70),letterSpacing: 0.7)),
                          ),
*/

          // hSizedBox6,

        ],
      )
    );
    final directory = Platform.isAndroid
        ? Directory('/storage/emulated/0/Documents') //FOR ANDROID
        // ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationDocumentsDirectory();
    final dirPath = '${directory.path}/moneytosfolder' ;
    print("dirPath>>>>> "+dirPath);
    final dirPathnew = await new Directory(dirPath).create();
    // File file2 = File("${dirPathnew.path}/"+first_name+".png");
    // await file2.writeAsBytes(capturedImage!);
    Utility.showFlutterToast( "Receipt Download Successfully");
    final file = File("${dirPathnew.path}/"+first_name+".pdf");

    //? Directory('/storage/emulated/0/Download')
    //download platform condition
    if(Platform.isAndroid){
      await file.writeAsBytes(await pdf.save());
    }else{
      await file.writeAsBytes(await pdf.save());
      await FlutterShare.shareFile(
          title: 'Save File',
          filePath: file.path,
          fileType: 'pdf'
      );
    }

  }

  //initial state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>txnDetailapi(context));
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.primaryColor,
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            // color: MyColors.whiteColor,
            //  margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      CupertinoIcons.clear,
                      color: MyColors.whiteColor,
                    )),
                Text(
                  "Receipt",
                  style: TextStyle(
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      fontFamily:
                      "s_asset/font/raleway/raleway_extrabold.ttf"),
                ),
                InkWell(
                  onTap: (){
                    // screenshotController
                    //     .capture(delay: Duration(milliseconds: 10))
                    //     .then((capturedImage) async {
                    //   print(capturedImage);
                    //   // final directory = await getExternalStorageDirectory();
                    //   final directory = Platform.isAndroid
                    //       ? await getExternalStorageDirectory() //FOR ANDROID
                    //       : await getApplicationDocumentsDirectory();
                    //   final dirPath = '${directory!.path}/moneytosfolder' ;
                    //   print("dirPath>>>>> "+dirPath);
                    //   final dirPathnew = await new Directory(dirPath).create();
                    //   File file2 = File("${dirPathnew.path}/"+first_name+".png");
                    //   await file2.writeAsBytes(capturedImage!);
                    //   Fluttertoast.showToast(msg: "Receipt Download Successfully");
                    // }).catchError((onError) {
                    //   print(onError);
                    // });
                    mainpdfave();
                  },
                  child: Text(
                    "Download",
                    style: TextStyle(
                        color: MyColors.lightblueColor,
                        fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: is_load?Container(
        height: size.width,
        width: size.height,
        child: Center(
            child:GFLoader(
                type: GFLoaderType.custom,
                child: Image(image: AssetImage("a_assets/logo/progress_image.png"),
                ))
        ),
      ):Screenshot(
        controller: screenshotController,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        MyColors.primaryColor,
                        MyColors.color_03153B,
                      ])),
              //  color: MyColors.color_03153B,
            ),
            Container(
              //margin: EdgeInsets.only(top: size.height /9),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors.whiteColor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox3,
                    usercard(),
                    hSizedBox2,
                    deliveryMethid(),
                    hSizedBox3,

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              MyString.transaction_detail,
                              style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontSize: 14,
                                  fontFamily:
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          // Container(
                          //   alignment: Alignment.topLeft,
                          //   child: Text(
                          //     MyString.view_detail,
                          //     style: TextStyle(
                          //         color: MyColors.lightblueColor,
                          //         fontSize: 12,
                          //         fontFamily:
                          //             "s_asset/font/raleway/Raleway-SemiBold.ttf",
                          //         fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    hSizedBox3,

                    ///
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "01.00",
                                  style: TextStyle(
                                      color: MyColors.lightblueColor,
                                      fontSize: 14,
                                      fontFamily:
                                      "s_asset/font/montserrat/MontserratAlternates-SemiBold.otf",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              wSizedBox,
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.usd,
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 9,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_medium.ttf",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              wSizedBox1,
                              SvgPicture.asset(
                                "a_assets/icons/small_swap.svg",
                              ),
                              wSizedBox1,
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${exchange_rate}",
                                  style: TextStyle(
                                      color: MyColors.lightblueColor,
                                      fontSize: 14,
                                      fontFamily:
                                      "s_asset/font/montserrat/MontserratAlternates-SemiBold.otf",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              wSizedBox,
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  currency_code,
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 9,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_medium.ttf",
                                      fontWeight: FontWeight.w500),
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              created_at==""?"":"${created_at}",
                              style: TextStyle(
                                  letterSpacing: 0.5,
                                  color: MyColors.blackColor,
                                  fontSize: 12,
                                  fontFamily:
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),

                    hSizedBox1,
                    hSizedBox,

                    ///
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              mtin_number,
                              style: TextStyle(
                                  letterSpacing: 0.5,
                                  color: MyColors.blackColor,
                                  fontSize: 12,
                                  fontFamily:
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    hSizedBox4,

                    ///
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  double.parse(you_send).toStringAsFixed(2),
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 14,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_extrabold.ttf",
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              wSizedBox,
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.usd,
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 8,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_semibold.ttf",
                                      fontWeight: FontWeight.w500),
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
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  // widget.fees,
                                  fees,
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 14,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_extrabold.ttf",
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              wSizedBox,
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.usd,
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: 8,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_semibold.ttf",
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    hSizedBox3,

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 0.5,
                      child: DottedBorder(
                        color: Color(0xffE9EDF2),
                        strokeWidth: 0.5,
                        dashPattern: [8, 4],
                        child: Container(),
                      ),
                    ),
                    hSizedBox3,

                    ///
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  "s_asset/font/raleway/raleway_medium.ttf",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${total_amount}",
                                style: TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 20,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_extrabold.ttf",
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            wSizedBox,
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                MyString.usd,
                                style: TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 10,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_semibold.ttf",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),

                    // hSizedBox2,
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   child: Row(
                    //     children: [
                    //       Image.asset(
                    //         "a_assets/logo/bank2.png",
                    //       ),
                    //       wSizedBox1,
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             alignment: Alignment.topLeft,
                    //             child: Text(
                    //               MyString.rbl_banl,
                    //               style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w700,
                    //                   fontFamily:
                    //                       "s_asset/font/montserrat/Montserrat-Bold.otf",
                    //                   color: MyColors.blackColor),
                    //             ),
                    //           ),
                    //           hSizedBox,
                    //           Container(
                    //             alignment: Alignment.topLeft,
                    //             child: Text(
                    //               "Account - 9560",
                    //               style: TextStyle(
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w500,
                    //                   fontFamily:
                    //                       "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                    //                   color: MyColors.blackColor),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // hSizedBox2,

                    hSizedBox2,

                    /// alert strings................

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          "Times may vary but we estimate the recipient will receive funds 2 business days, Some receiving financial institutions may charge additional fees; foreign taxes may apply\nToll Free No: (855) 411-237\n\nMoneytos may earn revenue from the conversion of USD to other countries.",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor,
                              letterSpacing: 0.7)),
                    ),
                    hSizedBox2,

                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.consumer_fraud_alert,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "s_asset/font/raleway/raleway_bold.ttf",
                              color: MyColors.blackColor,
                              letterSpacing: 0.7)),
                    ),
                    hSizedBox1,
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.consumer_fraud_alert_des,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.consumer_fraud_alert_des1,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.lightblueColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),

                    ///
                    hSizedBox2,

                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.minnesota_dept_of_commerce,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "s_asset/font/raleway/raleway_bold.ttf",
                              color: MyColors.blackColor,
                              letterSpacing: 0.7)),
                    ),
                    hSizedBox1,
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.minnesota_dept_of_commerce_des1,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.minnesota_dept_of_commerce_des2,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.minnesota_dept_of_commerce_des3,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.lightblueColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.minnesota_dept_of_commerce_des4,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.lightblueColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.minnesota_dept_of_commerce_des5,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.minnesota_dept_of_commerce_des6,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.minnesota_dept_of_commerce_des7,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),

                    ///
                    hSizedBox2,

                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.consumer_Financial_Protection_Bureau,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "s_asset/font/raleway/raleway_bold.ttf",
                              color: MyColors.blackColor,
                              letterSpacing: 0.7)),
                    ),
                    hSizedBox1,
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          MyString.consumer_finencial_legal_des,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          MyString.consumer_Financial_Protection_Bureau_des1,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.lightblueColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),

                    ///
                    ///

                    ///
                    hSizedBox2,

                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(MyString.Moneytos_llc,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "s_asset/font/raleway/raleway_bold.ttf",
                              color: MyColors.blackColor,
                              letterSpacing: 0.7)),
                    ),
                    hSizedBox1,
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          MyString.Moneytos_llc_des1,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          MyString.phone_not_available,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.lightblueColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          MyString.Moneytos_llc_des2,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.lightblueColor.withOpacity(0.70),
                              letterSpacing: 0.7)),
                    ),

                    /* hSizedBox2,

                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(MyString.consumer_Financial_Protection_Bureau,
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",color: MyColors.blackColor,letterSpacing: 0.7)),
                          ),
                          hSizedBox1,
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(MyString.consumer_Financial_Protection_Bureau_des,
                                style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/montserrat/MontserratAlternates-Medium.otf",color: MyColors.blackColor.withOpacity(0.70),letterSpacing: 0.7)),
                          ),
*/

                    hSizedBox6,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  stepprogressbar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "a_assets/logo/check_mark.svg",
                    // height: 20,
                    // width: 20,
                    //height: 100,
                  ),
                  wSizedBox,
                  Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        color: MyColors.lightblueColor.withOpacity(0.90),
                        value: 0.60,
                      ),
                    ),
                  ),
                  wSizedBox,
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: MyColors.yellow,
                    ),
                    child: Center(
                      child: Icon(
                        CupertinoIcons.checkmark_alt,
                        color: MyColors.whiteColor,
                        size: 15,
                      ),
                    ),
                  ),
                  wSizedBox,
                  Container(
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        color: MyColors.lightblueColor.withOpacity(0.90),
                        value: 0.60,
                      ),
                    ),
                  ),
                  wSizedBox,
                  SvgPicture.asset(
                    "a_assets/logo/light_checkmark.svg",
                    height: 20,
                    width: 20,
                    //height: 100,
                  ),
                ],
              ),
            ),
            hSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyColors.lightblueColor.withOpacity(0.20),
                  ),
                  child: Text(
                    MyString.on_its_way,
                    style: TextStyle(
                        color: MyColors.primaryColor.withOpacity(0.60),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyColors.yellow.withOpacity(0.20),
                  ),
                  child: Text(
                    MyString.with_partner,
                    style: TextStyle(
                        color: MyColors.yellow.withOpacity(0.70),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyColors.greenColor.withOpacity(0.20),
                  ),
                  child: Text(
                    MyString.completed,
                    style: TextStyle(
                        color: MyColors.greenColor.withOpacity(0.70),
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// usercard...
  usercard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.lightblueColor.withOpacity(0.06)),
      child: Column(
        children: [
          /// top
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: MyColors.lightblueColor.withOpacity(0.09),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: FadeInImage(
                    height: 200,width: 200,
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      rec_image,),
                    placeholder: AssetImage(
                        "a_assets/logo/progress_image.png"),
                    placeholderFit: BoxFit.scaleDown,
                    imageErrorBuilder:
                        (context, error, stackTrace) {
                      return Container(
                          color: MyColors.divider_color,
                          alignment:Alignment.center,child: Text(first_name.toString()[0].toUpperCase(),style: TextStyle(
                          color: MyColors.shedule_color,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: "s_asset/font/raleway/raleway_bold.ttf")));
                    },
                  ),
                ),
              ),
              wSizedBox1,
              wSizedBox,
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${first_name} ${last_name}",
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily:
                            "s_asset/font/raleway/raleway_semibold.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    hSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "(+${phone_code}) ${phone_number}",
                        style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.50),
                            fontSize: 12,
                            fontFamily:
                            "s_asset/font/raleway/raleway_medium.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
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
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Will Receive",
                        style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.50),
                            fontSize: 12,
                            fontFamily:
                            "s_asset/font/raleway/raleway_medium.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    hSizedBox,
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${double.parse(will_recieve).toStringAsFixed(2)}",
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 14,
                                fontFamily:
                                "s_asset/font/montserrat/Montserrat-ExtraBold.otf",
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        wSizedBox,

                        /// aud
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            currency_code,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 8,
                                fontFamily:
                                "s_asset/font/raleway/raleway_semibold.ttf",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// right text
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Transfer Reason",
                        style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.50),
                            fontSize: 12,
                            fontFamily:
                            "s_asset/font/raleway/raleway_medium.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    hSizedBox,
                    Row(
                      children: [
                        Container(
                          width: 120,
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.transfer_reason,
                            style: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 14,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.lightblueColor.withOpacity(0.06)),
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
                  "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                  color: MyColors.blackColor.withOpacity(0.30)),
            ),
          ),
          hSizedBox2,
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "a_assets/icons/bank.svg",
                      color: MyColors.blackColor,
                    ),
                    wSizedBox1,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        delivery_method,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                            "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                            color: MyColors.blackColor),
                      ),
                    ),
                  ],
                ),
                /*     new Container(
                  // gray box
                  child: new Center(
                    child: new Transform(
                      child: SvgPicture.asset(
                        "a_assets/icons/arrow_left.svg",
                        color: MyColors.blackColor.withOpacity(0.10),
                      ),
                      alignment: FractionalOffset.center,
                      transform: new Matrix4.identity()
                        ..rotateZ(10 * 3.1415927 / 150),
                    ),
                  ),
                )*/
              ],
            ),
          ),
          hSizedBox2,
          Container(
            child: Row(
              children: [
                SvgPicture.asset(
                  "a_assets/icons/bank4.svg",
                ),
                wSizedBox1,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.6,
                      alignment: Alignment.topLeft,
                      child: Text(
                        bank_name,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                            "s_asset/font/montserrat/Montserrat-Bold.otf",
                            color: MyColors.blackColor),
                      ),
                    ),
                    hSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        account_number,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                            "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                            color: MyColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future <void> txnDetailapi(BuildContext context) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};
    request['recipient_id'] = sharedPreferences.getString("recpi_id").toString();


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(Apiservices.txnDetailapi+"?txn_id="+widget.txnId),
        // body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
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
      account_number = txnDetailResponse.data!.recipientReceiveMethodLast4digit.toString();

      exchange_rate = txnDetailResponse.data!.exchangeRate.toString();
      created_at = txnDetailResponse.data!.newCreatedAt.toString();
      mtin_number = txnDetailResponse.data!.confirmationNumber.toString();
      you_send = txnDetailResponse.data!.sendAmount.toString();
      currency_code = txnDetailResponse.data!.receivingCurrency.toString();
      fees =  txnDetailResponse.data!.monyetosfee.toString();

      you_send = txnDetailResponse.data!.sendAmount.toString();
      // fees = txnDetailResponse.data!.monyetosfee.toString();
      will_recieve = txnDetailResponse.data!.recipientRecivedAmout.toString();
      total_amount = (double.parse(txnDetailResponse.data!.sendAmount.toString())+double.parse(txnDetailResponse.data!.monyetosfee.toString())).toString();
      total_amount = double.parse(double.parse(total_amount).toStringAsFixed(2)).toString();

      setState(() {

      });
    } else {
      setState(() {

      });
    }
    return;
  }
  Future <void> TransfersApi(BuildContext context,String readyremit_transferId) async {
    // Utility.ProgressloadingDialog(context, true);
    is_load = true;
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(AllApiService.TransfersURL+"/"+readyremit_transferId),
        // body: convert.jsonEncode(request),
        headers: {
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      // Utility.ProgressloadingDialog(context, false);
      //
      is_load = false;

      var recipientDetailsfieldsList =   jsonResponse["recipientDetails"]["fields"];
      first_name = jsonResponse["recipientDetails"]["firstName"];
      last_name = jsonResponse["recipientDetails"]["lastName"];
      for(int i = 0 ; i< recipientDetailsfieldsList.length ;i++){
        print("fields response>>>> "+recipientDetailsfieldsList[i]["id"]);
        if(recipientDetailsfieldsList[i]["id"]=="PHONE_NUMBER"){
          phone_number = recipientDetailsfieldsList[i]["value"]["number"].toString();
          phone_code = recipientDetailsfieldsList[i]["value"]["countryPhoneCode"].toString();
        }
      }

      will_recieve = jsonResponse["quote"]["receiveAmount"]["value"].toString();
      // transfer_reason = jsonResponse["quote"]["sendAmount"]["value"];
      delivery_method = jsonResponse["recipientAccountDetails"]["transferMethod"].toString();

      var recipientAccountDetailsfieldsList =   jsonResponse["recipientAccountDetails"]["fields"];

      for(int i = 0 ; i< recipientAccountDetailsfieldsList.length ;i++){
        print("fields response>>>> "+recipientAccountDetailsfieldsList[i]["id"]);
        if(recipientAccountDetailsfieldsList[i]["id"]=="BANK_NAME"){
          bank_name = recipientAccountDetailsfieldsList[i]["value"].toString();
        }
        if(recipientAccountDetailsfieldsList[i]["id"]=="BANK_ACCOUNT_NUMBER"){
          account_number = recipientAccountDetailsfieldsList[i]["value"].toString();
        }
      }

      exchange_rate = jsonResponse["quote"]["rate"].toString();
      try {
        exchange_rate = double.parse(exchange_rate).toStringAsFixed(2);
      } catch(Exception) {
        exchange_rate = jsonResponse["quote"]["rate"].toString();
      }
      created_at = jsonResponse["createdAt"].toString();
      mtin_number = jsonResponse["confirmationNumber"].toString();
      you_send = jsonResponse["quote"]["sendAmount"]["value"].toString();
      currency_code = jsonResponse["quote"]["destinationCurrencyISO3Code"].toString();

      var quoteadjustmentsList =   jsonResponse["quote"]["adjustments"];

      for(int i = 0 ; i< quoteadjustmentsList.length ;i++){
        if(quoteadjustmentsList[i]["label"]=="Transfer Fee"){
          fees = quoteadjustmentsList[i]["amount"]["value"].toString();
        }
      }

      you_send = (double.parse(you_send)/100).toString();
      fees = (double.parse(fees)/100).toString();
      will_recieve = (double.parse(will_recieve)/100).toString();
      total_amount = (double.parse(you_send)+double.parse(widget.fees)).toString();
      total_amount = double.parse(double.parse(total_amount).toStringAsFixed(2)).toString();

      setState(() {

      });
    } else {
      // Utility.ProgressloadingDialog(context, false);
      is_load = false;

      setState(() {

      });
    }
    return;
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }
}
