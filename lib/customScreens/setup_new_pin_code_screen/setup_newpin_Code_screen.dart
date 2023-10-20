import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/customHomecardui.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/dash_settingscreen/setting_forgot_pin/setting_forgot_pinCode_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../model/customlists/customLists.dart';
import '../../s_Api/s_utils/Utility.dart';

void Update(){}
class SetupNewPinCodeScreen extends StatefulWidget {
  Function Oncallback;
  SetupNewPinCodeScreen({Key? key, this.Oncallback=Update}) : super(key: key);


  @override
  _SetupNewPinCodeScreenState createState() => _SetupNewPinCodeScreenState();
}

class _SetupNewPinCodeScreenState extends State<SetupNewPinCodeScreen> {
  /// create number list
  List<int> firstlist = [1, 2, 3];
  List<int> secondlist = [4, 5, 6];
  List<int> thirdlist = [7, 8, 9];

  int pinlength = 4;
  String pinEntered ="";
  //String workingpin = "123456";
  String alert = "";
  bool isforgot = false;

  bool load=  false;


  numberClicked(int item){


    if(pinEntered.length < pinlength){
      pinEntered = pinEntered + item.toString();
      print("object${pinEntered}");
      print("jbbjfdj");

     // alert =(pinEntered == workingpin) ? "Good luck" : "Incorrect please try again";
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

  setuppinApi()async{
    setState(() {
      load = true;
    });
    await Webservices.setpinRequest(context, pinEntered);

    setState(() {
      load = false;
      this.widget.Oncallback!();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          hSizedBox1,

          /// Setup New Pin Code
          Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Text(
              MyString.setup_new_pin_code,
              style: TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
              fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
            ),
          ),

          /// please enter your pin

          hSizedBox1,
          Container(
            width: size.width*0.7,
           // padding: EdgeInsets.only(left: 30,right: 30),
            alignment: Alignment.center,
            child: Text(
              MyString.please_enter_your_pin_code_you,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.blackColor.withOpacity(0.20),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),

          hSizedBox4,
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.circle_fill,
                  color: pinEntered.length >= 1?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                  size: 9,
                ),
                wSizedBox1,
                Icon(
                  CupertinoIcons.circle_fill,
                  color:pinEntered.length >= 2 ?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                  size: 9,
                ),
                wSizedBox1,
                Icon(
                  CupertinoIcons.circle_fill,
                  color:pinEntered.length >= 3?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                  size: 9,
                ),
                wSizedBox1,
                Icon(
                  CupertinoIcons.circle_fill,
                  color: pinEntered.length >= 4?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                  size: 9,
                ),
                // wSizedBox1,
                // Icon(
                //   CupertinoIcons.circle_fill,
                //   color:pinEntered.length >= 5?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                //   size: 9,
                // ),
                // wSizedBox1,
                // Icon(
                //   CupertinoIcons.circle_fill,
                //   color:pinEntered.length == 6?MyColors.lightblueColor:  MyColors.lightblueColor.withOpacity(0.30),
                //   size: 9,
                // ),
              ],
            ),
          ),

          // Container(
          //   alignment: Alignment.center,
          //   child: Text(alert,style: TextStyle(color: (pinEntered == workingpin)? MyColors.greenColor:MyColors.red,fontSize: 13),),
          // ),

          /// number ui

          hSizedBox3,
          //numberButton(1),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: firstlist.map((e) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    numberClicked(e);
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric( vertical: 10),
                      child: numberButton(e)),
                );
              }).toList(),
            ),
          ),

          hSizedBox3,

          /// number button2
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: secondlist.map((e) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  pinlength.toString().length == 4 ? Container(): numberClicked(e);
                },
                child: Container(
                    padding: EdgeInsets.symmetric( vertical: 10),
                    child: numberButton(e)),
              );
            }).toList(),
          ),

          hSizedBox3,

          /// number button3
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: thirdlist.map((e) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  pinlength.toString().length == 4 ? Container():  numberClicked(e);
                },
                child: Container(
                    padding: EdgeInsets.symmetric( vertical: 15),
                    child: numberButton(e)),
              );
            }).toList(),
          ),

          hSizedBox3,

          /// number button4
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only( top: 15),
                child: InkWell(
                    onTap: () {
                      backSpace();
                    },
                    child: Container(
                      width: 70,
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        "a_assets/icons/close_square.svg",
                        height: 25,
                        width: 25,
                      ),
                    ),
                    //Icon(CupertinoIcons.clear_fill,color: MyColors.blackColor,)
                ),
              ),

              Padding(padding: EdgeInsets.only( top: 15,right: 55),child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                 pinlength.toString().length == 4 ? Container():

                 pinlength.toString().length == 4 ? Container(): numberClicked(0);
                },
                child: Container(
                  child:  numberButton(0),
                ),
              )),

         //    (pinEntered != workingpin && pinEntered.length == pinlength) ?

              isforgot == true?
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){

                    pushNewScreen(
                      context,
                      screen: SettingForgotPinCodeScreen(),
                      withNavBar: false,
                    );

                },
                child: Container(
                 // height: 20,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only( top: 22),
                  child: Text("Forgot!",style: TextStyle(color: MyColors.lightblueColor,fontSize: 12,fontWeight: FontWeight.w500),),
                ),
              )
                 : Container()
            ]
          ),
          hSizedBox4,
         /* (pinEntered != workingpin && pinEntered.length == pinlength) ?
              Container():*/
        GestureDetector(
            onTap: (){
              isforgot = true;
              if(pinEntered.isEmpty){
                Utility.showFlutterToast( "Please set pin code");
              }else {
                setuppinApi();
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton2(btnname:MyString.submit,bg_color: MyColors.lightblueColor,bordercolor: MyColors.lightblueColor,),
            ),
          ),
          hSizedBox4,
        ],
      ),
    );
  }

  numberButton(int item) {
    return Container(
      alignment: Alignment.topCenter,
       width: 80,
      height: 30,
      child: Text(
        item.toString(),
        style: TextStyle(
            color: MyColors.blackColor,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),
      ),
    );
  }
}
