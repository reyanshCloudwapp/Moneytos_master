import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/customTextfield/custom_textFields.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/view/home/s_home/bankdetailsscreen/bank_details_screen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/bank2/BankDetailsScreen2.dart';


class SelectBankScreen2 extends StatefulWidget{



  @override
  State<SelectBankScreen2> createState() => _SelectBankScreen2State();
}

class _SelectBankScreen2State extends State<SelectBankScreen2> {

  ///Textfield contrller
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocus.unfocus();
  }



  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: MyColors.whiteColor,
              flexibleSpace:    Container(
                child:Column(
                  children: [
                    Container(
                      color: MyColors.color_03153B,
                      padding: const EdgeInsets.only(top: 60,left: 22,right: 22),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: (){
                                    Navigator.of(context).pop(false);
                                  }
                                  ,child: SvgPicture.asset("s_asset/images/leftarrow.svg",height: 32,
                                width: 32,)
                              ),
                              Center(
                                child: Container(
                                  //   margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                                  child:  const Text(
                                    MyString.select_bank,
                                    style: TextStyle(
                                        color: MyColors.whiteColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                                    ),
                                  )
                                  ,
                                ),
                              ),
                              Container(width: 20,)

                            ],
                          ),

                          hSizedBox3,
                        ],
                      ),
                    ),

                    Container(
                      color:MyColors.color_03153B,
                      child: Container(
                          padding: const EdgeInsets.only(top: 45,left: 22,right: 22),
                          decoration: const BoxDecoration(
                            color: MyColors.whiteColor,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                          ),
                          // padding:  EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [

                              searchbank(),
                              hSizedBox,

                            ],
                          )
                        //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
                      ),
                    ),
                  ],
                ) ,
              ),


            ),
          ),

          bottomSheet: Container(
            color: MyColors.whiteColor,
            height: 80,
            margin: const EdgeInsets.only(bottom: 40),

            alignment: Alignment.center,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
                //   Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 15.0,top: 15),
                height: 50,
                width: 100,

                color: MyColors.whiteColor,


                child: CustomButton(

                  btnname: MyString.back,
                  textcolor: MyColors.lightblueColor,
                  bordercolor: MyColors.lightblueColor.withOpacity(0.08),
                  bg_color: MyColors.lightblueColor.withOpacity(0.14),
                ),
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(color: MyColors.whiteColor,height: 300,width: MediaQuery.of(context).size.width,),
              Container(
                // margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: MyColors.whiteColor,
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:  const EdgeInsets.only(bottom: 80.0),
                          child: GridView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1/0.6 ,
                              crossAxisSpacing: 1.1,
                              mainAxisSpacing: 0.3,
                            ),
                            children:CustomList.titlelist.map((String url) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BankDetaislScreen2()));
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(vertical:1,horizontal: 10),
                                    margin: const EdgeInsets.symmetric(vertical:6,horizontal: 5),
                                    child: CustomSelectBankList(title: MyString.bank_name,img: "a_assets/images/onboarding_img/logo.png",)),
                              );
                            }).toList(),
                          ),
                        ),
                        hSizedBox3,



                      ],

                    ),
                  ),

                ),

              )
            ],
          ),
        )
    );
  }


  searchbank(){
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
        controller: searchController,
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

          hintText: MyString.search_bank,
          hintStyle: TextStyle(color: MyColors.blackColor.withOpacity(0.30),fontWeight: FontWeight.w500,fontSize: 13),
        ),
      ),



    );
  }


}