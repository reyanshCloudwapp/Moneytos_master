import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/s_Api/S_Request/CreateCustomerRequest.dart';
import 'package:moneytos/view/dash_settingscreen/setting_account_setting/front_image.dart';
import 'package:moneytos/view/home/s_home/linknewmethod/link_new_method.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../s_Api/AllApi/ApiService.dart';
import '../../../s_Api/S_ApiResponse/AccountSettingResponse.dart';
import '../../../s_Api/s_utils/Utility.dart';
import '../../select_payment_method_screen/select_payment_method_screen.dart';
import 'dart:convert' as convert;

import '../manage_payment_method_detail_screen.dart';

class ManagePaymentMethodScreen extends StatefulWidget {
  final bool isMfs;
  const ManagePaymentMethodScreen({Key? key,required this.isMfs}) : super(key: key);

  @override
  _ManagePaymentMethodScreenState createState() =>
      _ManagePaymentMethodScreenState();
}

class _ManagePaymentMethodScreenState extends State<ManagePaymentMethodScreen> {
  String? status_title;
  String ischeck = "";
  AccountSettingResponse accountSettingResponse = new AccountSettingResponse();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => paymentmethodsRequest(context));
    accountSettingApi(context);
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
            preferredSize: Size.fromHeight(55),
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: MyColors.light_primarycolor2,
              flexibleSpace: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(22, 30, 22, 0),
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
                    Container(
                      // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                      child: Text(
                        MyString.manage_payment_method,
                        style: TextStyle(
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 24,
                            fontFamily:
                            "s_asset/font/raleway/raleway_extrabold.ttf"),
                      ),
                    ),
                    Container(width: 0,)
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
              /*  hSizedBox4,
                hSizedBox,*/
                   /* Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(

                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                  "s_asset/images/leftarrow.svg",
                                  height: 20,
                                  width: 20,
                                )),
                            wSizedBox3,
                            Container(
                              // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                              child: Text(
                                MyString.manage_payment_method,
                                style: TextStyle(
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily:
                                        "s_asset/font/raleway/Raleway-Medium.ttf"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),*/
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 0,
                    color: MyColors.whiteColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          hSizedBox5,
                          Container(
                            child: InkWell(
                                onTap: () {
                                  //Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                  "a_assets/images/empty_illustration.svg",
                                )),
                          ),
                          hSizedBox1,
                          Container(
                            width: size.width * 0.6,
                            margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                            child: Text(
                              "There's no Payment method linked yet before to pay by it",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  fontFamily:
                                      "s_asset/font/raleway/raleway_medium.ttf"),
                            ),
                          ),
                          hSizedBox5,
                          GestureDetector(
                            onTap: (){
                              // ischeck == "already_add"?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectPaymentMethodScreen(selectedMethodScreen: 0,))):
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => LinkNewMethodScreen()));
                              accountSettingResponse.status==true?
                                  accountSettingResponse.data!.userData!.magicpayCustomerId==""?
                              createcustomersRequest(context):nextpage():null;

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                              margin: EdgeInsets.symmetric(horizontal:size.width /6.7,vertical: 20),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  //  stops: [0.0, 1.0],
                                  colors: [
                                    MyColors.color_3F84E5.withOpacity(0.80),
                                    MyColors.color_3F84E5.withOpacity(0.90),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment:Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: MyColors.whiteColor
                                    ),
                                    height: 30,
                                    width: 30,
                                    child:Center(child: Icon(CupertinoIcons.add,color: MyColors.lightblueColor,))
                                   /* SvgPicture.asset(
                                      "a_assets/icons/bold_plus.svg",
                                    ),*/
                                  ),
                                  hSizedBox1,
                                  Container(
                                    child: Text(
                                      MyString.link_new_method,
                                      style: TextStyle(
                                          color: MyColors.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily:
                                              "s_asset/font/maven/mavenpro_bold.ttf"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  nextpage(){
    ischeck == "already_add"?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SelectPaymentMethodScreen(isMfs: widget.isMfs,selectedMethodScreen: 0,))):
    Navigator.push(context, MaterialPageRoute(builder: (_) => LinkNewMethodScreen()));
  }
  search() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        textInputAction: TextInputAction.next,
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: MyString.document_id,
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

        keyboardType: TextInputType.emailAddress,

        // Only numbers can be entered
      ),
    );
  }

  cardList(String title, String img) {
    return Container(
      width: 140,
      child: Material(
        elevation: 50,
        shadowColor: MyColors.lightblueColor.withOpacity(0.05),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
            side: BorderSide(
                color: status_title == title
                    ? MyColors.lightblueColor
                    : MyColors.whiteColor)),
        color: MyColors.whiteColor,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                  color: status_title == title
                      ? MyColors.lightblueColor
                      : MyColors.whiteColor,
                  width: 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                img,
                color: status_title == title
                    ? MyColors.lightblueColor
                    : MyColors.blackColor,
              ),
              hSizedBox1,
              hSizedBox,
              Text(
                title,
                style: TextStyle(
                    color: status_title == title
                        ? MyColors.lightblueColor
                        : MyColors.blackColor,
                    fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  Cameracard(String title, String img) {
    return Container(
      height: 130,
      //  padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          //  stops: [0.0, 1.0],
          colors: [
            MyColors.color_3F84E5.withOpacity(0.06),
            MyColors.color_3F84E5.withOpacity(0.30),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(img),
          hSizedBox1,
          Text(
            title,
            style: TextStyle(
                color: MyColors.blackColor,
                fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                fontSize: 14,
                fontWeight: FontWeight.w600),
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
            child: FrontImageScreen());
      },
    );
  }

  Future<void> paymentmethodsRequest(BuildContext context) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(AllApiService.payment_methods+sharedPreferences.getString("customer_id").toString()+"/payment-methods"),
        // body: convert.jsonEncode(request),
        headers: {
          // "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          // "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
          "Authorization": AllApiService.client_id,
        });

    if(response.statusCode==200){
      Utility.ProgressloadingDialog(context, false);
      // Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      // print("nsklvnsf>> "+jsonResponse.toString());
      ischeck = "already_add";
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManageSelectPaymentMethodScreen(selectedMethodScreen: 0,)));
    }else{
      Utility.ProgressloadingDialog(context, false);
    }

    setState(() {});
    // }
    return;
  }

  Future<void> createcustomersRequest(BuildContext context) async {
    Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    CreateCustomerRequest createCustomerRequest = new CreateCustomerRequest();

    createCustomerRequest.identifier = accountSettingResponse.data!.userData!.id.toString();
    createCustomerRequest.customerNumber = accountSettingResponse.data!.userData!.id.toString();
    createCustomerRequest.firstName = accountSettingResponse.data!.userData!.name.toString();
    createCustomerRequest.lastName = accountSettingResponse.data!.userData!.name.toString();
    createCustomerRequest.email = accountSettingResponse.data!.userData!.email.toString();
    createCustomerRequest.website = "";
    createCustomerRequest.phone = accountSettingResponse.data!.userData!.mobileNumber.toString();
    createCustomerRequest.alternatePhone = accountSettingResponse.data!.userData!.mobileNumber.toString();
    CreateCustomerBillingInfo billingInfo = new CreateCustomerBillingInfo();
    billingInfo.firstName = accountSettingResponse.data!.userData!.name.toString();
    billingInfo.lastName = accountSettingResponse.data!.userData!.name.toString();
    billingInfo.street = accountSettingResponse.data!.userData!.address.toString();
    billingInfo.street2 = accountSettingResponse.data!.userData!.address.toString();
    billingInfo.state = accountSettingResponse.data!.userData!.state.toString();
    billingInfo.city = accountSettingResponse.data!.userData!.city.toString();
    billingInfo.zip = "";
    billingInfo.country = accountSettingResponse.data!.userData!.country.toString();
    billingInfo.phone = accountSettingResponse.data!.userData!.mobileNumber.toString();
    createCustomerRequest.billingInfo = billingInfo;
    createCustomerRequest.active = true;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.createcustomersURL),
        body: convert.jsonEncode(createCustomerRequest),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
          // "Authorization": AllApiService.client_id,
        });

    if(response.statusCode==201){
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>> if"+jsonResponse.toString());
      print("magig pay id>>> if"+jsonResponse["id"].toString());
      Utility.ProgressloadingDialog(context, false);
      sharedPreferences.setString("customer_id", jsonResponse["id"].toString());
      addMagicpayCustomerIdapi(context, jsonResponse["id"].toString());
    }else{
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>> else"+jsonResponse.toString());
      Utility.ProgressloadingDialog(context, false);
      Utility.showFlutterToast( jsonResponse["error_details"].toString());
    }
    setState(() {});


    return;
  }
  Future <void> addMagicpayCustomerIdapi(BuildContext context,String magicpay_customer_id) async {

     Utility.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['magicpay_customer_id'] = magicpay_customer_id;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.addMagicpayCustomerIdapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print("createMagicpayTxnapi>>>> "+jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      Utility.ProgressloadingDialog(context, false);
      nextpage();
      setState(() {

      });
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      Utility.ProgressloadingDialog(context, false);

      setState(() {

      });
    }
    return;
  }

  Future <void> accountSettingApi(BuildContext context,) async {

    //  Utility.ProgressloadingDialog(context, true);
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

      // Utility.ProgressloadingDialog(context, false);
      setState(() {

      });
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      //  Utility.ProgressloadingDialog(context, false);


      setState(() {

      });
    }
    return;
  }
}
