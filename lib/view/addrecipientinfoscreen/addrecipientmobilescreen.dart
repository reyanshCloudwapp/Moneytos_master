import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/home/s_home/selectdeliverymethod/selectdeliverymethod.dart';
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as Math;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


import '../../constance/customLoader/customLoader.dart';
import '../../constance/customTextfield/uppercase_textfield.dart';
import '../../model/RecipientFiealdModel.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';
import '../bank_accountnumber/bank_accountNumber.dart';
import '../home/s_home/sendmoneyquotation/sendmoneyfromrecipient.dart';


class AddRecipientMobileScreen extends StatefulWidget{
  final bool? isMfsMobileMoney;
  final Function? Oncallback;
  const AddRecipientMobileScreen({super.key,this.isMfsMobileMoney,this.Oncallback});

  @override
  State<AddRecipientMobileScreen> createState() => _AddRecipientMobileScreenState();
}

class _AddRecipientMobileScreenState extends State<AddRecipientMobileScreen> {
  String slectedcountrCode="+91";
  bool load = false;
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController beneficiaryWalletTitleController = TextEditingController();
  SharedPreferences? p;
  int phone_min_val = 0;
  int phone_max_val = 0;
  String recipient_id = "";
  String phonecode = "";
  String mobile_number = "";
  String mobile_operator = "";
  String beneficiary_wallet_title = "";

  FocusNode mobileFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
getPrefences()async{
  p = await SharedPreferences.getInstance();

  print("partnerPaymentMethod>>>> "+p!.getString("partnerPaymentMethod").toString());
  print("select_payment_method_status>>>> "+p!.getString("select_payment_method_status").toString());
  print("currency iso>>>> "+p!.getString("country_Currency_isoCode3").toString());
  print("country_isoCode3 iso>>>> "+p!.getString("country_isoCode3").toString());
  print("phonecode iso>>>> "+p!.getString("phonenumber_min_max_validation").toString());
  phone_min_val = p!.getString("partnerPaymentMethod").toString()=="mfs" || p!.getString("partnerPaymentMethod").toString()=="juba"?0:int.parse(p!.getString("phonenumber_min_max_validation").toString().split("-")[0]);
  phone_max_val = p!.getString("partnerPaymentMethod").toString()=="mfs" || p!.getString("partnerPaymentMethod").toString()=="juba"?0:int.parse(p!.getString("phonenumber_min_max_validation").toString().split("-")[1]);
  recipient_id = p!.getString("recpi_id").toString();
  phonecode = p!.getString("phonecode").toString();
  mobile_operator = p!.getString("mfs_mobile_operator_name").toString();
  setState(() {

  });
}





  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [

        KeyboardActionsItem(
            focusNode: mobileFocusNode,

        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    mobileFocusNode.unfocus();
  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getPrefences();
  }
/*  Oncallback(bool load){
    field_load = load;
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 30),
        color: MyColors.whiteColor,
        child:Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){

                  mobileFocusNode.unfocus();

                  Navigator.pop(context);
                },
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
                          MyColors.lightblueColor.withOpacity(0.10),
                        ],
                      ),
                      //color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:  EdgeInsets.only(left: 28, right: 28, bottom: 0,top: 0),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
                    child: Center(child: Text(MyString.back,style: TextStyle(color: MyColors.lightblueColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),))
                ),
              ),
              wSizedBox3,
           GestureDetector(
                onTap: (){

                  mobile_number = mobileNumberController.text;
                  beneficiary_wallet_title = beneficiaryWalletTitleController.text;

                  if(p?.getString("partnerPaymentMethod").toString()=="juba"){
                    if(mobile_number.isEmpty){
                      Utility.showFlutterToast( "enter phone number");
                    }if(beneficiary_wallet_title.isEmpty){
                      Utility.showFlutterToast( "enter beneficiary wallet title");
                    }else{

                      addRecipientMobileApi(context);
                    }
                  }else{
                    if(mobile_number.isEmpty){
                      Utility.showFlutterToast( "enter phone number");
                    }else{

                      addRecipientMobileApi(context);
                    }
                  }

                },
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
                          MyColors.lightblueColor,
                          MyColors.lightblueColor,
                        ],
                      ),
                      //color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:  EdgeInsets.only(left: 28, right: 28, bottom: 0,top: 0),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
                    child: Center(child: Text(MyString.Add,style: TextStyle(color: MyColors.whiteColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),))
                ),
              ),
            ],
          ),
        ),
      ),

      body:  KeyboardActions(
        autoScroll: false,
        config: _buildKeyboardActionsConfig(context),
        child: Stack(
          children: [
            SingleChildScrollView(
                child:  Column(
                  children: [
                    hSizedBox4,

                    Container(
                        margin: EdgeInsets.only(top: 0.0,bottom: 30,),
                        alignment: Alignment.center,
                        child: Text(MyString.Add_Recipient_Mobile_Info,style: TextStyle(color: MyColors.color_text,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600 ),)),
                    hSizedBox,


                    Row(
                      children: [
                        Container(
                          width:60,
                          margin:  EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
                          decoration: BoxDecoration(
                            color: MyColors.color_93B9EE.withOpacity(0.1),
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: TextFormField(
                            enabled: false,
                            controller: TextEditingController(text: p?.getString("phonecode").toString()),
                            textInputAction: TextInputAction.done,
                            style: TextStyle(

                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"


                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),
                              counterText: '',
                              border: InputBorder.none,


                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                            ),

                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                            maxLines: 1,

                            // Only numbers can be entered
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width:double.infinity,
                            margin:  EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
                            decoration: BoxDecoration(
                              color: MyColors.color_93B9EE.withOpacity(0.1),
                              border: Border.all(color: MyColors.color_gray_transparent),
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: TextFormField(
                              controller: mobileNumberController,
                              textInputAction: TextInputAction.done,
                              maxLength: p?.getString("partnerPaymentMethod").toString()=="mfs" || p?.getString("partnerPaymentMethod").toString()=="juba" ?null:phone_max_val,
                              focusNode: mobileFocusNode,
                              style: TextStyle(

                                  color:MyColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "a_assets/font/poppins_regular.ttf"


                              ),
                              decoration: InputDecoration(
                                hintText: 'Phone number',
                                hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),
                                counterText: '',
                                border: InputBorder.none,


                                // fillColor: MyColors.color_gray_transparent,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                              ),

                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                              maxLines: 1,

                              // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),


                    p?.getString("partnerPaymentMethod").toString()=="juba"?
                    Container(
                      width:double.infinity,
                      margin:  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                        color: MyColors.color_93B9EE.withOpacity(0.1),
                        border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: TextFormField(
                        controller: beneficiaryWalletTitleController,
                        textInputAction: TextInputAction.done,
                        focusNode: titleFocusNode,
                        style: TextStyle(

                            color:MyColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "a_assets/font/poppins_regular.ttf"


                        ),
                        decoration: InputDecoration(
                          hintText: 'Beneficiary Wallet Title',
                          hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),
                          counterText: '',
                          border: InputBorder.none,


                          // fillColor: MyColors.color_gray_transparent,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                        ),


                        maxLines: 1,

                        // Only numbers can be entered
                      ),
                    ):Container()


                    // hSizedBox6,
                    // hSizedBox6,


                  ],
                )
            ),


          ],
        ),
      ),


    );
  }
  // FieldSetsModel model
  Future<void> addRecipientMobileApi(BuildContext context) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    request['recipient_id'] = recipient_id;
    request['phonecode'] = phonecode;
    request['mobile_number'] = mobile_number;
    request['mobile_operator'] = mobile_operator;
    request['partner_payment_method'] = sharedPreferences.getString("partnerPaymentMethod").toString();

    if(sharedPreferences.getString("partnerPaymentMethod").toString()=="juba"){
      request['beneficiary_wallet_title'] = beneficiary_wallet_title;
      request['juba_NominatedCode'] = sharedPreferences.getString("juba_NominatedCode").toString();
    }



    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.addRecipientMobileApi),
        // var response = await http.post(Uri.parse(AllApiService.payment_methods+sharedPreferences.getString("customer_id").toString()+"/payment-methods"),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",

          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": AllApiService.client_id,
        });

    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse['status']==true){
      CustomLoader.ProgressloadingDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>> else"+jsonResponse.toString());
      Utility.showFlutterToast( jsonResponse["message"].toString());
      this.widget.Oncallback!();
      Navigator.pop(context);
    }else{
      CustomLoader.ProgressloadingDialog(context, false);
      Utility.showFlutterToast( jsonResponse["message"].toString());
      print("jsonResponse>>> if"+jsonResponse.toString());
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManageSelectPaymentMethodScreen(selectedMethodScreen: 1,)));
    }
    setState(() {});


    return;
  }

}
