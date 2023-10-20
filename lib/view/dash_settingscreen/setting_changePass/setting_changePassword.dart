import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/setup_new_pin_code_screen/setup_newpin_Code_screen.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/dash_settingscreen/setting_account_setting/front_image.dart';

import '../../../s_Api/s_utils/Utility.dart';
bool _isObscureoldpassword = true;
bool _isObscurenewpassword = true;
bool _isObscureconfirmpassword = true;
class SettingChangePasswordScreen extends StatefulWidget {
  const SettingChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _SettingChangePasswordScreenState createState() =>
      _SettingChangePasswordScreenState();
}

class _SettingChangePasswordScreenState extends State<SettingChangePasswordScreen> {
  String? status_title;
  /// TextEditingController
  TextEditingController current_passController = TextEditingController();
  TextEditingController new_passController = TextEditingController();
  TextEditingController confirm_passController = TextEditingController();
  /// FocusNode
  FocusNode currentpassFocusNode = FocusNode();
  FocusNode newpassFocusNode = FocusNode();
  FocusNode confirmpassFocusNode = FocusNode();

  String old_passerror = "";
  bool is_oldpasserror = false;
  Color currentpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color currentpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  String passerror = "";
  bool is_passerror = false;
  bool is_showpasseooer = false;
  Color newpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color newpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  bool is_confirmpasserror = false;
  String confirmpasserror = "";
  Color confirmpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color confirmpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);







  bool load = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentpassFocusNode.unfocus();
    newpassFocusNode.unfocus();
    confirmpassFocusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
  }

  settingChangePassworddata() async{
    setState(() {
      load = true;
    });
    await Webservices.changepasswordRequest(context, current_passController.text, new_passController.text, confirm_passController.text);

    setState(() {
      load = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: MyColors.light_primarycolor2,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child:   AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: MyColors.light_primarycolor2,
                flexibleSpace: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(23, 30, 20, 0),
                  child: Row(

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
                      // wSizedBox3,
                      // wSizedBox3,
                      //  wSizedBox,
                      Container(
                        // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                        child: Text(
                          MyString.change_password,
                          style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              fontFamily:
                              "s_asset/font/raleway/raleway_extrabold.ttf"),
                        ),
                      ),
                      Container()
                    ],
                  ),
                ),
              ),

            ),
          // bottomSheet: Container(
          //   height: 80,
          //   child:   Padding(
          //     padding:  EdgeInsets.only(top:56.0),
          //     child: Align(
          //
          //       alignment: Alignment.center,
          //       child: ElevatedButton(
          //         child: Text(MyString.update_password),
          //         onPressed: () {
          //           currentpassFocusNode.unfocus();
          //           newpassFocusNode.unfocus();
          //           confirmpassFocusNode.unfocus();
          //         },
          //         style: ElevatedButton.styleFrom(
          //             primary: MyColors.lightblueColor,
          //             padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          //
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.all(Radius.circular(16.0))
          //             ),
          //             textStyle: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold)),
          //       ),
          //     ),
          //   ),
          // ),
          body: Container(
           // height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  color: MyColors.light_primarycolor2,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                        color: MyColors.whiteColor,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                          child: SingleChildScrollView(
                            child: Column(
                                children: [
                                  hSizedBox3,

                                  Container(
                                    width: size.width * 0.6,
                                    margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                                    child: Text(
                                      MyString.update_your_password,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: MyColors.blackColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          fontFamily:
                                          "s_asset/font/raleway/raleway_bold.ttf"),
                                    ),
                                  ),
                                  hSizedBox5,

                                  Column(
                                    children: [
                                      Container(
                                        child:textfield(current_passController,MyString.current_password,currentpassFocusNode,TextInputType.text,TextInputAction.next),
                                      ),
                                      is_oldpasserror == true ?  Container(
                                        margin:  EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                                        alignment: Alignment.topLeft,
                                        child: Text(old_passerror,style: TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                                          : Container()
                                    ],
                                  ),

                                  hSizedBox2,
                                  Column(
                                    children: [
                                      Container(
                                        child:newpasstextfield(new_passController,MyString.new_password,newpassFocusNode,TextInputType.text,TextInputAction.next),
                                      ),
                                      is_showpasseooer == true ?  Container(
                                        margin:  EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                                        alignment: Alignment.topLeft,
                                        child: Text(passerror,style: TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                                          : Container()
                                    ],
                                  ),
                                  hSizedBox2,
                                  Column(
                                    children: [
                                      Container(
                                        child: oldpasstextfield(confirm_passController,MyString.confirm_new_password,confirmpassFocusNode,TextInputType.text,TextInputAction.done),
                                      ),
                                      is_confirmpasserror == true ?  Container(
                                        margin:  EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                                        alignment: Alignment.topLeft,
                                        child: Text(confirmpasserror,style: TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                                          : Container()
                                    ],
                                  ),



                                  hSizedBox5,
                                  GestureDetector(
                                    onTap: (){
                                      currentpassFocusNode.unfocus();
                                      newpassFocusNode.unfocus();
                                      confirmpassFocusNode.unfocus();

                                      print("shdhfgrjefgg");
                                      if(current_passController.text.isEmpty){
                                        print("gwdgfehg");
                                        is_oldpasserror = true;
                                        currentpassbordercolor = MyColors.red;
                                        currentpassfillcolor = MyColors.red.withOpacity(0.03);
                                        old_passerror = "Please enter Current Password";
                                        setState(() {});
                                        Utility.showFlutterToast( "Please enter Current Password");
                                      }
                                      else if(new_passController.text.isEmpty){
                                        print("sfej");
                                        is_oldpasserror = false;
                                        currentpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                        currentpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                        newpassfillcolor = MyColors.red.withOpacity(0.03);
                                        newpassbordercolor = MyColors.red.withOpacity(0.03);

                                        passerror =  'Pleser enter password';
                                        is_passerror = false;
                                        is_showpasseooer = true;

                                        Utility.showFlutterToast( "Please enter new Password");
                                      }
    else {
    is_oldpasserror = false;
    is_passerror = false;
    is_confirmpasserror = false;
    is_showpasseooer = false;

    newpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);
    newpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);

    confirmpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
    newpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

    currentpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
    currentpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

    setState(() {});
    settingChangePassworddata();
    }

/*
                                      else
                                      {
                                        if (!RegExp('.*[A-Z].*').hasMatch(
                                            new_passController.text ?? '')) {

                                          passerror =  'Input should contain an (uppercase) ';
                                          is_passerror = false;

                                        }
                                       else if (!RegExp('.*[a-z].*').hasMatch(
                                            new_passController.text ?? '')) {
                                          if(is_passerror) {
                                            passerror =
                                            "Input should contain a (lowercase)";
                                          }
                                          else
                                          {
                                            passerror = passerror+" , "+"a (lowercase)";

                                          }
                                          is_passerror = false;
                                          is_showpasseooer = true;

                                          setState(() {});
                                        }
                                       else if (!RegExp('.[!@#\$&*~].*').hasMatch(
                                            new_passController.text ?? '')) {
                                          if(is_passerror) {
                                            passerror =
                                            "Input should contain a (special character)";
                                          }
                                          else
                                          {
                                            passerror = passerror+","+"(special character)";

                                          }
                                          is_passerror = false;
                                          is_showpasseooer = true;
                                          setState(() {});
                                        }
                                       else if (!RegExp(".*[0-9].*").hasMatch(
                                            new_passController.text ?? '')) {
                                          if(is_passerror) {
                                            passerror = "Input should contain a (Number)";
                                          }
                                          else
                                          {
                                            passerror = passerror+","+"a (Number)";

                                          }
                                          is_passerror = false;

                                          setState(() {});
                                        }

                                       else if(is_passerror) {
                                          if (confirm_passController.text
                                              .isEmpty) {
                                            is_passerror = false;
                                            is_oldpasserror = false;
                                            is_confirmpasserror = true;
                                            newpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                            newpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);

                                            confirmpassbordercolor = MyColors.red;
                                            confirmpassfillcolor = MyColors.red.withOpacity(0.03);

                                            currentpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                            currentpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                      passerror = "";
                                      confirmpasserror = "Please enter confirm Password";
                                      setState(() {});
                                      Fluttertoast.showToast(
                                      msg: "Please enter confirm Password");
                                      }

                                          else if (new_passController.text ==
                                              confirm_passController.text
                                                  .isEmpty) {
                                            is_passerror = false;
                                            is_oldpasserror = false;
                                            is_confirmpasserror = true;
                                            is_showpasseooer = false;
                                            newpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                            newpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);

                                            confirmpassbordercolor = MyColors.red;
                                            confirmpassfillcolor = MyColors.red.withOpacity(0.03);

                                            currentpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                            currentpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                            passerror = "Not match Password";
                                            confirmpasserror =
                                            "Not match Password";
                                            setState(() {});

                                          }
                                        else {
                                          is_oldpasserror = false;
                                          is_passerror = false;
                                          is_confirmpasserror = false;
                                          is_showpasseooer = false;

                                          newpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                          newpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);

                                          confirmpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                          newpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                          currentpassbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                          currentpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                          setState(() {});
                                          settingChangePassworddata();
                                        }
                                      }
                                        else
                                        {
                                          is_showpasseooer = true;
                                          newpassfillcolor = MyColors.red.withOpacity(0.03);
                                          newpassbordercolor = MyColors.red;
                                          print(passerror);
                                        }


                                      }*/

                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, ),
                                      child: CustomButton2(btnname: MyString.update_password,bg_color: MyColors.lightblueColor,bordercolor: MyColors.lightblueColor,height: 55,),
                                    ),
                                  ),


                                ]
                            ),
                          ),
                        )
                    )),
                ]
          ),
        )));
  }



  textfield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color:  currentpassfillcolor,
          border: Border.all(color: currentpassbordercolor),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        obscureText: _isObscureoldpassword,
        textInputAction: textInputAction,
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                _isObscureoldpassword ? Icons.visibility_off : Icons.visibility,
                color:
                //ispasserror == true ? MyColors.red :
                MyColors.greycolor,
              ),
              onPressed: () {
                setState(() {
                  print("_isObscure >>>>>>>>>>" + _isObscureoldpassword.toString());
                  _isObscureoldpassword = !_isObscureoldpassword;
                });
              }),
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.all(22),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  newpasstextfield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: newpassfillcolor,
          borderRadius: BorderRadius.circular(15),
      border: Border.all(color: newpassbordercolor,width: 1)
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        obscureText: _isObscurenewpassword,
        textInputAction: textInputAction,
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                _isObscurenewpassword ? Icons.visibility_off : Icons.visibility,
                color:
                //ispasserror == true ? MyColors.red :
                MyColors.greycolor,
              ),
              onPressed: () {
                setState(() {
                  print("_isObscure >>>>>>>>>>" + _isObscurenewpassword.toString());
                  _isObscurenewpassword = !_isObscurenewpassword;
                });
              }),
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.all(22),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }
  oldpasstextfield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: confirmpassfillcolor,
          borderRadius: BorderRadius.circular(10),
      border: Border.all(color: confirmpassbordercolor)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        obscureText: _isObscureconfirmpassword,
        textInputAction: textInputAction,
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(
                _isObscureconfirmpassword ? Icons.visibility_off : Icons.visibility,
                color:
                //ispasserror == true ? MyColors.red :
                MyColors.greycolor,
              ),
              onPressed: () {
                setState(() {
                  print("_isObscure >>>>>>>>>>" + _isObscureconfirmpassword.toString());
                  _isObscureconfirmpassword = !_isObscureconfirmpassword;
                });
              }),
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.all(22),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

}

confirfationDialog(BuildContext context){
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomConfirmationDialog(context),
            )
        );
      }
  );}


CustomConfirmationDialog(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Wrap(
      children: [
        Container(
         // padding: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            "a_assets/logo/success_img.svg",
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 25),
          alignment: Alignment.center,
          child: Text(MyString.your_new_pincode_has_been_saved,textAlign: TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),),
        ),
        Container(
          padding: EdgeInsets.only(top: 40),
          //  alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  //  width: 100,
                    child: Material(
                      color: MyColors.color_3F84E5,
                      elevation: 0.1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //  color: MyColors.ligh
                            //  border: Border.all(color: bordercolor,width: 1.4)
                          ),
                          child: Center(child: Text(MyString.ok,style: TextStyle(fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",color:MyColors.whiteColor,fontSize:14,fontWeight: FontWeight.w700,letterSpacing: 0.4 ),))),
                    )

                ),
              ),


            ],
          ),
        )
      ],
    ),
  );
}
showbottomsheet(BuildContext context) {
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    backgroundColor: MyColors.whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    context: context,
    builder: (BuildContext context) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.86,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: SetupNewPinCodeScreen());
    },
  );
}