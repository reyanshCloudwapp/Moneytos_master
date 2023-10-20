import 'package:flutter/material.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/model/customlists/customLists.dart';

class SelectStoreScreen extends StatefulWidget{
  @override
  State<SelectStoreScreen> createState() => _SelectStoreScreenState();
}

class _SelectStoreScreenState extends State<SelectStoreScreen> {

  ///Textfield contrller
  TextEditingController searchStoreController = TextEditingController();
  FocusNode searchFocus = FocusNode();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.whiteColor,
        centerTitle: true,
        title: const Text(MyString.Select_Store,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),),
      ),

      bottomSheet: GestureDetector(
        onTap: (){
          Navigator.pop(context);

          // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
        },
        child: Container(
          height: 150,
          color: MyColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
          child: CustomButton(
            btnname: MyString.back,
            textcolor: MyColors.color_3F84E5.withOpacity(0.50),
            bordercolor: MyColors.lightblueColor.withOpacity(0.05),
            bg_color: MyColors.lightblueColor.withOpacity(0.32),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox2,
            Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20.0),
                child: searchStore()
              //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
            ),
            GridView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1/0.74 ,
                crossAxisSpacing: 1.1,
                mainAxisSpacing: 0.3,
              ),
              children:CustomList.countrylist.map((String url) {
                return Container(
                    padding: const EdgeInsets.symmetric(vertical:4,horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical:8,horizontal: 5),
                    child: CustomSelectBankList(title: MyString.Company_name,img:"s_asset/images/store.png",));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  searchStore(){
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
        controller: searchStoreController,
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

          hintText: MyString.Search_Store,
          hintStyle: TextStyle(color: MyColors.blackColor.withOpacity(0.30),fontFamily:"s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,fontSize: 12),
        ),
      ),
    );
  }
}