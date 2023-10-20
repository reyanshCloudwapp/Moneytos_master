import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:moneytos/add_new_recipients_dashboard/dashaddrecipientinfoscreen.dart';
import 'package:moneytos/constance/customLoader/customLoader.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/model/account_detailsModel.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/addrecipientinfoscreen/addrecipientinfoscreen.dart';
import 'package:moneytos/view/dash_recipentScreen/select_recipient_screen/select_new_recipient_screen.dart';
import 'package:moneytos/view/recipients_opened_sscreen/custom_recipientsopenedList.dart';
import 'package:moneytos/view/resonforsendingscreen/reasonforsendingscreen.dart';
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';


List<AccountsDetailModel> accountdetaillist = [];
List<AccountDetailFieldsModel> accountdetailfieldsetlist = [];

List<AccountsDetailModel> accountdetaillist2 = [];
List<AccountDetailFieldsModel> accountdetailfieldsetlist2 = [];

class DashSelectDeliveryAddMethodScreen extends StatefulWidget{
  //final Function oncallback;

  //DashSelectDeliveryAddMethodScreen(this.oncallback);

  @override
  State<DashSelectDeliveryAddMethodScreen> createState() => _DashSelectDeliveryAddMethodScreenState();
}



class _DashSelectDeliveryAddMethodScreenState extends State<DashSelectDeliveryAddMethodScreen> {

  bool load = false;
  int cureentindex = 0;
  Color bordercolor = MyColors.whiteColor;
  String? recipientId;
  bool itemload = false;
  String bankName="",account_type="",account_number="";
  String receipent_id="";
  String receipent_account_id="";
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
    setState((){

    });
  }

  getaccountdetailApi() async{
    accountdetaillist.clear();
    accountdetailfieldsetlist.clear();


    setState((){
      load = true;
    });
    await Webservices.AccountDetailsRequest(context,accountdetaillist,accountdetailfieldsetlist,receipent_id);

    recipientId =  accountdetaillist.length > 0 ? accountdetaillist[0].recipientAccountId.toString(): "";
    receipent_account_id =  accountdetaillist.length > 0 ? accountdetaillist[0].recipientAccountId.toString(): "";
    setState((){});
    getaccountitemdetailApi(receipent_id,receipent_account_id);
    setState((){
      load = false;
    });
    print("dhghfgfj${accountdetailfieldsetlist.length}");
  }
  Future<void> pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    receipent_id = sharedPreferences.getString("recipientId").toString();
    print("receipent_id"+receipent_id);
    setState((){
    });
    getaccountdetailApi();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pref();

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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SelectNewRecipientScreen()));
               // Navigator.pop(context);
              },
              child: Container(
                //  padding: EdgeInsets.only(top: size.height / 2),
                alignment: Alignment.center,
                child:Custombtn(MyString.cancel,76,140,context) ,
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => DashAddRecipientInfoScreen()));
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
                      SizedBox(
                        height: 150,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: accountdetaillist.length,
                                    itemBuilder: (context,int index){
                                      return SizedBox(
                                        height: 150,
                                        width: 200,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                          child: Material(
                                            elevation: 2,
                                            color: MyColors.whiteColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: GestureDetector(
                                              onTap: (){

                                                cureentindex = index;
                                                bordercolor = MyColors.lightblueColor;
                                                recipientId = accountdetaillist[index].recipientAccountId.toString();
                                                setState(() {});

                                                getaccountitemdetailApi(receipent_id,accountdetaillist[index].recipientAccountId.toString());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 17,vertical: 10),
                                                decoration: BoxDecoration(
                                                    color: MyColors.whiteColor,
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(color: cureentindex  == index? MyColors.lightblueColor : MyColors.whiteColor,width: 1)
                                                ),
                                                child: ListView.builder(
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: 1,
                                                    //accountdetaillist[index].fields!.length,
                                                    itemBuilder: (context,int i){
                                                      return Container(
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
                                                                    width: 120,
                                                                    alignment: Alignment.topLeft,
                                                                    child:  Text(
                                                                      // accountdetaillist[index].fields![0].id.toString() == "BANK" ?

                                                                      accountdetaillist[index].fields![1].value.toString(),
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
                                                              ],
                                                            ),

                                                            hSizedBox2,
                                                            Container(
                                                                alignment: Alignment.topLeft,
                                                                child:  Text(
                                                                  //  accountdetaillist[index].fields![i].id.toString() == "BANK_ACCOUNT_NUMBER" ?
                                                                  accountdetaillist[index].fields![1].value.toString() == "p" ? "Saving": "Checking" ,
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
                                                                    alignment: Alignment.topLeft,
                                                                    child:  Text(
                                                                      accountdetaillist[index].transferMethod.toString(),
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

                                                      );
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),


                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: (){
                                  print("hbdhjbdf");
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
                                accountdetaillist2.length > 0 ?   accountdetaillist2[0].transferMethod.toString() : "",
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
                                                  bankName,
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
                                            account_type == "p" ?  "Saving": "Checking",
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
                                          account_number,
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

  addMathodButton(String text,double height,double width,  ) {
    return  Container(
      height: height,
      // width: width,
      color: MyColors.whiteColor,
      //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
      child: Container(
          padding: EdgeInsets.only(left: 10,right: 10),
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
class DashSelectDeliveryAddMethodScreen extends StatefulWidget{
  @override
  State<DashSelectDeliveryAddMethodScreen> createState() => _DashSelectDeliveryAddMethodScreenState();
}



class _DashSelectDeliveryAddMethodScreenState extends State<DashSelectDeliveryAddMethodScreen> {

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
