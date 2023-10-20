import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/addrecipientinfoscreen/addrecipientinfoscreen.dart';
import 'package:moneytos/view/home/s_home/selectdeliverymethod/bankdepositselectdeliverymethod.dart';
import 'package:moneytos/view/select_bank/selectBank_screen.dart';
import 'package:moneytos/view/selectbankscreen/SelectBankScreen2BankDeposit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../s_Api/s_utils/Utility.dart';
import '../../../dash_recipentScreen/select_recipient_screen/select_new_recipient_screen.dart';
import '../../../dashboardScreen/dashboard.dart';
import '../selectbankaccounnum/selectdeliveryaddmethod.dart';

class SelectDeliveryMethodScreen extends StatefulWidget {
  @override
  State<SelectDeliveryMethodScreen> createState() =>
      _SelectDeliveryMethodScreenState();
}

class _SelectDeliveryMethodScreenState
    extends State<SelectDeliveryMethodScreen> {
  String countryName = "";
  String countryFlag = "";
  String totalFees = "";
  String auhtToken = "";
  bool is_check = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadPref();
    setState(() {});
  }

  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    countryName = sharedPreferences.getString("country_Name").toString();
    countryFlag = sharedPreferences.getString("country_Flag").toString();
    totalFees = sharedPreferences.getString("totalCostFee").toString();
    auhtToken = sharedPreferences.getString("auth_Token").toString();

    print("countryName>>>" + countryName);
    print("countryFlag>>>" + countryFlag);
    print("totalCostFee>>>" + totalFees);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          actions: const [],
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 65, left: 26, right: 26),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.Select_Delivery_Method,
                    style: TextStyle(
                        color: MyColors.color_text,
                        fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4),
                  ),
                ),
                hSizedBox4,
                /*    Container(
                    width:double.infinity,
                    height: 50,
                    // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                    padding: EdgeInsets.fromLTRB(16.0,0, 20.0, 0.0),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      //border: Border.all(color: MyColors.color_gray_transparent),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.color_linecolor,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircledFlag(flag: countryFlag, radius: 13,),
                            wSizedBox1,
                            Text(countryName,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/Raleway-Medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                          ],
                        ),
                        Container(
                            width: 50,
                            child: SvgPicture.asset("a_assets/icons/clear_red.svg")),
                      ],
                    )
                ),*/

                /*  hSizedBox,

                Container(
                  height: 50,
                    width:double.infinity,
                  //  margin:  EdgeInsets.fromLTRB(12.0, 16.0, 0.0, 0.0),
                    padding: EdgeInsets.fromLTRB(16.0,0, 20.0, 0.0),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      //  border: Border.all(color: MyColors.color_gray_transparent),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.color_linecolor,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
                        ),
                      ],
                    ),


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // SvgPicture.asset("s_asset/images/flag2.svg",width: 24,height: 24,),
                            //wSizedBox1,
                            Text(MyString.city_name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/Raleway-Medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                          ],
                        ),
                        Container(
                            width: 50,
                            child: SvgPicture.asset("a_assets/icons/clear_red.svg")),

                      ],
                    )
                ),
*/
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  hSizedBox2,
            /*    Container(

                width:350,
                margin:  EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 0.0),
                padding: EdgeInsets.fromLTRB(16.0, 20.0, 20.0, 16.0),

                decoration: BoxDecoration(


                  color: MyColors.whiteColor,
                 // border: Border.all(color: MyColors.color_gray_transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.color_linecolor,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),


                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("s_asset/images/flag2.svg",width: 26,height: 26,),
                        wSizedBox1,
                        Text(MyString.country_name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/Raleway-Medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                      ],
                    ),
                    SvgPicture.asset("a_assets/icons/clear_red.svg"),

                  ],
                )
            ),*/

            //  hSizedBox3,
            GestureDetector(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>BankDepositDeliveryMethodScreen(MyString.bank_deposit)));
                is_check = true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectDeliveryAddMethodScreen()));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        color: MyColors.color_text.withOpacity(0.2),
                        width: 1.0),
                  ),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 0, right: 4),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "a_assets/icons/bank.svg",
                          height: 36,
                          width: 36,
                        ),
                        wSizedBox3,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              MyString.bank_deposit,
                              style: TextStyle(
                                  color: MyColors.color_text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily:
                                      "s_asset/font/raleway/raleway_medium.ttf"),
                            ),
                            hSizedBox,
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    totalFees.toString(),
                                    style: const TextStyle(
                                      color: MyColors.color_text,
                                      fontSize: 15,
                                      fontFamily:
                                          "s_asset/font/raleway/raleway_bold.ttf",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Text(
                                    " USD",
                                    style: TextStyle(
                                      color: MyColors.color_text,
                                      fontSize: 12,
                                      fontFamily:
                                          "s_asset/font/raleway/raleway_medium.ttf",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),

            GestureDetector(
              onTap: () {
                is_check = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BankDepositDeliveryMethodScreen(
                      MyString.mobile_money,
                    ),
                  ),
                );
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        color: MyColors.color_text.withOpacity(0.2),
                        width: 1.0),
                  ),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 0, right: 4),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "s_asset/images/mobilemoney.svg",
                          height: 36,
                          width: 36,
                        ),
                        wSizedBox3,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child: const Text(
                                  MyString.mobile_money,
                                  style: TextStyle(
                                      color: MyColors.color_text,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily:
                                          "s_asset/font/raleway/raleway_medium.ttf"),
                                )),
                            hSizedBox,
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                child:  const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "1.50",
                                      style: TextStyle(
                                        color: MyColors.color_text,
                                        fontSize: 15,
                                        fontFamily:
                                            "s_asset/font/raleway/raleway_bold.ttf",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      " USD",
                                      style: TextStyle(
                                        color: MyColors.color_text,
                                        fontSize: 12,
                                        fontFamily:
                                            "s_asset/font/raleway/raleway_medium.ttf",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>CashPickupSelectStore()));
                is_check = true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BankDepositDeliveryMethodScreen(
                            MyString.Cash_Pickup)));
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        color: MyColors.color_text.withOpacity(0.2),
                        width: 1.0),
                  ),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 0, right: 4),
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "s_asset/images/cashpickup.svg",
                          height: 36,
                          width: 36,
                        ),
                        wSizedBox3,
                         const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MyString.Cash_Pickup,
                              style: TextStyle(
                                  color: MyColors.color_text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily:
                                      "s_asset/font/raleway/raleway_medium.ttf"),
                            ),
                            hSizedBox,
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "3.00",
                                    style: TextStyle(
                                      color: MyColors.color_text,
                                      fontSize: 15,
                                      fontFamily:
                                          "s_asset/font/raleway/raleway_bold.ttf",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    " USD",
                                    style: TextStyle(
                                      color: MyColors.color_text,
                                      fontSize: 12,
                                      fontFamily:
                                          "s_asset/font/raleway/raleway_medium.ttf",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            hSizedBox6,
            Container(
              color: MyColors.whiteColor,
              margin: const EdgeInsets.only(left: 15, bottom: 20, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pop(context);
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SelectNewRecipientScreen()));
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(0, 4),
                                blurRadius: 5.0)
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            //  stops: [0.0, 1.0],
                            colors: [
                              MyColors.lightblueColor.withOpacity(0.10),
                              MyColors.lightblueColor.withOpacity(0.10),
                            ],
                          ),
                          //color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.only(
                            left: 28, right: 28, bottom: 15, top: 15),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 0, top: 0.0),
                        child: const Text(
                          MyString.cancel,
                          style: TextStyle(
                              color: MyColors.lightblueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily:
                                  "s_asset/font/raleway/raleway_bold.ttf"),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      is_check
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddRecipientInfoScreen()))
                          : Utility.showFlutterToast(
                              "Please Select Delivery Method");
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.white,
                                offset: Offset(0, 4),
                                blurRadius: 5.0)
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            //  stops: [0.0, 1.0],
                            colors: [
                              MyColors.lightblueColor,
                              MyColors.lightblueColor,
                            ],
                          ),
                          //color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.only(
                            left: 28, right: 28, bottom: 15, top: 15),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 0, top: 0.0),
                        child: const Text(
                          MyString.Next,
                          style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily:
                                  "s_asset/font/raleway/raleway_bold.ttf"),
                        )),
                  ),
                ],
              ),
            ),
            hSizedBox1,
          ],
        ),
      ),
    );
  }
}

class CircledFlag extends StatelessWidget {
  const CircledFlag({
    Key? key,
    required this.flag,
    required this.radius,
  }) : super(key: key);

  final String flag;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _FlagClipper(radius),
      child: Text(
        flag,
        style: TextStyle(fontSize: 3 * radius),
      ),
    );
  }
}

class _FlagClipper extends CustomClipper<Path> {
  const _FlagClipper(this.radius);

  final double radius;

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);

    path.addOval(Rect.fromCircle(center: center, radius: radius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
