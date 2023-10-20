import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../constance/myColors/mycolor.dart';
import '../../constance/myStrings/myString.dart';
import '../../constance/sizedbox/sizedBox.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _LegalResourcesScreenState();
}

class _LegalResourcesScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(22, 30, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      "s_asset/images/leftarrow.svg",
                        height: 32,
                        width: 32
                    )),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                    child: Text(
                      "FAQs",
                      style: TextStyle(
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          fontFamily:
                          "s_asset/font/raleway/raleway_extrabold.ttf"),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              color: MyColors.light_primarycolor2,
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: MyColors.whiteColor,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                     /* hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.our_story,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                "s_asset/font/raleway/Raleway-Bold.ttf",
                                color: MyColors.blackColor.withOpacity(0.80),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.our_story_des,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),
                    hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.our_story_des1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),

                      hSizedBox5,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.meet_our_team,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),
                      ///
                      hSizedBox4,

                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.mohamed_Ahmed,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",
                                color: MyColors.blackColor,
                                letterSpacing: 0.7)),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            MyString.ceo_,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),


                      ///
                      hSizedBox4,

                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Shahriyar_Khan,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",
                                color: MyColors.blackColor,
                                letterSpacing: 0.7)),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            MyString.cto_,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),


                      ///
                      hSizedBox4,

                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.SalmaAhmed,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",
                                color: MyColors.blackColor,
                                letterSpacing: 0.7)),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            MyString.coo,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),*/
                      hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_first_que,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor.withOpacity(0.80),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_first_ans,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_second_que,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor.withOpacity(0.80),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_second_ans,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_third_que,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor.withOpacity(0.80),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_third_ans,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_fourth_que,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor.withOpacity(0.80),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_fourth_ans,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_fifth_ques,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor.withOpacity(0.80),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_fifth_ans,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_sixth_ques,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor.withOpacity(0.80),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_sixth_ans,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_seven_que,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor.withOpacity(0.80),
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        margin: EdgeInsets.only(bottom: 50),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.Faq_seven_ans,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.50),
                                letterSpacing: 0.7)),
                      ),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
