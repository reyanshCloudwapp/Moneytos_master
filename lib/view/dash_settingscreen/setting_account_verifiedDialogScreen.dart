import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';

import '../../constance/sizedbox/sizedBox.dart';

class SettingAccountVerifiedDialogScreen extends StatefulWidget {
  SettingAccountVerifiedDialogScreen({Key? key}) : super(key: key);

  @override
  State<SettingAccountVerifiedDialogScreen> createState() =>
      _SettingAccountVerifiedDialogScreenState();
}

class _SettingAccountVerifiedDialogScreenState
    extends State<SettingAccountVerifiedDialogScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox5,
            Container(
                alignment: Alignment.center,
                child: SvgPicture.asset("a_assets/logo/verified_img.svg")),
            hSizedBox5,
            Container(
              alignment: Alignment.center,
              child: Text(
                MyString.account_verified,
                style: TextStyle(
                    color: MyColors.light_blueColor.withOpacity(0.80),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
              ),
            ),
            hSizedBox1,
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width / 10),
              alignment: Alignment.center,
              child: Text(
                MyString.account_verified_des,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.60),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                    fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
              ),
            ),
            hSizedBox2,
            hSizedBox2,
            Container(
                alignment: Alignment.center,
                child: SvgPicture.asset("a_assets/logo/passport.svg")),
            hSizedBox,
            Container(
              alignment: Alignment.center,
              child: Text(
                MyString.passport,
                style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.80),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
              ),
            ),
            hSizedBox3
          ],
        ),
      ),
    );
  }

  Cameracard(String img) {
    return Container(
      height: 110,
      //  padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          //  stops: [0.0, 1.0],
          colors: [
            MyColors.color_3F84E5.withOpacity(0.06),
            MyColors.color_3F84E5.withOpacity(0.30),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(img),
        ],
      ),
    );
  }
}
