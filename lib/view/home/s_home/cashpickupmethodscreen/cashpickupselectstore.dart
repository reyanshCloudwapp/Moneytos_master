import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/view/home/s_home/cashpickupmethodscreen/cashpickupseleclocation.dart';

 class CashPickupSelectStore extends StatefulWidget{
  @override
  State<CashPickupSelectStore> createState() => _CashPickupSelectStoreState();
}

class _CashPickupSelectStoreState extends State<CashPickupSelectStore> {


  ///Textfield contrller
  TextEditingController searchStoreController = TextEditingController();
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
         actions: const [],
         title: const Text(MyString.Select_Delivery_Method,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4),),
       ),


       bottomSheet: GestureDetector(
         onTap: (){
           Navigator.pop(context);
           // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
         },
         child: Container(
           height: 80,
           color: MyColors.whiteColor,
           padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 2.7,vertical:15 ),
           // margin: EdgeInsets.symmetric(vertical:10 ),
           child:  CustomButton(
             btnname: MyString.back,
             textcolor: MyColors.lightblueColor,
             bordercolor: MyColors.lightblueColor.withOpacity(0.08),
             bg_color: MyColors.lightblueColor.withOpacity(0.14),
           ),
         ),
       ),
       body: SingleChildScrollView(
         child: Column(
           children: [

             Container(

                 width:350,
                 margin:  const EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                 padding: const EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 22.0),
                 decoration: BoxDecoration(
                   color: MyColors.whiteColor,
                   border: Border.all(color: MyColors.color_gray_transparent),
                   borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                   boxShadow: const [
                     BoxShadow(
                       color: MyColors.color_gray_transparent,
                       offset: Offset(0.0, 1.0), //(x,y)
                       blurRadius: 4.0,
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
                         const Text(MyString.country_name,style: TextStyle(fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",fontWeight: FontWeight.w700,color: MyColors.color_text),),
                       ],
                     ),
                     SvgPicture.asset("a_assets/icons/clear_red.svg"),

                   ],
                 )
             ),
             Container(

                 width:350,
                 margin:  const EdgeInsets.fromLTRB(12.0, 16.0, 0.0, 0.0),
                 padding: const EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 22.0),
                 decoration: BoxDecoration(
                   color: MyColors.whiteColor,
                   border: Border.all(color: MyColors.color_gray_transparent),
                   borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                   boxShadow: const [
                     BoxShadow(
                       color: MyColors.color_gray_transparent,
                       offset: Offset(0.0, 1.0), //(x,y)
                       blurRadius: 4.0,
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
                     SvgPicture.asset("a_assets/icons/clear_red.svg"),

                   ],
                 )
             ),

             Column(
               children: [
                 hSizedBox2,
                 Container(
                     margin: const EdgeInsets.only(top: 16,bottom: 20),
                     alignment: Alignment.center,
                     child: const Text("Select Store",style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"))),
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
                     return GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CashPickUpSelectLocation()));
                       },
                       child: Container(
                           padding: const EdgeInsets.symmetric(vertical:4,horizontal: 10),
                           margin: const EdgeInsets.symmetric(vertical:8,horizontal: 5),
                           child: CustomSelectBankList(title: MyString.Company_name,img:"s_asset/images/store.png",)),
                     );
                   }).toList(),
                 ),
               ],
             ),
             hSizedBox5,




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