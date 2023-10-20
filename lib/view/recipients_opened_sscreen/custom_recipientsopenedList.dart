import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';

class CustomRecipientOpenedCardList extends StatelessWidget {
  String title, icon, subtitle, iban;
  Color bordercolor;
  bool status = false;

  CustomRecipientOpenedCardList(
      {Key? key,
      required this.title,
      required this.icon,
      required this.subtitle,
      required this.bordercolor,
      this.status = false,
      this.iban = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.45,
      child: Material(
        elevation: 0.4,
        color: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: bordercolor, width: 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 120,
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            fontFamily:
                                "s_asset/font/raleway/raleway_semibold.ttf"),
                      )),
                  /*  status == true ?    Padding(
                    padding:  EdgeInsets.only(top: 0.0,right: 1),
                    child: SvgPicture.asset(icon,color: MyColors.blackColor,height: 20,width: 20,),
                  ) : Container(),
                  status == true ?   Padding(
                    padding:  EdgeInsets.only(top: 0.0,right: 1),
                    child: SvgPicture.asset("a_assets/icons/delete.svg",height: 20,width: 20,),
                  ): Container(),
*/
                ],
              ),
              hSizedBox2,
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    iban,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                  )),
              hSizedBox1,
              hSizedBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, right: 1),
                    child: SvgPicture.asset(
                      "a_assets/icons/bank.svg",
                      height: 20,
                      width: 20,
                      color: subtitle == "Mobile Money"
                          ? MyColors.blackColor
                          : MyColors.lightblueColor,
                    ),
                  ),
                  wSizedBox1,
                  wSizedBox,
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        subtitle,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: subtitle == "Mobile Money"
                                ? MyColors.blackColor
                                : MyColors.lightblueColor.withOpacity(0.80),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
