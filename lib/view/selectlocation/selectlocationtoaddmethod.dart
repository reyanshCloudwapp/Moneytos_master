import 'package:flutter/material.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/customScreens/customchart_cartList/customChart_cardList.dart';
import 'package:moneytos/model/customlists/customLists.dart';

 class SelectLocationToAddMethodScreen extends StatefulWidget{
  @override
  State<SelectLocationToAddMethodScreen> createState() => _SelectLocationToAddMethodScreenState();
}

class _SelectLocationToAddMethodScreenState extends State<SelectLocationToAddMethodScreen> {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.whiteColor,
        centerTitle: true,
        title: const Text(MyString.Select_Location_method,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),),
      ),

      bottomSheet: Container(
        height: 100,
        child: GestureDetector(
          onTap: (){
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
          },
          child: Container(

            color: MyColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3,vertical: 25 ),
            child:  CustomButton(

              btnname: MyString.back,
              textcolor: MyColors.color_3F84E5.withOpacity(0.50),
              bordercolor: MyColors.lightblueColor.withOpacity(0.05),
              bg_color: MyColors.lightblueColor.withOpacity(0.32),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox2,
            Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20.0),
                child: searchLocation()
              //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context,int index){
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),

                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: MyColors.color_text.withOpacity(0.2),width: 1.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 24),
                    child:const Text(MyString.location_name,style: TextStyle(color: MyColors.color_text,fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500),)
                  );
                }
            ),
          ],
        ),
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