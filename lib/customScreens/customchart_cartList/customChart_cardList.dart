import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';

class CustomChartCardList extends StatelessWidget {
  String recipient_name;
  String img;
  String amount;
  String totalamount;


  CustomChartCardList({Key? key,required this.recipient_name,required this.img,required this.amount,required this.totalamount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: MyColors
                          .lightblueColor
                          .withOpacity(0.05),
                    ),
                    height: 40,
                    width: 40,
                    
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: FadeInImage(
                        height: 200,width: 200,
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          img.toString(),),
                        placeholder: AssetImage(
                            "a_assets/logo/progress_image.png"),
                        placeholderFit: BoxFit.scaleDown,
                        imageErrorBuilder:
                            (context, error, stackTrace) {
                          return Container(
                              color: MyColors.divider_color,
                              alignment:Alignment.center,child: Text(recipient_name.toString()[0].toUpperCase(),style: TextStyle(
                              color: MyColors.shedule_color,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "s_asset/font/raleway/raleway_bold.ttf")));
                        },
                      ),
                    ),
                    // backgroundImage: NetworkImage(recipientList[index].profileImage.toString()),
                  ),
                  /*CircleAvatar(
                    radius: 20,
                    backgroundImage: img.isEmpty ?  AssetImage("a_assets/logo/profile_img.png",) : NetworkImage(url),
                  ),*/
                  wSizedBox1,
                  ///Recipient name
                  Container(
                    width: 160,
                    alignment: Alignment.topLeft,
                    child: Text(recipient_name,style: TextStyle(color: MyColors.blackColor,fontWeight: FontWeight.w500,fontSize: 15,letterSpacing: 0.5),),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      alignment: Alignment.topLeft,
                      child: Text(double.parse(amount).toStringAsFixed(2),style: TextStyle(color: MyColors.blackColor,fontSize: 24,fontWeight: FontWeight.w600),),
                    ),
                    wSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(MyString.usd,style: TextStyle(color: MyColors.blackColor,fontSize: 12,fontWeight: FontWeight.w700),),
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSizedBox1,
          hSizedBox,
          LinearProgressIndicator(
            value: double.parse(totalamount)/double.parse(amount),
            color: MyColors.lightblueColor,
            semanticsLabel: 'Linear progress indicator',
          ),
          hSizedBox1,
        ],
      ),
    );
  }
}
