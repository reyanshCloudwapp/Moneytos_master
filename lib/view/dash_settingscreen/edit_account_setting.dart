import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/setup_new_pin_code_screen/setup_newpin_Code_screen.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/view/dash_settingscreen/setting_account_setting/front_image.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constance/customLoader/customLoader.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/S_ApiResponse/AccountSettingResponse.dart';
import '../../s_Api/S_ApiResponse/SelectCountryListResponse.dart';
import '../../s_Api/S_ApiResponse/StateListResponse.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';
import 'package:http/http.dart'as http;
import 'dart:convert' as convert;
bool isload = false;
List<SelectCountryList> selectCountryList = <SelectCountryList>[];
List<StateListData> selectStateList = <StateListData>[];
TextEditingController stateController = TextEditingController();
TextEditingController countryController = TextEditingController();
SelectCountryListResponse countryListResponse = new SelectCountryListResponse();
String country_id = "";
String state_id = "";
StateListResponse stateListResponse = new StateListResponse();
class EditAccountSettingScreen extends StatefulWidget {
  AccountSettingResponse accountSettingResponse;
  Function Oncallback;
  EditAccountSettingScreen({Key? key,required this.accountSettingResponse,required this.Oncallback}) : super(key: key);

  @override
  _EditAccountSettingScreenState createState() =>
      _EditAccountSettingScreenState();
}

class _EditAccountSettingScreenState extends State<EditAccountSettingScreen> {
  String? status_title;
  bool _isObscure = true;
  /// TextEditingController
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  /// FocusNode

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode zipcodeFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();


  final ImagePicker imagePicker = ImagePicker();
  XFile? _frontimage;
  String image_path = "";
  bool frontimageSelected = false;

  DateTime selectedPickerDate = DateTime.now();
  String selected_date="";

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [

        KeyboardActionsItem(
            focusNode: mobileFocusNode,
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
    nameFocusNode.unfocus();
    emailFocusNode.unfocus();
    countryFocusNode.unfocus();
    addressFocusNode.unfocus();
    stateFocusNode.unfocus();
    mobileFocusNode.unfocus();
    zipcodeFocusNode.unfocus();
    dobFocusNode.unfocus();


  }

  @override
  void initState() {
    super.initState();
    DataSet();
    setState(() {});
  }

  void DataSet(){
    nameController.text = widget.accountSettingResponse.data!.userData!.name.toString();
    emailController.text = widget.accountSettingResponse.data!.userData!.email.toString();
    countryController.text = widget.accountSettingResponse.data!.userData!.countryName.toString();
    country_id = widget.accountSettingResponse.data!.userData!.country.toString();
    stateController.text = widget.accountSettingResponse.data!.userData!.stateName.toString();
    state_id = widget.accountSettingResponse.data!.userData!.state.toString();
    birthController.text = widget.accountSettingResponse.data!.userData!.dob.toString()!="null"?Utility.DatefomatToYYYYMMTOMMDD(widget.accountSettingResponse.data!.userData!.dob.toString()):"";
    selected_date = widget.accountSettingResponse.data!.userData!.dob.toString()=="null"?"":Utility.DatefomatToYYYYMMTOMMDD(widget.accountSettingResponse.data!.userData!.dob.toString());
    numberController.text = widget.accountSettingResponse.data!.userData!.mobileNumber.toString();
    addressController.text = widget.accountSettingResponse.data!.userData!.address.toString();
    zipcodeController.text = widget.accountSettingResponse.data!.userData!.zipcode.toString();
    setState(() {});
  }

  frontDocumentbottoms(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            child: Wrap(children: [
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
            ]),
          );
        });
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
          image_path = _frontimage!.path;
          setState(() {

          });
          print('image path is ${image_path}');
        }
        //  Navigator.pop(context);
      });
    }
  }

  Future<void> updateProfileapi(BuildContext context,String profile_img,
      String name, String email, String country,String dob,String state,String phone_number,String address,String zipcode) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(Apiservices.updateProfileapi));
        profile_img == "" ? null :
        request.files
            .add(await http.MultipartFile.fromPath('profileImage', profile_img));
        request.fields['name'] = name;
        request.fields['dob'] = dob;
        request.fields['country'] = country;
        request.fields['state'] = state;
        request.fields['address'] = address;
        request.fields['zipcode'] = zipcode;
        request.fields['email'] = email;


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
          CustomLoader.ProgressloadingDialog6(context, false);
          // Navigator.pop(context);
          // this.widget.Oncallback();
          Navigator.of(context, rootNavigator: true)
              .pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return  DashboardScreen(currentpage_index:3,);
              },
            ),
                (_) => false,
          );
          setState(() {});


          /// SUCCESS
        } else {
          print(map);

          CustomLoader.ProgressloadingDialog6(context, false);
          setState(() {});
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final size = MediaQuery.of(context).size;
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            backgroundColor: MyColors.light_primarycolor2,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child:   AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: MyColors.light_primarycolor2,
                flexibleSpace: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(23, 30, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SvgPicture.asset(
                            "s_asset/images/leftarrow.svg",
                              height: 32,
                              width: 32
                          )),
                      Container(
                        // margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                        child: const Text(
                          MyString.account_setting,
                          style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              fontFamily:
                              "s_asset/font/raleway/raleway_extrabold.ttf"),
                        ),
                      ),

                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset("s_asset/images/edit.svg",color: MyColors.whiteColor.withOpacity(0.40),)),
                    ],
                  ),
                ),
              ),

            ),
            bottomSheet: Container(
              color: MyColors.whiteColor,
              padding: const EdgeInsets.only(top: 10,bottom: 40,left: 25,right: 25),
              height: 120,
              child:   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 100,
                      height: 45,
                      alignment: Alignment.center,
                      child:Material(
                          elevation: 10,
                        shadowColor:  MyColors.btncolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        child: CustomButton(btnname: MyString.cancel,textcolor: MyColors.color_3F84E5,fontsize: 16,),
                      )
                    ),
                  ),
                  wSizedBox5,
                  wSizedBox,
                  InkWell(
                    onTap: (){
                      String name = nameController.text;
                      String email = emailController.text;
                      String country = countryController.text;
                      String dob = birthController.text;
                      String state = stateController.text;
                      String phone_number = numberController.text;
                      String address = addressController.text;
                      String zipcode = zipcodeController.text;
                      if(name.isEmpty){
                        Utility.showFlutterToast( "Enter Name");
                      }else if(email.isEmpty){
                        Utility.showFlutterToast( "Enter Email");
                      }else if(!Utility.isEmail(email)){
                        Utility.showFlutterToast( "Enter Valid Email");
                      }else if(country.isEmpty){
                        Utility.showFlutterToast( "Select Country");
                      }else if(state.isEmpty){
                        Utility.showFlutterToast( "Select State");
                      }else if(dob.isEmpty){
                        Utility.showFlutterToast( "Select Date Of Birth");
                      }else if(phone_number.isEmpty){
                        Utility.showFlutterToast( "Enter Phone Number");
                      }else if(address.isEmpty){
                        Utility.showFlutterToast( "Enter Address");
                      }else if(zipcode.isEmpty){
                        Utility.showFlutterToast( "Enter zipcode");
                      }else{
                        updateProfileapi(context, image_path, name, email, country_id, selected_date, state_id, phone_number, address, zipcode);
                      }

                    },
                    child: Container(
                      width: 100,
                      height: 45,
                      alignment: Alignment.center,
                      child:Material(
                          elevation: 10,
                          shadowColor:  MyColors.btncolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: CustomButton2(btnname: MyString.save,textcolor: MyColors.whiteColor,fontsize: 16,bg_color: MyColors.darkbtncolor,bordercolor: MyColors.darkbtncolor.withOpacity(0.10),)),
                    ),
                  ),

                ],
              ),
            ),
            body: KeyboardActions(
              autoScroll: false,
              config: _buildKeyboardActionsConfig(context),
              child: Container(
                // height: MediaQuery.of(context).size.height,
                child: Stack(
                    children: <Widget>[
                      Container(
                        color: MyColors.light_primarycolor2,
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                      ),
                      SingleChildScrollView(
                        // physics: FixedExtentScrollPhysics(),
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          //  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          //   height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                elevation: 0,
                                color: MyColors.whiteColor,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Column(
                                      children: [
                                        hSizedBox2,

                                        Container(
                                          width: size.width * 0.6,
                                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                          child: const Text(
                                            MyString.edit_profile_info,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: MyColors.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                fontFamily:
                                                "s_asset/font/raleway/raleway_bold.ttf"),
                                          ),
                                        ),
                                        hSizedBox4,

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
                                                  height: 100,width: 100,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(200),
                                                      child: Image.file(File(image_path.toString()),fit: BoxFit.cover,)))
                                                  :
                                              CircleAvatar(
                                                radius: 200,
                                                backgroundColor: MyColors.lightblueColor.withOpacity(0.09),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(200.0),
                                                  child: FadeInImage(
                                                    height: 156,width: 149,
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                      widget.accountSettingResponse.data!.userData!.profileImage.toString(),),
                                                    placeholder: const AssetImage(
                                                        "s_asset/images/userplaceholder.png"),
                                                    placeholderFit: BoxFit.scaleDown,
                                                    imageErrorBuilder:
                                                        (context, error, stackTrace) {
                                                      return CircleAvatar(
                                                          radius: 100,
                                                          backgroundColor: Colors.white30,
                                                          child: ClipOval(child: Image.asset("s_asset/images/userplaceholder.png",fit: BoxFit.cover,width: 100, height: 100) )

                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                          ),
                                        ),

                                        hSizedBox4,
                                        hSizedBox1,

                                        textfield(nameController,"Hesham",nameFocusNode,TextInputType.text,TextInputAction.next),
                                        hSizedBox1,
                                        hSizedBox,
                                        textfield(emailController,"Hesham@gmail.com",emailFocusNode,TextInputType.text,TextInputAction.next),
                                        hSizedBox1,
                                        hSizedBox,
                                        // unitedtextfield(unitedController,"United States",countryFocusNode,TextInputType.text,TextInputAction.next),
                                        Container(
                                          height: 45,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          decoration: BoxDecoration(
                                              color: MyColors.primaryColor.withOpacity(0.01),
                                              borderRadius: BorderRadius.circular(8)),
                                          child: InkWell(
                                            onTap: (){
                                              showModalBottomSheet<void>(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return CustomCountryBottomSheet();
                                                },
                                              );
                                            },
                                            child: TextField(
                                              enabled: false,
                                              controller: countryController,
                                              textInputAction: TextInputAction.next,
                                              onTap: () {


                                                setState(() {});
                                              },
                                              style: const TextStyle(
                                                  color: MyColors.blackColor,
                                                  fontSize: 12,
                                                  fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                                              ),
                                              decoration: const InputDecoration(
                                                hintText: 'Country',
                                                border: InputBorder.none,
                                                fillColor: MyColors.whiteColor,
                                                contentPadding: EdgeInsets.symmetric(horizontal: 22,vertical: 12),
                                                //border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),

                                              keyboardType: TextInputType.emailAddress,

                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ),
                                        hSizedBox1,
                                        hSizedBox,
                                        // textfield(newyorkController,"New York",stateFocusNode,TextInputType.text,TextInputAction.next),
                                        Container(
                                          height: 45,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          decoration: BoxDecoration(
                                              color: MyColors.primaryColor.withOpacity(0.01),
                                              borderRadius: BorderRadius.circular(8)),
                                          child: InkWell(
                                            onTap: (){

                                              showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return CustomStateBottomSheet();
                                                },
                                              );
                                            },
                                            child: TextField(
                                              enabled: false,
                                              controller: stateController,
                                              textInputAction: TextInputAction.next,
                                              onTap: () {

                                                //is_phoneborder = false;
                                                setState(() {});
                                              },
                                              style: const TextStyle(
                                                  color: MyColors.blackColor,
                                                  fontSize: 12,
                                                  fontFamily: "s_asset/font/raleway/raleway_medium.ttf"

                                              ),
                                              decoration: const InputDecoration(
                                                hintText: 'State',
                                                border: InputBorder.none,
                                                fillColor: MyColors.whiteColor,
                                                contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 22, vertical: 12),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                //border: InputBorder.none,

                                              ),

                                              keyboardType: TextInputType.emailAddress,

                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ),
                                        hSizedBox1,
                                        hSizedBox,
                                        InkWell(
                                          onTap: (){
                                            selectDateFun(context);
                                          },
                                          child: Container(
                                            height: 45,
                                            margin: const EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: MyColors.primaryColor.withOpacity(0.01),
                                                borderRadius: BorderRadius.circular(8)),
                                            width: MediaQuery.of(context).size.width,
                                            child: TextField(
                                              enabled: false,
                                              focusNode: dobFocusNode,
                                              controller:birthController ,
                                              textInputAction: TextInputAction.next,
                                              style: const TextStyle(
                                                  color: MyColors.blackColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                                              decoration: InputDecoration(
                                                hintText: "Birthdate (dd/mm/yy)",
                                                border: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                    borderSide: const BorderSide(color: MyColors.lightblueColor, width: 1)),
                                                fillColor: MyColors.whiteColor,
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 22,vertical: 12),

                                                hintStyle: TextStyle(
                                                    color: MyColors.blackColor.withOpacity(0.50),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                                                    letterSpacing: 0.3),
                                                //border: InputBorder.none,
                                              ),

                                              keyboardType: TextInputType.text,

                                              // Only numbers can be entered
                                            ),
                                          ),
                                        ),
                                        hSizedBox1,
                                        hSizedBox,
                                        textphonefield(numberController,"426-678-987",mobileFocusNode,TextInputType.number,TextInputAction.next),
                                        hSizedBox1,
                                        hSizedBox,
                                        textfield(addressController,"Address",addressFocusNode,TextInputType.text,TextInputAction.next),
                                        hSizedBox1,
                                        hSizedBox,
                                        textfield(zipcodeController,"Zip Code",zipcodeFocusNode,TextInputType.text,TextInputAction.next),


                                        hSizedBox6,
                                        hSizedBox6,
                                        hSizedBox6,
                                      /*  GestureDetector(
                                          onTap: (){
                                            currentpassFocusNode.unfocus();
                                            newpassFocusNode.unfocus();
                                            confirmpassFocusNode.unfocus();
                                            showbottomsheet(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 20, ),
                                            child: CustomButton2(btnname: MyString.update_password,bg_color: MyColors.lightblueColor,bordercolor: MyColors.lightblueColor,height: 55,),
                                          ),
                                        ),*/


                                      ]
                                  ),
                                )
                            )),
                      ),
                    ]
                ),
              ),
            )));
  }



  selectDateFun(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedPickerDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedPickerDate)
      setState(() {
        selectedPickerDate = selected;
        selected_date = DateFormat('yyyy-MM-dd').format(selectedPickerDate);
        birthController.text = DateFormat('MM-dd-yyyy').format(selectedPickerDate);
      });
  }

  textphonefield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: MyColors.primaryColor.withOpacity(0.01),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        maxLength: 10,
        textInputAction: textInputAction,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(horizontal: 22,vertical: 12),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }


  textfield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: MyColors.primaryColor.withOpacity(0.01),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        textInputAction: textInputAction,
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 22,vertical: 12),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }


  unitedtextfield(TextEditingController controller,String hinttext,FocusNode focusNode,TextInputType textInputType,TextInputAction textInputAction) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: MyColors.primaryColor.withOpacity(0.01),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller:controller ,
        textInputAction: textInputAction,
        style: const TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          prefixIcon:   Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SvgPicture.asset("s_asset/images/flag1.svg")),
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.all(12),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
              letterSpacing: 0.3),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  showbottomsheet(BuildContext context) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: MyColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.86,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: SetupNewPinCodeScreen());
      },
    );
  }
}

class CustomStateBottomSheet extends StatefulWidget {
  CustomStateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomStateBottomSheet> createState() => _CustomStateBottomSheetState();
}

class _CustomStateBottomSheetState extends State<CustomStateBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>statelistbycountryidApi(context,country_id));

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child:
      isload==true?

      Container(
        child: const GFLoader(
            type: GFLoaderType.custom,
            child: Image(image: AssetImage("a_assets/logo/progress_image.png"),
            )),

      ):
      selectStateList.isNotEmpty?


      ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: selectStateList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                stateController.text = selectStateList[index].name.toString();
                state_id = selectStateList[index].id.toString();
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(selectStateList[index].name.toString()),
              ),
            );
          }
      ):
      Container(
        child: const Text("No State Found"),
      ),
    );
  }
  Future <void> statelistbycountryidApi(BuildContext context,String country_id) async {

    // Utility.ProgressloadingDialog(context, true);
    setState((){
      isload = true;
    });
    selectStateList.clear();
    var request = {};
    request['country_id'] = country_id;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(AllApiService.statelistbycountryid_List_URL+"?country_id="+country_id),
        // body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,


        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      stateListResponse  = await StateListResponse.fromJson(jsonResponse);


      for(int i =0; i<stateListResponse.data!.length;i++){

        selectStateList.add(stateListResponse.data![i]);





      }


      // Utility.ProgressloadingDialog(context, false);
      setState((){
        isload = false;


      });
      //Navigator.of(context).pop();
      print("isload >>>> if"+isload.toString());
    } else {
      // Utility.ProgressloadingDialog(context, false);

      setState((){
        isload = false;
      });
      /// Navigator.of(context).pop();
      print("isload >>>> else"+isload.toString());
    }

    return;

  }
}

class CustomCountryBottomSheet extends StatefulWidget {
  CustomCountryBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomCountryBottomSheet> createState() => _CustomCountryBottomSheetState();
}

class _CustomCountryBottomSheetState extends State<CustomCountryBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>selectCountryListApi(context));

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child:
      isload==true?

      Container(
        child: const GFLoader(
            type: GFLoaderType.custom,
            child: Image(image: AssetImage("a_assets/logo/progress_image.png"),
            )),

      ):
      selectCountryList.isNotEmpty?


      ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: selectCountryList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                countryController.text = selectCountryList[index].name.toString();
                country_id = selectCountryList[index].id.toString();
                selectStateList.clear();
                state_id = "";
                stateController.clear();

                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(selectCountryList[index].name.toString()),
              ),
            );
          }
      ):
      Container(
        child: const Text("No State Found"),
      ),
    );
  }
  Future <void> selectCountryListApi(BuildContext context,) async {

    // CustomLoader.ProgressloadingDialog6(context, true);
    setState((){
      isload = true;
    });
    var request = {};


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(AllApiService.Countries_List_URL),
        // body: convert.jsonEncode(request),
        headers: {
          "X-CLIENT": AllApiService.x_client,


        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {

      countryListResponse  = await SelectCountryListResponse.fromJson(jsonResponse);



      for(int i =0; i<countryListResponse.data!.length;i++){

        selectCountryList.add(countryListResponse.data![i]);





      }

      setState((){
        isload = false;
      });
    } else {
      // CustomLoader.ProgressloadingDialog6(context, false);

      setState((){
        isload = false;
      });
    }

    return;

  }
}
