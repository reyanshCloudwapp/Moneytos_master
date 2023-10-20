import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';

import '../../constance/myColors/mycolor.dart';
import '../../constance/myStrings/myString.dart';
import '../../constance/sizedbox/sizedBox.dart';

class LegalResourcesScreen extends StatefulWidget {
  const LegalResourcesScreen({Key? key}) : super(key: key);

  @override
  State<LegalResourcesScreen> createState() => _LegalResourcesScreenState();
}

class _LegalResourcesScreenState extends State<LegalResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(22, 30, 20, 0),
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
                    margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                    child: const Text(
                      MyString.legal_resorces,
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
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: MyColors.whiteColor,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      hSizedBox3,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(MyString.minnesota_dept_of_commerce,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor,
                                letterSpacing: 0.7)),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.minnesota_dept_of_commerce_des1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.minnesota_dept_of_commerce_des2,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.minnesota_dept_of_commerce_des3,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.lightblueColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.minnesota_dept_of_commerce_des4,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.lightblueColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.minnesota_dept_of_commerce_des5,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(MyString.minnesota_dept_of_commerce_des6,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(MyString.consumer_Financial_Protection_Bureau,
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            MyString.consumer_finencial_legal_des1,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                color: MyColors.blackColor.withOpacity(0.70),
                                letterSpacing: 0.7)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      hSizedBox2,

                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(MyString.Moneytos_llc,
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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

                      hSizedBox2,

                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(MyString.privacypolicy,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor,
                                letterSpacing: 0.7)),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      InkWell(
                        onTap: (){
                          Utility().launchUrl(AllApiService.personabashurl+"terms-conditions");
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              AllApiService.personabashurl+"privacy-policy",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily:
                                  "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                  color: MyColors.lightblueColor.withOpacity(0.70),
                                  letterSpacing: 0.7)),
                        ),
                      ),

                      hSizedBox2,

                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(MyString.termscondition,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "s_asset/font/raleway/raleway_bold.ttf",
                                color: MyColors.blackColor,
                                letterSpacing: 0.7)),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      InkWell(
                        onTap:
                        (){
                          Utility().launchUrl(AllApiService.personabashurl+"terms-conditions");
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              AllApiService.personabashurl+"terms-conditions",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily:
                                  "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                  color: MyColors.lightblueColor.withOpacity(0.70),
                                  letterSpacing: 0.7)),
                        ),
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
