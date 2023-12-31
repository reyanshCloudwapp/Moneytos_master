import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/customHomecardui.dart';

import '../../model/customlists/customLists.dart';

class CustomKeyboardScreen extends StatefulWidget {
  const CustomKeyboardScreen({Key? key}) : super(key: key);

  @override
  _CustomKeyboardScreenState createState() => _CustomKeyboardScreenState();
}

class _CustomKeyboardScreenState extends State<CustomKeyboardScreen> {
  /// create number list
  List<int> firstlist = [1, 2, 3];
  List<int> secondlist = [4, 5, 6];
  List<int> thirdlist = [7, 8, 9];

  int pinlength = 6;
  String pinEntered ="";
  String workingpin = "123456";
  String alert = "";


  numberClicked(int item){
    pinEntered = pinEntered + item.toString();
    print("object${pinEntered}");
    if(pinEntered.length == pinlength){
      alert =(pinEntered == workingpin) ? "Good luck" : "Incorrect please try again";
    }
    setState(() {});
  }

  backSpace(){
    if(pinEntered.length > 0){
      pinEntered = pinEntered.substring(0,pinEntered.length -1);
      alert = "";
      print("pinentered..${pinEntered}");
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox2,

            /// number ui
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: firstlist.map((e) {
                  return Container(
                      padding: EdgeInsets.symmetric( vertical: 10),
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
                    padding: EdgeInsets.symmetric( vertical: 10),
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
                    padding: EdgeInsets.symmetric( vertical: 15),
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
                    padding: EdgeInsets.only( top: 15),
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

                  Padding(padding: EdgeInsets.only( top: 17),child:Container(
                    width: 50,
                    child:  numberButton(0),
                  )),

                  (pinEntered != workingpin && pinEntered.length == pinlength) ?
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){

                    },
                    child: Container(
                      // height: 20,
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only( top: 22),
                      child: Text(".",style: TextStyle(color: MyColors.lightblueColor,fontSize: 12,fontWeight: FontWeight.w500),),
                    ),
                  )
                      : Container()
                ]
            ),
            // hSizedBox4,
            // (pinEntered != workingpin && pinEntered.length == pinlength) ?
            // Container():
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: CustomButton2(btnname:MyString.submit,bg_color: MyColors.lightblueColor,bordercolor: MyColors.lightblueColor,),
            // ),
           // hSizedBox4,
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
            style: TextStyle(
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
