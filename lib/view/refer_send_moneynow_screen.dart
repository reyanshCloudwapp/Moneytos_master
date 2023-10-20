import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constance/customLoader/customLoader.dart';
import '../constance/myStrings/myString.dart';
import '../s_Api/AllApi/ApiService.dart';
import '../s_Api/S_ApiResponse/ReferListResponse.dart';
import '../s_Api/s_utils/Utility.dart';
import '../services/Apiservices.dart';
import 'dash_settingscreen/refer_a_friendScreen/refer_a_friendScreen.dart';
import 'dart:convert' as convert;

class ReferSendMoneyScreen extends StatefulWidget {
  const ReferSendMoneyScreen({Key? key}) : super(key: key);

  @override
  State<ReferSendMoneyScreen> createState() => _ReferSendMoneyScreenState();
}

class _ReferSendMoneyScreenState extends State<ReferSendMoneyScreen> {
  ReferlistResponse referlistResponse = new ReferlistResponse();
  String referral_id = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pref();
    WidgetsBinding.instance.addPostFrameCallback((_) =>referral_listapi(context));
  }

  void Update(){
    print("Refer Update");
    WidgetsBinding.instance.addPostFrameCallback((_) =>referral_listapi(context));
  }

  Future<void> pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    referral_id = sharedPreferences.getString("referral_id").toString();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child:   AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: MyColors.light_primarycolor2,
          flexibleSpace: Container(
            padding: EdgeInsets.fromLTRB(22, 50, 20, 0),
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

                //  wSizedBox,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.refe_friend,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                        "s_asset/font/raleway/raleway_extrabold.ttf"),
                  ),
                ),
                wSizedBox2
              ],
            ),
          ),
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
            //padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 0,
              color: MyColors.whiteColor,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: MyColors.light_primarycolor2,
                        height: 70,
                      ),

                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: MyColors.pink,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 165,
                          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text(
                              "Refer your friend and earn free transfers!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                            ),
                            SizedBox(height: 20,),
                            Text(
                              "Refer & Earn: Get a free transfer when your referral signs up and makes their first transfer.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                            ),
                          ],),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 38,),

                  Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your Referrals",
                      style: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                    ),
                  ),


                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        hSizedBox,
                        Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              referlistResponse.status == true?
                              referlistResponse.data!.referralData!.isNotEmpty?
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: referlistResponse.data!.referralData!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment : Alignment.centerLeft,
                                            child: Text(
                                              referlistResponse.data!.referralData![index].name.toString(),
                                              style: TextStyle(
                                                  color: MyColors.blackColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                                            ),
                                          ),

                                          SizedBox(height: 12,),

                                          Divider()
                                        ],
                                      ),
                                    );
                                  }
                              ):Container(
                                height: size.height/1.5,
                                alignment: Alignment.center,
                                child: Text("No Data",style: TextStyle(fontSize: 18),),
                              ):Container(
                                height: size.height/1.5,
                                alignment: Alignment.center,
                                child: Text("No Data",style: TextStyle(fontSize: 18),),
                              ),
                              // userlistcard("Today",MyColors.blackColor.withOpacity(0.05),"Sent",MyColors.primaryColor),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.blackColor.withOpacity(0.05),"Sent",MyColors.primaryColor),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.orange.withOpacity(0.08),"Viewed",MyColors.orange),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.greenColor.withOpacity(0.08),"Joined",MyColors.greenColor),
                              // hSizedBox3,
                              // youearnedcard(),
                              // hSizedBox3,
                              // userlistcard("Today",MyColors.blackColor.withOpacity(0.05),"Sent",MyColors.primaryColor),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.blackColor.withOpacity(0.05),"Sent",MyColors.primaryColor),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.orange.withOpacity(0.08),"Viewed",MyColors.orange),
                              // hSizedBox6,
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        // color: MyColors.whiteColor,
          height: 140,
          decoration: BoxDecoration(
            color: MyColors.whiteColor,
            /*gradient: LinearGradient(
           begin: Alignment.center,
           end: Alignment.bottomCenter,
           //  stops: [0.0, 1.0],
           colors: [
             MyColors.lightblueColor
                 .withOpacity(0.01),
             MyColors.lightblueColor
                 .withOpacity(0.01),
           ],
         ),*/
          ),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 35,horizontal: 20),
          child:  GestureDetector(
            onTap:(){

              share();

            },
            child: Container(
                width:MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom:25,left: 20,right: 20,),
                child: Material(
                    elevation: 2,
                    shadowColor: MyColors.light_primarycolor2,
                    //shadowColor: MyColors.lightblueColor.withOpacity(0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          //  stops: [0.0, 1.0],
                          colors: [
                            MyColors.light_primarycolor2,
                            MyColors.light_primarycolor2,
                          ],
                        ),
                        //    border: Border.all(color: bordercolor,width: 1.4)
                      ),
                      child: Container(alignment: Alignment.center, child: Text(MyString.share,style: TextStyle(fontFamily: "s_asset/font/raleway/raleway_bold.ttf",color:MyColors.whiteColor,fontSize: 16,fontWeight: FontWeight.w700,letterSpacing: 0.7 ),)),
                    )
                )
            ),
          )
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Moneytos',
        text: "Sign up with my referral code ${referral_id} \n"+AllApiService.personabashurl+"refferallink",
        chooserTitle: 'Moneytos'
    );
  }

  userlistcard(String day,Color color,btnname,Color textcolor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(color: MyColors.lightblueColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Friend Name",
                  style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                ),
              ),
              Container(
                child: Text(
                  day,
                  style: TextStyle(
                      color: MyColors.blackColor.withOpacity(0.50),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
                ),
              )
            ],
          ),
          hSizedBox,
          Container(
            child: Text(
              "heshamsqrat@gmail.com",
              style: TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
            ),
          ),
          hSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "121345646545",
                  style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color:color,
                  borderRadius: BorderRadius.circular(50)
                    ),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text(
                  btnname,
                  style: TextStyle(
                      color: textcolor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  youearnedcard() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "You Earned",
                  style: TextStyle(
                      color: MyColors.blackColor.withOpacity(0.50),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                ),
              ),

              Row(
                children: [
                  Container(
                    child: Text(
                      "2",
                      style: TextStyle(
                          color: MyColors.lightblueColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),
                    ),
                  ),
                  wSizedBox,
                  Container(
                    child: Text(
                      "Free Transaction",
                      style: TextStyle(
                          color: MyColors.blackColor.withOpacity(0.50),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Container(
            width: 100,

            child: CustomButton2(btnname: "Redeem",fontsize: 14,bg_color: MyColors.lightblueColor,bordercolor: MyColors.lightblueColor,height: 45,),
          )
        ],
      ),
    );
  }

  Future <void> referral_listapi(BuildContext context,) async {

    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};

    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.referral_listapi),
        // body: convert.jsonEncode(request),
        headers: {

          "X-AUTHTOKEN":"${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog6(context, false);
      referlistResponse = await ReferlistResponse.fromJson(jsonResponse);

      setState(() {

      });
    } else {
      CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {

      });
    }
    return;
  }


}
