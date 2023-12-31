import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:moneytos/constance/customLoader/customLoader.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/model/account_detailsModel.dart';
import 'package:moneytos/model/purpose_code_response.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/addrecipientinfoscreen/addrecipientinfoscreen.dart';
import 'package:moneytos/view/dash_recipentScreen/select_recipient_screen/select_new_recipient_screen.dart';
import 'package:moneytos/view/recipients_opened_sscreen/custom_recipientsopenedList.dart';
import 'package:moneytos/view/resonforsendingscreen/reasonforsendingscreen.dart';
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../add_new_recipients_dashboard/EditSelectBankScreen.dart';
import '../../../../add_new_recipients_dashboard/edit_bank_accountNumber.dart';
import '../../../../s_Api/AllApi/ApiService.dart';
import '../../../../s_Api/S_ApiResponse/BankDetailResponse.dart';
import '../../../../s_Api/S_ApiResponse/BankListResponse.dart';
import '../../../../s_Api/s_utils/Utility.dart';
import '../../../../services/Apiservices.dart';
import '../../../bank_accountnumber/bank_accountNumber.dart';
import '../../../dashboardScreen/dashboard.dart';
import 'dart:convert' as convert;

import '../linknewmethod/link_new_method.dart';
import '../reasonforsendingpaymethod/reasonforsendingpaymethod.dart';


List<AccountsDetailModel> accountdetaillist = [];
List<AccountDetailFieldsModel> accountdetailfieldsetlist = [];

List<AccountsDetailModel> accountdetaillist2 = [];
List<AccountDetailFieldsModel> accountdetailfieldsetlist2 = [];

class SelectDeliveryAddMethodScreen extends StatefulWidget{
  //final Function oncallback;
  final bool? ismfsAndalready;
  //SelectDeliveryAddMethodScreen(this.oncallback);
  SelectDeliveryAddMethodScreen({super.key,this.ismfsAndalready});
  @override
  State<SelectDeliveryAddMethodScreen> createState() => _SelectDeliveryAddMethodScreenState();
}



class _SelectDeliveryAddMethodScreenState extends State<SelectDeliveryAddMethodScreen> {
  BankListResponse bankListResponse = new BankListResponse();
  bool load = false;
  int cureentindex = 0;
  Color bordercolor = MyColors.whiteColor;
  String? recipientId;
  bool itemload = false;
  String bankName="",account_type="",account_number="";
  String receipent_id="";
  String receipent_account_id="";
  TextEditingController reasonController = new TextEditingController();
  PurposeCodesResponse purposeCodesResponse = new PurposeCodesResponse();
  getaccountitemdetailApi(String recipentid,String recipentaccid)async{
    accountdetailfieldsetlist2.clear();
    setState((){
      itemload = true;
    });
    await Webservices.AccountDetailsitemRequest(context, accountdetaillist2, accountdetailfieldsetlist2, recipentid,recipentaccid);
    setState((){
      itemload = false;
    });

    for(int i=0;i<accountdetailfieldsetlist2.length;i++){
      print("accountdetailfieldsetlist2[i].id.toString()>>>> "+accountdetailfieldsetlist2[i].id.toString());
      if(accountdetailfieldsetlist2[i].id.toString() == "BANK_NAME"){
        bankName = accountdetailfieldsetlist2[i].value.toString();
      } if(accountdetailfieldsetlist2[i].id.toString() == "BANK_ACCOUNT_TYPE"){
        account_type = accountdetailfieldsetlist2[i].value.toString();
      } if(accountdetailfieldsetlist2[i].id.toString() == "BANK_ACCOUNT_NUMBER"){
        account_number = accountdetailfieldsetlist2[i].value.toString();
      }

    }
    print("account_type>>> "+account_type);
    setState((){

    });
  }

  getaccountdetailApi() async{
    accountdetaillist.clear();
    accountdetailfieldsetlist.clear();


    // setState((){
    //   load = true;
    // });
    await Webservices.AccountDetailsRequest(context,accountdetaillist,accountdetailfieldsetlist,receipent_id);

    recipientId =  accountdetaillist.length > 0 ? accountdetaillist[0].recipientAccountId.toString(): "";
    receipent_account_id =  accountdetaillist.length > 0 ? accountdetaillist[0].recipientAccountId.toString(): "";
    setState((){});
    getaccountitemdetailApi(receipent_id,receipent_account_id);
    // setState((){
    //   load = false;
    // });
    print("dhghfgfj${accountdetailfieldsetlist.length}");
  }
  Future<void> pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    receipent_id = sharedPreferences.getString("recpi_id").toString();
    print("receipent_id"+receipent_id);
    setState((){
    });
    // getaccountdetailApi();
    recipientBankAccountsapi(context);
    niumPurposeCodesApi(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pref();

  }

  void Update(){
    recipientBankAccountsapi(context);
    // getaccountdetailApi();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.whiteColor,
        centerTitle: true,
        actions: [],
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.whiteColor,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Text(MyString.Select_Delivery_Method,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4),),
      ),
      bottomSheet:   load == true || itemload == true?  Container(
        height: 0,
      ) :  Container(
        //margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 20,right:20,top: 20,bottom: 20),
        color: MyColors.whiteColor,
        height: 125,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SelectNewRecipientScreen()));
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    DashboardScreen()), (Route<dynamic> route) => false);
               // Navigator.pop(context);
              },
              child: Container(
                //  padding: EdgeInsets.only(top: size.height / 2),
                alignment: Alignment.center,
                child:Custombtn(MyString.cancel,76,140,context) ,
              ),
            ),
            GestureDetector(
              onTap: () {

                // String reason = reasonController.text;
                // if(reason.isEmpty){
                //   Fluttertoast.showToast(msg: "Enter reason");
                // }else{
                //
                //   Navigator.push(context, MaterialPageRoute(builder: (_) => LinkNewMethodScreen()));
                // }
                (widget.ismfsAndalready ?? false)?
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectPaymentMethodScreen(isMfs: true,selectedMethodScreen: 0,))):
                Navigator.push(context, MaterialPageRoute(builder: (_) => ReasonforSendingScreen(status: "reason_for_sending",)));
              },
              child: addMathodButton(MyString.Next,76,140),
            )
          ],
        ),
      ) ,



      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // hSizedBox2,
                /*  Container(

                    width:350,
                    margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                    padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 22.0),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      border: Border.all(color: MyColors.color_gray_transparent),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.color_linecolor,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
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
                            Text(MyString.country_name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
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
                          color: MyColors.color_linecolor,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
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
                            Text(MyString.City_Name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/Raleway-Bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                          ],
                        ),
                        SvgPicture.asset("a_assets/icons/clear_red.svg"),

                      ],
                    )
                ),*/
                // hSizedBox,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(30),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0)),
                      color: MyColors.whiteColor),
                  child: Column(
                    children: [
                      hSizedBox,


                      /// create listview....,

                      load == true ?
                      Utility.shrimmerHorizontalListLoader(150,220):
                      SizedBox(
                        height: 150,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              bankListResponse.status==true?
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: bankListResponse.data!.length,
                                    itemBuilder: (context,int index){
                                      return SizedBox(
                                        height: 150,
                                        width: 220,
                                        child: Container(
                                          // padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                          padding: EdgeInsets.only(right: 5,top: 5,bottom: 5),
                                          child: Material(
                                            elevation: 2,
                                            color: MyColors.whiteColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: GestureDetector(
                                              onTap: () async {
                                                cureentindex = index;
                                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                                BankDetailResponse bankdetailreponse = new BankDetailResponse();
                                                bankdetailreponse.status = true;
                                                bankdetailreponse.message = "success";
                                                BankDetailData data = new BankDetailData();
                                                data.id = bankListResponse.data![cureentindex].id;
                                                data.rid = bankListResponse.data![cureentindex].rid;
                                                data.uid = bankListResponse.data![cureentindex].uid;
                                                data.routingCodeType1 = bankListResponse.data![cureentindex].routingCodeType1;
                                                data.routingCodeValue1 = bankListResponse.data![cureentindex].routingCodeValue1;
                                                data.routingCodeType2 = bankListResponse.data![cureentindex].routingCodeType2;
                                                data.routingCodeValue2 = bankListResponse.data![cureentindex].routingCodeValue2;
                                                data.accountNumber = bankListResponse.data![cureentindex].accountNumber;
                                                data.bankAccountType = bankListResponse.data![cureentindex].bankAccountType;
                                                data.bankName = bankListResponse.data![cureentindex].bankName;
                                                data.bankCode = bankListResponse.data![cureentindex].bankCode;
                                                data.updatedAt = bankListResponse.data![cureentindex].updatedAt;
                                                data.createdAt = bankListResponse.data![cureentindex].createdAt;
                                                bankdetailreponse.data = data;
                                                print("object"+json.encode(bankdetailreponse));
                                                sharedPreferences.setString("BankdetailResponse", json.encode(bankdetailreponse));
                                                sharedPreferences.setString("recipientReceiveBankOrMobileNo", bankListResponse.data![cureentindex].accountNumber.toString());
                                                sharedPreferences.setString("recipientReceiveBankNameOrOperatorName", bankListResponse.data![cureentindex].bankName.toString());

                                                // bordercolor = MyColors.lightblueColor;
                                                // recipientId = accountdetaillist[index].recipientAccountId.toString();
                                                setState(() {});
                                                //
                                                // getaccountitemdetailApi(receipent_id,accountdetaillist[index].recipientAccountId.toString());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 17,vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: MyColors.whiteColor,
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(color: cureentindex  == index? MyColors.lightblueColor : MyColors.whiteColor,width: 1)
                                                ),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8, vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [

                                                          Container(
                                                              width: 100,
                                                              alignment: Alignment.topLeft,
                                                              child:  Text(
                                                                // accountdetaillist[index].fields![0].id.toString() == "BANK" ?

                                                                "****"+bankListResponse.data![index].accountNumber.toString().substring(bankListResponse.data![index].accountNumber.toString().length-4),
                                                                //: "",
                                                                maxLines: 1,
                                                                textAlign: TextAlign.start,
                                                                style: TextStyle(
                                                                    color: cureentindex == index ? MyColors.lightblueColor:MyColors.blackColor.withOpacity(0.80),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"
                                                                ),)
                                                          ),
                                                          /*  status == true ?    Padding(
                    padding:  EdgeInsets.only(top: 0.0,right: 1),
                    child: SvgPicture.asset(icon,color: MyColors.blackColor,height: 20,width: 20,),
                  ) : Container(),
                  status == true ?   Padding(
                    padding:  EdgeInsets.only(top: 0.0,right: 1),
                    child: SvgPicture.asset("a_assets/icons/delete.svg",height: 20,width: 20,),
                  ): Container(),
*/

                                                          // InkWell(
                                                          //     onTap: () async {
                                                          //       // pushNewScreen(
                                                          //       //   context,
                                                          //       //   screen: EditSelectBankScreen(onCallback: Update, recipient_account_id: bankListResponse.data![index].id.toString(),),
                                                          //       //   withNavBar: false,
                                                          //       // );
                                                          //       SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                                          //       BankDetailResponse bankdetailreponse = new BankDetailResponse();
                                                          //       bankdetailreponse.status = true;
                                                          //       bankdetailreponse.message = "success";
                                                          //       BankDetailData data = new BankDetailData();
                                                          //       data.id = bankListResponse.data![cureentindex].id;
                                                          //       data.rid = bankListResponse.data![cureentindex].rid;
                                                          //       data.uid = bankListResponse.data![cureentindex].uid;
                                                          //       data.routingCodeType1 = bankListResponse.data![cureentindex].routingCodeType1;
                                                          //       data.routingCodeValue1 = bankListResponse.data![cureentindex].routingCodeValue1;
                                                          //       data.routingCodeType2 = bankListResponse.data![cureentindex].routingCodeType2;
                                                          //       data.routingCodeValue2 = bankListResponse.data![cureentindex].routingCodeValue2;
                                                          //       data.accountNumber = bankListResponse.data![cureentindex].accountNumber;
                                                          //       data.bankAccountType = bankListResponse.data![cureentindex].bankAccountType;
                                                          //       data.bankName = bankListResponse.data![cureentindex].bankName;
                                                          //       data.bankCode = bankListResponse.data![cureentindex].bankCode;
                                                          //       data.updatedAt = bankListResponse.data![cureentindex].updatedAt;
                                                          //       data.createdAt = bankListResponse.data![cureentindex].createdAt;
                                                          //       bankdetailreponse.data = data;
                                                          //       print("object"+json.encode(bankdetailreponse));
                                                          //       sharedPreferences.setString("BankdetailResponse", json.encode(bankdetailreponse));
                                                          //       pushNewScreen(
                                                          //         context,
                                                          //         screen: EditBankAccountNumber(bank_name:  bankListResponse.data![index].bankName.toString(),bank_id:bankListResponse.data![index].id.toString(),recipient_account_id:bankListResponse.data![index].id.toString(), Oncallback: Update,),
                                                          //         withNavBar: false,
                                                          //       );
                                                          //     }, child: SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,)),
                                                          SizedBox(width: 10,),
                                                          InkWell(
                                                              onTap: (){

                                                                // recipientId = accountdetaillist[index].recipientAccountId.toString();
                                                                dialogDelete(context, receipent_id, bankListResponse.data![index].id.toString());
                                                                setState((){});
                                                                // DeleteBankAccountApi(context,  widget.recipient_id.toString(), accountdetaillist[index].recipientAccountId.toString());
                                                              },
                                                              child: SvgPicture.asset("a_assets/icons/delete.svg",))
                                                        ],
                                                      ),

                                                      hSizedBox2,
                                                      Container(
                                                          alignment: Alignment.topLeft,
                                                          child:  Text(
                                                            //  accountdetaillist[index].fields![i].id.toString() == "BANK_ACCOUNT_NUMBER" ?
                                                            bankListResponse.data![index].bankAccountType.toString() ,
                                                            //: "",
                                                            maxLines: 2,
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(
                                                                color: MyColors.blackColor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 12,
                                                                overflow: TextOverflow.ellipsis,
                                                                fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                                            ),)
                                                      ),

                                                      hSizedBox1,
                                                      hSizedBox,
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [

                                                          Padding(
                                                            padding:  EdgeInsets.only(top: 0.0,right: 1),
                                                            child: SvgPicture.asset("a_assets/icons/bank.svg",height: 20,width: 20,color: cureentindex == index ? MyColors.lightblueColor:MyColors.blackColor,),
                                                          ),


                                                          wSizedBox1,
                                                          wSizedBox,
                                                          Container(
                                                            width: 120,
                                                              alignment: Alignment.topLeft,
                                                              child:  Text(
                                                                bankListResponse.data![index].bankName.toString(),
                                                                maxLines: 1,
                                                                textAlign: TextAlign.start,
                                                                style: TextStyle(
                                                                    color: cureentindex == index ? MyColors.lightblueColor:MyColors.blackColor.withOpacity(0.80),
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 12,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                                                ),)
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),

                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ):Container(),


                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: (){
                                  print("hbdhjbdf");
                                  (widget.ismfsAndalready ?? false)?
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          BankAccountNumber())):
                                  Navigator.pop(context);
                                  // widget.oncallback()
                                 /* pushNewScreen(
                                    context,
                                    screen: SelectPaymentMethodScreen(selectedMethodScreen: 1,),
                                    withNavBar: false,
                                  );*/
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.45,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical:0),
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        MyColors.lightblueColor.withOpacity(0.70),
                                        MyColors.lightblueColor.withOpacity(0.90),
                                      ]),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: MyColors.lightblueColor,
                                          width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              MyColors.whiteColor,
                                              MyColors.whiteColor
                                            ]),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Icon(
                                            CupertinoIcons.add,
                                            color: MyColors.lightblueColor,
                                          )),
                                      hSizedBox2,
                                      Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            MyString.add_new_method,
                                            style: TextStyle(
                                                color: MyColors.whiteColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                fontFamily:
                                                "s_asset/font/raleway/raleway_bold.ttf"),
                                          )),
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),



                      Column(children: [
                        hSizedBox2,

                        Container(
                          margin: EdgeInsets.only(left: 14),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    MyString.receive_methods,
                                    style: TextStyle(
                                        color: MyColors.color_text_a,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily:
                                        "s_asset/font/raleway/raleway_medium.ttf"),
                                  )),

                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top:12.0,left: 14),
                          child: Row(
                              children:[
                                SvgPicture.asset("a_assets/icons/bank.svg",height: 20,width: 20,color: MyColors.blackColor,),
                                wSizedBox1,
                                Text(
                                  "Bank Account",
                                  // bankListResponse.status==true?bankListResponse.data![cureentindex].routingCodeType1.toString():"",
                                  // MyString.bank_deposite,
                                  style: TextStyle(
                                      color: MyColors.color_text,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_medium.ttf"),
                                ),
                              ]

                          ),
                        ),
                        hSizedBox2,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 1,
                            physics: NeverScrollableScrollPhysics(),
                            //accountdetailfieldsetlist2.length,
                            itemBuilder: (context,int index){
                              return Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top:12.0,left: 14),
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Text(
                                                  "Bank Name",
                                                  style: TextStyle(
                                                      color:MyColors.color_text_a,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                      fontFamily:
                                                      "s_asset/font/raleway/raleway_medium.ttf"),
                                                ),
                                                hSizedBox1,

                                                Row(
                                                  children: [
                                                    SvgPicture.asset("a_assets/icons/bank4.svg",height: 26,width: 26,),
                                                    wSizedBox1,
                                                    Container(
                                                      width: 200,
                                                      child: Text(
                                                        bankListResponse.status==true?bankListResponse.data![cureentindex].bankName.toString():"",
                                                        style: TextStyle(
                                                            color: MyColors.color_text,
                                                            fontWeight: FontWeight.w800,
                                                            fontSize: 16,
                                                            fontFamily:
                                                            "s_asset/font/raleway/raleway_bold.ttf"),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]

                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top:0.0),
                                          padding: EdgeInsets.only(right: 14),
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                Text(
                                                  "Account Type",
                                                  //  MyString.Swift_Code,
                                                  style: TextStyle(
                                                      color:MyColors.color_text_a,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 12,
                                                      fontFamily:
                                                      "s_asset/font/raleway/raleway_medium.ttf"),
                                                ),
                                                hSizedBox1,


                                                Text(
                                                  // accountdetaillist[index].fields![1].value.toString() == "p" ? "Saving": "Checking" ,
                                                  //  accountdetailfieldsetlist2[index].id.toString()=="BANK_ACCOUNT_TYPE"?accountdetailfieldsetlist2[index].value.toString():"",
                                                  bankListResponse.status==true?bankListResponse.data![cureentindex].bankAccountType.toString():"" == "P" ?  "Saving": "Checking",
                                                  style: TextStyle(
                                                      color: MyColors.color_text,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14,
                                                      fontFamily:
                                                      "s_asset/font/raleway/raleway_semibold.ttf"),
                                                ),
                                              ]

                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(top:24.0,left: 14),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            Text(
                                              "BANK ACCOUNT NUMBER",
                                              // MyString.iban_code,
                                              style: TextStyle(
                                                  color:MyColors.color_text_a,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontFamily:
                                                  "s_asset/font/raleway/raleway_medium.ttf"),
                                            ),
                                            hSizedBox1,


                                            Text(
                                              bankListResponse.status==true?"****"+bankListResponse.data![cureentindex].accountNumber.toString().substring(bankListResponse.data![cureentindex].accountNumber.toString().length-4):"",
                                              style: TextStyle(
                                                  color: MyColors.color_text,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  fontFamily:
                                                  "s_asset/font/raleway/raleway_semibold.ttf"),
                                            ),
                                          ]

                                      ),
                                    ),

                                  ],
                                ) ,
                              );
                            }),

                        // hSizedBox3,
                        // Container(
                        //   margin: EdgeInsets.only(left: 14),
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     MyString.Reason,
                        //     style: TextStyle(
                        //         color: MyColors.color_text_a,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 12,
                        //         fontFamily:
                        //         "s_asset/font/raleway/Raleway-Medium.ttf"),
                        //   ),
                        // ),
                        //
                        // SizedBox(height: 12,),
                        // InkWell(
                        //   onTap: (){
                        //     dialogReason(context);
                        //   },
                        //   child: Container(
                        //     width: double.infinity,
                        //     margin: EdgeInsets.fromLTRB(
                        //         14.0, 0.0, 14.0, 0.0),
                        //     decoration: BoxDecoration(
                        //       color: MyColors.color_93B9EE
                        //           .withOpacity(0.1),
                        //       border: Border.all(
                        //           color: MyColors
                        //               .color_gray_transparent),
                        //       borderRadius: BorderRadius.all(
                        //           Radius.circular(12.0)),
                        //     ),
                        //     child: TextFormField(
                        //       enabled: false,
                        //       controller:
                        //       reasonController,
                        //       textInputAction:
                        //       TextInputAction.next,
                        //       onTap: () {
                        //         print("hvfh");
                        //         // AddRecipientFieldModel addmodel =   AddRecipientFieldModel(id:fieldsetlist[index].fields![i].fieldId.toString(),type:fieldsetlist[index].fields![i].fieldType.toString(),value :firstnameController.text);
                        //
                        //         //  addfieldlist.add(addmodel);
                        //         //  print("json..${json.encode(addfieldlist)}");
                        //         setState(() {});
                        //       },
                        //
                        //       style: TextStyle(
                        //           color: MyColors.blackColor,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //           fontFamily:
                        //           "a_assets/font/poppins_regular.ttf"),
                        //       decoration: InputDecoration(
                        //         hintText:
                        //         // fieldsetlistAccount[index]
                        //         //     .fields![i]
                        //         //     .placeholderText,
                        //         "Bank Account Type",
                        //         hintStyle: TextStyle(
                        //             color: MyColors.color_text
                        //                 .withOpacity(0.4),
                        //             fontSize: 12,
                        //             fontFamily:
                        //             "s_asset/font/raleway/Raleway-Medium.ttf",
                        //             fontWeight:
                        //             FontWeight.w500),
                        //
                        //         border: InputBorder.none,
                        //
                        //         // fillColor: MyColors.color_gray_transparent,
                        //         contentPadding:
                        //         EdgeInsets.symmetric(
                        //             horizontal: 16,
                        //             vertical: 12),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],),

                      SizedBox(height: 100,)

                    ],
                  ),
                ),
                hSizedBox4,
           /*     Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 15,right:15,),
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
                          child:Custombtn(MyString.cancel,76,140,context) ,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AddRecipientInfoScreen()));
                        },
                        child: addMathodButton(MyString.Next,70,140),
                      )
                    ],
                  ),
                ),
*/


              ],
            ),
          ),

          load == true || itemload == true?  Container(
            height: size.height,
            color: Colors.black.withOpacity(0.30),
            child: Center(
                child: GFLoader(
                    type: GFLoaderType.custom,
                    child: Image(image: AssetImage("a_assets/logo/progress_image.png"),
                    ))
            ),
          ) : Container()
        ],
      ),
    );
  }


  dialogReason(BuildContext context) {

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [



                      ListView.builder(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: purposeCodesResponse.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                setState(() async {
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  sharedPreferences.setString("reasonsending_name", purposeCodesResponse.data![index].purposeCodeDescription.toString());
                                  sharedPreferences.setString("reasonsending_id", purposeCodesResponse.data![index].purposeCode.toString());
                                  reasonController.text = purposeCodesResponse.data![index].purposeCodeDescription.toString();
                                  Navigator.pop(context);
                                });

                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Icon(Icons.radio_button_off_sharp,color: MyColors.primaryColor,),
                                    SizedBox(width: 10,),
                                    Expanded(child: Text('${purposeCodesResponse.data![index].purposeCodeDescription}')),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),

                      SizedBox(height: 10,),
                    ],
                  ),),



              ],
            ),
          ),
        ),
      ),
    );

  }

  Future <void> niumPurposeCodesApi(BuildContext context) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(
        Apiservices.niumPurposeCodesapi),
        headers: {
          "X-CLIENT": AllApiService.x_client,
          "content-type": "application/json",
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if(jsonResponse['status'] == true){
        purposeCodesResponse = PurposeCodesResponse.fromJson(jsonResponse);
      }
      setState(() {

      });
    }


    else{
      // List<dynamic> errorres = json.decode(response.body);
      // Fluttertoast.showToast(msg: errorres[0]["message"]);
      //Fluttertoast.showToast(msg: "Minimum amount was not met for this transaction.");

      setState(() {

      });

    }



  }


  addMathodButton(String text,double height,double width,  ) {
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
                MyColors.color_3F84E5.withOpacity(0.88),
                MyColors.color_3F84E5,
              ],
            ),
            //color: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
          child: Center(child: Text(text,style: TextStyle(color: MyColors.whiteColor,fontWeight: FontWeight.w700,fontSize: 18,fontFamily: "s_asset/font/raleway/Bold.ttf"),))),
    );
  }

  dialogDelete(BuildContext context,String recipientId,String recipient_account_id) {

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

                                  Navigator.pop(context);

                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                // color: MyColors.darkbtncolor,
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
                                  // DeleteRequest(context, payment_method_id);
                                  DeleteBankAccountApi(context, recipientId,recipient_account_id);

                                  setState(() {

                                  });

                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                // color: MyColors.darkbtncolor,
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

  Future<void> DeleteBankAccountApi(BuildContext context,
      String recipientId,String recipient_account_id) async {
    CustomLoader.ProgressloadingDialog(context, true);
    // setState((){
    //   load = true;
    // });
    SharedPreferences p = await SharedPreferences.getInstance();

    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['recipient_id'] = recipientId;
    request['account_id'] = recipient_account_id;


    print("request ${request}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(AllApiService.deleteRecipientBankAccountURL),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("bdjkdshjgh"+jsonResponse.toString());

      setState((){});
      /* String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();*/

      p.setString("BankdetailResponse", response.body);
      /* message == "" || message.isEmpty || message == ""? null:*/
      //  createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId);

      Navigator.pop(context);
      CustomLoader.ProgressloadingDialog(context, false);
      // getaccountdetailApi();
      recipientBankAccountsapi(context);
    } else {
      setState((){});
      List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast( errorres[0]["message"]);
      CustomLoader.ProgressloadingDialog(context, false);
    }

    setState((){

    });
    return;
  }
  Future <void> recipientBankAccountsapi(BuildContext context) async {
    load = true;
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};
    request['recipient_id'] = sharedPreferences.getString("recpi_id").toString();


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(Apiservices.recipientBankAccountsapi+"?recipient_id="+sharedPreferences.getString("recpi_id").toString()),
        // body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    // CustomLoader.ProgressloadingDialog(context, false);
    load = false;
    if (jsonResponse['status'] == true) {
      bankListResponse = await BankListResponse.fromJson(jsonResponse);

      if(bankListResponse.data!.length>0){
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        BankDetailResponse bankdetailreponse = new BankDetailResponse();
        bankdetailreponse.status = true;
        bankdetailreponse.message = "success";
        BankDetailData data = new BankDetailData();
        data.id = bankListResponse.data![cureentindex].id;
        data.rid = bankListResponse.data![cureentindex].rid;
        data.uid = bankListResponse.data![cureentindex].uid;
        data.routingCodeType1 = bankListResponse.data![cureentindex].routingCodeType1;
        data.routingCodeValue1 = bankListResponse.data![cureentindex].routingCodeValue1;
        data.routingCodeType2 = bankListResponse.data![cureentindex].routingCodeType2;
        data.routingCodeValue2 = bankListResponse.data![cureentindex].routingCodeValue2;
        data.accountNumber = bankListResponse.data![cureentindex].accountNumber;
        data.bankAccountType = bankListResponse.data![cureentindex].bankAccountType;
        data.bankName = bankListResponse.data![cureentindex].bankName;
        data.bankCode = bankListResponse.data![cureentindex].bankCode;
        data.updatedAt = bankListResponse.data![cureentindex].updatedAt;
        data.createdAt = bankListResponse.data![cureentindex].createdAt;
        bankdetailreponse.data = data;
        print("object"+json.encode(bankdetailreponse));
        sharedPreferences.setString("BankdetailResponse", json.encode(bankdetailreponse));
        sharedPreferences.setString("recipientReceiveBankOrMobileNo", bankListResponse.data![cureentindex].accountNumber.toString());
        sharedPreferences.setString("recipientReceiveBankNameOrOperatorName", bankListResponse.data![cureentindex].bankName.toString());

      }

      setState(() {

      });
    } else {
      bankListResponse = await BankListResponse.fromJson(jsonResponse);
      setState(() {

      });
    }
    return;
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




/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:moneytos/constance/customLoader/customLoader.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/model/account_detailsModel.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/addrecipientinfoscreen/select_oprator_screen.dart';
import 'package:moneytos/view/recipients_opened_sscreen/custom_recipientsopenedList.dart';
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


List<AccountsDetailModel> accountdetaillist = [];
List<AccountDetailFieldsModel> accountdetailfieldsetlist = [];
class SelectDeliveryAddMethodScreen extends StatefulWidget{
  @override
  State<SelectDeliveryAddMethodScreen> createState() => _SelectDeliveryAddMethodScreenState();
}



class _SelectDeliveryAddMethodScreenState extends State<SelectDeliveryAddMethodScreen> {

bool load = false;
  getaccountdetailApi() async{
    accountdetaillist.clear();
    accountdetailfieldsetlist.clear();

    setState((){
      load = true;
    });
    await Webservices.AccountDetailsRequest(context,accountdetaillist,accountdetailfieldsetlist);
    setState((){
      load = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getaccountdetailApi();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.whiteColor,
        centerTitle: true,
        actions: [],
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.whiteColor,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Text(MyString.Select_Delivery_Method,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4),),
      ),




      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
               // hSizedBox2,
              */
/*  Container(

                    width:350,
                    margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                    padding: EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 22.0),
                    decoration: BoxDecoration(
                      color: MyColors.whiteColor,
                      border: Border.all(color: MyColors.color_gray_transparent),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.color_linecolor,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
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
                          color: MyColors.color_linecolor,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 2.0,
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
                ),*//*

               // hSizedBox,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(30),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0)),
                      color: MyColors.whiteColor),
                  child: Column(
                    children: [
                      hSizedBox,


                      /// create listview....,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(accountdetaillist.length, (index) {
                              return SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: accountdetaillist[index].fields!.length,
                                    itemBuilder: (context,int i){
                                  return GestureDetector(
                                    onTap: (){
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BankAccountNumber(bank_name:  selectbankposts[index].name.toString(),)));
                                    },
                                    child:    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10),
                                      child: CustomRecipientOpenedCardList(
                                        title: accountdetaillist[index].fields![i].id.toString() == "BANK" ?  accountdetaillist[index].fields![i].value.toString(): "",
                                        icon: "a_assets/icons/edit.svg",
                                        subtitle:  accountdetaillist[index].transferMethod.toString(),
                                        bordercolor: MyColors.lightblueColor,
                                        status: true,
                                        iban:accountdetaillist[index].fields![i].id.toString() == "BANK_ACCOUNT_NUMBER" ?  accountdetaillist[index].fields![i].value.toString(): "",

                                      ),
                                    ),
                                  );
                                }),
                              );
                            }).toList(),

                       */
/*     [
                          //CustomList.countrylist.map((String url) {
                          // return
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: CustomRecipientOpenedCardList(
                              title: MyString.qnb_ba,
                              icon: "a_assets/icons/edit.svg",
                              subtitle: MyString.bank_deposit,
                              bordercolor: MyColors.lightblueColor,
                              status: true,
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: CustomRecipientOpenedCardList(
                              title: "Vodafone",
                              icon: "a_assets/icons/edit.svg",
                              subtitle: "Mobile Money",
                              bordercolor:
                              MyColors.lightblueColor.withOpacity(0.05),
                            ),
                          ),

                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: (){
                              print("hbdhjbdf");
                              pushNewScreen(
                                context,
                                screen: SelectPaymentMethodScreen(selectedMethodScreen: 1,),
                                withNavBar: false,
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: size.width * 0.45,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 30),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    MyColors.lightblueColor.withOpacity(0.70),
                                    MyColors.lightblueColor.withOpacity(0.90),
                                  ]),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: MyColors.lightblueColor,
                                      width: 1)),
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          MyColors.whiteColor,
                                          MyColors.whiteColor
                                        ]),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Icon(
                                        CupertinoIcons.add,
                                        color: MyColors.lightblueColor,
                                      )),
                                  hSizedBox2,
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        MyString.add_new_method,
                                        style: TextStyle(
                                            color: MyColors.whiteColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            fontFamily:
                                            "s_asset/font/raleway/raleway_bold.ttf"),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ]*//*

                          //}).toList(),
                        ),
                      ),

                      hSizedBox2,

                      Container(
                        margin: EdgeInsets.only(left: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.receive_methods,
                                  style: TextStyle(
                                      color: MyColors.color_text_a,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_medium.ttf"),
                                )),

                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top:12.0,left: 14),
                        child: Row(
                            children:[
                              SvgPicture.asset("a_assets/icons/bank.svg",height: 20,width: 20,color: MyColors.blackColor,),
                              wSizedBox1,
                              Text(
                                MyString.bank_deposite,
                                style: TextStyle(
                                    color: MyColors.color_text,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf"),
                              ),
                            ]

                        ),
                      ),
                      hSizedBox2,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top:12.0,left: 14),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text(
                                    MyString.bank_name,
                                    style: TextStyle(
                                        color:MyColors.color_text_a,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily:
                                        "s_asset/font/raleway/raleway_medium.ttf"),
                                  ),
                                  hSizedBox1,

                                  Row(
                                    children: [
                                      Image.asset("s_asset/images/bankicon1.png",height: 26,width: 26,),
                                      wSizedBox1,
                                      Text(
                                        "QNB",
                                        style: TextStyle(
                                            color: MyColors.color_text,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                            fontFamily:
                                            "s_asset/font/raleway/raleway_bold.ttf"),
                                      ),
                                    ],
                                  ),
                                ]

                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:0.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text(
                                    MyString.Swift_Code,
                                    style: TextStyle(
                                        color:MyColors.color_text_a,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily:
                                        "s_asset/font/raleway/raleway_medium.ttf"),
                                  ),
                                  hSizedBox1,


                                  Text(
                                    "QNB212XXX57",
                                    style: TextStyle(
                                        color: MyColors.color_text,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        fontFamily:
                                        "s_asset/font/raleway/raleway_semibold.ttf"),
                                  ),
                                ]

                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top:24.0,left: 14),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                MyString.iban_code,
                                style: TextStyle(
                                    color:MyColors.color_text_a,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf"),
                              ),
                              hSizedBox1,


                              Text(
                                "SAF548215445REW214874521",
                                style: TextStyle(
                                    color: MyColors.color_text,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_semibold.ttf"),
                              ),
                            ]

                        ),
                      ),


                    ],
                  ),
                ),
                hSizedBox1,
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 15,right:15,),
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
                          child:Custombtn(MyString.cancel,76,140,context) ,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => AddRecipientInfoScreen()));
                        },
                        child: addMathodButton(MyString.Next,70,140),
                      )
                    ],
                  ),
                ),



              ],
            ),
          ),

          load == true? Container(
    height: size.height,
    color: Colors.white,
    child: Center(
    child: GFLoader(
    type: GFLoaderType.custom,
    child: Image(image: AssetImage("a_assets/logo/progress_image.png"),
    ))
    ),
    ) : Container()
        ],
      ),
    );
  }

  addMathodButton(String text,double height,double width,  ) {
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
*/
