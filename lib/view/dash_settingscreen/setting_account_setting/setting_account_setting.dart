import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/customLoader/customLoader.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constance/sizedbox/sizedBox.dart';
import '../../../services/Apiservices.dart';
import '../../loginscreen/dashboard_LoginScreen.dart';
import '../edit_account_setting.dart';
import 'dart:convert' as convert;


class Setting_Account_setting extends StatefulWidget {
  const Setting_Account_setting({Key? key}) : super(key: key);

  @override
  _Setting_Account_settingState createState() => _Setting_Account_settingState();
}

class _Setting_Account_settingState extends State<Setting_Account_setting> {


  AccountSettingResponse accountSettingResponse = new AccountSettingResponse();
  String Auth="";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadPref();
    WidgetsBinding.instance.addPostFrameCallback((_) =>accountSettingApi(context));

    setState(() {

    });
  }


  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Auth = sharedPreferences.getString("auth").toString();

    print("Auth>" + Auth);


    //  WidgetsBinding.instance.addPostFrameCallback((_) =>BankAccountSiledApi());

    setState(() {});
  }


  void Update(){
    WidgetsBinding.instance.addPostFrameCallback((_) =>accountSettingApi(context));

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: MyColors.light_primarycolor2,
              flexibleSpace:   Container(
                padding: EdgeInsets.fromLTRB(22, 30, 20, 0),
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("s_asset/images/leftarrow.svg",height: 32,
                            width: 32)
                    ),

                    Center(
                      child: Container(
                       // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                        child:  Text(
                          "Account Settings",
                          style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              fontFamily:
                              "s_asset/font/raleway/raleway_extrabold.ttf"),
                        )
                        ,
                      ),
                    ),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => EditAccountSettingScreen(accountSettingResponse: accountSettingResponse, Oncallback: Update,)));
                        },
                        child: SvgPicture.asset("s_asset/images/edit.svg")),

                  ],
                ) ,
              ),

            ),
          ),
          body: SafeArea(
            child:
            Container(
              // height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                children: <Widget>[
                  Container(height: 300,color: MyColors.light_primarycolor2,),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: MyColors.whiteColor,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:
                      accountSettingResponse.status==true? Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  Text(
                                        "Name",
                                        style: TextStyle(
                                            color: MyColors.greycolor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child:  Text(
                                       accountSettingResponse.data!.userData!.name.toString(),
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  Text(
                                        "Email",
                                        style: TextStyle(
                                            color: MyColors.greycolor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child:  Text(
                                        accountSettingResponse.data!.userData!.email.toString(),
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  Text(
                                        "Phone Number",
                                        style: TextStyle(
                                            color: MyColors.greycolor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child:  Text(
                                        accountSettingResponse.data!.userData!.mobileNumber.toString(),
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  Text(
                                        "Birthdate",
                                        style: TextStyle(
                                            color: MyColors.greycolor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child:  Text(
                                          accountSettingResponse.data!.userData!.dob.toString()=="null"?"":Utility.DatefomatToYYYYMMTOMMDD(accountSettingResponse.data!.userData!.dob.toString()),
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  Text(
                                        "Country",
                                        style: TextStyle(
                                            color: MyColors.greycolor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child:  Text(
                                        accountSettingResponse.data!.userData!.countryName.toString(),
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  Text(
                                        "State",
                                        style: TextStyle(
                                            color: MyColors.greycolor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child:  Text(
                                        accountSettingResponse.data!.userData!.stateName.toString(),
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  Text(
                                        "Address",
                                        style: TextStyle(
                                            color: MyColors.greycolor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child:  Text(
                                          accountSettingResponse.data!.userData!.address.toString(),
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  Text(
                                        "Zip Code",
                                        style: TextStyle(
                                            color: MyColors.greycolor,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child:  Text(
                                          accountSettingResponse.data!.userData!.zipcode.toString(),
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                        ),
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              ),

                              hSizedBox,
                              GestureDetector(
                                onTap: (){
                                  setState(() {

                                  });
                                  // logout();
                                  // logoutdialog(context);
                                  dialogDeleteAccount(context);
                                },
                                child: Container(
                                  height: 50,
                                  margin: EdgeInsets.fromLTRB(00, 50, 0, 0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          "a_assets/icons/delete.svg",
                                          width: 20),
                                      Container(
                                        margin:
                                        EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Text(
                                          "Delete Account",
                                          style: TextStyle(
                                              color: MyColors.color_ED5565,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              fontFamily:
                                              "s_asset/font/raleway/raleway_bold.ttf"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ):Container(),
                    ),
                  )
                ],
              ),
            ),
          ),

        )
    );
  }



  Future <void> accountSettingApi(BuildContext context,) async {

   CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    var userid = p.getString("userid");
    var auth = p.getString("auth");
    var request = {};
    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.accountSetting_URl),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      accountSettingResponse  = await AccountSettingResponse.fromJson(jsonResponse);
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {

      });
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      CustomLoader.ProgressloadingDialog6(context, false);


      setState(() {

      });
    }
    return;
  }


  dialogDeleteAccount(BuildContext context) {

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[


                Container(
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        SizedBox(height: 10,),




                        Text(
                          "Are you sure, you want to Delete?",
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                        ),


                        SizedBox(height: 40,),

                        Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: ElevatedButton(
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
                                onPressed: () {

                                  // Navigator.pop(context);
                                  Navigator.of(context, rootNavigator: true).pop(context);

                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                /* shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),*/
                                //  color: MyColors.darkbtncolor,
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex:1,
                              child: ElevatedButton(
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

                                  delete_userapi(context);

                                  setState(() {

                                  });

                                },

                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10,),
                      ],
                    ),
                  ),),



              ],
            ),
          ),
        ),
      ),
    );

  }

  Future<void> delete_userapi(BuildContext context ) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Apiservices.delete_userapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN":"${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });
    print(response.body);

    if (response.statusCode == 200) {
      p.setBool("login", false);
      Utility.showFlutterToast( "Delete Successfully");
      Navigator.of(context, rootNavigator: true).pop(context);
      CustomLoader.ProgressloadingDialog6(context, false);

      pushNewScreen(
        context,
        screen: DashboardLoginScreen(),
        withNavBar: false,
      );

    } else {
      // List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast( "Invalid Request");
      Navigator.of(context, rootNavigator: true).pop(context);
      CustomLoader.ProgressloadingDialog6(context, false);
      // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

}