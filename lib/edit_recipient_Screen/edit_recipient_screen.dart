import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditRecipientScreen extends StatefulWidget {
  const EditRecipientScreen({Key? key}) : super(key: key);

  @override
  State<EditRecipientScreen> createState() => _EditRecipientScreenState();
}

class _EditRecipientScreenState extends State<EditRecipientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: AppBar(
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          centerTitle: true,
          title:    Container(
            padding: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text(
              MyString.edit_recipient,
              style: TextStyle(
                  fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
       // padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.width / 8 ),
        height: 150,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
              },
              child: Container(
                height: 50,
                width: 120,
                color: MyColors.whiteColor,
               // padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
                child: CustomButton(
                  btnname: MyString.cancel,
                  textcolor: MyColors.lightblueColor.withOpacity(0.50),
                  bordercolor: MyColors.lightblueColor.withOpacity(0.05),
                  bg_color: MyColors.lightblueColor.withOpacity(0.05),
                ),
              ),
            ),
            wSizedBox5,
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
              },
              child: Container(
                height: 50,
                width: 120,
                color: MyColors.whiteColor,
              //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
                child: CustomButton2(
                  btnname: "Save",
                  textcolor: MyColors.whiteColor.withOpacity(0.90),
                  bordercolor: MyColors.lightblueColor.withOpacity(0.05),
                  bg_color: MyColors.lightblueColor,
                ),
              ),
            ),

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// country name
            Container(
              decoration: BoxDecoration(
                color: MyColors.whiteColor,
                // border: Border.all(color: MyColors.lightblueColor),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),

              ),
              child: Column(
                children: [

                  hSizedBox4,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      // controller: FullName,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color:MyColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                      ),
                      decoration: InputDecoration(
                        hintText: MyString.country_name,
                        border: InputBorder.none,
                        fillColor: MyColors.whiteColor,
                        contentPadding: EdgeInsets.all(22),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            "a_assets/icons/clear_red.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "a_assets/icons/au_australia.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        hintStyle:  TextStyle(
                            color:MyColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                          letterSpacing: 0.3

                        ),

                      ),

                      keyboardType: TextInputType.emailAddress,

                    ),
                  ),
                  hSizedBox,
                  
                  Container(
                    height: 15,
                    color: MyColors.lightblueColor.withOpacity(0.05),
                  ),
                ],
              ),
            ),

            /// city name

            Container(
             margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                // controller: FullName,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                    color:MyColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                ),
                decoration: InputDecoration(
                  hintText: MyString.city_name,
                  border: InputBorder.none,
                  fillColor: MyColors.whiteColor,
                  contentPadding: EdgeInsets.all(22),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "a_assets/icons/clear_red.svg",
                      height: 20,
                      width: 20,
                    ),
                  ),
                  hintStyle:  TextStyle(
                      color:MyColors.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                      letterSpacing: 0.3

                  ),
                  //border: InputBorder.none,

                ),

                keyboardType: TextInputType.emailAddress,

                // Only numbers can be entered
              ),
            ),

            Container(
              height: 15,
              color: MyColors.lightblueColor.withOpacity(0.04),
            ),

            /// First Name and last name

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: TextField(
                      // controller: FullName,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color:MyColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                      ),
                      decoration: InputDecoration(
                        hintText: MyString.first_name,
                        border: InputBorder.none,
                        fillColor: MyColors.whiteColor,
                        contentPadding: EdgeInsets.all(22),
                        hintStyle:  TextStyle(
                            color:MyColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                            letterSpacing: 0.3

                        ),
                        //border: InputBorder.none,

                      ),

                      keyboardType: TextInputType.emailAddress,

                      // Only numbers can be entered
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: TextField(
                      // controller: FullName,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                          color:MyColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                      ),
                      decoration: InputDecoration(
                        hintText: MyString.first_name,
                        border: InputBorder.none,
                        fillColor: MyColors.whiteColor,
                        contentPadding: EdgeInsets.all(22),
                        hintStyle:  TextStyle(
                            color:MyColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                            letterSpacing: 0.3

                        ),
                        //border: InputBorder.none,

                      ),

                      keyboardType: TextInputType.emailAddress,

                      // Only numbers can be entered
                    ),
                  ),
                ],
              ),
            ),

            /// mobile number
            Container(
              margin: EdgeInsets.only(left: 18.0,top: 30),
              child: Row(
                children: [

                  CountryCodePicker(

                    onChanged: _onCountryChange,
                    // enabled: false,

                    initialSelection: 'CA',
                    // favorite: ['+91','IN'],
                    showCountryOnly: false,
                    textStyle: TextStyle(color: MyColors.primaryColor,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontSize: 16),
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    showFlag: false,

                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      // controller: FullName,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(

                          color:MyColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                      ),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle:TextStyle(

                            color:MyColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                        ),
                        border: InputBorder.none,
                        fillColor: MyColors.whiteColor,
                        contentPadding: EdgeInsets.all(10.0),
                        //border: InputBorder.none,

                      ),
                      // maxLength: 10,



                      // Only numbers can be entered
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String slectedcountrCode="+1";
  Future<void> _onCountryChange(CountryCode countryCode ) async {
    //TODO : manipulate the selected country code here
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    slectedcountrCode=countryCode.toString();
    print("New Country selected:>>>>" + slectedcountrCode);
    print("Country ISO code :>>>>" + countryCode.code.toString());
    print("Country name code :>>>>" + countryCode.name.toString());
    print("Country dialCode code :>>>>" + countryCode.dialCode.toString());
    sharedPreferences.setString('CountryISOCode',countryCode.code.toString());
    setState(() {});

  }
}
