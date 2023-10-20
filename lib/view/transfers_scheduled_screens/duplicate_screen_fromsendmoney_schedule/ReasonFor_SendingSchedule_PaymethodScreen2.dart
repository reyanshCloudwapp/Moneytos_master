import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/home/s_home/linknewmethod/link_new_method.dart';
import 'package:moneytos/view/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/LinkNew_ScedulePayment_MethodScreen2.dart';




class ReasonForSendingPaymethodScreen2 extends StatefulWidget{
  final bool isMfs;

  const ReasonForSendingPaymethodScreen2({super.key, required this.isMfs});
  @override
  State<ReasonForSendingPaymethodScreen2> createState() => _ReasonForSendingPaymethodScreen2State();
}

class _ReasonForSendingPaymethodScreen2State extends State<ReasonForSendingPaymethodScreen2> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(60),
            child:
            AppBar(

              backgroundColor: MyColors.color_03153B,
              systemOverlayStyle: SystemUiOverlayStyle(
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
                padding: EdgeInsets.only( left: 25,top: 25),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only( top: 5),
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
                      child: Text(
                        "Select Payment Method",
                        style: TextStyle(
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            fontFamily:
                            "s_asset/font/raleway/raleway_extrabold.ttf"),
                      ),
                    ),
                    Container(
                      width: 0,
                    )
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ),
          bottomSheet:   Container(
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
            ),

            margin: EdgeInsets.only(bottom: 30),
            padding: EdgeInsets.symmetric(horizontal: 15),

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
          body: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    color: MyColors.color_03153B,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 22, 0, 0),
                          // height: MediaQuery.of(context).size.height,
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
                            child: Column(
                              children: [
                                hSizedBox4,
                                Container(
                                  child: InkWell(
                                      onTap: () {
                                        //Navigator.of(context).pop();
                                      },
                                      child: SvgPicture.asset(
                                        "a_assets/images/empty_illustration.svg",
                                      )),
                                ),
                                hSizedBox1,
                                Container(
                                  width: size.width * 0.6,
                                  margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                                  child: Text(
                                    "There's no Payment method linked yet before to pay by it",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: MyColors.blackColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily:
                                        "s_asset/font/raleway/raleway_medium.ttf"),
                                  ),
                                ),
                                hSizedBox4,
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LinkNewScedulePaymentMethodScreen2(isMfs: widget.isMfs,)));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                                    margin: EdgeInsets.symmetric(horizontal:size.width /6.7,vertical: 20),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.bottomCenter,
                                        //  stops: [0.0, 1.0],
                                        colors: [
                                          MyColors.color_3F84E5.withOpacity(0.80),
                                          MyColors.color_3F84E5.withOpacity(0.90),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: SvgPicture.asset(
                                            "a_assets/icons/bold_plus.svg",
                                            color: MyColors.whiteColor,

                                          ),
                                        ),
                                        hSizedBox1,
                                        Container(
                                          child: Text(
                                            MyString.link_new_method,
                                            style: TextStyle(
                                                color: MyColors.whiteColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                fontFamily:
                                                "s_asset/font/maven/mavenpro_bold.ttf"),
                                          ),
                                        )
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
                  )
                ],
              ),
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