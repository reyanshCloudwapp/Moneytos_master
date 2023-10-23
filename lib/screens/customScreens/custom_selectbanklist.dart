import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytos/utils/constance/myColors/mycolor.dart';

class CustomSelectBankList extends StatelessWidget {
  final String title, img;

  const CustomSelectBankList({Key? key, this.title = '', required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: MyColors.blackColor.withOpacity(0.20),
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(img),
          // hSizedBox1,
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: MyColors.color_text,
              fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
