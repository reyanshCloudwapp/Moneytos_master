
import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/ScheduledTransferScreens/scheduled_face_and_touchid_screen.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/s_Api/S_Request/TransactionChargeRequest.dart';
import 'package:moneytos/services/Apiservices.dart';
import 'package:moneytos/view/home/home.dart';

import 'package:moneytos/view/home/s_home/transfer_verification_touch_faceIdScreen/transfer_verification_touch_face_id.dart';
import 'package:moneytos/view/transfers_scheduled_screens/sheduled_successfully_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../../../constance/customLoader/customLoader.dart';
import '../../../../s_Api/AllApi/ApiService.dart';
import '../../../../s_Api/S_ApiResponse/AccountSettingResponse.dart';
import '../../../../s_Api/S_ApiResponse/BankDetailResponse.dart';
import '../../../../s_Api/s_utils/Utility.dart';
import '../view/home/s_home/sendsuccessfullytransferscreen/sendsuccessfulyscreen.dart';

class ScheduledGotoreviewScreen extends StatefulWidget{
  String selected_acc_id;
  String selected_acc_name;
  String selected_payment_type;
  String selected_last4;
  ScheduledGotoreviewScreen({Key? key, required this.selected_acc_id, required this.selected_acc_name, required this.selected_payment_type, required this.selected_last4}) : super(key: key);

  @override
  State<ScheduledGotoreviewScreen> createState() => _ScheduledGotoreviewScreenState();
}

class _ScheduledGotoreviewScreenState extends State<ScheduledGotoreviewScreen> {
  String dstCurrencyIso3Code = "";
  String dstCountryIso3Code = "";
  String sourceCurrencyIso3Code = "";
  String sendAmount = "";
  String recipient_recieve_amount="";
  String recipientId = "";
  String senderId = "";
  String s_BankdetailResponse = "";
  String exchangerate = "";
  String fees = "";
  String monyetosfee = "";
  BankDetailResponse bankDetailResponse = new BankDetailResponse();
  String BankName = "";
  String BankAccNumber = "";
  String reasonsending_id = "";
  String reasonsending_name = "";
  String u_first_name = "";
  String u_last_name = "";
  String u_profile_img = "";
  AccountSettingResponse accountSettingResponse = new AccountSettingResponse();
  String total_amount = "0";
  String is_pin_enabled = "";
  String is_face_enabled = "";
  String document_status = "";
  String schedule_date="";
  String schedule_end_date="";
  String schedule_type="";
  String recipient_server_id="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>accountSettingApi(context));
    // accountSettingApi(context);
    print("Scheduled Flow check>>>>  ");
    pref();
    setState(() {

    });
  }
  pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dstCurrencyIso3Code = sharedPreferences.getString("dstCurrencyIso3Code").toString();
    dstCountryIso3Code = sharedPreferences.getString("dstCountryIso3Code").toString();
    sourceCurrencyIso3Code = sharedPreferences.getString("sourceCurrencyIso3Code").toString();
    sendAmount = sharedPreferences.getString("sendAmount").toString();
    recipient_recieve_amount= sharedPreferences.getString("receiveAmount").toString();
    recipientId = sharedPreferences.getString("recpi_id").toString();
    senderId = sharedPreferences.getString("senderId").toString();
    s_BankdetailResponse = sharedPreferences.getString("BankdetailResponse").toString();
    exchangerate = sharedPreferences.getString("exchangerate").toString();
    fees = sharedPreferences.getString("fees").toString();
    monyetosfee = sharedPreferences.getString("monyetosfee").toString();
    reasonsending_id = sharedPreferences.getString("reasonsending_id").toString();
    reasonsending_name = sharedPreferences.getString("reasonsending_name").toString();
    u_first_name = sharedPreferences.getString("u_first_name").toString();
    u_last_name = sharedPreferences.getString("u_last_name").toString();
    u_profile_img = sharedPreferences.getString("u_profile_img").toString();
    schedule_date = sharedPreferences.getString("ScheduleStartDate").toString();
    schedule_end_date = sharedPreferences.getString("ScheduleEndDate").toString();
    schedule_type = sharedPreferences.getString("ScheduleType").toString();
    recipient_server_id = sharedPreferences.getString("recpi_id").toString();

    print("recipient_server_id>>>> "+recipient_server_id);
    print("schedule_date>>>> "+schedule_date);
    print("schedule_end_date>>>> "+schedule_end_date);
    print("schedule_type>>>> "+schedule_type);
    print("reasonsending_name>>>> "+reasonsending_name);
    print("reasonsending_id>>>> "+reasonsending_id);
    print("selected_acc_id>>>> "+widget.selected_acc_id);
    print("selected_acc_name>>>> "+widget.selected_acc_name);
    print("selected_payment_type>>>> "+widget.selected_payment_type);
    print("selected_last4>>>> "+widget.selected_last4);
    print("dstCurrencyIso3Code>>>> "+dstCurrencyIso3Code);
    print("dstCountryIso3Code>>>> "+dstCountryIso3Code);
    print("sourceCurrencyIso3Code>>>> "+sourceCurrencyIso3Code);
    print("sendAmount>>>> "+sendAmount);
    print("recipient_recieve_amount>>>> "+recipient_recieve_amount);
    print("recipientId>>>> "+recipientId);
    print("senderId>>>> "+senderId);
    print("s_BankdetailResponse>>>> "+s_BankdetailResponse);
    print("exchangerate>>>> "+exchangerate);
    print("fees>>>> "+fees);
    print("monyetosfee>>>> "+monyetosfee);

    total_amount = (double.parse(sendAmount)+double.parse(monyetosfee)).toString();
    total_amount = double.parse(double.parse(total_amount).toStringAsFixed(2)).toString();
    print("total_amount>>>> "+total_amount);

    if(sharedPreferences.get("BankdetailResponse").toString()!="null"){
      Timer(
          Duration(seconds: 1),
              () {

            var response = sharedPreferences.get("BankdetailResponse").toString();
            Map<String, dynamic> jsonResponse = convert.jsonDecode(response);

            print("jsonResponse>>>>  "+jsonResponse.toString());

            // if (jsonResponse['status'] == true) {
              // Utility.ProgressloadingDialog(context, false);
              bankDetailResponse = BankDetailResponse.fromJson(jsonResponse);
              // for(int i = 0 ; i<bankDetailResponse.fields!.length;i++){
              //   if(bankDetailResponse.fields![i].id == "BANK_ACCOUNT_NUMBER"){
              //
              //     BankAccNumber = bankDetailResponse.fields![i].value.toString();
              //   }
              //
              //   if(bankDetailResponse.fields![i].id == "BANK_NAME"){
              //
              //     BankName = bankDetailResponse.fields![i].value.toString();
              //   }
              // }

            BankAccNumber = bankDetailResponse.data!.accountNumber.toString();
            BankName = bankDetailResponse.data!.bankName.toString();
              setState(() {

              });
            // } else {
            //   // Utility.ProgressloadingDialog(context, false);
            //   // isLoading = false;
            //   setState(() {
            //
            //   });
            // }
          });

    }else{
    }

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: MyColors.color_03153B,
          elevation: 0,
          centerTitle: true,

          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only( left: 25,top: 27),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only( top: 5),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        "s_asset/images/leftarrow.svg",
                          height: 32,
                          width: 32
                      )),
                ),
                // wSizedBox3,
                // wSizedBox3,
                Container(
                  padding: EdgeInsets.only( top: 5),
                  alignment: Alignment.center,
                  child: Text(
                    MyString.review_and_confirm,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                        "s_asset/font/raleway/raleway_extrabold.ttf"),
                  ),
                ),
                Container(
                  width: 50,
                )
              ],
            ),
          ),
          automaticallyImplyLeading: false,


          //backgroundColor: MyColors.primaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),

        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: MyColors.color_03153B,
              height: size.height * 1.5 ,
            ),

            Container(
              height: size.height,
              margin: EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  color: MyColors.whiteColor
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox2,

                    usercard(),
                    hSizedBox1,


                    deliveryMethid(),
                    hSizedBox1,

                    bankcard(),

                    hSizedBox2,
                    exchangeRatecard(),
                    hSizedBox2,

                    GestureDetector(
                      onTap:(){
                        print("is_pin_enabled>>> "+is_pin_enabled);
                        print("document_status>>> "+document_status);

                        // if(document_status == "Approved"){
                        //   print("document status Approved>>>>>> ");
                        //   if(is_pin_enabled==""){
                        //
                        //   }else{
                        //     if(is_pin_enabled=="1" || is_face_enabled=="1"){
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => ScheduledFaceAndTouchScreen(selected_acc_id: widget.selected_acc_id, selected_acc_name: widget.selected_acc_name, selected_payment_type: widget.selected_payment_type, selected_last4: widget.selected_last4,),
                        //       ));
                        //     }else{
                        //       saveScheduleApi(context);
                        //     }
                        //   }
                        // }
                        // else{
                        //   print("document status Blank>>>>>> ");
                        //   if(double.parse(sendAmount)<=200){
                        //     if(is_pin_enabled==""){
                        //
                        //     }else{
                        //       if(is_pin_enabled=="1" || is_face_enabled=="1"){
                        //         Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (context) => ScheduledFaceAndTouchScreen(selected_acc_id: widget.selected_acc_id, selected_acc_name: widget.selected_acc_name, selected_payment_type: widget.selected_payment_type, selected_last4: widget.selected_last4,),
                        //         ));
                        //       }else{
                        //         saveScheduleApi(context);
                        //
                        //       }
                        //     }
                        //   }else{
                        //     Fluttertoast.showToast(msg: "Please verify your account first to transfer amount more than \$200");
                        //   }
                        // }



                        comingsoonDialog(context);

                      },
                      child: Container(

                        padding: EdgeInsets.symmetric(horizontal: 60,vertical: 30),

                        child: CustomButton2(btnname: "Schedule From ${Utility.DatefomatToDDMMM(schedule_date)}",bordercolor: MyColors.lightblueColor,),
                      ),
                    ),
                    hSizedBox5,

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  comingsoonDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Column(children: [

              InkWell(
                onTap: (){
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset("a_assets/icons/clear_red.svg"),
                ),
              ),
              SizedBox(height: 50,),


              Text(
                "Schedule is coming soon check back later",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
              ),
              SizedBox(height: 20,),

              SizedBox(height: 50,),

            ],),

          );
        });
  }
  /// usercard...
  usercard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Material(
          elevation: 10,
          shadowColor: MyColors.lightblueColor.withOpacity(0.12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.whiteColor),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                /// top
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: MyColors.divider_color,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: FadeInImage(
                          height: 156,width: 149,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            u_profile_img,),
                          placeholder: AssetImage(
                              "a_assets/logo/progress_image.png"),
                          placeholderFit: BoxFit.scaleDown,
                          imageErrorBuilder:
                              (context, error, stackTrace) {
                            return Text(u_first_name.toString()[0].toUpperCase(),style: TextStyle(
                                color: MyColors.shedule_color,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: "s_asset/font/raleway/raleway_bold.ttf"));
                          },
                        ),
                      ),
                    ),
                    wSizedBox1,
                    wSizedBox,
                    Container(
                    //  width: MediaQuery.of(context).size.width * 0.6,
                      //width: MediaQuery.of(this.context).size.width*0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                width: 220.0,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "${u_first_name} ${u_last_name}",
                                    style: TextStyle(
                                        color: MyColors.blackColor,
                                        fontSize: 14,
                                        fontFamily:
                                        "s_asset/font/raleway/raleway_semibold.ttf",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                               // wSizedBox4,
                              // wSizedBox,
                              // SvgPicture.asset(
                              //   "a_assets/icons/edit.svg",
                              //   color: MyColors.blackColor,
                              // )
                            ],
                          ),
                          // hSizedBox,
                          // Container(
                          //   alignment: Alignment.topLeft,
                          //   child: Text(
                          //     "(+61) 124-335-547",
                          //     style: TextStyle(
                          //         color: MyColors.blackColor.withOpacity(0.50),
                          //         fontSize: 12,
                          //         fontFamily:
                          //         "s_asset/font/raleway/Raleway-Medium.ttf",
                          //         fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),

                hSizedBox1,
                hSizedBox,


              ],
            ),
          )
      ),
    );
  }

  /// deleviry method
  deliveryMethid() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Material(
        elevation: 10,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.whiteColor),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyString.delivery_method,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.30)),
                        ),
                      ),
                      hSizedBox1,
                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "a_assets/icons/bank.svg",
                              color: MyColors.blackColor,
                            ),
                            wSizedBox1,
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget.selected_payment_type=="check"?"Bank Account":widget.selected_payment_type,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                    "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                    color: MyColors.blackColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      hSizedBox2,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Receive (Approx.)",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor.withOpacity(0.30)),
                        ),
                      ),
                      hSizedBox1,
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                recipient_recieve_amount.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    fontFamily:
                                  "  s_asset/font/montserrat/MontserratAlternates-ExtraBold.otf",
                                    color: MyColors.blackColor),
                              ),
                            ),
                            wSizedBox,
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                dstCurrencyIso3Code,
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_semibold.ttf",
                                    color: MyColors.blackColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      hSizedBox2,
                    ],
                  ),
                ],
              ),



              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "a_assets/icons/bank4.svg",
                        ),
                        wSizedBox1,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              alignment: Alignment.topLeft,
                              child: Text(
                                  BankName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                    "s_asset/font/montserrat/Montserrat-Bold.otf",
                                    color: MyColors.blackColor),
                              ),
                            ),
                            hSizedBox,
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                BankAccNumber.isEmpty?"":"****"+BankAccNumber.substring(BankAccNumber.length-4),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                    "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                                    color: MyColors.blackColor),
                              ),
                            ),
                          ],
                        ),
//                    wSizedBox5,
                       /* wSizedBox2,
                        Container(
                          alignment: Alignment.centerRight,
                            child: SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,)),
*/
                      ],
                    ),

                    // Container(
                    //     alignment: Alignment.centerRight,
                    //     child: SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// bank Card
  bankcard(){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Material(
        elevation: 10,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.whiteColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "a_assets/logo/bank2.png",
                  ),
                  wSizedBox1,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.selected_acc_name.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                              "s_asset/font/montserrat/Montserrat-Bold.otf",
                              color: MyColors.blackColor),
                        ),
                      ),
                      hSizedBox,
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "****"+widget.selected_last4.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily:
                              "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                              color: MyColors.blackColor),
                        ),
                      ),
                    ],
                  ),
                 // wSizedBox5,


                ],
              ),
              // SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,),
            ],
          ),
        ),
      ),
    );
  }

  ///exchangeRate
  exchangeRatecard(){
    return Container(
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [

          ///
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  margin: EdgeInsets.only(top: 14.0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.exchange_rate,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.depend_on_day_of_transfer,
                    style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          hSizedBox2,

          ///
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.you_send,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        sendAmount,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                            fontWeight: FontWeight.w800),
                      ),
                    ),

                    wSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyString.usd,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 8,
                            fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          hSizedBox2,

          ///
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.fees,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        monyetosfee,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                            fontWeight: FontWeight.w800),
                      ),
                    ),

                    wSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyString.usd,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 8,
                            fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // hSizedBox3,
          // Container(
          //   child:  Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //
          //       Container(
          //         alignment: Alignment.topLeft,
          //         child: Text(
          //          "MTIN",
          //           style: TextStyle(
          //               color: MyColors.blackColor.withOpacity(0.30),
          //               fontSize: 12,
          //               fontFamily: "s_asset/font/raleway/Raleway-Medium.ttf",
          //               fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //
          //       Row(
          //         children: [
          //           Container(
          //             alignment: Alignment.topLeft,
          //             child: Text(
          //               "000-00-0000",
          //               style: TextStyle(
          //                   color: MyColors.blackColor,
          //                   fontSize: 14,
          //                   fontFamily: "s_asset/font/raleway/Raleway-ExtraBold.ttf",
          //                   fontWeight: FontWeight.w800),
          //             ),
          //           ),
          //
          //           wSizedBox,
          //
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          hSizedBox3,

          Container(
            height: 0.5,
            child: DottedBorder(
              color: Color(0xffE9EDF2),
              strokeWidth: 0.5,
              dashPattern: [8, 4],
              child: Container(),
            ),
          ),
          hSizedBox2,
          ///
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.total,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          total_amount,
                          style: TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 20,
                              fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                              fontWeight: FontWeight.w800),
                        ),
                      ),

                      wSizedBox,
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          MyString.usd,
                          style: TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 10,
                              fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]
                ),
              ],
            ),
          ),
          hSizedBox2,
        ],
      ),
    );
  }



  Future <void> saveScheduleApi(BuildContext context) async {
    Utility.transactionloadingDialog(context, true);
    //  Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['schedule_date'] = schedule_date;
    request['schedule_exp_date'] = schedule_end_date;
    request['schedule_type'] = schedule_type;
    request['dstCountryIso3Code'] = dstCountryIso3Code;
    request['recipientId'] = recipientId;
    request['recipient_server_id'] = recipient_server_id;
    request['recipient_name'] = u_first_name+" "+u_last_name;
    request['recipient_image'] = u_profile_img;
    request['recipient_recived_amount'] = recipient_recieve_amount;
    request['transaction_fees'] = fees;
    request['exchange_rate'] = exchangerate;
    request['recipient_receive_method'] = BankName;
    request['delivery_method_type'] = bankDetailResponse.data!.bankAccountType.toString();
    request['recipient_receive_method_last4digit'] = BankAccNumber;
    request['sender_send_method'] = widget.selected_payment_type;
    request['sender_send_method_id'] = widget.selected_acc_id;
    request['sender_send_method_last4digit'] = widget.selected_last4;
    request['trasnsfer_reason'] = reasonsending_name;
    // request['trasnsfer_reason_id'] = "1";
    request['trasnsfer_reason_id'] = reasonsending_id;
    request['sending_currency'] = "USD";
    request['receiving_currency'] = dstCurrencyIso3Code;
    request['recipientAccountId'] = bankDetailResponse.data!.id.toString();
    request['send_amount'] = sendAmount;
    request['monyetosfee'] = monyetosfee;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.saveScheduleapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.transactionfinishloadingDialog(context, false);
      pushNewScreen(
        context,
        screen: SheduledSuccessfullyScreen(amount: sendAmount,),
        withNavBar: false,
      );
      setState(() {});
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      setState(() {});
    }
    return;
  }


  Future <void> accountSettingApi(BuildContext context,) async {

    Utility.ProgressloadingDialog(context, true);
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
      Utility.ProgressloadingDialog(context, false);
      accountSettingResponse  = await AccountSettingResponse.fromJson(jsonResponse);
      is_pin_enabled = accountSettingResponse.data!.userData!.isPinEnabled.toString();
      is_face_enabled = accountSettingResponse.data!.userData!.isFaceEnabled.toString();
      document_status = accountSettingResponse.data!.userData!.documentStatus.toString();
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      // Utility.ProgressloadingDialog(context, false);
      setState(() {

      });
    } else {
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast( jsonResponse['message']);
      //  Utility.ProgressloadingDialog(context, false);



      setState(() {

      });
    }
    return;
  }

}