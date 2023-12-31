import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/home/s_home/debitcardscreen/debit_cardscreen.dart';
import 'package:moneytos/view/selectbankscreen/SelectBankScreen2BankDeposit.dart';
import 'package:moneytos/view/selectserviceprovider/selectserviceprovider.dart';
import 'package:moneytos/view/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/Debit2/DebitCardScreen2.dart';
import 'package:moneytos/view/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/MobileMoneyScreen2/MobileMoneyServiceproScreen2.dart';
import 'package:moneytos/view/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/bank2/SelectBankScreen2.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transferreview_and_confirmScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SelectPayMethScheduleScreen2 extends StatefulWidget{

  int selectedMethodScheduleScreen;

  SelectPayMethScheduleScreen2({Key? key,required this.selectedMethodScheduleScreen}) : super(key: key);

  @override
  State<SelectPayMethScheduleScreen2> createState() => _SelectPayMethScheduleScreenState();
}

class _SelectPayMethScheduleScreenState extends State<SelectPayMethScheduleScreen2> {


  int selectedItemTab=-1;
  String Bankacc="";
  String Debitcard="";
  String Mobilemoney="";

  int SelectedMethod=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SelectedMethod=widget.selectedMethodScheduleScreen;
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.light_primarycolor2,
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
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
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(
                    MyString.select_payment_method,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                        "s_asset/font/raleway/raleway_extrabold.ttf"),
                  ),
                ),
                Container(
                  width: 50,
                )
              ],
            ),
          ),



        ),
      ),
      /* appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: MyColors.primaryColor,
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
                      )),
                ),
                // wSizedBox3,
                // wSizedBox3,
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(
                    MyString.select_payment_method,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily:
                        "s_asset/font/raleway/raleway_medium.ttf"),
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
      ),*/
      bottomSheet: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
        //  print("Shivangi the nani papri>>>1223454,hjghjghjghfgj");
          //Fluttertoast.showToast(msg: 'Shivangi the nani papri>>> ');
          pushNewScreen(
            context,
            screen: TransferReview_andConfirmScreen(),
            withNavBar: false,
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: MyColors.whiteColor
          ),
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            alignment: Alignment.center,
            height: 46,
            width: double.infinity,
            margin: EdgeInsets.only(left: 62,right:62,top: 30,bottom:50 ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  MyColors.lightblueColor.withOpacity(0.90),
                  MyColors.lightblueColor,
                ]),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: MyColors.lightblueColor,
                    width: 1)),
            child:
            Container(
                alignment: Alignment.center,
                child: Text(
                  MyString.go_to_review,
                  style: TextStyle(
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily:
                      "s_asset/font/raleway/raleway_bold.ttf"),
                )
            ),


          ),
        ),
      ),

      body: Stack(
          children: [

            Container(
              height: 300,
              color: MyColors.light_primarycolor2,
            ),

            Container(
              margin: EdgeInsets.only(top: 0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  borderRadius:
                  BorderRadius.circular(30)
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox2,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children:  [
                            /*   customcard( "a_assets/icons/bank.svg",  MyString.bank_acount, MyColors.lightblueColor),
                        customcard( "a_assets/icons/debit_card.svg",  MyString.debit_card, MyColors.blackColor),
                        customcard( "a_assets/icons/mobile.svg",  MyString.mobile_money, MyColors.blackColor),
    ],
*/


                            GestureDetector(
                              onTap:(){
                                SelectedMethod=0;

                                setState(() {

                                });

                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),

                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: SelectedMethod==0?MyColors.color_93B9EE:MyColors.whiteColor,
                                              width: 2)
                                      ),
                                      child: Material(
                                          elevation: 20,
                                          shadowColor: MyColors.lightblueColor.withOpacity(0.10),
                                          color: MyColors.whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 30),
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  "a_assets/icons/bank.svg",height: 30,width: 30, color:SelectedMethod==0?MyColors.lightblueColor:MyColors.blackColor ,),
                                                hSizedBox1,
                                                hSizedBox,
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    MyString.bank_acount,
                                                    style: TextStyle(
                                                        color:SelectedMethod==0?MyColors.lightblueColor:MyColors.blackColor ,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily:
                                                        "s_asset/font/raleway/raleway_medium.ttf",
                                                        fontSize: 13),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )))

                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                SelectedMethod=1;
                                setState(() {

                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),

                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: SelectedMethod==1?MyColors.color_93B9EE:MyColors.whiteColor,
                                              width: 2)
                                      ),
                                      child: Material(
                                          elevation: 20,
                                          shadowColor: MyColors.lightblueColor.withOpacity(0.10),
                                          color: MyColors.whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 30),
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  "a_assets/icons/debit_card.svg",height: 30,width: 30,color:SelectedMethod==1?MyColors.lightblueColor:MyColors.blackColor , ),
                                                hSizedBox1,
                                                hSizedBox,
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    MyString.debit_card,
                                                    style: TextStyle(
                                                        color:SelectedMethod==1?MyColors.lightblueColor:MyColors.blackColor ,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily:
                                                        "s_asset/font/raleway/raleway_medium.ttf",
                                                        fontSize: 13),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )))

                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                SelectedMethod=2;
                                setState(() {

                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),

                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(color: SelectedMethod==2?MyColors.color_93B9EE:MyColors.whiteColor,
                                              width: 2)
                                      ),
                                      child: Material(
                                          elevation: 20,
                                          shadowColor: MyColors.lightblueColor.withOpacity(0.10),
                                          color: MyColors.whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 30),
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                  "a_assets/icons/mobile.svg",height: 30,width: 30,color:SelectedMethod==2?MyColors.lightblueColor:MyColors.blackColor , ),
                                                hSizedBox1,
                                                hSizedBox,
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    MyString.mobile_money,
                                                    style: TextStyle(
                                                        color:SelectedMethod==2?MyColors.lightblueColor:MyColors.blackColor ,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily:
                                                        "s_asset/font/raleway/raleway_medium.ttf",
                                                        fontSize: 13),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )))

                              ),
                            )


                          ]
                      ),
                    ),
                    hSizedBox2,




                    /////////////BankAccount///////////////




                    Visibility(
                      visible: SelectedMethod==0?true:false,
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              shrinkWrap: true,
                              itemBuilder: (context ,int index){
                                return GestureDetector(
                                  onTap: (){

                                    setState(()  {

                                      selectedItemTab=index;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top:14),
                                    child: Customcard2("","Citibank",MyColors.blackColor,"Account - 9560",index),
                                  ),
                                );
                              }),
                          hSizedBox4,


                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){
                              print("hbdhjbdf");
                              pushNewScreen(
                                context,
                                screen: SelectBankScreen2(),
                                withNavBar: false,
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 22,),

                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    MyColors.lightblueColor.withOpacity(0.80),
                                    MyColors.lightblueColor,
                                  ]),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: MyColors.lightblueColor,
                                      width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "a_assets/icons/bank.svg",color: MyColors.whiteColor,),
                                  wSizedBox2,
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Link New Bank",
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
                          ),
                          hSizedBox5,
                          hSizedBox2,
                          hSizedBox5,
                        ],
                      ),
                    ),



                    /////////////DebitCard///////////////

                    Visibility(
                      visible: SelectedMethod==1?true:false,
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              shrinkWrap: true,
                              itemBuilder: (context ,int index){
                                return GestureDetector(
                                  onTap: (){
                                    setState(()  {

                                      selectedItemTab=index;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top:14),
                                    child: Customcard3("","Card Name",MyColors.blackColor,"**** 9560",index),
                                  ),
                                );
                              }),
                          hSizedBox3,


                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){
                              print("hbdhjbdf");
                              pushNewScreen(
                                context,
                                screen: DebitCardScreen2(),
                                withNavBar: false,
                              );
                            },
                            child:
                            Container(
                              alignment: Alignment.center,

                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 20,),

                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    MyColors.lightblueColor.withOpacity(0.80),
                                    MyColors.lightblueColor,
                                  ]),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: MyColors.lightblueColor,
                                      width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "s_asset/images/cardnew.svg",color: MyColors.whiteColor,),
                                  wSizedBox2,
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Add New Card",
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
                          ),
                          hSizedBox5,
                          hSizedBox2,
                          hSizedBox5,
                        ],
                      ),
                    ),


                    /////////////MobileMoney///////////////

                    Visibility(
                      visible: SelectedMethod==2?true:false,
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              shrinkWrap: true,
                              itemBuilder: (context ,int index){
                                return GestureDetector(
                                  onTap: (){
                                    setState(()  {

                                      selectedItemTab=index;
                                    });
                                  },
                                  child: Container(
                                    margin:EdgeInsets.only(top:14),
                                    child: Customcard4("","Vodafone",MyColors.blackColor,"Number - 5117",index),
                                  ),
                                );
                              }),
                          hSizedBox3,


                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){
                              print("hbdhjbdf");
                              pushNewScreen(
                                context,
                                screen: MobileMoneyServiceProScreen2(),
                                withNavBar: false,
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,

                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 20,),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    MyColors.lightblueColor.withOpacity(0.80),
                                    MyColors.lightblueColor,
                                  ]),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: MyColors.lightblueColor,
                                      width: 1)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "s_asset/images/mobile2.svg",color: MyColors.whiteColor,),
                                  wSizedBox2,
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "New Mobile Money",
                                        style: TextStyle(
                                            color: MyColors.whiteColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            fontFamily:
                                            "s_asset/font/raleway/raleway_semibold.ttf"),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          hSizedBox5,
                          hSizedBox2,
                          hSizedBox5,
                        ],
                      ),
                    ),





                  ],
                ),
              ),
            ),

          ]
      ),
    );
  }



  Customcard2(String img, String title ,Color color,String des,int index){
    return Container(

      decoration: BoxDecoration(
          border: Border.all(color: selectedItemTab==index?MyColors.color_3F84E5:MyColors.whiteColor,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Material(

        elevation: 16,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        color: MyColors.whiteColor,

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10),
        ),
        child:  Container(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: 30),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color(0xff056CAD),
                          borderRadius: BorderRadius.circular(9)
                      ),
                      child: Image.asset("s_asset/images/bankicon1.png")),
                  wSizedBox1,
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                fontSize: 16),
                          ),
                        ),
                        hSizedBox1,
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf",
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,),
                  wSizedBox2,
                  wSizedBox,
                  SvgPicture.asset("a_assets/icons/delete.svg"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  Customcard3(String img, String title ,Color color,String des,int index){
    return Container(

      decoration: BoxDecoration(
          border: Border.all(color: selectedItemTab==index?MyColors.color_3F84E5:MyColors.whiteColor,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Material(
        elevation: 16,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        color: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10),
        ),
        child:  Container(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: 30),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SvgPicture.asset("s_asset/images/carda.svg"),
                  wSizedBox1,
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                fontSize: 16),
                          ),
                        ),
                        hSizedBox1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //  alignment: Alignment.topLeft,
                              child: Text(
                                "**** 9560",
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf",
                                    fontSize: 12),
                              ),

                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,),
                      wSizedBox2,
                      wSizedBox,
                      SvgPicture.asset("a_assets/icons/delete.svg"),
                    ],
                  ),

                  hSizedBox4,
                  Container(

                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "05/24",
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w500,
                          fontFamily:
                          "s_asset/font/raleway/raleway_medium.ttf",
                          fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  Customcard4(String img, String title ,Color color,String des,int index){
    return Container(

      decoration: BoxDecoration(
          border: Border.all(color: selectedItemTab==index?MyColors.color_3F84E5:MyColors.whiteColor,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Material(
        elevation: 16,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        color: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10),
        ),
        child:  Container(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: 30),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        // color: Color(0xff056CAD),
                          borderRadius: BorderRadius.circular(9)
                      ),
                      child: Image.asset("s_asset/images/companyimg.png")),
                  wSizedBox1,
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                fontSize: 16),
                          ),
                        ),
                        hSizedBox1,
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Number - 5117",
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf",
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,),
                  wSizedBox2,
                  wSizedBox,
                  SvgPicture.asset("a_assets/icons/delete.svg"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}