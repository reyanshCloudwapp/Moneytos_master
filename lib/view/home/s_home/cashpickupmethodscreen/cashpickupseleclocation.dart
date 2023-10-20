import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/model/customlists/customLists.dart';

class CashPickUpSelectLocation extends StatefulWidget{

  @override
  State<CashPickUpSelectLocation> createState() => _CashPickUpSelectLocationState();
}

class _CashPickUpSelectLocationState extends State<CashPickUpSelectLocation> {
  TextEditingController searchMobileCompanyController = TextEditingController();

  FocusNode searchFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocus.unfocus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,


      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(390),
        child: AppBar(
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          actions: const [],
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 65,left: 20,right: 20),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    child: const Text( MyString.Select_Delivery_Method ,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4),),
                  ),
                  hSizedBox3,
                  Container(
                      height: 55,
                      width:double.infinity,
                      // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                      padding: const EdgeInsets.fromLTRB(16.0, 5.0, 20.0, 5.0),
                      decoration: const BoxDecoration(
                        color: MyColors.whiteColor,
                        //border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.color_linecolor,
                            offset: Offset(0.0, 1.6), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("s_asset/images/flag2.svg",width: 26,height: 26,),
                              wSizedBox1,
                              const Text(MyString.country_name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: MyColors.color_text),),
                            ],
                          ),
                          Container(
                              width: 50,
                              child: SvgPicture.asset("a_assets/icons/clear_red.svg")),
                        ],
                      )
                  ),
                  hSizedBox2,
                  Container(
                      height: 55,
                      width:double.infinity,
                      // margin:  EdgeInsets.fromLTRB(12.0, 16.0, 0.0, 0.0),
                      padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
                      decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                        border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: const [
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
                          const Row(
                            children: [
                              // SvgPicture.asset("s_asset/images/flag2.svg",width: 24,height: 24,),
                              //wSizedBox1,
                              Text(MyString.City_Name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                            ],
                          ),
                          Container(
                              width: 50,
                              child: SvgPicture.asset("a_assets/icons/clear_red.svg")),

                        ],
                      )
                  ),
                  //
                  hSizedBox1,

                  Container(
                      margin: const EdgeInsets.only(top: 16,bottom: 20),
                      alignment: Alignment.center,
                      child: const Text("Select Location to Add method",style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"))),

                  hSizedBox1,
                  Container(
                    child: searchLocation(),
                  ),
                  hSizedBox2,
                ],
              ),
            ),
          ),
        ),
      ),

      bottomSheet: GestureDetector(
        onTap: (){
          Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: 100,
          color: MyColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 2.7,vertical:25 ),
          // margin: EdgeInsets.symmetric(vertical:10 ),
          child:  CustomButton(
            btnname: MyString.back,
            textcolor: MyColors.lightblueColor,
            bordercolor: MyColors.lightblueColor.withOpacity(0.08),
            bg_color: MyColors.lightblueColor.withOpacity(0.14),
          ),
        ),
      ),
      body: Stack(
          children:[
         Container(
              margin: const EdgeInsets.only(left: 12,right: 12,top: 1),

              child: SingleChildScrollView(
                child: Column(

                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context,int index){
                          return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: MyColors.color_text.withOpacity(0.2),width: 1.0),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 24),
                              child:const Text(MyString.location_name,style: TextStyle(color: MyColors.color_text,fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500),)
                          );
                        }
                    ),
                    hSizedBox6,
                    hSizedBox4,
                  ],
                ),
              ),
            )



          ]


      ),





    );
  }

  searchLocation(){
    return Container(
      height: 48,
      decoration: BoxDecoration(
          color: MyColors.blueColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(5)
      ),
      width: double.infinity,
      child:   TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: searchFocus,
        controller: searchMobileCompanyController,
        cursorColor:MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),
          enabledBorder:  const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),

          hintText: MyString.search_Area,
          hintStyle: TextStyle(color: MyColors.blackColor.withOpacity(0.30),fontFamily:"s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,fontSize: 12),
        ),
      ),
    );
  }

}