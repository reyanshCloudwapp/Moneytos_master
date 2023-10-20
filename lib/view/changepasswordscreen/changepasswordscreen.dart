import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';

import '../../services/webservices.dart';

class ChangePasswordScreen extends StatefulWidget{
  String mobileno,countrycode,otp;

  ChangePasswordScreen(this.mobileno,this.countrycode,this.otp);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  bool _isObscure = true;
  bool _isObscure_confirmpass = true;
  TextEditingController passController = TextEditingController();
  TextEditingController confirm_passController = TextEditingController();
  bool is_border = false;

  FocusNode passfocus = FocusNode();
  FocusNode con_passfocus = FocusNode();

  bool ispasserror = false;
  String passerror = "";

  bool isconfirm_passerror = false;
  String confirm_passerror = "";

  Color passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  Color confirm_passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
  Color cinfirmpassfillcolor = MyColors.lightblueColor.withOpacity(0.03);

  bool load = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passfocus.unfocus();
    con_passfocus.unfocus();
  }
  resetpasswordApi() async{
    setState(() {
      load = true;
    });
    await Webservices.resetPasswordRequest(context, widget.mobileno, widget.countrycode, widget.otp, passController.text, confirm_passController.text);
    setState(() {
      load = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 25),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: MyColors.color_03153B,
              image: DecorationImage(
                  image: AssetImage("s_asset/images/bgimage.png",),
                  fit: BoxFit.cover
              ),
            ),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 50.0,left: 0.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset('a_assets/images/logo.svg',fit: BoxFit.cover,))),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.3,
              decoration: const BoxDecoration(
                //color: MyColors.primaryColor,
                  image: DecorationImage(
                      image: AssetImage("s_asset/images/bgimage.png",),
                      fit: BoxFit.cover
                  )
              ),
          ),
          // Image.asset('assets/images/map.png',fit: BoxFit.cover,),

          Container(
            margin: const EdgeInsets.only(top: 30.0),
            width: MediaQuery.of(context).size.width,
            child: Material(
              color:MyColors.whiteColor ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Container(
                   height: size.height ,
                  margin: const EdgeInsets.only(top: 45.0,left: 20.0,right: 20.0),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                          alignment: Alignment.center,
                          child: Text("Change password",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w700,color: MyColors.blackColor,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)),

                      Padding(
                        padding:  const EdgeInsets.only(top:20.0),
                        child:
                        Align(
                            alignment: Alignment.center,
                            child: Text("Please enter your new password \n and confirm to go to login",textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: MyColors.blackColor.withOpacity(0.70),fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),)),
                      ),

                      hSizedBox3,
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            margin:  const EdgeInsets.fromLTRB(20.0, 60.0, 16.0, 0.0),
                            decoration: BoxDecoration(
                                color: passfillcolor,
                                border:  Border.all(color: passbordercolor ),
                                borderRadius: BorderRadius.circular(13)),

                            child: TextField(
                              controller: passController,
                              obscureText: _isObscure,
                              onTap: (){
                                is_border = true;
                                setState(() {});
                              },
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                  color:MyColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "s_asset/font/raleway/raleway_medium.ttf",

                              ),

                              decoration: InputDecoration(

                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure ? Icons.visibility_off : Icons.visibility,),
                                    onPressed: () {
                                      setState(() {
                                        print(
                                            "_isObscure >>>>>>>>>>" + _isObscure.toString());
                                        _isObscure = !_isObscure;

                                      });
                                    }),
                                hintText: 'Password',
                                border: InputBorder.none,
                                fillColor: MyColors.whiteColor,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 22,vertical: 15),

                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,

                                errorBorder: InputBorder.none,
                              ),

                              keyboardType: TextInputType.text,

                              // Only numbers can be entered
                            ),
                          ),

                          ispasserror == true ?  Container(
                            margin:  const EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                            alignment: Alignment.topLeft,
                            child: Text(passerror,style: const TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                              : Container()

                        ],
                      ),

                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            margin:  const EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 0.0),
                            decoration: BoxDecoration(
                                color: cinfirmpassfillcolor,
                                   border: Border.all(color: cinfirmpassfillcolor,width: 1),
                                borderRadius: BorderRadius.circular(13)),

                            child: TextField(
                              controller: confirm_passController,
                              obscureText: _isObscure_confirmpass,
                              onTap: (){
                                is_border = true;
                                setState(() {});
                              },
                              textInputAction: TextInputAction.done,
                              style: const TextStyle(
                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "s_asset/font/raleway/raleway_medium.ttf",

                              ),

                              decoration: InputDecoration(

                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure_confirmpass ? Icons.visibility_off : Icons.visibility,),
                                    onPressed: () {
                                      setState(() {
                                        print(
                                            "_isObscure >>>>>>>>>>" + _isObscure_confirmpass.toString());
                                        _isObscure_confirmpass = !_isObscure_confirmpass;

                                      });
                                    }),
                                hintText: 'Confirm Password',
                                border: InputBorder.none,
                                fillColor: MyColors.whiteColor,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 22,vertical: 15),
                                focusedBorder:InputBorder.none,
                                enabledBorder: InputBorder.none,

                                errorBorder: InputBorder.none,
                              ),

                              keyboardType: TextInputType.text,

                              // Only numbers can be entered
                            ),
                          ),

                          isconfirm_passerror == true ?  Container(
                            margin:  const EdgeInsets.fromLTRB(25.0, 5.0, 16.0, 0.0),
                            alignment: Alignment.topLeft,
                            child: Text(confirm_passerror,style: const TextStyle(color: MyColors.red,fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600),),)
                              : Container()
                        ],
                      ),
                      Padding(
                        padding:  const EdgeInsets.only(top:56.0),
                        child: Align(

                          alignment: Alignment.center,
                          child: load == true ? const CircularProgressIndicator(color: MyColors.lightblueColor,):  ElevatedButton(
                            child: const Text('Confirm'),
                            onPressed: () {
                              passfocus.unfocus();
                              con_passfocus.unfocus();
                              RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              //  RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                              var passNonNullValue=passController.text??"";
                              setState(() {});

                               if(passController.text.isEmpty ){
                               passController.text.isEmpty ?   passbordercolor = MyColors.red :passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                              passController.text.isEmpty ?   passfillcolor = MyColors.red.withOpacity(0.03) :passfillcolor = MyColors.lightblueColor.withOpacity(0.03);

                              passController.text.isEmpty ?   ispasserror = true  : ispasserror =false;
                              passController.text.isEmpty ?   passerror = "Please enter password*" : passerror = "";

                              setState(() {});
                              // Fluttertoast.showToast(msg: "Please Enter Your FullName");
                              }
                              else if(!regex.hasMatch(passNonNullValue)){
                              print("bdhjfjhdf");
                              passbordercolor = MyColors.red ;
                              passfillcolor = MyColors.red.withOpacity(0.03) ;
                              ispasserror = true;

                              passerror ="Password should contain upper,lower,digit and Special character ";
                              setState(() {});
                              }

                             else if(confirm_passController.text.isEmpty ){
                                 confirm_passbordercolor = MyColors.red;
                                 cinfirmpassfillcolor = MyColors.red.withOpacity(0.03);
                                 ispasserror = false;
                                 isconfirm_passerror = true ;
                                 confirm_passerror = "Please enter password*";
                                 setState(() {});
                             }
                               else if(passController.text != confirm_passController.text){
                                 confirm_passbordercolor = MyColors.red;
                                 cinfirmpassfillcolor = MyColors.red.withOpacity(0.03);
                                 ispasserror = false;
                                 isconfirm_passerror = true ;
                                 confirm_passerror = "Password & confirm password must be same";
                                 setState(() {});
                               }
                             else{
                                 ispasserror = false;
                                 isconfirm_passerror = false ;
                                 confirm_passbordercolor = MyColors.lightblueColor.withOpacity(0.03);
                                 passfillcolor = MyColors.lightblueColor.withOpacity(0.03);
                                 passbordercolor = MyColors.lightblueColor.withOpacity(0.03);

                                 resetpasswordApi();
                               }
                           //   Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));

                            },
                            style: ElevatedButton.styleFrom(
                                primary: MyColors.lightblueColor,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 17),

                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16.0))
                                ),
                                textStyle: const TextStyle(
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

    );
  }
}