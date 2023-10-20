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
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as Math;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


import '../../constance/customLoader/customLoader.dart';
import '../../constance/customTextfield/uppercase_textfield.dart';
import '../../model/RecipientFiealdModel.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';
import '../bank_accountnumber/bank_accountNumber.dart';
import '../home/s_home/sendmoneyquotation/sendmoneyfromrecipient.dart';
import '../resonforsendingscreen/reasonforsendingscreen.dart';


class AddRecipientInfoScreen extends StatefulWidget{
  final bool? isMfsMobileMoney;

  const AddRecipientInfoScreen({super.key,this.isMfsMobileMoney});

  @override
  State<AddRecipientInfoScreen> createState() => _AddRecipientInfoScreenState();
}

class _AddRecipientInfoScreenState extends State<AddRecipientInfoScreen> {

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

  print("partnerPaymentMethod>>>> "+p!.getString("partnerPaymentMethod").toString());
  print("select_payment_method_status>>>> "+p!.getString("select_payment_method_status").toString());
  print("currency iso>>>> "+p!.getString("country_Currency_isoCode3").toString());
  print("country_isoCode3 iso>>>> "+p!.getString("country_isoCode3").toString());
  print("phonecode iso>>>> "+p!.getString("phonenumber_min_max_validation").toString());
  phone_min_val = p!.getString("partnerPaymentMethod").toString()=="mfs" || p!.getString("partnerPaymentMethod").toString()=="juba"?0:int.parse(p!.getString("phonenumber_min_max_validation").toString().split("-")[0]);
  phone_max_val = p!.getString("partnerPaymentMethod").toString()=="mfs" || p!.getString("partnerPaymentMethod").toString()=="juba"?0:int.parse(p!.getString("phonenumber_min_max_validation").toString().split("-")[1]);
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
              leading: const Icon(Icons.camera_alt),
              title: const Text('camera'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('gallery'),
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
  bool isMfsMobileMoney =false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isMfsMobileMoney=widget.isMfsMobileMoney ?? false;
    });
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
    await Webservices.AddRecipientFieldRequest(context, addfieldlist,frontimg.toString());
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
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 30),
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
                      boxShadow: const [
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
                    padding:  const EdgeInsets.only(left: 28, right: 28, bottom: 0,top: 0),
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
                    child: const Center(child: Text(MyString.back,style: TextStyle(color: MyColors.lightblueColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),))
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

                  if(p!.getString("partnerPaymentMethod").toString()=="mfs" || p!.getString("partnerPaymentMethod").toString()=="juba"){

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

                  }else{
                    if(p!.getString("country_isoCode3").toString()=="IND"||p!.getString("country_isoCode3").toString()=="PAK"){
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
                    }
                    else{
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
                  }



                  // if(frontimg.toString().isEmpty || frontimg == "" || frontimg == null){
                  //  img_error = "Required*";
                  //  setState((){});
                  // }
                  // else{
                  //   img_error ="";

                    // addRecipientField();
                   /* for(int k= 0; k < addfieldlist.length ; k++){
                      print("value2...${addfieldlist[k].value.toString()}");
                      if(addfieldlist[k].value != null || addfieldlist[k].value.toString().isNotEmpty || addfieldlist[k].value != ""){
                        print("value...${addfieldlist[k].value.toString()}");
                        addRecipientField();
                        Fluttertoast.showToast(msg: "Error");

                      }else{
                        print("error...${addfieldlist[k].value.toString()}");
                        Fluttertoast.showToast(msg: addfieldlist[k].value.toString());
                      }*/
                  // }
                  // }
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectDeliveryMethodScreen()));

                },
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.white, offset: Offset(0, 4), blurRadius: 5.0)
                      ],
                      gradient: const LinearGradient(
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
                    padding:  const EdgeInsets.only(left: 28, right: 28, bottom: 0,top: 0),
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0,top: 0.0),
                    child: const Center(child: Text(MyString.Add,style: TextStyle(color: MyColors.whiteColor,fontWeight:FontWeight.w600,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),))
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
                        margin: const EdgeInsets.only(top: 0.0,bottom: 30,),
                        alignment: Alignment.center,
                        child: const Text(MyString.Add_Recipient_Info,style: TextStyle(color: MyColors.color_text,fontSize:18,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600 ),)),
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
                                margin: const EdgeInsets.only(top: 0.0),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
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
                            margin: const EdgeInsets.only(top: 0.0,bottom: 30),
                            alignment: Alignment.center,
                            child: Text(img_error,style: const TextStyle(color: MyColors.red,fontSize: 11),),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width:double.infinity,
                      margin:  const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                        color: MyColors.color_93B9EE.withOpacity(0.1),
                        border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: TextFormField(
                        controller: firstnameController,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(

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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                        ),

                        keyboardType: TextInputType.text,

                        maxLines: 1,

                        // Only numbers can be entered
                      ),
                    ),

                    hSizedBox3,
                    Container(
                      width:double.infinity,
                      margin:  const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      decoration: BoxDecoration(
                        color: MyColors.color_93B9EE.withOpacity(0.1),
                        border: Border.all(color: MyColors.color_gray_transparent),
                        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: TextFormField(
                        controller: lastnameController,
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        textInputAction: TextInputAction.done,
                        style: const TextStyle(

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
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),


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
                          margin:  const EdgeInsets.fromLTRB(20.0, 0.0, 5.0, 0.0),
                          decoration: BoxDecoration(
                            color: MyColors.color_93B9EE.withOpacity(0.1),
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: TextFormField(
                            enabled: false,
                            controller: TextEditingController(text: p?.getString("phonecode").toString()),
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(

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
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),


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
                            margin:  const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
                            decoration: BoxDecoration(
                              color: MyColors.color_93B9EE.withOpacity(0.1),
                              border: Border.all(color: MyColors.color_gray_transparent),
                              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: TextFormField(
                              controller: mobileNumberController,
                              textInputAction: TextInputAction.done,
                              maxLength: p?.getString("partnerPaymentMethod").toString()=="mfs" || p!.getString("partnerPaymentMethod").toString()=="juba"?null:phone_max_val,
                              focusNode: mobileFocusNode,
                              style: const TextStyle(

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
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),


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

                    p!.getString("partnerPaymentMethod").toString()=="mfs" || p!.getString("partnerPaymentMethod").toString()=="juba"?
                    Container():
                    Column(
                      children: [

                        hSizedBox3,
                        Container(
                          width:double.infinity,
                          margin:  const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          decoration: BoxDecoration(
                            color: MyColors.color_93B9EE.withOpacity(0.1),
                            border: Border.all(color: MyColors.color_gray_transparent),
                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          ),
                          child: TextFormField(
                            controller: relationshipController,
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(

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
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),


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
                              margin:  const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                              decoration: BoxDecoration(
                                color: MyColors.color_93B9EE.withOpacity(0.1),
                                border: Border.all(color: MyColors.color_gray_transparent),
                                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                              ),
                              child: TextFormField(
                                controller: addressController,
                                inputFormatters: [
                                  UpperCaseTextFormatter(),
                                ],
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(

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
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),


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
                                  margin:  const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  decoration: BoxDecoration(
                                    color: MyColors.color_93B9EE.withOpacity(0.1),
                                    border: Border.all(color: MyColors.color_gray_transparent),
                                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                  child: TextFormField(
                                    controller: cityController,
                                    inputFormatters: [
                                      UpperCaseTextFormatter(),
                                    ],
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(

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
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),


                                    ),

                                    keyboardType: TextInputType.text,

                                    maxLines: 1,

                                    // Only numbers can be entered
                                  ),
                                ),

                                hSizedBox3,

                                Container(
                                  width:double.infinity,
                                  margin:  const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  decoration: BoxDecoration(
                                    color: MyColors.color_93B9EE.withOpacity(0.1),
                                    border: Border.all(color: MyColors.color_gray_transparent),
                                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                  ),
                                  child: TextFormField(
                                    controller: postcodeController,
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(

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
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),


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


  Future<void> createRecipientRequest(BuildContext context,
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
      pre.setString("recipientReceiveBankOrMobileNo", phonecode+phone_number);
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
        request.fields['mobile_operator'] = pre.getString("mfs_mobile_operator_name").toString();
        request.fields['delivery_method_type'] = pre.getString("select_payment_method_status").toString();
        if(p!.getString("partnerPaymentMethod").toString()=="juba" && p!.getString("select_payment_method_status").toString()=="Mobile"){
          request.fields['juba_NominatedCode'] = pre.getString("juba_NominatedCode").toString();
        }

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
        print("create response>>>> "+event.toString());
        print("isMfsMobileMoney >>>> "+isMfsMobileMoney.toString());
        if (map["status"] == true) {
          CustomLoader.ProgressloadingDialog(context, false);
          pre.setString("recpi_id", map['data']['recipient_server_id'].toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>(countryIso3Code == "SOM" && (isMfsMobileMoney ))?ReasonforSendingScreen(status: "reason_for_sending",):(isMfsMobileMoney ) || (pre.getString("partnerPaymentMethod").toString()=="juba" && pre.getString("select_payment_method_status").toString() == "Cash")? /*SelectPaymentMethodScreen(isMfs: (widget.isMfsMobileMoney ?? false),selectedMethodScreen: 0,)*/ReasonforSendingScreen(status: "reason_for_sending",):BankAccountNumber()));

          if((pre.getString("partnerPaymentMethod").toString()=="juba" || pre.getString("partnerPaymentMethod").toString()=="mfs") && pre.getString("select_payment_method_status").toString() == "Mobile"){
            print("save in mfs mobile case");
            pre.setString("BankdetailResponse", event.toString());
          }

          // Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectDeliveryMethodScreen()));

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Create Recipient Successfully')),
          // );


          /// SUCCESS
        } else {
          print(map);
          print('error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(map["message"])),
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
