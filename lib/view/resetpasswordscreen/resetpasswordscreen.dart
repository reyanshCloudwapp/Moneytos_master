import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/changepasswordscreen/changepasswordscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget{
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  String slectedcountrCode="+1";
  bool is_border = false;

  TextEditingController mobileNumberController = TextEditingController();

  String mobileerror = "";
  bool ismobileerror = false;

  bool load  = false;


  Color mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);


  FocusNode mobilefocus = FocusNode();


  forgotpassApi() async{
    // setState(() {
    //   load = true;
    // });
    await Webservices.forgotPasswordRequest(context, mobileNumberController.text, slectedcountrCode.toString());
    // setState(() {
    //   load = false;
    // });
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [

        KeyboardActionsItem(
            focusNode: mobilefocus,
            onTapAction: (){

            }

        ),
      ],
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mobilefocus.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MyColors.color_03153B,
              image: DecorationImage(
                  image: AssetImage("s_asset/images/bgimage.png",),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 50.0,left: 0.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset('a_assets/images/logo.svg',fit: BoxFit.cover,))),
              ],
            ),
          ),
        ),
      ),
      body: KeyboardActions(
        autoScroll: false,
        config: _buildKeyboardActionsConfig(context),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.3,
              decoration: BoxDecoration(
                //color: MyColors.primaryColor,
                  image: DecorationImage(
                      image: AssetImage("s_asset/images/bgimage.png",),
                      fit: BoxFit.cover
                  )
              ),
            ),
            // Image.asset('assets/images/map.png',fit: BoxFit.cover,),

            Container(

              // color: MyColors.whiteColor,
              margin: EdgeInsets.only(top: 5.0),
              height: size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: Material(
                color:MyColors.whiteColor ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 60.0,left: 20.0,right: 20.0),
                  child: SingleChildScrollView(
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text("Reset your password",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500,color: MyColors.blackColor),)),


                        SizedBox(
                          height: 22.0,
                        ),

                        Align(
                            alignment: Alignment.center,
                            child: Text("We will send a code to your phone \n to reset your password.",textAlign: TextAlign.center,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: MyColors.blackColor),)),

                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 18.0,top: 30),
                              decoration: BoxDecoration(
                                  color:mobilefillcolor,
                                  border:  Border.all(color: mobilebordercolor, ),
                                  borderRadius: BorderRadius.circular(15)),

                              child: Row(
                                children: [

                                  CountryCodePicker(

                                    onChanged: _onCountryChange,
                                    // enabled: false,

                                    initialSelection: 'CA',
                                    // favorite: ['+91','IN'],
                                    showCountryOnly: false,
                                    textStyle: TextStyle(color: MyColors.primaryColor,fontWeight: FontWeight.w300),
                                    showOnlyCountryWhenClosed: false,
                                    alignLeft: false,
                                    showFlag: false,

                                  ),
                                  Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                    width: 200,
                                    child: TextField(
                                      controller: mobileNumberController,
                                      maxLength: 10,
                                      focusNode: mobilefocus,
                                      // keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                                      // inputFormatters: [
                                      //   LengthLimitingTextInputFormatter(10),
                                      // ],
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      textInputAction: TextInputAction.next,
                                      onTap: (){
                                        mobilebordercolor = MyColors.lightblueColor;
                                        mobilefillcolor = MyColors.whiteColor;
                                        setState(() {
                                        });
                                      },
                                      style: TextStyle(

                                          color:MyColors.blackColor,
                                          fontSize: 12,
                                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                                      ),
                                      decoration: InputDecoration(
                                          hintText: 'Phone Number',
                                          border: InputBorder.none,
                                          fillColor: MyColors.whiteColor,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 12),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        counterText: ''
                                        //border: InputBorder.none,

                                      ),
                                      // maxLength: 10,



                                      // Only numbers can be entered
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ismobileerror == true ?  Container(
                              margin:  EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                              alignment: Alignment.topLeft,
                              child: Text(mobileerror,style: TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                                : Container()
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top:60.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: load == true ? CircularProgressIndicator(color: MyColors.lightblueColor,) :  ElevatedButton(
                              child: Text('Reset Password'),
                              onPressed: () {
                                mobilefocus.unfocus();
                                if (mobileNumberController.text.isEmpty ) {
                                  mobileNumberController.text.isEmpty ?   mobilebordercolor = MyColors.red :  mobilebordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                  mobileNumberController.text.isEmpty ?   mobilefillcolor = MyColors.red.withOpacity(0.03) : mobilefillcolor = MyColors.lightblueColor.withOpacity(0.03);

                                  mobileNumberController.text.isEmpty ?   ismobileerror = true  : ismobileerror =false;

                                  mobileNumberController.text.isEmpty ?   mobileerror = "Please enter mobile number" : mobileerror ="";

                                  setState(() {});
                                }

                                else if(mobileNumberController.text.length < 10){
                                  mobilebordercolor = MyColors.red ;
                                  mobilefillcolor = MyColors.red.withOpacity(0.03);
                                  ismobileerror = true;
                                  mobileerror = "Please enter a valid mobile number";
                                  setState(() {});
                                }
                                else{
                                  ismobileerror = false;
                                  setState(() {});

                                  forgotpassApi();
                                }
                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));
                              },

                              style: ElevatedButton.styleFrom(
                                  primary: MyColors.lightblueColor,
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(16.0))
                                  ),
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),

    );
  }

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
