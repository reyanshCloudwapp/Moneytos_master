import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/home_history/download_receipt_screen.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constance/customLoader/customLoader.dart';
import '../../../../model/txn_detail_response.dart';
import '../../../../s_Api/AllApi/ApiService.dart';
import '../../../../s_Api/S_ApiResponse/GetStatusResponse.dart';
import '../../../../s_Api/s_utils/Utility.dart';
import 'dart:convert' as convert;

import '../../../../services/Apiservices.dart';

class SendSuccessfullyTransferScreen extends StatefulWidget{
  String readyremit_transferId;
  String sendAmount;
  String transfer_reason;
  String fees;
  SendSuccessfullyTransferScreen({Key? key,required this.readyremit_transferId,required this.sendAmount,required this.transfer_reason,required this.fees}) : super(key: key);
  @override
  State<SendSuccessfullyTransferScreen> createState() => _SendSuccessfullyTransferScreenState();
}

class _SendSuccessfullyTransferScreenState extends State<SendSuccessfullyTransferScreen> {
  TxnDetailResponse txnDetailResponse = new  TxnDetailResponse();
  String txn_status="";
  String u_phone_number = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>txnDetailapi(context));
    clearAllTransactionValue();
    pref();
    setState(() {});
  }

  Future<void> pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    u_phone_number = sharedPreferences.getString("u_phone_number").toString();

    try{
      u_phone_number = u_phone_number.substring(u_phone_number.length-3,u_phone_number.length);
    }catch(ex){
      u_phone_number = "";
    }
    print("u_phone_number>>> "+u_phone_number);
    setState(() {

    });
  }

  clearAllTransactionValue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("dstCurrencyIso3Code","");
    sharedPreferences.setString("dstCountryIso3Code","").toString();
     sharedPreferences.setString("sourceCurrencyIso3Code","").toString();
    sharedPreferences.setString("sendAmount","").toString();
    sharedPreferences.setString("recipientId","").toString();
    sharedPreferences.setString("senderId","").toString();
    sharedPreferences.setString("BankdetailResponse","").toString();
    sharedPreferences.setString("exchangerate","").toString();
    sharedPreferences.setString("fees","").toString();
    sharedPreferences.setString("reasonsending_id","").toString();
    sharedPreferences.setString("reasonsending_name","").toString();
    sharedPreferences.setString("u_first_name","").toString();
    sharedPreferences.setString("u_last_name","").toString();
    sharedPreferences.setString("u_profile_img","").toString();
    sharedPreferences.setString("receiveAmount","").toString();
    sharedPreferences.setString("select_payment_method_status","").toString();
    sharedPreferences.setString("recipientReceiveBankOrMobileNo","").toString();
    sharedPreferences.setString("recipientReceiveBankNameOrOperatorName","").toString();
    setState(() {});
  }
  Future<bool> _willPopCallback() async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        DashboardScreen()), (Route<dynamic> route) => false);
    return true; // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: MyColors.whiteColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.whiteColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.whiteColor,
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),

          ),
        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                hSizedBox5,

                Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("a_assets/logo/success_img.svg")
                ),
                hSizedBox4,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        double.parse(widget.sendAmount).toStringAsFixed(2),
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf"),
                      ),
                    ),
                    wSizedBox,
                    Container(
                      padding: EdgeInsets.only(bottom: 3),
                      alignment: Alignment.center,
                      child: Text(
                        MyString.usd,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),
                      ),
                    ),

                  ],
                ),

                hSizedBox4,

                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.Send_Successfuly,
                    style: TextStyle(
                        color: MyColors.greenColor2,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),
                  ),
                ),

                hSizedBox2,

                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "We will send SMS to Recipient\n Phone Number **${u_phone_number} with Transfer update,\nand you can track progress from history page",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.80),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.4,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                  ),
                ),
                hSizedBox3,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: SvgPicture.asset("s_asset/images/tick.svg",height: 16,width: 16,),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 100,
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        shape: BoxShape.rectangle,
                      ),

                    ),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: SvgPicture.asset("s_asset/images/tick.svg",height: 16,width: 16,),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 100,
                      decoration: BoxDecoration(
                        color: MyColors.color_linecolor,
                        shape: BoxShape.rectangle,
                      ),

                    ),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: MyColors.color_F3F3F3,
                        shape: BoxShape.circle,
                      ),

                    ),
                  ],
                ),
                hSizedBox2,

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        height: 32,
                        width: 100,
                        decoration: BoxDecoration(
                          color: MyColors.color_linecolor,
                            borderRadius: BorderRadius.all(Radius.circular(16))

                        ),
                        child: Container(
                          alignment: Alignment.center,
                            child: Text("On Its Way",textAlign:TextAlign.center,style: TextStyle(fontSize: 10, fontFamily:" s_asset/font/raleway/raleway_bold.ttf",fontWeight:FontWeight.w600,color: MyColors.txtcolor_1F4287 ),)),
                      ),
                      wSizedBox2,
                      Container(
                        height: 32,
                        width: 100,
                        decoration: BoxDecoration(
                            color: MyColors.color_linecolor,
                            borderRadius: BorderRadius.all(Radius.circular(16))

                        ),
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("In Progress",textAlign:TextAlign.center,style: TextStyle(fontSize: 10, fontFamily:" s_asset/font/raleway/raleway_bold.ttf",fontWeight:FontWeight.w600,color: txn_status=="pending"?MyColors.txtcolor_1F4287:MyColors.color_gray_707070.withOpacity(0.30)),)),
                      ),
                      wSizedBox2,
                      Container(
                        height: 32,
                        width: 100,
                        decoration: BoxDecoration(
                            color: MyColors.color_linecolor,
                            borderRadius: BorderRadius.all(Radius.circular(16))

                        ),
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("Completed",textAlign:TextAlign.center,style: TextStyle(fontSize: 10, fontFamily:" s_asset/font/raleway/raleway_bold.ttf",fontWeight:FontWeight.w600,color: MyColors.color_gray_707070.withOpacity(0.30) ),)),
                      ),

                    ],
                  ),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Container(
                //         height: 32,
                //         width: 32,
                //         decoration: BoxDecoration(
                //           color: MyColors.primaryColor,
                //           shape: BoxShape.circle,
                //         ),
                //         child: Padding(
                //           padding:  EdgeInsets.all(8.0),
                //           child: SvgPicture.asset("s_asset/images/tick.svg",height: 16,width: 16,),
                //         ),
                //
                //
                //       ),
                //       hSizedBox1,
                //       Container(
                //         height: 32,
                //         width: 100,
                //         decoration: BoxDecoration(
                //             color: MyColors.color_linecolor,
                //             borderRadius: BorderRadius.all(Radius.circular(16))
                //
                //         ),
                //         child: Container(
                //             alignment: Alignment.center,
                //             child: Text(txn_status,textAlign:TextAlign.center,style: TextStyle(fontSize: 10, fontFamily:" s_asset/font/raleway/Raleway-Bold.ttf",fontWeight:FontWeight.w600,color: MyColors.txtcolor_1F4287 ),)),
                //       ),
                //     ],
                //   ),
                // ),

                hSizedBox4,

                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        DashboardScreen()), (Route<dynamic> route) => false);
                  },
                  child: Container(
                    width: 250,
                    child: CustomButton2(btnname: MyString.back_to_home,bordercolor: MyColors.lightblueColor,bg_color: MyColors.lightblueColor,),
                  ),
                ),

                hSizedBox2,
              /*  Container(
                  width: 250,
                  child: CustomButton(btnname: "MyString."Receipt,bordercolor: MyColors.lightblueColor,bg_color: MyColors.lightblueColor,textcolor:MyColors.lightblueColor,fontsize: 16 ,),
                ),*/
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    print("hbdhjbdf");
                    pushNewScreen(
                      context,
                      screen: DownloadReceiptScreen(txnId: widget.readyremit_transferId, transfer_reason: widget.transfer_reason, fees: widget.fees,),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                   height: 50,
                   width: 120,

                   // padding: EdgeInsets.symmetric(horizontal: 30,vertical:20 ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,),
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
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          wSizedBox2,
                          SvgPicture.asset(
                            "s_asset/images/recipet.svg",color: MyColors.color_3F84E5,),
                          wSizedBox1,
                          Container(
                             // alignment: Alignment.center,
                              child: Text(
                                "Receipt",
                                style: TextStyle(
                                    color: MyColors.color_3F84E5,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_semibold.ttf"),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                hSizedBox4,
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future <void> txnDetailapi(BuildContext context) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};
    request['recipient_id'] = sharedPreferences.getString("recpi_id").toString();


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(Apiservices.txnDetailapi+"?txn_id="+widget.readyremit_transferId),
        // body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    CustomLoader.ProgressloadingDialog(context, false);
    if (jsonResponse['status'] == true) {
      // txnDetailResponse = TxnDetailResponse.fromJson(jsonResponse);
      // txn_status = txnDetailResponse.data!.readyremitStatus.toString();
      txn_status = jsonResponse['data']['readyremit_status'];
      setState(() {

      });
    } else {
      setState(() {

      });
    }
    return;
  }
}

