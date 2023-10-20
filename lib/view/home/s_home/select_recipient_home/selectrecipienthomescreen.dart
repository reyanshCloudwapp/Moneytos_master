import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/home/s_home/sendmoneyquotation/sendmoneyfromrecipient.dart';
import 'package:moneytos/view/recipients_opened_sscreen/custom_recipientsopenedList.dart';
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SelectRecipientHomeScreen extends StatefulWidget {
  final bool isMfs;

  const SelectRecipientHomeScreen({
    super.key,
    required this.isMfs,
  });

  @override
  State<SelectRecipientHomeScreen> createState() =>
      _SelectRecipientHomeScreenState();
}

class _SelectRecipientHomeScreenState extends State<SelectRecipientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.color_03153B,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(265),
        child: AppBar(
          backgroundColor: MyColors.color_03153B,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, top: 65, right: 20),
            child: Column(
              children: [
                /// appbar ui....

                Container(
                  //  margin: EdgeInsets.fromLTRB(20, 25, 20, 10),
                  child: Column(
                    children: [
                      /// Profile image
                      Stack(children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 16, 0.0, 10.0),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40,
                            backgroundImage:
                                AssetImage("a_assets/logo/female_profile.jpg"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 26,
                            width: 26,
                            decoration: const BoxDecoration(
                                color: MyColors.accent_ED5565_red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "s_asset/images/closeimg.png"))),
                            margin: const EdgeInsets.fromLTRB(26, 0, 0.0, 10.0),
                          ),
                        ),
                      ]),

                      /// recipent name

                      hSizedBox1,
                      const Text(
                        MyString.recipient_name,
                        style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily:
                            "s_asset/font/raleway/raleway_semibold.ttf"),
                      ),
                      hSizedBox,

                      Container(
                          // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                          child: Text(
                        "(+61) 124-335-547",
                        style: TextStyle(
                            color: MyColors.whiteColor.withOpacity(0.50),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                      )),

                      hSizedBox1,
                      hSizedBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0, right: 1),
                            child: SvgPicture.asset(
                              "a_assets/icons/au_australia.svg",
                              height: 20,
                              width: 20,
                            ),
                          ),
                          wSizedBox,
                          Container(
                              margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                              child: const Text(
                                "Sydney, AU",
                                style: TextStyle(
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily:
                                        "s_asset/font/raleway/raleway_semibold.ttf"),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: MyColors.color_03153B,
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            width: double.infinity,
            decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(30),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0)),
                color: MyColors.whiteColor),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  hSizedBox1,

                  /// create listview....

                  hSizedBox2,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      //CustomList.countrylist.map((String url) {
                      // return
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: CustomRecipientOpenedCardList(
                          title: MyString.qnb_ba,
                          icon: "a_assets/icons/edit.svg",
                          subtitle: MyString.bank_deposit,
                          bordercolor: MyColors.lightblueColor,
                          status: true,
                        ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: CustomRecipientOpenedCardList(
                          title: "Vodafone",
                          icon: "a_assets/icons/edit.svg",
                          subtitle: "Mobile Money",
                          bordercolor:
                              MyColors.lightblueColor.withOpacity(0.05),
                        ),
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          print("hbdhjbdf");
                          pushNewScreen(
                            context,
                            screen: SelectPaymentMethodScreen(
                              isMfs: widget.isMfs,
                              selectedMethodScreen: 1,
                            ),
                            withNavBar: false,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width * 0.45,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 30),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                MyColors.lightblueColor.withOpacity(0.70),
                                MyColors.lightblueColor.withOpacity(0.90),
                              ]),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: MyColors.lightblueColor, width: 1)),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      MyColors.whiteColor,
                                      MyColors.whiteColor
                                    ]),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.add,
                                    color: MyColors.lightblueColor,
                                  )),
                              hSizedBox2,
                              Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    MyString.add_new_method,
                                    style: TextStyle(
                                        color: MyColors.whiteColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        fontFamily:
                                            "s_asset/font/raleway/raleway_bold.ttf"),
                                  )),
                            ],
                          ),
                        ),
                      )
                    ]
                        //}).toList(),
                        ),
                  ),

                  hSizedBox2,

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            MyString.receive_methods,
                            style: TextStyle(
                                color: MyColors.color_text_a,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf"),
                          )),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    child: Row(children: [
                      SvgPicture.asset(
                        "a_assets/icons/bank.svg",
                        height: 20,
                        width: 20,
                        color: MyColors.blackColor,
                      ),
                      wSizedBox1,
                      const Text(
                        MyString.bank_deposite,
                        style: TextStyle(
                            color: MyColors.color_text,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf"),
                      ),
                    ]),
                  ),
                  hSizedBox2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 12.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                MyString.bank_name,
                                style: TextStyle(
                                    color: MyColors.color_text_a,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily:
                                        "s_asset/font/raleway/raleway_medium.ttf"),
                              ),
                              hSizedBox1,
                              Row(
                                children: [
                                  Image.asset(
                                    "s_asset/images/bankicon1.png",
                                    height: 26,
                                    width: 26,
                                  ),
                                  wSizedBox1,
                                  const Text(
                                    "QNB",
                                    style: TextStyle(
                                        color: MyColors.color_text,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        fontFamily:
                                            "s_asset/font/raleway/raleway_bold.ttf"),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0.0),
                        child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                MyString.Swift_Code,
                                style: TextStyle(
                                    color: MyColors.color_text_a,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily:
                                        "s_asset/font/raleway/raleway_medium.ttf"),
                              ),
                              hSizedBox1,
                              Text(
                                "QNB212XXX57",
                                style: TextStyle(
                                    color: MyColors.color_text,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily:
                                        "s_asset/font/raleway/raleway_semibold.ttf"),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 24.0),
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MyString.iban_code,
                            style: TextStyle(
                                color: MyColors.color_text_a,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf"),
                          ),
                          hSizedBox1,
                          Text(
                            "SAF548215445REW214874521",
                            style: TextStyle(
                                color: MyColors.color_text,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_semibold.ttf"),
                          ),
                        ]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (Context) =>
                                  SendMoneyquotationRecipints()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width / 4,
                      ),
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            MyColors.lightblueColor.withOpacity(0.90),
                            MyColors.lightblueColor,
                          ]),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: MyColors.lightblueColor, width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: const Text(
                                MyString.Next,
                                style: TextStyle(
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    fontFamily:
                                        "s_asset/font/raleway/raleway_bold.ttf"),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
