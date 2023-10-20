import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/model/onboardinModel.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/loginscreen/loginscreen.dart';
import 'package:moneytos/view/select_bank/selectBank_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  List<SliderModel> contents = [
    SliderModel(
      title: MyString.cretae_your_free_account,
      description: MyString.cretae_your_free_desc,
        image: "a_assets/images/onboarding_img/img1.png"
    ),
    SliderModel(
      title: MyString.select_payment_method,
      description: MyString.select_payment_desc,
        image: "a_assets/images/onboarding_img/img2.png"
    ),
    SliderModel(
      title: MyString.select_money_to_recipent,
      description: MyString.select_money_to_desc,
        image: "a_assets/images/onboarding_img/img3.png"
    ),
  ];
  bool isShow = false;
  int currentindex = 0;
  PageController? _controller;
  bool preload = false;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
   // _checkIfLoggedIn();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  late SharedPreferences pre;
  bool check = false;
  void _checkIfLoggedIn() async {
    pre = await SharedPreferences.getInstance();
    var login =  pre.getBool("login");
    print("loginvalue ${login}");
    if (login == true) {
      var emailverify =    pre.getString("emailVerified") ;
      setState(() {
        check = true;

      });
   /*   Timer(
          Duration(seconds: 1),
              ()
          {*/
            emailverify == "1" ?
            Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => DashboardScreen()))
            :  Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreenPage()));

         // }
    //  );
    }
    else{
      setState(() {
        check = false;
        Timer(
            Duration(seconds: 1),
                () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreenPage()));
            }
        );
      });
    }
  }
  //SliderModel content =[];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50),
      //   child: AppBar(
      //     elevation: 0,
      //     backgroundColor: MyColors.whiteColor,
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       // Status bar color
      //       statusBarColor: MyColors.whiteColor,
      //
      //       // Status bar brightness (optional)
      //       statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      //       statusBarBrightness: Brightness.light, // For iOS (dark icons)
      //     ),
      //     // flexibleSpace: Container(
      //     //   padding: EdgeInsets.only(top: size.height/15),
      //     //   child: Row(
      //     //     mainAxisAlignment: MainAxisAlignment.center,
      //     //     children: [
      //     //      //Icon(CupertinoIcons.paperplane_fill),
      //     //       SvgPicture.asset("s_asset/images/send.svg",height: 20,width: 20,color: MyColors.blackColor,),
      //     //       wSizedBox1,
      //     //       Text(
      //     //         MyString.app_name,
      //     //         style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600),
      //     //       ),
      //     //     ],
      //     //   ),
      //     // ),
      //     //centerTitle: true,
      //
      //   ),
      // ),
      body: PageView.builder(
          itemCount: contents.length,
          controller: _controller,
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          onPageChanged: (int index) {
            setState(() {
              currentindex = index;
            });
          },
          itemBuilder: (context, i) {
            return SingleChildScrollView(
              child: Stack(
                // mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                height: MediaQuery.of(context).size.height/1.1,width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(contents[i].image.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Image.asset(contents[i].image.toString(),height: MediaQuery.of(context).size.height/1.1,width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                    child: i==1?Container():Container(
                      child: GFLoader(
                          type: GFLoaderType.custom,
                          child: Image(image: AssetImage("a_assets/images/onboarding_img/logo_onboarding_anim.gif"),
                            // height: MediaQuery.of(context).size.height,
                            // width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ),
                  // hSizedBox6,

                  // /// text title ui
                  Container(
                    height: MediaQuery.of(context).size.height/1.1,
                    padding: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            // padding: EdgeInsets.symmetric(horizontal: 20),
                            // width: size.width * 0.8,
                            child: Text(
                              contents[i].title.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.darkgreen,
                                  letterSpacing: 0.5),
                            )),

                        /// text description ui
                        hSizedBox1,
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 20),
                          //  width: size.width * 0.85,
                            child: Text(
                              contents[i].description.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.blackColor.withOpacity(0.40),
                                  letterSpacing: 0.5),
                            )),
                      ],
                    ),
                  )


                  //Icon(Icons.edit),

                ],
              ),
            );
          }),
      // ),
    bottomNavigationBar: Container(
      alignment: Alignment.bottomCenter,
    //  color: MyColors.blackColor,
      padding: EdgeInsets.symmetric(horizontal: 15),
    width: size.width,
    height: 75,
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    _builddot(currentindex, context),
    _getstarted(currentindex),
    ],
    )


    ),
    );
  }

  _builddot(int index, BuildContext context) {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height * 0.01,
          child: Align(
            alignment: Alignment.center,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: contents.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(

                      height: currentindex == i ? 8 : 8,
                      width: currentindex == i ? 8 : 8,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: currentindex == i
                              ? MyColors.color_3F84E5.withOpacity(0.50)
                              : MyColors.greycolor.withOpacity(0.50)),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  _getstarted(int index) {
    return SizedBox(
      width: 115,
      height: 75,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
          onTap: () async{
            currentindex != 2 ?  await _controller!.nextPage(duration: Duration(microseconds: 100),
                curve: Curves.bounceIn)
            : Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreenPage()));

            pre.setInt("initScreen",1);
          },
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              //  stops: [0.0, 1.0],
                colors: [
                  MyColors.color_3F84E5.withOpacity(0.40),
                  MyColors.color_3F84E5.withOpacity(0.80),
                ],
              ),
              //color: Colors.deepPurple.shade300,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: MyColors.whiteColor,
              size: 25,
            )),
      ),
    );
  }
}
