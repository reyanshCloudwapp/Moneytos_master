import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:moneytos/ScheduledTransferScreens/scheduledbank_accountNumber.dart';
import 'package:moneytos/constance/customTextfield/custom_textFields.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/view/bank_accountnumber/bank_accountNumber.dart';
import 'package:flutter/services.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/S_ApiResponse/SelectBankListResponse.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class ScheduledSelectBankScreen2BankDeposit extends StatefulWidget {
  const ScheduledSelectBankScreen2BankDeposit({Key? key}) : super(key: key);

  @override
  State<ScheduledSelectBankScreen2BankDeposit> createState() => _ScheduledSelectBankScreen2BankDeposit();
}

class _ScheduledSelectBankScreen2BankDeposit extends State<ScheduledSelectBankScreen2BankDeposit> {
  ///Textfield contrller
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  SharedPreferences? pre;



  List<BankListSelectPost> selectbankposts = [];
  String countryName="";
  String countryFlag="";
  String totalFees="";
  String auhtToken="";
  String desticountry_isoCode3="";



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
    totalFees=sharedPreferences.getString("totalCostFee").toString();
    auhtToken=sharedPreferences.getString("auth_Token").toString();
    desticountry_isoCode3=sharedPreferences.getString("country_isoCode3").toString();


    print("countryName>>>"+countryName);
    print("countryFlag>>>"+countryFlag);
    print("totalCostFee>>>"+totalFees);
    WidgetsBinding.instance.addPostFrameCallback((_) =>selectBankApi(context,auhtToken,desticountry_isoCode3));



    setState(() {

    });

  }





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
        preferredSize: Size.fromHeight(50),
        child: AppBar(

          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          title: Text(MyString.select_bank,style: TextStyle(color: MyColors.blackColor,fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.4,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),),
        ),
      ),

      bottomSheet: GestureDetector(
        onTap: (){
          Navigator.pop(context);
         //Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
        },
        child: Container(
          height: 150,
          color: MyColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
          child: CustomButton(
            btnname: MyString.back,
            textcolor: MyColors.lightblueColor,
            bordercolor: MyColors.lightblueColor.withOpacity(0.08),
            bg_color: MyColors.lightblueColor.withOpacity(0.08),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox2,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.0),
              child: searchbank()
              //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
            ),
            GridView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1/0.50 ,
                crossAxisSpacing: 1.1,
                mainAxisSpacing: 0.3,
              ),
              children:List.generate(selectbankposts.length, (index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduledBankAccountNumber(bank_name:  selectbankposts[index].name.toString(),bank_id:selectbankposts[index].id.toString())));
                  },
                  child: Container(
                     padding: EdgeInsets.symmetric(vertical:4,horizontal: 10),
                     margin: EdgeInsets.symmetric(vertical:8,horizontal: 5),
                      child: CustomSelectBankList(title:selectbankposts[index].name.toString(),img: "a_assets/images/onboarding_img/logo.png",)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
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
        onChanged: (value) => _searchBankFilter(value),

        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: searchFocus,
        controller: searchController,
        cursorColor:MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.whiteColor)
          ),

          hintText: MyString.search_bank,
          hintStyle: TextStyle(color: MyColors.blackColor.withOpacity(0.30),fontWeight: FontWeight.w500,fontSize: 13,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        ),
      ),
    );
  }




  /*<<<<<<<<<<<<<<<<<<<SelecBankApi>>>>>>>>>>>>>>>>>>>*/


  Future <void> selectBankApi(BuildContext context, String auhtToken,String desticountry_isoCode3) async {

    Utility.ProgressloadingDialog(context, true);
    var request = {};


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(AllApiService.select_Banks_URL+"countryIso3Code="+desticountry_isoCode3),
        // body: convert.jsonEncode(request),
        headers: {
          "Authorization":"Bearer "+auhtToken,

        });
    print("authToken?>>>>>>"+"Bearer "+auhtToken);


    // Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    /*  final jsonList = jsonDecode(response.body) as List<dynamic>;
    final searchedUsers = [
      for (final map in jsonList.cast<Map<String, dynamic>>())
        SelectBankListResponse.fromJson(map)
    ];

    searchedUsers.forEach(print);
    print("vnjksngjksgfjknfjkn>>>  "+jsonList[0]);
*/

    selectbankposts = PostsBankList.fromJson(json.decode(response.body)).bankList!;
    print("ndlknbldnfb>>> "+PostsBankList.fromJson(json.decode(response.body)).bankList![0].name.toString());

    Utility.ProgressloadingDialog(context, false);

    setState(() {

    });

//     if (jsonResponse['status'] == true) {
//       selectBankListResponse  = await SelectBankListResponse.fromJson(jsonResponse);
//
//
//
//     /*  for(int i =0; i<selectCountryListResponse.data!.length;i++){
//
//         selectCountryList.add(selectCountryListResponse.data![i]);
//
//
//
//
//
//       }
// */
//
//       Utility.ProgressloadingDialog(context, false);
//       setState(() {
//
//       });
//     } else {
//       Utility.ProgressloadingDialog(context, false);
//
//       selectBankListResponse  = await SelectBankListResponse.fromJson(jsonResponse);
//       setState(() {
//
//       });
//     }

    return;

  }


  void _searchBankFilter(String enteredKeyword) {
    List<BankListSelectPost> results =<BankListSelectPost> [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = selectbankposts;
    } else {
      results = selectbankposts.where((user) => user.name.toString().toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      selectbankposts = results;
    });
  }



}
