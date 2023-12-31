import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/Select_PaymentMethod_from_ScheduleScreen2.dart';



class BankDetaislScreen2 extends StatefulWidget{


  @override
  State<BankDetaislScreen2> createState() => _BankDetaislScreen2State();
}

class _BankDetaislScreen2State extends State<BankDetaislScreen2> {



  TextEditingController ibanController = TextEditingController();
  FocusNode ibanFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ibanFocus.unfocus();
  }




  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: MyColors.color_03153B,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: MyColors.color_03153B,

              flexibleSpace: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 50,left: 22,right: 20),
                // margin: EdgeInsets.fromLTRB(50, 20, 20, 0),
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
                    Container(
                      // margin: EdgeInsets.fromLTRB(60, 20, 20, 0),
                      child: Text(

                        "Bank Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            fontFamily:
                            "s_asset/font/raleway/raleway_extrabold.ttf"),
                      ),
                    ),

                    wSizedBox3,
                  ],
                ),
              ),

            ),
          ),
          bottomSheet:   Container(
            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: MyColors.whiteColor,
            height: 100,
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
                  margin: EdgeInsets.fromLTRB(0, 22, 0, 0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    color: MyColors.whiteColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top:20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Container(
                                margin: EdgeInsets.only(top:24,left: 0,right: 0),
                                alignment: Alignment.center,
                                child:
                                Text("A small amount will be deducted and \n refunded again for verified and linked your\n bank account",textAlign: TextAlign.center,style: TextStyle(color: MyColors.color_text.withOpacity(0.90),fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),)
                            ),
                            hSizedBox3,
                            hSizedBox2,

                            IBAN(),

                            hSizedBox2,
                            Container(
                              margin: EdgeInsets.only(left: 22,right: 22),
                              height: 48,
                              decoration: BoxDecoration(
                                  color: MyColors.blueColor.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              width: double.infinity,
                              child:   TextField(
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                // focusNode: ibanFocus,
                                // controller: ibanController,
                                cursorColor:MyColors.primaryColor,
                                decoration: InputDecoration(
                                  fillColor: MyColors.blueColor.withOpacity(0.40),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyColors.whiteColor)
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(color: MyColors.whiteColor)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: MyColors.whiteColor)
                                  ),
                                  // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                  hintText: "Enter amount deducted",

                                  hintStyle: TextStyle(color: MyColors.blackColor.withOpacity(0.30),fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                                ),
                              ),
                            ),

                            hSizedBox4,
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPayMethScheduleScreen2(selectedMethodScheduleScreen: 0,)));
                              },
                              child: Container(
                                  width:size.width,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                                    ],
                                    gradient: LinearGradient(
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
                                  padding:  EdgeInsets.only(left: 0, right: 0, bottom: 15,top: 15),
                                  margin: EdgeInsets.only(left: 90, right: 90, bottom: 0,top: 20.0),
                                  child: Text("Link Bank Account",textAlign: TextAlign.center,style: TextStyle(color: MyColors.whiteColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  IBAN(){
    return Container(
      margin: EdgeInsets.only(left: 22,right: 22),
      height: 48,
      decoration: BoxDecoration(
          color: MyColors.blueColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(5)
      ),
      width: double.infinity,
      child:   TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        //  focusNode: ibanFocus,
        controller: ibanController,
        cursorColor:MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintText: "AccountNumber",
          suffixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: SvgPicture.asset("a_assets/icons/paste.svg",height: 15,),
          ),
          hintStyle: TextStyle(color: MyColors.blackColor.withOpacity(0.30),fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        ),
      ),
    );
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
          boxShadow: [
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
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: Center(child: Text(text,style: TextStyle(color: MyColors.lightblueColor,fontSize: 16,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w600),))),
  );
}