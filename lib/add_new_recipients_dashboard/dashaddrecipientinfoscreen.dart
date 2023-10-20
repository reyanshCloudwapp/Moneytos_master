import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/home/s_home/selectdeliverymethod/selectdeliverymethod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as Math;


import '../../model/RecipientFiealdModel.dart';
import '../constance/customLoader/customLoader.dart';
import '../constance/customTextfield/uppercase_textfield.dart';
import '../s_Api/s_utils/Utility.dart';
import '../services/Apiservices.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../view/dashboardScreen/dashboard.dart';
import 'dashselectdeliveryaddmethod.dart';
import 'dashselectdeliverymethod.dart';


class DashAddRecipientInfoScreen extends StatefulWidget{
  @override
  State<DashAddRecipientInfoScreen> createState() => _DashAddRecipientInfoScreenState();
}

class _DashAddRecipientInfoScreenState extends State<DashAddRecipientInfoScreen> {

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [

        KeyboardActionsItem(
          focusNode: mobileFocusNode,

        ),
      ],
    );
  }

  String url = "https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&transferMethod=BANK_ACCOUNT";

  String slectedcountrCode="+91";
  String? selectedCategory ;
  String? selectedCategory2 ;
  List<FieldSetsModel> fieldsetlist = [];
  List<RecipientFieldsModel> recipientfieldsetlist = [];
  List<Options> optionlist =[];
  bool load = false;

  List<TextEditingController> _controllers1 = [];
  List<TextEditingController> _controllers2 = [];

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();


  FocusNode firstFocusNode = FocusNode();
  FocusNode lastFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode address1FocusNode = FocusNode();
  FocusNode address2FocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode zipFocusNode = FocusNode();

  String img_error = "";


  XFile? _frontimage;
  String front_images = "";
  String? frontimg = "";

  SharedPreferences? p;
  int phone_min_val = 0;
  int phone_max_val = 0;

getPrefences()async{
  p = await SharedPreferences.getInstance();

  print("currency iso>>>> "+p!.getString("country_Currency_isoCode3").toString());
  print("phonecode iso>>>> "+p!.getString("phonecode").toString());
  phone_min_val = p!.getString("partnerPaymentMethod").toString()=="mfs"?0:int.parse(p!.getString("phonenumber_min_max_validation").toString().split("-")[0]);
  phone_max_val = p!.getString("partnerPaymentMethod").toString()=="mfs"?0:int.parse(p!.getString("phonenumber_min_max_validation").toString().split("-")[1]);
  setState(() {

  });
}

  bool frontimageSelected = false;

  final ImagePicker imagePicker = ImagePicker();




  getfieldrecipient() async{
    fieldsetlist.clear();
    recipientfieldsetlist.clear();
    optionlist.clear();
    setState(() {
      load = true;
    });
    await Webservices.RecipientFieldRequest(context, fieldsetlist,recipientfieldsetlist,optionlist);

    setState(() {
      load = false;
    });
  }
  List<TextEditingController> _controllers = [];


  frontDocumentbottoms(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('camera'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('gallery'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.gallery);
              },
            ),
          ]);
        });
  }

  void compressImage(imageSource) async {
    var image = await imagePicker.getImage(source: imageSource,
        imageQuality: 10);
    if (image == null) {
      print('+++++++++null');
    } else {
      _frontimage = XFile(image.path);
      front_images = _frontimage!.path;
      frontimg =  _frontimage!.path;
      setState(() {

      });

      print('image path is ${frontimg}');
    }

  }

  Future getfrontCameraImage(imageSource) async {
    var image = await imagePicker.getImage(source: imageSource,
        imageQuality: 5);
    if (mounted) {
      setState(() {
        frontimageSelected = true;


        if (image == null) {
          print('+++++++++null');
        } else {
          _frontimage = XFile(image.path);
          front_images = _frontimage!.path;
          frontimg =  _frontimage!.path;
          setState(() {

          });
          print('image path is ${frontimg}');
        }
        //  Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstFocusNode.unfocus();
    lastFocusNode.unfocus();
    mobileFocusNode.unfocus();
    address1FocusNode.unfocus();
    address2FocusNode.unfocus();
    cityFocusNode.unfocus();
    zipFocusNode.unfocus();
  }
  List<AddRecipientFieldModel> addfieldlist =  [];
  bool field_load =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefences();
    getfieldrecipient();
  }
/*  Oncallback(bool load){
    field_load = load;
  }*/

  addRecipientField() async{
    // setState(() {
    //   field_load= true;
    // });
    await AddRecipientFieldRequest(context, addfieldlist,frontimg.toString());
    // setState(() {
    //   field_load = false;
    // });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
      ),

      bottomNavigationBar:load == true ? Container(height: 0,): field_load == true ? Container(height: 0,): Container(
        height: 100,
        padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 30),
        color: MyColors.whiteColor,
        child:Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  firstFocusNode.unfocus();
                  lastFocusNode.unfocus();
                  mobileFocusNode.unfocus();
                  address1FocusNode.unfocus();
                  address2FocusNode.unfocus();
                  cityFocusNode.unfocus();
                  zipFocusNode.unfocus();
                  Navigator.pop(context);
                },
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        //  stops: [0.0, 1.0],
                        colors: [
                          MyColors.lightblueColor.withOpacity(0.10),
                          MyColors.lightblueColor.withOpacity(0.10),
                        ],
                      ),
                      //color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:  EdgeInsets.only(left: 28, right: 28, bottom: 0,top: 0),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
                    child: Center(child: Text(MyString.back,style: TextStyle(color: MyColors.lightblueColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),))
                ),
              ),
              wSizedBox3,
           GestureDetector(
                onTap: (){

                  String first_name = firstnameController.text;
                  String last_name = lastnameController.text;
                  String phone_number = mobileNumberController.text;
                  String relationship = relationshipController.text;
                  String address = addressController.text;
                  String city = cityController.text;
                  String postcode = postcodeController.text;

                  // if(frontimg.toString().isEmpty || frontimg == "" || frontimg == null){
                  //   Fluttertoast.showToast(msg: "select image");
                  // }else

                  if(p!.getString("partnerPaymentMethod").toString()=="mfs"){

                    if(first_name.isEmpty){
                      Utility.showFlutterToast( "enter first name");
                    }else if(last_name.isEmpty){
                      Utility.showFlutterToast( "enter last name");
                    }else if(phone_number.isEmpty){
                      Utility.showFlutterToast( "enter phone number");
                    }else{
                      createRecipientRequest(context, first_name, last_name, front_images, p!.getString("country_isoCode3").toString(),p!.getString("phonecode").toString(), phone_number, relationship,address,city,postcode);
                      print("json..${json.encode(addfieldlist)}");
                    }

                  }else if(p!.getString("country_isoCode3").toString()=="IND"||p!.getString("country_isoCode3").toString()=="PAK"){
                    if(first_name.isEmpty){
                      Utility.showFlutterToast( "enter first name");
                    }else if(last_name.isEmpty){
                      Utility.showFlutterToast( "enter last name");
                    }else if(phone_number.isEmpty){
                      Utility.showFlutterToast( "enter phone number");
                    }else if(phone_number.length<phone_min_val){
                      Utility.showFlutterToast( "enter valid phone number");
                    }else if(phone_number.length>phone_max_val){
                      Utility.showFlutterToast( "enter valid phone number");
                    }else if(relationship.isEmpty){
                      Utility.showFlutterToast( "enter relationship");
                    }
                    else{
                      createRecipientRequest(context, first_name, last_name, front_images, p!.getString("country_isoCode3").toString(),p!.getString("phonecode").toString(), phone_number, relationship,address,city,postcode);
                      print("json..${json.encode(addfieldlist)}");
                    }
                  }else if(p!.getString("country_isoCode3").toString()=="BGD"){
                    if(first_name.isEmpty){
                      Utility.showFlutterToast( "enter first name");
                    }else if(last_name.isEmpty){
                      Utility.showFlutterToast( "enter last name");
                    }else if(phone_number.isEmpty){
                      Utility.showFlutterToast( "enter phone number");
                    }else if(phone_number.length<phone_min_val){
                      Utility.showFlutterToast( "enter valid phone number");
                    }else if(phone_number.length>phone_max_val){
                      Utility.showFlutterToast( "enter valid phone number");
                    }else if(relationship.isEmpty){
                      Utility.showFlutterToast( "enter relationship");
                    }else if(address.isEmpty){
                      Utility.showFlutterToast( "enter address");
                    }
                    else{
                      createRecipientRequest(context, first_name, last_name, front_images, p!.getString("country_isoCode3").toString(),p!.getString("phonecode").toString(), phone_number, relationship,address,city,postcode);
                      print("json..${json.encode(addfieldlist)}");
                    }
                  }else{
                    if(first_name.isEmpty){
                      Utility.showFlutterToast( "enter first name");
                    }else if(last_name.isEmpty){
                      Utility.showFlutterToast( "enter last name");
                    }else if(phone_number.isEmpty){
                      Utility.showFlutterToast( "enter phone number");
                    }else if(phone_number.length<phone_min_val){
                      Utility.showFlutterToast( "enter valid phone number");
                    }else if(phone_number.length>phone_max_val){
                      Utility.showFlutterToast( "enter valid phone number");
                    }else if(relationship.isEmpty){
                      Utility.showFlutterToast( "enter relationship");
                    }else if(address.isEmpty){
                      Utility.showFlutterToast( "enter address");
                    }else if(city.isEmpty){
                      Utility.showFlutterToast( "enter city");
                    }else if(postcode.isEmpty){
                      Utility.showFlutterToast( "enter postcode");
                    }

                    else{
                      createRecipientRequest(context, first_name, last_name, front_images, p!.getString("country_isoCode3").toString(),p!.getString("phonecode").toString(), phone_number, relationship,address,city,postcode);
                      print("json..${json.encode(addfieldlist)}");
                    }
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        //  stops: [0.0, 1.0],
                        colors: [
                          MyColors.lightblueColor,
                          MyColors.lightblueColor,
                        ],
                      ),
                      //color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:  EdgeInsets.only(left: 28, right: 28, bottom: 0,top: 0),
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
                    child: Center(child: Text(MyString.Add,style: TextStyle(color: MyColors.whiteColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),))
                ),
              ),
            ],
          ),
        ),
      ),

      body:  KeyboardActions(
        autoScroll: false,
        config: _buildKeyboardActionsConfig(context),
        child: Stack(
          children: [
            SingleChildScrollView(
                child:  Column(
                  children: [
                    hSizedBox4,

                    Container(
                        margin: EdgeInsets.only(top: 0.0,bottom: 30,),
                        alignment: Alignment.center,
                        child: Text(MyString.Add_Recipient_Info,style: TextStyle(color: MyColors.color_text,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600 ),)),
                    hSizedBox,
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap:(){
                              frontDocumentbottoms(context);

                            },
                            child: Container(
                                height: 100,

                                width: 100,
                                margin: EdgeInsets.only(top: 0.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("s_asset/images/circleprof.png",)
                                    )
                                ),
                                child:
                                _frontimage != null ? Container(
                                    height: 80,width: 80,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(200),
                                        child: Image.file(File(frontimg.toString()),fit: BoxFit.cover,)))
                                    :
                                SvgPicture.asset("s_asset/images/camera.svg")),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0.0,bottom: 30),
                            alignment: Alignment.center,
                            child: Text(img_error,style: TextStyle(color: MyColors.red,fontSize: 11),),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width:double.infinity,
                      margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                        color: MyColors.color_93B9EE.withOpacity(0.1),
                        border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: TextFormField(
                        controller: firstnameController,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        textInputAction: TextInputAction.done,
                        style: TextStyle(

                            color:MyColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "a_assets/font/poppins_regular.ttf"


                        ),
                        decoration: InputDecoration(
                          hintText: 'First name',
                          hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                          border: InputBorder.none,


                          // fillColor: MyColors.color_gray_transparent,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                        ),

                        keyboardType: TextInputType.text,

                        maxLines: 1,

                        // Only numbers can be entered
                      ),
                    ),

                    hSizedBox3,
                    Container(
                      width:double.infinity,
                      margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                        color: MyColors.color_93B9EE.withOpacity(0.1),
                        border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: TextFormField(
                        controller: lastnameController,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        textInputAction: TextInputAction.done,
                        style: TextStyle(

                            color:MyColors.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "a_assets/font/poppins_regular.ttf"


                        ),
                        decoration: InputDecoration(
                          hintText: 'Last name',
                          hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                          border: InputBorder.none,


                          // fillColor: MyColors.color_gray_transparent,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                        ),

                        keyboardType: TextInputType.text,

                        maxLines: 1,

                        // Only numbers can be entered
                      ),
                    ),

                    hSizedBox3,
                    Row(
                      children: [
                        Container(
                          width:60,
                          margin:  EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
                          decoration: BoxDecoration(
                            color: MyColors.color_93B9EE.withOpacity(0.1),
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: TextFormField(
                            enabled: false,
                            controller: TextEditingController(text: p?.getString("phonecode").toString()),
                            textInputAction: TextInputAction.done,
                            style: TextStyle(

                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"


                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),
                              counterText: '',
                              border: InputBorder.none,


                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                            ),

                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                            maxLines: 1,

                            // Only numbers can be entered
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width:double.infinity,
                            margin:  EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
                            decoration: BoxDecoration(
                              color: MyColors.color_93B9EE.withOpacity(0.1),
                              border: Border.all(color: MyColors.color_gray_transparent),
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: TextFormField(
                              controller: mobileNumberController,
                              textInputAction: TextInputAction.done,
                              maxLength: p?.getString("partnerPaymentMethod").toString()=="mfs"?null:phone_max_val,
                              focusNode: mobileFocusNode,
                              style: TextStyle(

                                  color:MyColors.blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "a_assets/font/poppins_regular.ttf"


                              ),
                              decoration: InputDecoration(
                                hintText: 'Phone number',
                                hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),
                                counterText: '',
                                border: InputBorder.none,


                                // fillColor: MyColors.color_gray_transparent,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                              ),

                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                              maxLines: 1,

                              // Only numbers can be entered
                            ),
                          ),
                        ),
                      ],
                    ),

                    p!.getString("partnerPaymentMethod").toString()=="mfs"?
                    Container():
                    Column(
                      children: [

                        hSizedBox3,
                        Container(
                          width:double.infinity,
                          margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                            color: MyColors.color_93B9EE.withOpacity(0.1),
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: TextFormField(
                            controller: relationshipController,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            textInputAction: TextInputAction.done,
                            style: TextStyle(

                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"


                            ),
                            decoration: InputDecoration(
                              hintText: 'Relationship',
                              hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                              border: InputBorder.none,


                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                            ),

                            keyboardType: TextInputType.text,

                            maxLines: 1,

                            // Only numbers can be entered
                          ),
                        ),



                        p!.getString("country_isoCode3").toString()=="IND"||p!.getString("country_isoCode3").toString()=="PAK"?
                        Container():Column(
                          children: [


                            Container(
                              width:double.infinity,
                              margin:  EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                color: MyColors.color_93B9EE.withOpacity(0.1),
                                border: Border.all(color: MyColors.color_gray_transparent),
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              ),
                              child: TextFormField(
                                controller: addressController,
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                ],
                                textInputAction: TextInputAction.done,
                                style: TextStyle(

                                    color:MyColors.blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "a_assets/font/poppins_regular.ttf"


                                ),
                                decoration: InputDecoration(
                                  hintText: 'Address',
                                  hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                                  border: InputBorder.none,


                                  // fillColor: MyColors.color_gray_transparent,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                                ),

                                keyboardType: TextInputType.text,

                                maxLines: 1,

                                // Only numbers can be entered
                              ),
                            ),

                            p!.getString("country_isoCode3").toString()=="BGD"?
                            Container():
                            Column(
                              children: [
                                hSizedBox3,
                                Container(
                                  width:double.infinity,
                                  margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  decoration: BoxDecoration(
                                    color: MyColors.color_93B9EE.withOpacity(0.1),
                                    border: Border.all(color: MyColors.color_gray_transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                  child: TextFormField(
                                    controller: cityController,
                                    inputFormatters: [
                                      UpperCaseTextFormatter(),
                                    ],
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(

                                        color:MyColors.blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "a_assets/font/poppins_regular.ttf"


                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'City',
                                      hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                                      border: InputBorder.none,


                                      // fillColor: MyColors.color_gray_transparent,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                                    ),

                                    keyboardType: TextInputType.text,

                                    maxLines: 1,

                                    // Only numbers can be entered
                                  ),
                                ),

                                hSizedBox3,

                                Container(
                                  width:double.infinity,
                                  margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  decoration: BoxDecoration(
                                    color: MyColors.color_93B9EE.withOpacity(0.1),
                                    border: Border.all(color: MyColors.color_gray_transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                  child: TextFormField(
                                    controller: postcodeController,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(

                                        color:MyColors.blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "a_assets/font/poppins_regular.ttf"


                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Postalcode',
                                      hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                                      border: InputBorder.none,


                                      // fillColor: MyColors.color_gray_transparent,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                                    ),

                                    keyboardType: TextInputType.text,

                                    maxLines: 1,

                                    // Only numbers can be entered
                                  ),
                                ),
                              ],
                            ),

                          ],
                        )
                      ],
                    ),



                    // hSizedBox6,
                    // hSizedBox6,


                  ],
                )
            ),


          ],
        ),
      ),


    );
  }
  // FieldSetsModel model

  addresssCountrytatedropd(String name,int index){
    return GestureDetector(
      onTap: (){
        recipientfieldsetlist[index].value  =  "${p!.getString("country_Name")}";
        setState((){});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        height: 55,
        width: double.infinity,
        margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        decoration: BoxDecoration(
          color: MyColors.color_93B9EE.withOpacity(0.1),
          border: Border.all(color: MyColors.color_gray_transparent),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),

        child:Text("${p!.getString("country_Name")}",style: TextStyle(color: MyColors.color_text,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),)


        /*   DropdownButtonHideUnderline(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: DropdownButton(
                  isExpanded: true,
                  value: selectedCategory,
                  style:
                  TextStyle(color: MyColors.blackColor),
                  items: optionlist.map((Options model) {
                    return new DropdownMenuItem<String>(
                        value: model.id.toString()  ,
                        child: new Text(model.name.toString() ));
                  }).toList(),
                  hint: Text(
                    "${name}",
                    style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (value) {

                    setState(() {

                      print(value);
                      selectedCategory = value.toString();
                      model.fields![index].value = value.toString();
                      setState(() {});
                      print("value $selectedCategory");

                    });

                    //  updateClassState();
                  },
                ),
              );
            },
          ),
        ),*/
      ),
    );
  }

  // FieldSetsModel model,
  dropd(String name,int index){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      width: double.infinity,
      margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: MyColors.color_93B9EE.withOpacity(0.1),
        border: Border.all(color: MyColors.color_gray_transparent),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),

      child:  IgnorePointer(
        ignoring: true,
        child: DropdownButtonHideUnderline(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: DropdownButton(
                  isExpanded: true,
                  value: selectedCategory2,
                  style:
                  TextStyle(color: MyColors.blackColor),
                  items: optionlist.map((Options model) {
                    return new DropdownMenuItem<String>(
                        value: model.id.toString()  ,
                        child: new Text(model.name.toString() ));
                  }).toList(),
                  hint: Text(
                    "${name}",
                    style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (value) {

                    setState(() {
                      selectedCategory2 = value.toString();
                      recipientfieldsetlist[index].value = value.toString();
                      print("value $selectedCategory2");
                    });

                    //  updateClassState();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  static Future<void> createRecipientRequest(BuildContext context,
      String first_name, String last_name, String profile_img, String countryIso3Code,String phonecode,String phone_number,String relationship,String address,String city,String postalcode) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      pre.setString("u_first_name", first_name);
      pre.setString("u_last_name", last_name);
      pre.setString("u_phone_number", phone_number);
      pre.setString("u_profile_img", profile_img);
      pre.setString("relationship", relationship);
      pre.setString("postcode", postalcode);
      pre.setString("rec_address", address);
      pre.setString("rec_city", city);
      print('route is ${Apiservices.createRecipient}');
      var request = http.MultipartRequest(
          'POST', Uri.parse(Apiservices.createRecipient));
      if (context != null && first_name != null && last_name != null) {
        profile_img == "" ? null :
        request.files
            .add(await http.MultipartFile.fromPath('profileImage', profile_img));
        request.fields['first_name'] = first_name;
        request.fields['last_name'] = last_name;
        request.fields['countryIso3Code'] = countryIso3Code;
        request.fields['country_name'] = "${pre.getString("country_Name")}";
        request.fields['phonecode'] = phonecode;
        request.fields['phone_number'] = phone_number;
        request.fields['relationship'] = relationship;
        request.fields['address'] = address;
        request.fields['city'] = city;
        request.fields['postcode'] = postalcode;
      }


      Map<String, String> headers = {
        "X-AUTHTOKEN": "${pre.getString("auth")}",
        "X-USERID": "${pre.getString("userid")}",
        "content-type": "application/json",
        "accept": "application/json"};

      print('the request is :');
      print(request.fields);
      print(request.files);
      request.headers.addAll(headers);
      var response = await request.send();

      response.stream.transform(convert.utf8.decoder).listen((event) {
        Map map = convert.jsonDecode(event);
        print("create response>>>> "+map.toString());
        if (map["status"] == true) {
          CustomLoader.ProgressloadingDialog(context, false);
          pre.setString("recpi_id", map['data']['recipient_server_id'].toString());
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              DashboardScreen(currentpage_index:2)), (Route<dynamic> route) => false);

          // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectDeliveryMethodScreen()));

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Create Recipient Successfully')),
          // );


          /// SUCCESS
        } else {
          print(map);
          print('error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('error')),
          );
          CustomLoader.ProgressloadingDialog(context, false);

          /// FAIL
        }
      });
    } catch (e) {
      ///EXCEPTION
      print('error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    }
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

  Future<void> AddRecipientFieldRequest(BuildContext context,
      var field,String profileimg ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    print("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    request['UserType'] = "PERSON";
    request['dstCountryIso3Code'] = "${p.getString("country_isoCode3")}";
    request['dstCurrencyIso3Code'] = "${p.getString("country_Currency_isoCode3")}";
    request['transferMethod'] = "BANK_ACCOUNT";
    request['SenderId'] = "23cab527-e802-4e49-8cc1-78e5c5c8e8df";
    request['accountNumber'] = "333000333";
    request['fields'] = field;


    // otpo
    print("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.addrecipientfield),
        body: convert.jsonEncode(request),
        headers: {
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("bdjkdshjgh"+jsonResponse.toString());

      String firstname = jsonResponse['firstName'].toString();
      String lastname = jsonResponse['lastName'].toString();
      String message = jsonResponse['message'].toString();
      String recipientId = jsonResponse['recipientId'].toString();
      String senderId = jsonResponse['senderId'].toString();
      print("recipientId...${recipientId}");
      p.setString("recipientId", recipientId);
      p.setString("senderId", senderId);
      p.setString("firstName", firstname);
      p.setString("lastname", lastname);
      p.setString("lastname", lastname);
      print("recipientId22...${p.getString("recipientId")}");
      /* message == "" || message.isEmpty || message == ""? null:*/
      String phone_number="" , phone_code="";
      // List<dynamic> fieldsList = json.decode(jsonResponse['fields']);
      var fieldsList =   jsonResponse["fields"];
      for(int i = 0 ; i< fieldsList.length  ;i++){

        print("fields response>>>> "+fieldsList[i]["id"]);
        if(fieldsList[i]["id"]=="PHONE_NUMBER"){
          phone_number = fieldsList[i]["value"]["number"].toString();
          phone_code = fieldsList[i]["value"]["countryPhoneCode"].toString();
        }


      }
      createRecipient2Request(context, firstname, lastname, profileimg, "${p.getString("country_isoCode3")}",recipientId,phone_code,phone_number);

      CustomLoader.ProgressloadingDialog(context, false);

    } else {
      List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast( errorres[0]["message"]);
      CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  Future<void> createRecipient2Request(BuildContext context,
      String first_name, String last_name, String profile_img, String countryIso3Code,String recipentId,String phonecode,String phone_number) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      pre.setString("u_first_name", first_name);
      pre.setString("u_last_name", last_name);
      pre.setString("u_phone_number", phone_number);
      pre.setString("u_profile_img", profile_img);
      print('route is ${Apiservices.createRecipient}');
      var request = http.MultipartRequest(
          'POST', Uri.parse(Apiservices.createRecipient));
      if (context != null && first_name != null && last_name != null) {
        profile_img == "" ? null :
        request.files
            .add(await http.MultipartFile.fromPath('profileImage', profile_img));
        request.fields['first_name'] = first_name;
        request.fields['last_name'] = last_name;
        request.fields['countryIso3Code'] = countryIso3Code;
        request.fields['country_name'] = "${pre.getString("country_Name")}";
        request.fields['recipientId'] = recipentId;
        request.fields['phonecode'] = phonecode;
        request.fields['phone_number'] = phone_number;
      }


      Map<String, String> headers = {
        "X-AUTHTOKEN": "${pre.getString("auth")}",
        "X-AUTHTOKEN": "${pre.getString("auth")}",
        "X-USERID": "${pre.getString("userid")}",
        "content-type": "application/json",
        "accept": "application/json"};

      print('the request is :');
      print(request.fields);
      print(request.files);
      request.headers.addAll(headers);
      var response = await request.send();

      response.stream.transform(convert.utf8.decoder).listen((event) {
        Map map = convert.jsonDecode(event);
        print("create response>>>> "+map.toString());
        if (map["status"] == true) {
          CustomLoader.ProgressloadingDialog(context, false);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              DashboardScreen(currentpage_index:2)), (Route<dynamic> route) => false);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => DashSelectDeliveryMethodScreen()));
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Create Recipient Successfully')),
          // );


          /// SUCCESS
        } else {
          print(map);
          print('error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('error')),
          );
          CustomLoader.ProgressloadingDialog(context, false);

          /// FAIL
        }
      });
    } catch (e) {
      ///EXCEPTION
      print('error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    }
  }
}

/*
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/home/s_home/selectdeliverymethod/selectdeliverymethod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/RecipientFiealdModel.dart';
import '../home/s_home/sendmoneyquotation/sendmoneyfromrecipient.dart';


class DashAddRecipientInfoScreen extends StatefulWidget{
  @override
  State<DashAddRecipientInfoScreen> createState() => _DashAddRecipientInfoScreenState();
}

class _DashAddRecipientInfoScreenState extends State<DashAddRecipientInfoScreen> {

  String url = "https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&transferMethod=BANK_ACCOUNT";

  String slectedcountrCode="+91";
  String? selectedCategory ;
  List<FieldSetsModel> fieldsetlist = [];
  List<RecipientFieldsModel> recipientfieldsetlist = [];
  List<Options> optionlist =[];
  bool load = false;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  TextEditingController addressline1Controller = TextEditingController();
  TextEditingController addressline2Controller = TextEditingController();
  TextEditingController addressline3Controller = TextEditingController();
  TextEditingController address_zip3Controller = TextEditingController();
  XFile? _frontimage;
  String front_images = "";
  String frontimg = "";



  bool frontimageSelected = false;

  final ImagePicker imagePicker = ImagePicker();



  getfieldrecipient() async{
    fieldsetlist.clear();
    recipientfieldsetlist.clear();
    optionlist.clear();
    setState(() {
      load = true;
  });
    await Webservices.RecipientFieldRequest(context, fieldsetlist,recipientfieldsetlist,optionlist);

    setState(() {
      load = false;
    });
  }

  frontDocumentbottoms(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('camera'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('gallery'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.gallery);
              },
            ),
          ]);
        });
  }

  Future getfrontCameraImage(imageSource) async {
    var image = await imagePicker.getImage(source: imageSource,
        imageQuality: 10);
    if (mounted) {
      setState(() {
        frontimageSelected = true;


        if (image == null) {
          print('+++++++++null');
        } else {
          _frontimage = XFile(image.path);
          front_images = _frontimage!.path;
          frontimg =  _frontimage!.path;
          setState(() {

          });
          print('image path is ${frontimg}');
        }
        //  Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfieldrecipient();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: MyColors.whiteColor,
     appBar: PreferredSize(
       preferredSize: Size.fromHeight(0),
       child: AppBar(
         elevation: 0,
         backgroundColor: MyColors.whiteColor,
         systemOverlayStyle: SystemUiOverlayStyle(
           // Status bar color
           statusBarColor: MyColors.whiteColor,
           statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
           statusBarBrightness: Brightness.light, // For iOS (dark icons)
         ),
       ),
     ),

bottomSheet: Container(
  height: 100,
  padding: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 30),
  color: MyColors.whiteColor,
  child:Container(

    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){

            Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                ],
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  //  stops: [0.0, 1.0],
                  colors: [
                    MyColors.lightblueColor.withOpacity(0.10),
                    MyColors.lightblueColor.withOpacity(0.10),
                  ],
                ),
                //color: Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              padding:  EdgeInsets.only(left: 28, right: 28, bottom: 0,top: 0),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
              child: Center(child: Text(MyString.back,style: TextStyle(color: MyColors.lightblueColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),))
          ),
        ),
        wSizedBox3,
        GestureDetector(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SendMoneyquotationRecipints()));
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectDeliveryMethodScreen()));

          },
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                ],
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  //  stops: [0.0, 1.0],
                  colors: [
                    MyColors.lightblueColor,
                    MyColors.lightblueColor,
                  ],
                ),
                //color: Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              padding:  EdgeInsets.only(left: 28, right: 28, bottom: 0,top: 0),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
              child: Center(child: Text(MyString.Add,style: TextStyle(color: MyColors.whiteColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),))
          ),
        ),
      ],
    ),
  ),
),

body:  Stack(
  children: [
        SingleChildScrollView(
      child:  Column(
        children: [

          GestureDetector(
            onTap:(){
              frontDocumentbottoms(context);

   },
            child: Container(
                height: 180,
                width: 180,
                margin: EdgeInsets.only(top: 0.0,bottom: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("s_asset/images/circleprof.png",)
                    )
                ),
                child: frontimg != null || frontimg.isNotEmpty  || frontimg != ""? Container(
                    height: 80,width: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.file(File(frontimg.toString()),fit: BoxFit.cover,))):  SvgPicture.asset("s_asset/images/camera.svg")),
          ),

          Container(
              margin: EdgeInsets.only(top: 0.0,bottom: 30,),
              alignment: Alignment.center,
              child: Text(MyString.Add_Recipient_Info,style: TextStyle(color: MyColors.color_text,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600 ),)),

          ListView.builder(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: fieldsetlist.length,
              itemBuilder: (context,int index){
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin:  EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 20.0),
                    alignment: Alignment.topLeft,
                    child: Text(fieldsetlist[index].fieldSetName.toString(),style: TextStyle(color: MyColors.color_text,fontSize:14,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600 ),)),

                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: fieldsetlist[index].fields!.length,
                    itemBuilder: (context,int i){
                  return  Column(
                    children: [
                         Visibility(
                           visible:fieldsetlist[index].fields![i].fieldId == "FIRST_NAME" ?true : false,
                           child: Container(
                        width:double.infinity,
                        margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                            color: MyColors.color_93B9EE.withOpacity(0.1),
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: TextFormField(
                            controller: firstnameController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(

                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"


                            ),
                            decoration: InputDecoration(
                              hintText: recipientfieldsetlist[i].name,
                              hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                              border: InputBorder.none,


                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                            ),

                            keyboardType: TextInputType.text,

                            maxLines: 1,

                            // Only numbers can be entered
                        ),
                      ),
                         ),

                         Visibility(
                           visible:fieldsetlist[index].fields![i].fieldId == "LAST_NAME" ?true:false,
                           child: Container(
                        width:double.infinity,
                             margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                     //   margin:  EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),


                        decoration: BoxDecoration(
                            color: MyColors.color_93B9EE.withOpacity(0.1),
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: TextFormField(
                            controller: lastnameController,
                            textInputAction: TextInputAction.next,

                            style: TextStyle(
                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"

                            ),
                            decoration: InputDecoration(
                                hintText: fieldsetlist[index].fields![i].name.toString(),
                                hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                                border: InputBorder.none,
                                // fillColor: MyColors.color_gray_transparent,
                                contentPadding: EdgeInsets.all(16)

                            ),

                            keyboardType: TextInputType.text,

                            // Only numbers can be entered
                        ),
                      ),
                         ),

                           Visibility(
                             visible:fieldsetlist[index].fields![i].fieldId == "PHONE_NUMBER" ?true:false,
                             child: Container(
                        margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),


                        child: Row(
                          children: [

                              Container(
                                margin:EdgeInsets.only(left: 5),
                                decoration:BoxDecoration(
                                  // color: MyColors.whiteColor,

                                ),
                                child: CountryCodePicker(

                                  onChanged: _onCountryChange,
                                  // enabled: false,

                                  initialSelection: 'IN',
                                  // favorite: ['+91','IN'],
                                  showCountryOnly: false,
                                  textStyle: TextStyle(color: MyColors.color_text,fontWeight: FontWeight.w500,fontSize: 16,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  showFlag: false,

                                ),
                              ),
                              wSizedBox,
                              Container(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                                decoration:BoxDecoration(
                                  color: MyColors.color_93B9EE.withOpacity(0.1),
                                  border: Border.all(color: MyColors.color_gray_transparent),
                                  borderRadius: BorderRadius.all(Radius.circular(12.0)),

                                ),
                                width: 240,
                                child: TextField(
                                  // controller: FullName,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                                  style: TextStyle(

                                      color:MyColors.blackColor,
                                      fontSize: 12,
                                      fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                                  ),
                                  decoration: InputDecoration(
                                    hintText: fieldsetlist[index].fields![i].name,
                                    hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),
                                    border: InputBorder.none,
                                    fillColor: MyColors.whiteColor,
                                    contentPadding: EdgeInsets.all(16.0),
                                    //border: InputBorder.none,

                                  ),
                                  // maxLength: 10,



                                  // Only numbers can be entered
                                ),
                              ),
                          ],
                        ),
                      ),
                           ) ,


                           Visibility(
                             visible:fieldsetlist[index].fields![i].fieldId == "ADDRESS_LINE_1" ?true:false,
                             child: Container(
                               margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                               decoration: BoxDecoration(
                                 color: MyColors.color_93B9EE.withOpacity(0.1),
                                 border: Border.all(color: MyColors.color_gray_transparent),
                                 borderRadius: BorderRadius.all(Radius.circular(12.0)),
                               ),
                        child:TextFormField(
                          controller: addressline1Controller,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(

                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"


                          ),
                          decoration: InputDecoration(
                              hintText: recipientfieldsetlist[i].name,
                              hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                              border: InputBorder.none,


                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                          ),

                          keyboardType: TextInputType.text,

                          maxLines: 1,

                          // Only numbers can be entered
                        ),
                      ),
                           ),

                          Visibility(
                            visible:fieldsetlist[index].fields![i].fieldId == "ADDRESS_LINE_2" ?true:false,
                            child: Container(
                              margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                color: MyColors.color_93B9EE.withOpacity(0.1),
                                border: Border.all(color: MyColors.color_gray_transparent),
                                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              ),
                              child: TextFormField(
                        controller: addressline2Controller,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(

                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"


                        ),
                        decoration: InputDecoration(
                              hintText: recipientfieldsetlist[i].name,
                              hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                              border: InputBorder.none,


                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                        ),

                        keyboardType: TextInputType.text,

                        maxLines: 1,

                        // Only numbers can be entered
                      ),
                            ),
                          ),

                           Visibility(
                             visible:fieldsetlist[index].fields![i].fieldId == "ADDRESS_CITY" ?true:false,
                             child: Container(
                               margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                               decoration: BoxDecoration(
                                 color: MyColors.color_93B9EE.withOpacity(0.1),
                                 border: Border.all(color: MyColors.color_gray_transparent),
                                 borderRadius: BorderRadius.all(Radius.circular(12.0)),
                               ),
                        child: TextFormField(
                          controller: addressline3Controller,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(

                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"


                          ),
                          decoration: InputDecoration(
                              hintText: recipientfieldsetlist[i].hintText,
                              hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                              border: InputBorder.none,


                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                          ),

                          keyboardType: TextInputType.text,

                          maxLines: 1,

                          // Only numbers can be entered
                        ),
                      ),
                           ),

                      Visibility(
                          visible:fieldsetlist[index].fields![i].fieldId == "ADDRESS_COUNTRY" ?true:false,
                          child: Container(
                            child:dropd( fieldsetlist[index].fields![i].placeholderText.toString(),) ,
                          )),


                           Visibility(
                             visible:fieldsetlist[index].fields![i].fieldId == "ADDRESS_ZIP" ?true:false,
                             child: Container(
                               margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                               decoration: BoxDecoration(
                                 color: MyColors.color_93B9EE.withOpacity(0.1),
                                 border: Border.all(color: MyColors.color_gray_transparent),
                                 borderRadius: BorderRadius.all(Radius.circular(12.0)),
                               ),
                        child: TextFormField(
                          controller: address_zip3Controller,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(

                                color:MyColors.blackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "a_assets/font/poppins_regular.ttf"


                          ),
                          decoration: InputDecoration(
                              hintText: recipientfieldsetlist[i].hintText,
                              hintStyle: TextStyle(color: MyColors.color_text.withOpacity(0.4),fontSize: 12,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500 ),

                              border: InputBorder.none,


                              // fillColor: MyColors.color_gray_transparent,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                          ),

                          keyboardType: TextInputType.text,

                          maxLines: 1,

                          // Only numbers can be entered
                        ),
                      ),
                           ),



                      Visibility(
                        visible:fieldsetlist[index].fields![i].fieldId == "ADDRESS_STATE" ?true:false,
                        child: Container(

                          child: addressstatedropd( fieldsetlist[index].fields![i].placeholderText.toString(),),
                        ),
                      ),

                      hSizedBox4,

                    ],
                  );
                }),

              ],
            ),
          );
          }),

          hSizedBox6,
          hSizedBox6,

         */
/* Container(
            margin: EdgeInsets.only(top: 46,left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){

                    Navigator.pop(context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          //  stops: [0.0, 1.0],
                          colors: [
                            MyColors.lightblueColor.withOpacity(0.10),
                            MyColors.lightblueColor.withOpacity(0.10),
                          ],
                        ),
                        //color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:  EdgeInsets.only(left: 28, right: 28, bottom: 18,top: 18),
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
                      child: Text(MyString.back,style: TextStyle(color: MyColors.lightblueColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)
                  ),
                ),
                wSizedBox3,
                GestureDetector(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>SendMoneyquotationRecipints()));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectDeliveryMethodScreen()));

                  },
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          //  stops: [0.0, 1.0],
                          colors: [
                            MyColors.lightblueColor,
                            MyColors.lightblueColor,
                          ],
                        ),
                        //color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:  EdgeInsets.only(left: 28, right: 28, bottom: 18,top: 18),
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
                      child: Text(MyString.Add,style: TextStyle(color: MyColors.whiteColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),)
                  ),
                ),
              ],
            ),
          ),*//*

        ],
      )
    ),

    load == true ? Container(
      color: MyColors.primaryColor.withOpacity(0.60),
      child: Center(
        child: CircularProgressIndicator(color: MyColors.lightblueColor,) ,
      ),
    ) : Container()
  ],
),


   );
  }

  dropd(String name){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      width: double.infinity,
      margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: MyColors.color_93B9EE.withOpacity(0.1),
        border: Border.all(color: MyColors.color_gray_transparent),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),

      child:  DropdownButtonHideUnderline(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: DropdownButton(
                isExpanded: true,
                value: selectedCategory,
                style:
                TextStyle(color: MyColors.blackColor),
                items: optionlist.map((Options model) {
                  return new DropdownMenuItem<String>(
                      value: model.id.toString()  ,
                      child: new Text(model.name.toString() ));
                }).toList(),
                hint: Text(
                  "${name}",
                  style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (value) {

                  setState(() {

                    print(value);
                    selectedCategory = value.toString();
                    print("value $selectedCategory");

                  });

                  //  updateClassState();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  addressstatedropd(String name){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      width: double.infinity,
      margin:  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
        color: MyColors.color_93B9EE.withOpacity(0.1),
        border: Border.all(color: MyColors.color_gray_transparent),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),

      child:  DropdownButtonHideUnderline(
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: DropdownButton(
                isExpanded: true,
                value: selectedCategory,
                style:
                TextStyle(color: MyColors.blackColor),
                items: optionlist.map((Options model) {
                  return new DropdownMenuItem<String>(
                      value: model.id.toString()  ,
                      child: new Text(model.name.toString() ));
                }).toList(),
                hint: Text(
                  "${name}",
                  style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                onChanged: (value) {

                  setState(() {

                    print(value);
                    selectedCategory = value.toString();
                    print("value $selectedCategory");

                  });

                  //  updateClassState();
                },
              ),
            );
          },
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
}*/
class PhoneNumberModel {
  String? countryIso3Code;
  int? countryPhoneCode;
  String? number;

  PhoneNumberModel({this.countryIso3Code, this.countryPhoneCode, this.number});

  PhoneNumberModel.fromJson(Map<String, dynamic> json) {
    countryIso3Code = json['countryIso3Code'];
    countryPhoneCode = json['countryPhoneCode'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryIso3Code'] = this.countryIso3Code;
    data['countryPhoneCode'] = this.countryPhoneCode;
    data['number'] = this.number;
    return data;
  }


}
