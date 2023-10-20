import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/transfers_scheduled_screens/face_and_touchid_screen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/treansfer_enter_pin_code.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../constance/custombuttom/CustomButton.dart';
import '../../constance/myColors/mycolor.dart';
import '../../constance/myStrings/myString.dart';

class TransferReview_andConfirmScreen extends StatefulWidget {
  const TransferReview_andConfirmScreen({Key? key}) : super(key: key);

  @override
  State<TransferReview_andConfirmScreen> createState() => _TransferReview_andConfirmScreenState();
}

class _TransferReview_andConfirmScreenState extends State<TransferReview_andConfirmScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Shivangi the nani pari>>>> ");
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: MyColors.light_primarycolor2,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only( left: 25,top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only( top: 5),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        "s_asset/images/leftarrow.svg",
                          height: 32,
                          width: 32
                      )),
                ),
                // wSizedBox3,
                // wSizedBox3,
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.review_and_confirm,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                  ),
                ),
                Container(
                  width: 50,
                )
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child:Stack(
          children: [
            Container(
              color: MyColors.light_primarycolor2,
              height: size.height * 1.5 ,
            ),

            Container(
              height: size.height,
              child: Container(
                height: size.height,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    color: MyColors.whiteColor
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
                        onTap:(){
                          // pushNewScreen(
                          //   context,
                          //   screen: FaceAndTouchScreen(),
                          //   withNavBar: false,
                          // );
                          //  transferbottomsheet(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),

                          child: CustomButton2(btnname: "Schedule From 16 Jul",bordercolor: MyColors.lightblueColor,),
                        ),
                      ),
                      hSizedBox5,

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
  /// usercard...
  usercard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Material(
        elevation: 10,
        shadowColor: MyColors.lightblueColor.withOpacity(0.30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.whiteColor),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              /// top
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: MyColors.lightblueColor.withOpacity(0.09),
                    child: const Center(
                      child: Text(
                        "R",
                        style:
                        TextStyle(color: MyColors.lightblueColor, fontSize: 16),
                      ),
                    ),
                  ),
                  wSizedBox1,
                  wSizedBox,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                "Hesham Sqrat",
                                style: TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 14,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_semibold.ttf",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            // wSizedBox4,
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "a_assets/icons/edit.svg",
                                  color: MyColors.blackColor,
                                ),

                              ],
                            )
                          ],
                        ),
                        hSizedBox,
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "(+61) 124-335-547",
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


            ],
          ),
        )
      ),
    );
  }


  ////<>>>>>>
  /*Column(
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
                      onTap:(){
                        pushNewScreen(
                          context,
                          screen: FaceAndTouchScreen(),
                          withNavBar: false,
                        );
                      //  transferbottomsheet(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),

                        child: CustomButton2(btnname: "Schedule From 16 Jul",bordercolor: MyColors.lightblueColor,),
                      ),
                    ),
                    hSizedBox5,

                  ],
                ),*/

  /// deleviry method
  deliveryMethid() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Material(
        elevation: 10,
        shadowColor: MyColors.lightblueColor.withOpacity(0.30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.whiteColor),
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
              hSizedBox1,
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
                          child: const Text(
                            MyString.bank_deposit,
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
                    new Container(
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
                    )
                  ],
                ),
              ),
              hSizedBox2,
              Container(
                child: Row(
                  children: [
                    Image.asset(
                      "a_assets/logo/bank2.png",
                    ),
                    wSizedBox1,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            MyString.qnb_ba,
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
                          child: const Text(
                            "DE68500105178297336485",
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
        ),
      ),
    );
  }

  /// bank Card
  bankcard(){

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Material(
        elevation: 10,
        shadowColor: MyColors.lightblueColor.withOpacity(0.30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.whiteColor),
          child: Row(
            children: [
              Image.asset(
                "a_assets/logo/bank2.png",
              ),
              wSizedBox1,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      MyString.qnb_ba,
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
                    child: const Text(
                      "DE68500105178297336485",
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
        ),
      ),
    );
  }

  ///exchangeRate
  exchangeRatecard(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [

          ///
          Container(
            child:  Row(
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
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    MyString.depend_on_day_of_transfer,
                    style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          hSizedBox2,

          ///
          Container(
            child:  Row(
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
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "1,473.00",
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                            fontWeight: FontWeight.w800),
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
                            fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
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
            child:  Row(
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
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "1,473.00",
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                            fontWeight: FontWeight.w800),
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
                            fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
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
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "MTIN",
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "000-00-0000",
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                            fontWeight: FontWeight.w800),
                      ),
                    ),

                    wSizedBox,

                  ],
                ),
              ],
            ),
          ),
          hSizedBox3,
          Container(
            height: 0.5,
            child: DottedBorder(
              color: Colors.black.withOpacity(0.50),
              strokeWidth: 0.5,
              dashPattern: const [8, 4],
              child: Container(),
            ),
          ),
          hSizedBox2,
          ///
          Container(
            child:  Row(
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
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "1,473.00",
                          style: TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 20,
                              fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                              fontWeight: FontWeight.w800),
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
                              fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]
                ),
              ],
            ),
          ),
          hSizedBox2,
        ],
      ),
    );
  }

  /// bottom sheet



}
