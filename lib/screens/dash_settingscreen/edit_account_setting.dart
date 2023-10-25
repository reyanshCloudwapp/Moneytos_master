import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:moneytos/screens/customScreens/setup_new_pin_code_screen/setup_newpin_Code_screen.dart';
import 'package:moneytos/screens/dashboardScreen/dashboard.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/SelectCountryListResponse.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/StateListResponse.dart';
import 'package:moneytos/utils/import_helper.dart';

bool isload = false;
List<SelectCountryList> selectCountryList = <SelectCountryList>[];
List<StateListData> selectStateList = <StateListData>[];
TextEditingController stateController = TextEditingController();
TextEditingController countryController = TextEditingController();
SelectCountryListResponse countryListResponse = SelectCountryListResponse();
String country_id = '';
String state_id = '';
StateListResponse stateListResponse = StateListResponse();

class EditAccountSettingScreen extends StatefulWidget {
  final AccountSettingResponse accountSettingResponse;
  final Function Oncallback;

  const EditAccountSettingScreen({
    Key? key,
    required this.accountSettingResponse,
    required this.Oncallback,
  }) : super(key: key);

  @override
  State<EditAccountSettingScreen> createState() =>
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
  String image_path = '';
  bool frontimageSelected = false;

  DateTime selectedPickerDate = DateTime.now();
  String selected_date = '';

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [
        KeyboardActionsItem(focusNode: mobileFocusNode, onTapAction: () {}),
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

  void DataSet() {
    nameController.text =
        widget.accountSettingResponse.data!.userData!.name.toString();
    emailController.text =
        widget.accountSettingResponse.data!.userData!.email.toString();
    countryController.text =
        widget.accountSettingResponse.data!.userData!.countryName.toString();
    country_id =
        widget.accountSettingResponse.data!.userData!.country.toString();
    stateController.text =
        widget.accountSettingResponse.data!.userData!.stateName.toString();
    state_id = widget.accountSettingResponse.data!.userData!.state.toString();
    birthController.text =
        widget.accountSettingResponse.data!.userData!.dob.toString() != 'null'
            ? Utility.DatefomatToYYYYMMTOMMDD(
                widget.accountSettingResponse.data!.userData!.dob.toString(),
              )
            : '';
    selected_date =
        widget.accountSettingResponse.data!.userData!.dob.toString() == 'null'
            ? ''
            : Utility.DatefomatToYYYYMMTOMMDD(
                widget.accountSettingResponse.data!.userData!.dob.toString(),
              );
    numberController.text =
        widget.accountSettingResponse.data!.userData!.mobileNumber.toString();
    addressController.text =
        widget.accountSettingResponse.data!.userData!.address.toString();
    zipcodeController.text =
        widget.accountSettingResponse.data!.userData!.zipcode.toString();
    setState(() {});
  }

  frontDocumentbottoms(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150,
          child: Wrap(
            children: [
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
            ],
          ),
        );
      },
    );
  }

  Future getfrontCameraImage(imageSource) async {
    var image =
        await imagePicker.getImage(source: imageSource, imageQuality: 5);
    if (mounted) {
      setState(() {
        frontimageSelected = true;

        if (image == null) {
          debugPrint('+++++++++null');
        } else {
          _frontimage = XFile(image.path);
          image_path = _frontimage!.path;
          setState(() {});
          debugPrint('image path is $image_path');
        }
        //  Navigator.pop(context);
      });
    }
  }

  Future<void> updateProfileapi(
    BuildContext context,
    String profileImg,
    String name,
    String email,
    String country,
    String dob,
    String state,
    String phoneNumber,
    String address,
    String zipcode,
  ) async {
    CustomLoader.progressloadingDialog6(context, true);
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Apiservices.updateProfileapi),
      );
      profileImg == ''
          ? null
          : request.files.add(
              await http.MultipartFile.fromPath('profileImage', profileImg),
            );
      request.fields['name'] = name;
      request.fields['dob'] = dob;
      request.fields['country'] = country;
      request.fields['state'] = state;
      request.fields['address'] = address;
      request.fields['zipcode'] = zipcode;
      request.fields['email'] = email;

      Map<String, String> headers = {
        'X-AUTHTOKEN': "${pre.getString("auth")}",
        'X-USERID': "${pre.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      };

      debugPrint('the request is :');
      debugPrint(request.fields.toString());
      debugPrint(request.files.toString());
      request.headers.addAll(headers);
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((event) {
        Map map = jsonDecode(event);
        debugPrint('create response>>>> $map');
        if (map['status'] == true) {
          CustomLoader.progressloadingDialog6(context, false);
          // Navigator.pop(context);
          // this.widget.Oncallback();
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const DashboardScreen(
                  currentpage_index: 3,
                );
              },
            ),
            (_) => false,
          );
          setState(() {});

          /// SUCCESS
        } else {
          debugPrint(map.toString());

          CustomLoader.progressloadingDialog6(context, false);
          setState(() {});

          /// FAIL
        }
      });
    } catch (e) {
      ///EXCEPTION
      debugPrint('error: $e');
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
          child: AppBar(
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
                      'assets/images/leftarrow.svg',
                      height: 32,
                      width: 32,
                    ),
                  ),
                  const Text(
                    MyString.account_setting,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      fontFamily: 'assets/fonts/raleway/raleway_extrabold.ttf',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/edit.svg',
                      color: MyColors.whiteColor.withOpacity(0.40),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          color: MyColors.whiteColor,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 40,
            left: 25,
            right: 25,
          ),
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 100,
                  height: 45,
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 10,
                    shadowColor: MyColors.btncolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const CustomButton(
                      btnname: MyString.cancel,
                      textcolor: MyColors.color_3F84E5,
                      fontsize: 16,
                    ),
                  ),
                ),
              ),
              wSizedBox5,
              wSizedBox,
              InkWell(
                onTap: () {
                  String name = nameController.text;
                  String email = emailController.text;
                  String country = countryController.text;
                  String dob = birthController.text;
                  String state = stateController.text;
                  String phoneNumber = numberController.text;
                  String address = addressController.text;
                  String zipcode = zipcodeController.text;
                  if (name.isEmpty) {
                    Utility.showFlutterToast('Enter Name');
                  } else if (email.isEmpty) {
                    Utility.showFlutterToast('Enter Email');
                  } else if (!Utility.isEmail(email)) {
                    Utility.showFlutterToast('Enter Valid Email');
                  } else if (country.isEmpty) {
                    Utility.showFlutterToast('Select Country');
                  } else if (state.isEmpty) {
                    Utility.showFlutterToast('Select State');
                  } else if (dob.isEmpty) {
                    Utility.showFlutterToast('Select Date Of Birth');
                  } else if (phoneNumber.isEmpty) {
                    Utility.showFlutterToast('Enter Phone Number');
                  } else if (address.isEmpty) {
                    Utility.showFlutterToast('Enter Address');
                  } else if (zipcode.isEmpty) {
                    Utility.showFlutterToast('Enter zipcode');
                  } else {
                    updateProfileapi(
                      context,
                      image_path,
                      name,
                      email,
                      country_id,
                      selected_date,
                      state_id,
                      phoneNumber,
                      address,
                      zipcode,
                    );
                  }
                },
                child: Container(
                  width: 100,
                  height: 45,
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 10,
                    shadowColor: MyColors.btncolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomButton2(
                      btnname: MyString.save,
                      textcolor: MyColors.whiteColor,
                      fontsize: 16,
                      bg_color: MyColors.darkbtncolor,
                      bordercolor: MyColors.darkbtncolor.withOpacity(0.10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: KeyboardActions(
          autoScroll: false,
          config: _buildKeyboardActionsConfig(context),
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
                                    'assets/fonts/raleway/raleway_bold.ttf',
                              ),
                            ),
                          ),
                          hSizedBox4,

                          GestureDetector(
                            onTap: () {
                              frontDocumentbottoms(context);
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.only(top: 0.0),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/circleprof.png',
                                  ),
                                ),
                              ),
                              child: _frontimage != null
                                  ? SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          200,
                                        ),
                                        child: Image.file(
                                          File(image_path.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 200,
                                      backgroundColor: MyColors.lightblueColor
                                          .withOpacity(0.09),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          200.0,
                                        ),
                                        child: FadeInImage(
                                          height: 156,
                                          width: 149,
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            widget.accountSettingResponse.data!
                                                .userData!.profileImage
                                                .toString(),
                                          ),
                                          placeholder: const AssetImage(
                                            'assets/images/userplaceholder.png',
                                          ),
                                          placeholderFit: BoxFit.scaleDown,
                                          imageErrorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return CircleAvatar(
                                              radius: 100,
                                              backgroundColor: Colors.white30,
                                              child: ClipOval(
                                                child: Image.asset(
                                                  'assets/images/userplaceholder.png',
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                            ),
                          ),

                          hSizedBox4,
                          hSizedBox1,

                          textfield(
                            nameController,
                            'Hesham',
                            nameFocusNode,
                            TextInputType.text,
                            TextInputAction.next,
                          ),
                          hSizedBox1,
                          hSizedBox,
                          textfield(
                            emailController,
                            'Hesham@gmail.com',
                            emailFocusNode,
                            TextInputType.text,
                            TextInputAction.next,
                          ),
                          hSizedBox1,
                          hSizedBox,
                          // unitedtextfield(unitedController,"United States",countryFocusNode,TextInputType.text,TextInputAction.next),
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor.withOpacity(0.01),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomCountryBottomSheet();
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
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Country',
                                  border: InputBorder.none,
                                  fillColor: MyColors.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 12,
                                  ),
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
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: MyColors.primaryColor.withOpacity(0.01),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CustomStateBottomSheet();
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
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'State',
                                  border: InputBorder.none,
                                  fillColor: MyColors.whiteColor,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 12,
                                  ),
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
                            onTap: () {
                              selectDateFun(context);
                            },
                            child: Container(
                              height: 45,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: MyColors.primaryColor.withOpacity(0.01),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                enabled: false,
                                focusNode: dobFocusNode,
                                controller: birthController,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: MyColors.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_medium.ttf',
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Birthdate (dd/mm/yy)',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                      color: MyColors.lightblueColor,
                                      width: 1,
                                    ),
                                  ),
                                  fillColor: MyColors.whiteColor,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 12,
                                  ),

                                  hintStyle: TextStyle(
                                    color:
                                        MyColors.blackColor.withOpacity(0.50),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_medium.ttf',
                                    letterSpacing: 0.3,
                                  ),
                                  //border: InputBorder.none,
                                ),

                                keyboardType: TextInputType.text,

                                // Only numbers can be entered
                              ),
                            ),
                          ),
                          hSizedBox1,
                          hSizedBox,
                          textphonefield(
                            numberController,
                            '426-678-987',
                            mobileFocusNode,
                            TextInputType.number,
                            TextInputAction.next,
                          ),
                          hSizedBox1,
                          hSizedBox,
                          textfield(
                            addressController,
                            'Address',
                            addressFocusNode,
                            TextInputType.text,
                            TextInputAction.next,
                          ),
                          hSizedBox1,
                          hSizedBox,
                          textfield(
                            zipcodeController,
                            'Zip Code',
                            zipcodeFocusNode,
                            TextInputType.text,
                            TextInputAction.next,
                          ),

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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectDateFun(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedPickerDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedPickerDate) {
      setState(() {
        selectedPickerDate = selected;
        selected_date = DateFormat('yyyy-MM-dd').format(selectedPickerDate);
        birthController.text =
            DateFormat('MM-dd-yyyy').format(selectedPickerDate);
      });
    }
  }

  textphonefield(
    TextEditingController controller,
    String hinttext,
    FocusNode focusNode,
    TextInputType textInputType,
    TextInputAction textInputAction,
  ) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: MyColors.primaryColor.withOpacity(0.01),
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        maxLength: 10,
        textInputAction: textInputAction,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: MyColors.lightblueColor, width: 1),
          ),
          fillColor: MyColors.whiteColor,
          counterText: '',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 22, vertical: 12),

          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.50),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            letterSpacing: 0.3,
          ),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  textfield(
    TextEditingController controller,
    String hinttext,
    FocusNode focusNode,
    TextInputType textInputType,
    TextInputAction textInputAction,
  ) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: MyColors.primaryColor.withOpacity(0.01),
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        textInputAction: textInputAction,
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: MyColors.lightblueColor, width: 1),
          ),
          fillColor: MyColors.whiteColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 22, vertical: 12),

          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.50),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            letterSpacing: 0.3,
          ),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  unitedtextfield(
    TextEditingController controller,
    String hinttext,
    FocusNode focusNode,
    TextInputType textInputType,
    TextInputAction textInputAction,
  ) {
    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: MyColors.primaryColor.withOpacity(0.01),
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        textInputAction: textInputAction,
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SvgPicture.asset('assets/images/flag1.svg'),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: MyColors.lightblueColor, width: 1),
          ),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.all(12),

          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.50),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            letterSpacing: 0.3,
          ),
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
          child: const SetupNewPinCodeScreen(),
        );
      },
    );
  }
}

class CustomStateBottomSheet extends StatefulWidget {
  const CustomStateBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomStateBottomSheet> createState() => _CustomStateBottomSheetState();
}

class _CustomStateBottomSheetState extends State<CustomStateBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => statelistbycountryidApi(context, country_id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: isload == true
          ? const GFLoader(
              type: GFLoaderType.custom,
              child: Image(
                image: AssetImage('assets/logo/progress_image.png'),
              ),
            )
          : selectStateList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: selectStateList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        stateController.text =
                            selectStateList[index].name.toString();
                        state_id = selectStateList[index].id.toString();
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(selectStateList[index].name.toString()),
                      ),
                    );
                  },
                )
              : const Text('No State Found'),
    );
  }

  Future<void> statelistbycountryidApi(
    BuildContext context,
    String countryId,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    setState(() {
      isload = true;
    });
    selectStateList.clear();
    var request = {};
    request['country_id'] = countryId;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        '${AllApiService.statelistbycountryid_List_URL}?country_id=$countryId',
      ),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      stateListResponse = StateListResponse.fromJson(jsonResponse);

      for (int i = 0; i < stateListResponse.data!.length; i++) {
        selectStateList.add(stateListResponse.data![i]);
      }

      // Utility.ProgressloadingDialog(context, false);
      setState(() {
        isload = false;
      });
      //Navigator.of(context).pop();
      debugPrint('isload >>>> if$isload');
    } else {
      // Utility.ProgressloadingDialog(context, false);

      setState(() {
        isload = false;
      });

      /// Navigator.of(context).pop();
      debugPrint('isload >>>> else$isload');
    }

    return;
  }
}

class CustomCountryBottomSheet extends StatefulWidget {
  const CustomCountryBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomCountryBottomSheet> createState() =>
      _CustomCountryBottomSheetState();
}

class _CustomCountryBottomSheetState extends State<CustomCountryBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => selectCountryListApi(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: isload == true
          ? const GFLoader(
              type: GFLoaderType.custom,
              child: Image(
                image: AssetImage('assets/logo/progress_image.png'),
              ),
            )
          : selectCountryList.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: selectCountryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        countryController.text =
                            selectCountryList[index].name.toString();
                        country_id = selectCountryList[index].id.toString();
                        selectStateList.clear();
                        state_id = '';
                        stateController.clear();

                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(selectCountryList[index].name.toString()),
                      ),
                    );
                  },
                )
              : const Text('No State Found'),
    );
  }

  Future<void> selectCountryListApi(
    BuildContext context,
  ) async {
    // CustomLoader.ProgressloadingDialog6(context, true);
    setState(() {
      isload = true;
    });
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(AllApiService.Countries_List_URL),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      countryListResponse = SelectCountryListResponse.fromJson(jsonResponse);

      for (int i = 0; i < countryListResponse.data!.length; i++) {
        selectCountryList.add(countryListResponse.data![i]);
      }

      setState(() {
        isload = false;
      });
    } else {
      // CustomLoader.ProgressloadingDialog6(context, false);

      setState(() {
        isload = false;
      });
    }

    return;
  }
}
