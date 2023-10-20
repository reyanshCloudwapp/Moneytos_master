import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';

import 'transfer_rasonforSending.dart';


class TransferKeyBoardNum1 extends StatefulWidget {
  const TransferKeyBoardNum1({Key? key}) : super(key: key);

  @override
  State<TransferKeyBoardNum1> createState() => _TransferKeyBoardNum1State();
}

class _TransferKeyBoardNum1State extends State<TransferKeyBoardNum1> {
  /// create number list
  List<int> firstlist = [1, 2, 3];
  List<int> secondlist = [4, 5, 6];
  List<int> thirdlist = [7, 8, 9];

  int pinlength = 6;
  String pinEntered ="";
  String workingpin = "123456";
  String alert = "";
  bool isforgot = false;


  numberClicked(int item){
    pinEntered = pinEntered + item.toString();
    print("object${pinEntered}");
    if(pinEntered.length == pinlength){
      alert =(pinEntered == workingpin) ? "Good luck" : "Incorrect please try again";
    }
    setState(() {});
  }

  backSpace(){
    if(pinEntered.isNotEmpty){
      pinEntered = pinEntered.substring(0,pinEntered.length -1);
      alert = "";
      print("pinentered..${pinEntered}");
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox3,

            Container(
              margin: EdgeInsets.symmetric(horizontal:size.width /4 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: MyColors.lightblueColor
              ),
              alignment: Alignment.center,
              child: const Text("1,473.00",style: TextStyle(color: Colors.white,fontSize: 36,fontWeight: FontWeight.w800,fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),),
            ),
            hSizedBox3,

            Container(
              margin: EdgeInsets.symmetric(horizontal:size.width /4 ),

              alignment: Alignment.center,
              child: Text(MyString.exchange_rate,style: TextStyle(color: Colors.black.withOpacity(0.30),fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),),
            ),

            hSizedBox1,
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "01.00",
                      style: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 14,
                          fontFamily: "s_asset/font/montserrat/MontserratAlternates-SemiBold.otf",
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  wSizedBox,
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      MyString.usd,
                      style: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 9,
                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  wSizedBox1,

                  SvgPicture.asset(
                    "a_assets/icons/small_swap.svg",
                  ),
                  wSizedBox1,

                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "01.00",
                      style: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 14,
                          fontFamily: "s_asset/font/montserrat/MontserratAlternates-SemiBold.otf",
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  wSizedBox,
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      MyString.aud,
                      style: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 9,
                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            
            hSizedBox,
            
            Container(
              margin: EdgeInsets.symmetric(horizontal:size.width /4.6 ),
              padding: const EdgeInsets.symmetric(vertical:8 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: MyColors.lightblueColor.withOpacity(0.02)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal:size.width /4 ),

                    alignment: Alignment.center,
                    child: Text(MyString.fees,style: TextStyle(color: Colors.black.withOpacity(0.30),fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),),
                  ),

                  wSizedBox1,
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "01.00",
                      style: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 14,
                          fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf",
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
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            hSizedBox2,

            /// number ui

            hSizedBox3,
            //numberButton(1),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: firstlist.map((e) {
                  return Container(
                      padding: const EdgeInsets.symmetric( vertical: 10),
                      child: numberButton(e));
                }).toList(),
              ),
            ),

            hSizedBox3,

            /// number button2
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: secondlist.map((e) {
                return Container(
                    padding: const EdgeInsets.symmetric( vertical: 10),
                    child: numberButton(e));
              }).toList(),
            ),

            hSizedBox3,

            /// number button3
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: thirdlist.map((e) {
                return Container(
                    padding: const EdgeInsets.symmetric( vertical: 15),
                    child: numberButton(e));
              }).toList(),
            ),

            hSizedBox3,

            /// number button4
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only( top: 15),
                    child: InkWell(
                      onTap: () {
                        backSpace();
                      },
                      child: Container(
                        width: 50,
                        alignment: Alignment.topLeft,
                        child: SvgPicture.asset(
                          "a_assets/icons/close_square.svg",
                          height: 25,
                          width: 25,
                        ),
                      ),
                      //Icon(CupertinoIcons.clear_fill,color: MyColors.blackColor,)
                    ),
                  ),

                  Padding(padding: const EdgeInsets.only( top: 17),child:Container(
                    width: 50,
                    child:  numberButton(0),
                  )),

                  //    (pinEntered != workingpin && pinEntered.length == pinlength) ?

                  //isforgot == true?
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){

                      // pushNewScreen(
                      //   context,
                      //   screen: ForgotPinCodeScreen(),
                      //   withNavBar: false,
                      // );

                    },
                    child: Container(
                      // height: 20,
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only( right: 25),
                      child: const Text(".",style: TextStyle(  color: MyColors.blackColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),),
                    ),
                  )
                   //   : Container()
                ]
            ),
            hSizedBox4,

            GestureDetector(
              onTap: (){
                print("dsghhjdfg");
                Navigator.pop(context);
                transferbottomsheet(context);
                // isforgot = true;
                // setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width /6),
                child: CustomButton2(btnname:MyString.confirm,bg_color: MyColors.lightblueColor,bordercolor: MyColors.lightblueColor,),
              ),
            ),
            hSizedBox4,
          ],
        ),
      ),
    );
  }

  numberButton(int item) {
    return Container(
      child: GestureDetector(
        onTap: () {
          numberClicked(item);
        },
        child: Container(
          width: 40,
          height: 30,
          child: Text(
            item.toString(),
            style: const TextStyle(
                color: MyColors.blackColor,
                fontWeight: FontWeight.w800,
                fontSize: 20,
                fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),
          ),
        ),
      ),
    );
  }
}


transferbottomsheet(BuildContext context){
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
      ),
      // anchorPoint: Offset(20.0, 30.0),
      //  backgroundColor: Colors.white,
      builder: (context) {
        return Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: CustompinDialog(context))
        );}
  );
}

CustompinDialog(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    child: SingleChildScrollView(
      child: Wrap(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "a_assets/logo/confirm_img.svg",
              height: 100,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: const Text(MyString.please_confirm,textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),),
          ),

          Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: const Text(MyString.exchange_rate_will_be_calculated_on_the,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),),
          ),


          Container(
            padding: const EdgeInsets.only(top: 50,left: 25,right: 25,bottom: 80),
            //  alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (_) => const TransferReasonforSendingScreen2(isMfs: false,)));
              },
              child: Container(
                  alignment: Alignment.center,
                  //  width: 100,
                  child: Material(
                    color: MyColors.whiteColor,
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.lightblueColor
                          //  border: Border.all(color: bordercolor,width: 1.4)
                        ),
                        child: const Center(child: Text(MyString.confirm,style: TextStyle(fontFamily: "s_asset/font/raleway/raleway_bold.ttf",color:MyColors.whiteColor,fontSize:18,fontWeight: FontWeight.w700,letterSpacing: 0.4 ),))),
                  )

              ),
            ),
          ),

          hSizedBox3
        ],
      ),
    ),
  );
}