import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/main.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/dash_settingscreen/setting_account_setting/front_image.dart';
import 'package:moneytos/view/dash_settingscreen/setting_verification_successfully_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/usermodel.dart';
import '../VerificationPage.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';

class Setting_Verification extends StatefulWidget {
  const Setting_Verification({Key? key}) : super(key: key);

  @override
  _Setting_VerificationState createState() => _Setting_VerificationState();
}

class _Setting_VerificationState extends State<Setting_Verification> {

  bool uploadagainbool = false;
  bool loader = false;
  List<UserDataModel>  userlist= [];
  String document_status = "";
  String actual_status = "";

  getprofiledata() async{
    userlist.clear();
    await Webservices.profileRequest(context, userlist);
    print(userlist.length);
    // passport_type = (userlist.length > 0 ? "${userlist[0].documentStatus == null || userlist[0].documentStatus.toString().isEmpty? "": userlist[0].documentStatus}" : "");
    actual_status = (userlist.length > 0 ? "${userlist[0].documentStatus == null || userlist[0].documentStatus.toString().isEmpty? "": userlist[0].documentStatus}" : "");
    document_status = (userlist.length > 0 ? "${userlist[0].documentStatus == null || userlist[0].documentStatus.toString().isEmpty? "": userlist[0].documentStatus}" : "");
    document_status = document_status == "pending"?"Incomplete":document_status=="Complete"?"pending":document_status ;
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    // getDocumentApi();
    getprofiledata();

  }


  @override
  Widget build(BuildContext context) {

    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: MyColors.light_primarycolor2,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: MyColors.light_primarycolor2,
              flexibleSpace:          Container(
                padding: EdgeInsets.fromLTRB(22, 30, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {

                          Navigator.of(context).pop();

                          setState(() {

                          });
                        },
                        child: SvgPicture.asset(
                          "s_asset/images/leftarrow.svg",
                            height: 32,
                            width: 32
                        )),
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                        child: Text(
                          MyString.verification,
                          style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              fontFamily:
                              "s_asset/font/raleway/raleway_extrabold.ttf"),
                        ),
                      ),
                    ),
                    Container(width: 20,)
                  ],
                ),
              ),

            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  color: MyColors.light_primarycolor2,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),


                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  color: MyColors.whiteColor,
                  child: Column(children: [

                    SizedBox(height: 100,),
                    actual_status == "Approved"?
                    Container(
                        alignment: Alignment.center,
                        child:
                        SvgPicture.asset("a_assets/logo/success_img.svg")
                    ):Container(
                        alignment: Alignment.center,
                        child:
                        SvgPicture.asset("a_assets/logo/confirm_img.svg")
                    ),

                    document_status == "Blank"?
                    Container():
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Verification status : ${document_status}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                      ),
                    ),


                    SizedBox(height: 20,),

                    actual_status == "expired"|| actual_status =="Rejected" ||actual_status =="declined"?
                        Column(children: [
                          Text(
                            "Please re upload verification.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                          ),


                          SizedBox(height: 20,),

                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                                foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    )
                                )
                            ),
                            onPressed: () async {
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              Navigator.of(context,rootNavigator: true);
                              pushNewScreen(
                                context,
                                screen: LoginVerificatrionDetailScreen(),
                                withNavBar: false,
                              );
                            },
                            // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10.0)),
                            // color: MyColors.darkbtncolor,
                            child: Text(
                              "If you want to update verification Click Here"
                              ,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                            ),
                          ),

                          SizedBox(height: 20,),
                        ],
                        ):Container(),




                    actual_status == "Blank"?
                    Column(children: [



                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                            foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                )
                            )
                        ),
                        onPressed: () async {
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          Navigator.of(context,rootNavigator: true);
                          pushNewScreen(
                            context,
                            screen: LoginVerificatrionDetailScreen(),
                            withNavBar: false,
                          );
                        },
                        // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10.0)),
                        // color: MyColors.darkbtncolor,
                        child: Text(
                          "Verify Your Account"
                          ,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                        ),
                      ),

                      SizedBox(height: 20,),
                    ],
                    ):Container(),



                    document_status == "Incomplete"?
                    Column(children: [
                      Text(
                        "Your Verification is incomplete , Please re upload verification.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                      ),

                      SizedBox(height: 20,),


                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                            foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                )
                            )
                        ),
                        onPressed: () async {
                          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          Navigator.of(context,rootNavigator: true);
                          pushNewScreen(
                            context,
                            screen: LoginVerificatrionDetailScreen(),
                            withNavBar: false,
                          );
                        },
                        // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10.0)),
                        // color: MyColors.darkbtncolor,
                        child: Text(
                          "If you want to update verification Click Here"
                          ,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                        ),
                      ),

                      SizedBox(height: 20,),
                    ],
                    ):Container(),




                    document_status == "Pending"?
                    Column(children: [
                      Text(
                        "We will notify you as soon as you’re approved.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                      ),


                      SizedBox(height: 20,),
                    ],
                    ):Container(),

                  ],),
                ),

                // document_status == "Blank"?
                // VerifyDocumentbody()
                //     :
                // uploadsuccefully()
                // ,

              loader == true?  Container(
                child: Container(
                  color: Colors.white,
                  child: Card(
                    color: MyColors.whiteColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    child: Center(
                        child: GFLoader(
                            type: GFLoaderType.custom,
                            child: Image(image: AssetImage("a_assets/logo/progress_image.png"),
                            ))
                    ),
                  ),
                )
              ): Container()

              ],
            ),
          ),
        ));
  }
}
