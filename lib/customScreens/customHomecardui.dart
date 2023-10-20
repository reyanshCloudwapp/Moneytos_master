import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';

import '../s_Api/S_ApiResponse/LatestTransferResponse.dart';
import '../s_Api/s_utils/Utility.dart';

class CustomHomeCardList extends StatelessWidget {
  Color bg_color;
  TxnSubData txnSubData;

  CustomHomeCardList({Key? key, required this.bg_color,required this.txnSubData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      // height:  size.height * 0.3,
      width: 165,
      child: Material(
        color: MyColors.whiteColor,
        elevation: 0.6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: wh
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: MyColors.lightblueColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FadeInImage(
                    height: 156,width: 149,
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      txnSubData.profileImage.toString(),),
                    placeholder: const AssetImage(
                        "a_assets/logo/progress_image.png"),
                    placeholderFit: BoxFit.scaleDown,
                    imageErrorBuilder:
                        (context, error, stackTrace) {
                      return Text(txnSubData.recipientName.toString()[0].toUpperCase());
                    },
                  ),
                ),
              ),
              // hSizedBox1,
              hSizedBox1,

              ///Recipient name
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  txnSubData.recipientName.toString(),
                  style: const TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                      fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                ),
              ),
              hSizedBox1,

              ///Today, 03:27pm
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                    txnSubData.createdAt.toString(),
                  // Utility.CurrentDate()==(txnSubData.createdAt.toString().split("T")[0])?"Today "+Utility.DatefomatToTime(txnSubData.createdAt.toString()):Utility.DatefomatToDateTime(txnSubData.createdAt.toString()),
                  style: TextStyle(
                      color: MyColors.blackColor.withOpacity(0.40),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.03,
                      fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                ),
              ),
              hSizedBox1,


              ///USd
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      txnSubData.sendAmount.toString(),
                      style: const TextStyle(
                          color: MyColors.lightblueColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          letterSpacing: 0.5,

                          fontFamily:
                          "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),
                    ),
                  ),
                  wSizedBox1,
                  Container(
                    padding: const EdgeInsets.only(top: 2),
                    alignment: Alignment.topLeft,
                    child: Text(
                      MyString.usd,
                      style: TextStyle(
                          color: MyColors.lightblueColor.withOpacity(0.90),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                          fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                    ),
                  ),
                ],
              ),

              hSizedBox2,
              // hSizedBox1,

              /// Button
              ///
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: bg_color,
                ),
                child: Text(
                  txnSubData.readyremitStatus.toString(),
                  style: TextStyle(
                      color: txnSubData.readyremitStatus == "pending"
                          ? MyColors.dark_yellow
                          : MyColors.greenColor2.withOpacity(
                          0.60),
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
