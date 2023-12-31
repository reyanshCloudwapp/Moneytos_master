import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/resonforsendingscreen/reasonforsendingscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendMoneyquotationRecipints extends StatefulWidget{
  //SelectCountryList selectCountryList;


  //SendMoneyquotationRecipints({Key? key,required this.selectCountryList}) : super(key: key);


  @override
  State<SendMoneyquotationRecipints> createState() => _SendMoneyquotationRecipintsState();
}

class _SendMoneyquotationRecipintsState extends State<SendMoneyquotationRecipints> {


  String countryName="";
  String countryFlag="";
  String auhtToken="";
  TextEditingController toMoneyController =TextEditingController();
  TextEditingController fromMoneyController =TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadPref();
    setState(() {

    });
  }

  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    countryName=sharedPreferences.getString("country_Name").toString();
    countryFlag=sharedPreferences.getString("country_Flag").toString();
    auhtToken=sharedPreferences.getString("auth_Token").toString();

    print("countryName>>>"+countryName);
    print("countryFlag>>>"+countryFlag);

    print("auhtToken_auhtToken>>>"+auhtToken);

  }


  @override
    Widget build(BuildContext context) {
      var size = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: MyColors.color_03153B,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(265),
          child: AppBar(
            backgroundColor: MyColors.color_03153B,
            elevation: 0,
            centerTitle: true,
            flexibleSpace: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only( left: 20,top: 65,right: 20),
              child: Column(
                children: [
                  /// appbar ui....

                  Container(
                    //  margin: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: Column(
                      children: [
                        /// Profile image
                        Stack(
                            children:[
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 18, 0.0, 10.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      "a_assets/logo/female_profile.jpg"),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                      color: MyColors.accent_ED5565_red,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage("s_asset/images/closeimg.png")
                                      )

                                  ),
                                  margin: EdgeInsets.fromLTRB(26, 0, 0.0, 10.0),

                                ),
                              ),

                            ]

                        ),

                        /// recipent name

                        hSizedBox1,
                        Container(
                          //  margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                            child: Text(
                              MyString.recipient_name,
                              style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily:
                                  "s_asset/font/raleway/raleway_semibold.ttf"),
                            )),
                        hSizedBox,

                        Container(
                          // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                            child: Text(
                              "(+61) 124-335-547",
                              style: TextStyle(
                                  color: MyColors.whiteColor
                                      .withOpacity(0.50),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  fontFamily:
                                  "s_asset/font/raleway/raleway_medium.ttf"),
                            )),

                        hSizedBox1,
                        hSizedBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(top: 0.0, right: 1),
                              child: SvgPicture.asset(
                                "a_assets/icons/au_australia.svg",
                                height: 20,
                                width: 20,
                              ),
                            ),
                            wSizedBox,
                            Container(
                                margin:
                                EdgeInsets.fromLTRB(00, 5, 0, 0),
                                child: Text(
                                  "Sydney, AU",
                                  style: TextStyle(
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_semibold.ttf"),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.color_03153B,
              statusBarIconBrightness: Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),

          ),
        ),
        body: Stack(
          children: [
            Container(
              color: MyColors.color_03153B,
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: size.height,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(30),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),bottomLeft: Radius.circular(5)),
                  color: MyColors.whiteColor),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      hSizedBox1,
                      Container(
                          width:double.infinity,
                          margin:  EdgeInsets.fromLTRB(12.0, 26.0, 12.0, 0.0),
                          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                          decoration: BoxDecoration(
                            color: MyColors.color_D8E6FA_bac,
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width:150,

                                  child: TextField(
                                    controller: toMoneyController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                       // labelText: 'Enter Name',
                                        hintText:   "You send",
                                      contentPadding: EdgeInsets.zero,


                                    ),

                                    style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                                        fontWeight: FontWeight.w500,color: MyColors.color_ffF4287_text),)),
                              Row(
                                children: [
                                  SvgPicture.asset("s_asset/images/flag1.svg"),
                                  wSizedBox,
                                  Text(MyString.usd,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                                ],
                              ),
                            ],
                          )
                      ),
                      Container(
                          width:double.infinity,
                          margin:  EdgeInsets.fromLTRB(12.0, 26.0, 12.0, 0.0),
                          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                          decoration: BoxDecoration(
                            color: MyColors.color_D8E6FA_bac,
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(

                                  width:150,
                                  child: TextField(
                                    controller: fromMoneyController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        // labelText: 'Enter Name',
                                        hintText:"Yhesham sqrat gets",
                                        contentPadding: EdgeInsets.zero,


                                      ),style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_ffF4287_text),)),
                              Row(
                                children: [
                                  SvgPicture.asset("s_asset/images/flag2.svg"),
                                  wSizedBox,
                                  Text(MyString.AUD,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                                  wSizedBox,
                                  SvgPicture.asset("s_asset/images/dropdown.svg",),
                                ],
                              ),
                            ],
                          )
                      ),
                      hSizedBox3,
                      hSizedBox3,

                      Text("Exchange Rate",style: TextStyle(fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text_a),),
                      hSizedBox1,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("01.00",style: TextStyle(color: MyColors.color_text,fontSize:12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w800,),),
                              Text(" USD",style: TextStyle(color: MyColors.color_text,fontSize:9,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w600, ),)
                            ],
                          ),
                          wSizedBox1,
                          SvgPicture.asset("s_asset/images/leftrightarrow.svg",height: 10,width: 10,),
                          wSizedBox1,

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("01.30",style: TextStyle(color: MyColors.color_text,fontSize:12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w800,),),
                              Text(" AUD",style: TextStyle(color: MyColors.color_text,fontSize:9,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w600, ),)
                            ],
                          ),



                        ],
                      ),
                      hSizedBox3,
                      Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(

                          color: MyColors.color_D8E6FA_bac,
                          border: Border.all(color: MyColors.color_gray_transparent),
                          borderRadius: BorderRadius.all(Radius.circular(26.0)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Fees   ",style: TextStyle(color: MyColors.color_text_a,fontSize:12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,),),

                            Text("2.60",style: TextStyle(color: MyColors.color_text,fontSize:12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w800,),),
                            Text(" USD",style: TextStyle(color: MyColors.color_text,fontSize:9,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w600, ),)
                          ],
                        ),
                      ),

                      hSizedBox1,
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ReasonforSendingScreen()));
                        },
                        child: Container(
                          alignment: Alignment.center,

                          height: 50,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width /4,),
                          margin: EdgeInsets.symmetric(
                              horizontal: 30,vertical: 40),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                MyColors.lightblueColor.withOpacity(0.90),
                                MyColors.lightblueColor,
                              ]),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: MyColors.lightblueColor,
                                  width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    MyString.Next,
                                    style: TextStyle(
                                        color: MyColors.whiteColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        fontFamily:
                                        "s_asset/font/raleway/raleway_bold.ttf"),
                                  )),
                            ],
                          ),
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }


}