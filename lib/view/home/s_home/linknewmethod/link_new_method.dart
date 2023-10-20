import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/home/s_home/debitcardscreen/debit_cardscreen.dart';
import 'package:moneytos/view/select_bank/selectBank_screen.dart';
import 'package:moneytos/view/selectserviceprovider/selectserviceprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../select_payment_method_screen/select_payment_method_screen.dart';
import '../bankdetailsscreen/bank_details_screen.dart';

class LinkNewMethodScreen extends StatefulWidget{
  @override
  State<LinkNewMethodScreen> createState() => _LinkNewMethodScreenState();
}

class _LinkNewMethodScreenState extends State<LinkNewMethodScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),

        child: Scaffold(
          backgroundColor: MyColors.primaryColor.withOpacity(0.50),

          appBar:PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child:
            AppBar(

              backgroundColor: MyColors.color_03153B,
              systemOverlayStyle: const SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: MyColors.color_03153B,

                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.light, // For Android (dark icons)
                statusBarBrightness: Brightness.dark, // For iOS (dark icons)
              ),
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
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5,right: 5),
                        alignment: Alignment.center,
                        child: const Text(
                          "Select Payment Method",
                          textAlign: TextAlign.center,
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
                      width: 26,
                    )
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ),


          bottomSheet:   Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 30),

            color: MyColors.whiteColor,
            height: 80,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                child:Custombtn(MyString.back,70,140,context) ,
              ),
            ),
          ),
          body: Container(

            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  color: MyColors.color_03153B,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [


                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                           height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 0,
                            color: MyColors.whiteColor,
                            margin: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                            ),
                            child: Column(
                              children: [
                                hSizedBox5,
                                // GestureDetector(
                                //   onTap: (){
                                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPaymentMethodScreen(isMfs: false,selectedMethodScreen: 0,)));
                                //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>BankDetailsScreen()));
                                //   },
                                //   child:
                                //   Container(
                                //       width: size.width,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.all(Radius.circular(12)),
                                //         border: Border.all(color: MyColors.color_text.withOpacity(0.2),width: 1.0),
                                //       ),
                                //       padding: EdgeInsets.only(left:0,right:24,top:22,bottom: 22),
                                //       margin: EdgeInsets.symmetric(vertical:10,horizontal: 60),
                                //       child: Container(
                                //         margin: EdgeInsets.only(left:40),
                                //         child: Row(
                                //           children: [
                                //             SvgPicture.asset("a_assets/icons/bank.svg",height: 36,width: 36,),
                                //             SizedBox(width: 24,),
                                //             Text(MyString.bank_acount,style: TextStyle(color:MyColors.color_text,fontSize:14,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/Raleway-Medium.ttf"),),
                                //
                                //
                                //
                                //           ],
                                //         ),
                                //       )),
                                // ),


                                GestureDetector(
                                  onTap: () async {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>DebitCardScreen()));
                                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPaymentMethodScreen(isMfs: sharedPreferences.getString("partnerPaymentMethod").toString() == "mfs"?true:false,selectedMethodScreen: 1,)));
                                  },
                                  child: Container(
                                    width: size.width,

                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                                        border: Border.all(color: MyColors.color_text.withOpacity(0.2),width: 1.0),
                                      ),
                                      padding: const EdgeInsets.only(left:0,right:24,top:22,bottom: 22),
                                      margin: const EdgeInsets.symmetric(vertical:10,horizontal: 60),
                                      child: Container(
                                        margin: const EdgeInsets.only(left:40),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset("s_asset/images/debitcard.svg",height: 28,width: 28,),
                                            const SizedBox(width: 24,),
                                            const Text("Debit Card" ,style: TextStyle(color:MyColors.color_text,fontSize:14,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),),

                                          ],
                                        ),
                                      )),
                                ),
                                // GestureDetector(
                                //   onTap: (){
                                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectServiceProviderScreen()));
                                //
                                //   },
                                //   child: Container(
                                //       width: size.width,
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.all(Radius.circular(12)),
                                //         border: Border.all(color: MyColors.color_text.withOpacity(0.2),width: 1.0),
                                //       ),
                                //       padding: EdgeInsets.only(left:0,right:24,top:22,bottom: 22),
                                //       margin: EdgeInsets.symmetric(vertical:10,horizontal: 60),
                                //       child: Container(
                                //         margin: EdgeInsets.only(left:40),
                                //         child: Row(
                                //           children: [
                                //             Container(
                                //                 margin: EdgeInsets.only(left:8,),
                                //                 child: SvgPicture.asset("s_asset/images/mobilemoney.svg",height: 32,width: 32,)),
                                //          SizedBox(width: 24,),
                                //             Text("Mobile Money",style: TextStyle(color:MyColors.color_text,fontSize:14,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/Raleway-Medium.ttf"),),
                                //
                                //           ],
                                //         ),
                                //       )),
                                // ),
                              ],
                            ),
                          ),
                        )


                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Custombtn(String text,double height,double width, BuildContext context) {
  return  Container(
    height: height,
    width: width,
    color: MyColors.whiteColor,
    //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
    child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            //  stops: [0.0, 1.0],
            colors: [
              MyColors.lightblueColor.withOpacity(0.10),
              MyColors.lightblueColor.withOpacity(0.36),
            ],
          ),
          //color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: Center(child: Text(text,style: const TextStyle(color: MyColors.lightblueColor,fontSize: 16,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w600),))),
  );
}