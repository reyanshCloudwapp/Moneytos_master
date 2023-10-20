import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/home/s_home/debitcardscreen/debit_cardscreen.dart';
import 'package:moneytos/view/home/s_home/go_toreview_screen/go_toreview_screen.dart';
import 'package:moneytos/view/select_bank/selectBank_screen.dart';
import 'package:moneytos/view/selectserviceprovider/selectserviceprovider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constance/customLoader/customLoader.dart';
import '../../constance/myStrings/myString.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/S_ApiResponse/ViewDebitCardListResponse.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../dash_recipentScreen/select_recipient_screen/select_new_recipient_screen.dart';
import '../home/s_home/bankdetailsscreen/bank_details_screen.dart';
import '../home/s_home/debitcardscreen/edit_debit_cardscreen.dart';
import '../select_payment_method_screen/edit_bank_details_screen.dart';
import '../transfers_scheduled_screens/transferreview_and_confirmScreen.dart';
import 'dart:convert' as convert;

import 'manage_payment_bank_details_screen.dart';
import 'manage_payment_debit_cardscreen.dart';



class ManageSelectPaymentMethodScreen extends StatefulWidget {

  int selectedMethodScreen;

 ManageSelectPaymentMethodScreen({Key? key,required this.selectedMethodScreen}) : super(key: key);

  @override
  State<ManageSelectPaymentMethodScreen> createState() => _ManageSelectPaymentMethodScreenState();
}

class _ManageSelectPaymentMethodScreenState extends State<ManageSelectPaymentMethodScreen> {
  bool _enabled = true;
  int selectedItemTab=-1;
  String Bankacc="";
  String Debitcard="";
  String Mobilemoney="";

  int SelectedMethod=0;
  List<dynamic> viewdebitcardlist = [];
  bool is_bankselect = false;
  bool is_cardselect = false;
  String selected_acc_id = "";
  String selected_acc_name = "";
  String selected_payment_type = "";
  String selected_last4 = "";
  @override
  void initState() {
    // TODO: implement initState
    /// comment code for hide bank
    // SelectedMethod = widget.selectedMethodScreen;

    /// show only card
    SelectedMethod=1;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => paymentmethodsRequest(context));
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.light_primarycolor2,
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only( left: 25,top: 25),
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
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(
                    MyString.select_payment_method,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                        "s_asset/font/raleway/raleway_extrabold.ttf"),
                  ),
                ),
                Container(
                  width: 26,
                )
              ],
            ),
          ),



        ),
      ),
     /* appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: MyColors.primaryColor,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only( left: 25,top: 25),
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
                      )),
                ),
                // wSizedBox3,
                // wSizedBox3,
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(
                    MyString.select_payment_method,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily:
                        "s_asset/font/raleway/raleway_medium.ttf"),
                  ),
                ),
                Container(
                  width: 50,
                )
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),*/

      body: Stack(
        children: [

          Container(
            height: 300,
            color: MyColors.light_primarycolor2,
          ),

          Container(
            margin: EdgeInsets.only(top: 0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius:
                BorderRadius.circular(30)
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  hSizedBox2,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:  [

                        /// commit for hide bank
                        /*
                        GestureDetector(
                          onTap:(){
                            SelectedMethod=0;
                            is_bankselect = false;
                            is_cardselect = false;
                            selectedItemTab=-1;
                            setState(() {

                            });

                  },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),

                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(color: SelectedMethod==0?MyColors.color_93B9EE:MyColors.whiteColor,
                                          width: 2)
                                  ),
                                  child: Material(
                                      elevation: 20,
                                      shadowColor: MyColors.lightblueColor.withOpacity(0.10),
                                      color: MyColors.whiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 30),
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                              "a_assets/icons/bank.svg",height: 30,width: 30, color:SelectedMethod==0?MyColors.lightblueColor:MyColors.blackColor ,),
                                            hSizedBox1,
                                            hSizedBox,
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                MyString.bank_acount,
                                                style: TextStyle(
                                                    color:SelectedMethod==0?MyColors.lightblueColor:MyColors.blackColor ,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                    "s_asset/font/raleway/Raleway-Medium.ttf",
                                                    fontSize: 13),
                                              ),
                                            )
                                          ],
                                        ),
                                      )))

                          ),
                        ),

                         */
                        GestureDetector(
                          onTap: (){
                            SelectedMethod=1;
                            is_bankselect = false;
                            is_cardselect = false;
                            selectedItemTab=-1;
                            setState(() {

                            });
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),

                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(color: SelectedMethod==1?MyColors.color_93B9EE:MyColors.whiteColor,
                                          width: 2)
                                  ),
                                  child: Material(
                                      elevation: 20,
                                      shadowColor: MyColors.lightblueColor.withOpacity(0.10),
                                      color: MyColors.whiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 30),
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                              "a_assets/icons/debit_card.svg",height: 30,width: 30,color:SelectedMethod==1?MyColors.lightblueColor:MyColors.blackColor , ),
                                            hSizedBox1,
                                            hSizedBox,
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                MyString.debit_card,
                                                style: TextStyle(
                                                    color:SelectedMethod==1?MyColors.lightblueColor:MyColors.blackColor ,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                    "s_asset/font/raleway/raleway_medium.ttf",
                                                    fontSize: 13),
                                              ),
                                            )
                                          ],
                                        ),
                                      )))

                          ),
                        ),

                      ]
                    ),
                  ),
                  hSizedBox2,




                  /////////////BankAccount///////////////



                  _enabled==true?Utility.shrimmerVerticalListLoader(100, MediaQuery.of(context).size.width):
                  Visibility(
                    visible: SelectedMethod==0?true:false,
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: viewdebitcardlist.length,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shrinkWrap: true,
                            itemBuilder: (context ,int index){
                          return
                            viewdebitcardlist[index]["payment_method_type"]=="check"?
                            GestureDetector(
                            onTap: (){

                              setState(()  {

                                selectedItemTab=index;
                                is_bankselect = true;
                                selected_acc_id = viewdebitcardlist[index]["id"].toString();
                                selected_acc_name = viewdebitcardlist[index]["name"].toString();
                                selected_payment_type = viewdebitcardlist[index]["payment_method_type"].toString();
                                selected_last4 = viewdebitcardlist[index]["last4"].toString();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(top:14),
                              child: Customcard2(viewdebitcardlist[index]["name"],viewdebitcardlist[index]["last4"],MyColors.blackColor,viewdebitcardlist[index]["sec_code"],viewdebitcardlist[index]["routing_number"],viewdebitcardlist[index]["id"].toString(),index),
                            ),
                          ):Container();
                        }),
                        hSizedBox4,


                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: (){
                            print("hbdhjbdf");
                            pushNewScreen(
                              context,
                              screen: ManagePaymentBankDetailsScreen(oncallBack: Update,),
                              withNavBar: false,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 22,),

                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  MyColors.lightblueColor.withOpacity(0.80),
                                  MyColors.lightblueColor,
                                ]),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: MyColors.lightblueColor,
                                    width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "a_assets/icons/bank.svg",color: MyColors.whiteColor,),
                                wSizedBox2,
                                Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Link New Bank",
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
                        ),
                        hSizedBox5,
                        hSizedBox2,
                        hSizedBox5,
                      ],
                    ),
                  ),



                  /////////////DebitCard///////////////
                  _enabled==true?Utility.shrimmerVerticalListLoader(100, MediaQuery.of(context).size.width):
                     Visibility(
                       visible: SelectedMethod==1?true:false,
                       child: Column(
                         children: [
                           ListView.builder(
                            itemCount: viewdebitcardlist.length,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shrinkWrap: true,
                            itemBuilder: (context ,int index){
                    return viewdebitcardlist[index]["payment_method_type"]=="card"?
                      GestureDetector(
                      onTap: (){
                        setState(()  {

                          selectedItemTab=index;
                          is_cardselect = true;
                          selected_acc_id = viewdebitcardlist[index]["id"].toString();
                          selected_acc_name = viewdebitcardlist[index]["name"].toString();
                          selected_payment_type = viewdebitcardlist[index]["payment_method_type"].toString();
                          selected_last4 = viewdebitcardlist[index]["last4"].toString();
                        });
                      },
                      child: Container(
                       margin: EdgeInsets.only(top:14),
                              child: Customcard3(viewdebitcardlist[index]["id"].toString(),viewdebitcardlist[index]["avs_address"],viewdebitcardlist[index]["avs_zip"],viewdebitcardlist[index]["name"],MyColors.blackColor,viewdebitcardlist[index]["last4"],viewdebitcardlist[index]["expiry_month"]!=null?viewdebitcardlist[index]["expiry_month"].toString():"",viewdebitcardlist[index]["expiry_year"]!=null?viewdebitcardlist[index]["expiry_year"].toString():"",viewdebitcardlist[index]["card_type"]!=null?viewdebitcardlist[index]["card_type"].toString():"",index),
                      ),
                    ):Container();
                  }),
                  hSizedBox3,


                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                            print("hbdhjbdf");
                            pushNewScreen(
                              context,
                              screen: ManagePaymentDebitCardScreen(oncallBack: Update,),
                              withNavBar: false,
                            );
                    },
                    child:
                    Container(
                            alignment: Alignment.center,

                      height: 50,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20,),

                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  MyColors.lightblueColor.withOpacity(0.80),
                                  MyColors.lightblueColor,
                                ]),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: MyColors.lightblueColor,
                                    width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "s_asset/images/cardnew.svg",color: MyColors.whiteColor,),
                                wSizedBox2,
                                Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Add New Card",
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
                  ),
                  hSizedBox5,
                  hSizedBox2,
                           hSizedBox5,
                         ],
                       ),
                     ),


                  /////////////MobileMoney///////////////

                     Visibility(
                       visible: SelectedMethod==2?true:false,
                       child: Column(
                         children: [
                           ListView.builder(
                            itemCount: 2,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            shrinkWrap: true,
                            itemBuilder: (context ,int index){
                    return GestureDetector(
                      onTap: (){
                        setState(()  {

                          selectedItemTab=index;
                        });
                      },
                      child: Container(
                        margin:EdgeInsets.only(top:14),
                              child: Customcard4("","Vodafone",MyColors.blackColor,"Number - 5117",index),
                      ),
                    );
                  }),
                  hSizedBox3,


                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                            print("hbdhjbdf");
                            pushNewScreen(
                              context,
                              screen: SelectServiceProviderScreen(isMfs: false),
                              withNavBar: false,
                            );
                    },
                    child: Container(
                            alignment: Alignment.center,

                            height: 50,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 20,),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  MyColors.lightblueColor.withOpacity(0.80),
                                  MyColors.lightblueColor,
                                ]),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: MyColors.lightblueColor,
                                    width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    "s_asset/images/mobile2.svg",color: MyColors.whiteColor,),
                                wSizedBox2,
                                Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "New Mobile Money",
                                      style: TextStyle(
                                          color: MyColors.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          fontFamily:
                                          "s_asset/font/raleway/raleway_semibold.ttf"),
                                    )),
                              ],
                            ),
                    ),
                  ),
                  hSizedBox5,
                  hSizedBox2,
                           hSizedBox5,
                         ],
                       ),
                     ),





                ],
              ),
            ),
          ),

      ]
      ),
    );
  }



  Customcard2(String title, String last4 ,Color color,String sec_code,String rounting_number,String payment_method_id,int index){
return Container(

  decoration: BoxDecoration(
    border: Border.all(color: selectedItemTab==index?MyColors.color_3F84E5:MyColors.whiteColor,width: 2),
    borderRadius: BorderRadius.all(Radius.circular(12))
  ),
  child: Material(

    elevation: 16,
    shadowColor: MyColors.lightblueColor.withOpacity(0.10),
    color: MyColors.whiteColor,

    shape: RoundedRectangleBorder(
      borderRadius:
      BorderRadius.circular(10),
    ),
    child:  Container(
      padding: EdgeInsets.symmetric(
          vertical: 20, horizontal: 30),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                  width: 40,
                  // decoration: BoxDecoration(
                  //   color: Color(0xff056CAD),
                  //   borderRadius: BorderRadius.circular(9)
                  // ),
                  child: SvgPicture.asset("a_assets/icons/bank4.svg")),
              wSizedBox1,
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                            "s_asset/font/raleway/raleway_bold.ttf",
                            fontSize: 16),
                      ),
                    ),
                    hSizedBox1,
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Account - "+last4,
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                            "s_asset/font/raleway/raleway_medium.ttf",
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),

          Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBankDetailsScreen(sec_code: sec_code, last4: last4, title: title, rounting_number: rounting_number, payment_method_id: payment_method_id, oncallBack: Update,)));
                },
                  child: SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,)),
              wSizedBox2,
              wSizedBox,
              InkWell(
                  onTap: (){
                    dialogDelete(context,payment_method_id);
                  },
                  child: SvgPicture.asset("a_assets/icons/delete.svg")),
            ],
          )
        ],
      ),
    ),
  ),
);
  }

  void Update(){
    WidgetsBinding.instance.addPostFrameCallback((_) => paymentmethodsRequest(context));
    setState(() {

    });
  }

  dialogDelete(BuildContext context,String payment_method_id) {

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
                                  DeleteRequest(context, payment_method_id);

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

  Future<void> DeleteRequest(BuildContext context,String payment_method_id) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    request['payment_method_id'] = payment_method_id;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.DeleteBankCardURL),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
          // "Authorization": AllApiService.client_id,
        });

    // if(response.statusCode==204){
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   // Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    //   // print("jsonResponse>>> if"+jsonResponse.toString());
    //   Update();
    //   Navigator.pop(context);
    // }else{
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    //   print("jsonResponse>>> else"+jsonResponse.toString());
    //   Fluttertoast.showToast(msg: jsonResponse["error_details"].toString());
    // }
    Update();
    Navigator.pop(context);
    Navigator.pop(context);
    setState(() {});

    // if (jsonResponse['status'] == true) {
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Fluttertoast.showToast(msg: jsonResponse['message']);
    //
    //
    //   setState(() {});
    // } else {
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Fluttertoast.showToast(msg: jsonResponse['message']);
    //   setState(() {});
    // }

    return;
  }


  Customcard3(String payment_method_id,String avsAddress,String avsZip, String title ,Color color,String CardNumber,String Month,String Year,String cardType,int index){
    return Container(

      decoration: BoxDecoration(
          border: Border.all(color: selectedItemTab==index?MyColors.color_3F84E5:MyColors.whiteColor,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Material(
        elevation: 16,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        color: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10),
        ),
        child:  Container(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: 30),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  cardType == "MasterCard"?
                  SvgPicture.asset("s_asset/images/carda.svg"):
                  Container(margin:EdgeInsets.only(bottom: 5),child: SvgPicture.asset("s_asset/images/ic_visa.svg",height: 20,width: 24,)),

                  wSizedBox1,
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                fontSize: 16),
                          ),
                        ),
                        hSizedBox1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                            //  alignment: Alignment.topLeft,
                              child: Text(
                                "**** "+CardNumber,
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf",
                                    fontSize: 12),
                              ),

                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditDebitCardScreen(avsAddress: avsAddress, Month: Month, CardNumber: selected_last4, oncallBack: Update, Year: Year, title: title, avsZip: avsZip, payment_method_id: payment_method_id,)));
                        },
                          child: SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,)),
                      wSizedBox2,
                      wSizedBox,
                      InkWell(
                          onTap: (){
                            dialogDelete(context,payment_method_id);
                          },
                          child: SvgPicture.asset("a_assets/icons/delete.svg")),
                    ],
                  ),

                  hSizedBox4,
                  Container(

                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      Month+"/"+Year,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w500,
                          fontFamily:
                          "s_asset/font/raleway/raleway_medium.ttf",
                          fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  Customcard4(String img, String title ,Color color,String des,int index){
    return Container(

      decoration: BoxDecoration(
          border: Border.all(color: selectedItemTab==index?MyColors.color_3F84E5:MyColors.whiteColor,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Material(
        elevation: 16,
        shadowColor: MyColors.lightblueColor.withOpacity(0.10),
        color: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10),
        ),
        child:  Container(
          padding: EdgeInsets.symmetric(
              vertical: 20, horizontal: 30),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                         // color: Color(0xff056CAD),
                          borderRadius: BorderRadius.circular(9)
                      ),
                      child: Image.asset("s_asset/images/companyimg.png")),
                  wSizedBox1,
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                "s_asset/font/raleway/raleway_bold.ttf",
                                fontSize: 16),
                          ),
                        ),
                        hSizedBox1,
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Number - 5117",
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf",
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("a_assets/icons/edit.svg",color: MyColors.blackColor,),
                  wSizedBox2,
                  wSizedBox,
                  SvgPicture.asset("a_assets/icons/delete.svg"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> paymentmethodsRequest(BuildContext context) async {
    // CustomLoader.ProgressloadingDialog(context, true);
    _enabled = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(AllApiService.magicpayPaymentMethods),
        // body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
          // "Authorization": AllApiService.client_id,
        });

    if(response.statusCode==200){
      // Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      // print("nsklvnsf>> "+jsonResponse.toString());
      // CustomLoader.ProgressloadingDialog(context, false);
      _enabled = false;
     viewdebitcardlist = json.decode(response.body);
      // print("nsklvnsf>> "+viewdebitcardlist[0]["avs_zip"]);
      // for (var responsedata in viewdebitcardlist) {
      //   if(responsedata["payment_method_type"]=="check"||responsedata["payment_method_type"]=="card"){
      //     SelectedMethod = 0;
      //   }else if(responsedata["payment_method_type"]=="check"){
      //     SelectedMethod = 0;
      //   }else if(responsedata["payment_method_type"]=="card"){
      //     SelectedMethod = 1;
      //   }else{
      //
      //   }
      //   SelectedMethod = responsedata["payment_method_type"]=="check"?0:responsedata["payment_method_type"]=="card"?1:2;
      // }
    }else{
      _enabled = false;
      // CustomLoader.ProgressloadingDialog(context, false);
    }


    // if (jsonResponse['status'] == true) {
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Fluttertoast.showToast(msg: jsonResponse['message']);
    //
    //
    //   setState(() {});
    // } else {
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Fluttertoast.showToast(msg: jsonResponse['message']);
      setState(() {});
    // }
    return;
  }

}
