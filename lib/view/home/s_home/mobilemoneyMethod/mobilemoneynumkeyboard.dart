import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/customkeyboard_screen/customkeyboard_screen.dart';
import 'package:moneytos/customScreens/setup_new_pin_code_screen/setup_newpin_Code_screen.dart';


class MobileMoneyNumberKeyboardScreen extends StatefulWidget{
  @override
  State<MobileMoneyNumberKeyboardScreen> createState() => _MobileMoneyNumberKeyboardScreenState();
}

class _MobileMoneyNumberKeyboardScreenState extends State<MobileMoneyNumberKeyboardScreen> {


  TextEditingController ibanController = TextEditingController();
  FocusNode ibanFocus = FocusNode();

  /// create number list
  List<int> firstlist = [1, 2, 3];
  List<int> secondlist = [4, 5, 6];
  List<int> thirdlist = [7, 8, 9];

  int pinlength = 6;
  String pinEntered ="";
  String workingpin = "123456";
  String alert = "";
  bool is_keyboard = false;


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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ibanFocus.unfocus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.whiteColor,
        centerTitle: true,
        actions: [],
        title: Text(MyString.Select_Delivery_Method,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4),),
      ),


      bottomSheet:   Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: MyColors.whiteColor,
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                //  padding: EdgeInsets.only(top: size.height / 2),
                alignment: Alignment.bottomRight,
                child:Custombtn(MyString.back,70,140,context) ,
              ),
            ),
            GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
              },
              child: addMathodButton(MyString.add_method,70,200),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(

                width:350,
                margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 22.0),
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  border: Border.all(color: MyColors.color_gray_transparent),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.color_gray_transparent,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 4.0,
                    ),
                  ],
                ),


                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("s_asset/images/flag2.svg",width: 24,height: 24,),
                        wSizedBox1,
                        Text(MyString.country_name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                      ],
                    ),
                    SvgPicture.asset("a_assets/icons/clear_red.svg"),

                  ],
                )
            ),
            Container(

                width:350,
                margin:  EdgeInsets.fromLTRB(12.0, 16.0, 0.0, 0.0),
                padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 22.0),
                decoration: BoxDecoration(
                  color: MyColors.whiteColor,
                  border: Border.all(color: MyColors.color_gray_transparent),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.color_gray_transparent,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 4.0,
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
                        Text(MyString.City_Name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                      ],
                    ),
                    SvgPicture.asset("a_assets/icons/clear_red.svg"),

                  ],
                )
            ),

            Column(
              children: [
                hSizedBox2,
                Container(
                    margin: EdgeInsets.only(top: 16,bottom: 20),
                    alignment: Alignment.center,
                    child: Text(MyString.Mobile_Money_Number,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"))),
                hSizedBox4,
                IBAN(),
                is_keyboard == true ?  keyboardNum()
                    : Container()
                //SetupNewPinCodeScreen(),

              ],
            ),
            hSizedBox5,




          ],
        ),
      ),
    );
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
        focusNode: ibanFocus,
        onTap: (){
          is_keyboard = true;
          setState(() {

          });
        },
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
          hintText: "12xx-xxx-xxx-xx",
          suffixIcon: Padding(
            padding: EdgeInsets.all(12),
            child: SvgPicture.asset("a_assets/icons/paste.svg",height: 15,),
          ),
          hintStyle: TextStyle(color: MyColors.blackColor.withOpacity(0.30),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500),
        ),
      ),
    );
  }


  keyboardNum(){
    return Column(
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


  addMathodButton(String text,double height,double width,  ) {
    return  Container(
      height: height,
      // width: width,
      color: MyColors.whiteColor,
      //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
      child: Container(
          padding: EdgeInsets.only(left: 10,right: 10),
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
                MyColors.color_3F84E5.withOpacity(0.88),
                MyColors.color_3F84E5,
              ],
            ),
            //color: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 22),
          child: Center(child: Text(text,style: TextStyle(color: MyColors.whiteColor,fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "s_asset/font/raleway/Bold.ttf"),))),
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
