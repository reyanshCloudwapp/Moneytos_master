import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/resonforsendingscreen/reasonforsendingscreen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transfer_keyboardnum1.dart';

class TransferSendMoneyFromRecipient2 extends StatefulWidget{

  @override
  State<TransferSendMoneyFromRecipient2> createState() => _TransferSendMoneyFromRecipient2State();
}

class _TransferSendMoneyFromRecipient2State extends State<TransferSendMoneyFromRecipient2> {


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(265),
        child: AppBar(
          backgroundColor: MyColors.light_primarycolor2,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only( left: 20,top: 65,right: 20),
            child: Column(
              children: [
                /// appbar ui....

                Container(
                  //  margin: EdgeInsets.fromLTRB(20, 25, 20, 10),
                  child: Column(
                    children: [
                      /// Profile image
                      Stack(
                          children:[
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 16, 0.0, 10.0),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                                backgroundImage: AssetImage(
                                    "a_assets/logo/female_profile.jpg"),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 26,
                                width: 26,
                                decoration: const BoxDecoration(
                                    color: MyColors.accent_ED5565_red,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: AssetImage("s_asset/images/closeimg.png")
                                    )

                                ),
                                margin: const EdgeInsets.fromLTRB(26, 0, 0.0, 10.0),

                              ),
                            ),

                          ]

                      ),

                      /// recipent name

                      hSizedBox1,
                      Container(
                        //  margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                          child: const Text(
                            MyString.recipient_name,
                            style: TextStyle(
                                color: MyColors.whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily:
                                "s_asset/font/raleway/raleway_semibold.ttf"),
                          )),
                      hSizedBox,

                      Container(
                        // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                          child: Text(
                            "(+61) 124-335-547",
                            style: TextStyle(
                                color: MyColors.whiteColor
                                    .withOpacity(0.50),
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
                            padding:
                            const EdgeInsets.only(top: 0.0, right: 1),
                            child: SvgPicture.asset(
                              "a_assets/icons/au_australia.svg",
                              height: 20,
                              width: 20,
                            ),
                          ),
                          wSizedBox,
                          Container(
                              margin:
                              const EdgeInsets.fromLTRB(00, 5, 0, 0),
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
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: MyColors.light_primarycolor2,
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            height: size.height,
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(30),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                color: MyColors.whiteColor),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  hSizedBox1,
                  Container(
                      width:double.infinity,
                      margin:  const EdgeInsets.fromLTRB(12.0, 26.0, 12.0, 0.0),
                      padding: const EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 22.0),
                      decoration: BoxDecoration(
                        color: MyColors.color_D8E6FA_bac,
                        border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width:170,
                              child: const Text("You send",style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_ffF4287_text),)),
                          Row(
                            children: [
                              SvgPicture.asset("s_asset/images/flag1.svg"),
                              wSizedBox,
                              const Text(MyString.usd,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                            ],
                          ),
                        ],
                      )
                  ),
                  Container(
                      width:double.infinity,
                      margin:  const EdgeInsets.fromLTRB(0.0, 26.0, 0.0, 0.0),
                      padding: const EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 22.0),
                      decoration: BoxDecoration(
                        color: MyColors.color_D8E6FA_bac,
                        border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width:170,
                              child: const Text("hesham sqrat gets",style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_ffF4287_text),)),
                          Row(
                            children: [
                              SvgPicture.asset("s_asset/images/flag2.svg"),
                              wSizedBox,
                              const Text(MyString.AUD,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                              wSizedBox,
                              SvgPicture.asset("s_asset/images/dropdown.svg",),
                            ],
                          ),
                        ],
                      )
                  ),
                  hSizedBox3,

                  const Text("Exchange Rate will effect in scheduled Date",style: TextStyle(fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: Color(0xffFCB901)),),
                  hSizedBox3,

                  const Text("Exchange Rate",style: TextStyle(fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text_a),),
                  hSizedBox1,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("01.00",style: TextStyle(color: MyColors.color_text,fontSize:12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w800,),),
                          Text(" USD",style: TextStyle(color: MyColors.color_text,fontSize:9,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w600, ),)
                        ],
                      ),
                      wSizedBox1,
                      SvgPicture.asset("s_asset/images/leftrightarrow.svg",height: 10,width: 10,),
                      wSizedBox1,

                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("01.30",style: TextStyle(color: MyColors.color_text,fontSize:12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w800,),),
                          Text(" AUD",style: TextStyle(color: MyColors.color_text,fontSize:9,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w600, ),)
                        ],
                      ),



                    ],
                  ),
                  hSizedBox3,
                  Container(
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(

                      color: MyColors.color_D8E6FA_bac,
                      border: Border.all(color: MyColors.color_gray_transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Fees   ",style: TextStyle(color: MyColors.color_text_a,fontSize:12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,),),

                        Text("2.60",style: TextStyle(color: MyColors.color_text,fontSize:12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w800,),),
                        Text(" USD",style: TextStyle(color: MyColors.color_text,fontSize:9,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w600, ),)
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      transferKeyboardbottomsheet(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ReasonforSendingScreen()));
                    },
                    child: Container(
                      alignment: Alignment.center,

                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width /4,),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20,vertical: 50),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            MyColors.lightblueColor.withOpacity(0.90),
                            MyColors.lightblueColor,
                          ]),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: MyColors.lightblueColor,
                              width: 1)),
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

  transferKeyboardbottomsheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30)
        ),
        // anchorPoint: Offset(20.0, 30.0),
          backgroundColor: Colors.black.withOpacity(0.70),
        builder: (context) {
          return Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.85,
              child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(30)),
                  child: const TransferKeyBoardNum1())
          );}
    );
  }
}