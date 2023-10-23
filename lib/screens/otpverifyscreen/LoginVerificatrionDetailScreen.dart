import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/AccountSettingResponse.dart';
import 'package:moneytos/utils/import_helper.dart';

import '../VerificationPage.dart';

class LoginVerificatrionDetailScreen extends StatefulWidget {
  const LoginVerificatrionDetailScreen({super.key});

  @override
  State<LoginVerificatrionDetailScreen> createState() =>
      _LoginVerificatrionDetailScreenState();
}

class _LoginVerificatrionDetailScreenState
    extends State<LoginVerificatrionDetailScreen> {
  AccountSettingResponse accountSettingResponse = AccountSettingResponse();

  DateTime selectedPickerDate = DateTime.now();
  String selected_date = '';

  TextEditingController dobController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController documentTypeController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController sourceofincomeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => accountSettingApi(context));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
        dobController.text =
            DateFormat('MM-dd-yyyy').format(selectedPickerDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(190),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.color_03153B,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/bgimage.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SvgPicture.asset('assets/icons/arrow_back.svg'),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50.0, left: 0.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/images/logo.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 46,
                )
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
                image: AssetImage(
                  'assets/images/bgimage.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Image.asset('assets/images/map.png',fit: BoxFit.cover,),

          Container(
            // color: MyColors.whiteColor,
            margin: const EdgeInsets.only(top: 20.0),
            height: size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: Material(
              color: MyColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin:
                    const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Verification',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: MyColors.blackColor,
                            fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          selectDateFun(context);
                        },
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.01),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            enabled: false,
                            controller: dobController,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_medium.ttf',
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/images/ic_date_verify.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ),
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
                                color: MyColors.blackColor.withOpacity(0.50),
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
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          accountTypeDialog(context);
                        },
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.01),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            enabled: false,
                            controller: accountTypeController,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_medium.ttf',
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/images/dropdown.svg',
                                  height: 12,
                                  width: 12,
                                ),
                              ),
                              hintText: 'Account Type',
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
                                color: MyColors.blackColor.withOpacity(0.50),
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
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          documentTypeDialog(
                            context,
                            accountTypeController.text,
                          );
                        },
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.01),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            enabled: false,
                            controller: documentTypeController,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_medium.ttf',
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/images/dropdown.svg',
                                  height: 12,
                                  width: 12,
                                ),
                              ),
                              hintText: 'Document Type',
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
                                color: MyColors.blackColor.withOpacity(0.50),
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor.withOpacity(0.01),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: idNumberController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
                          decoration: InputDecoration(
                            hintText: 'ID Number',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: MyColors.whiteColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),

                            hintStyle: TextStyle(
                              color: MyColors.blackColor.withOpacity(0.50),
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor.withOpacity(0.01),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: addressController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
                          decoration: InputDecoration(
                            hintText: 'Address',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: MyColors.whiteColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),

                            hintStyle: TextStyle(
                              color: MyColors.blackColor.withOpacity(0.50),
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor.withOpacity(0.01),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: cityController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
                          decoration: InputDecoration(
                            hintText: 'City',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: MyColors.whiteColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),

                            hintStyle: TextStyle(
                              color: MyColors.blackColor.withOpacity(0.50),
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
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor.withOpacity(0.01),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: zipcodeController,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
                          decoration: InputDecoration(
                            hintText: 'Zipcode',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: MyColors.whiteColor,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),

                            hintStyle: TextStyle(
                              color: MyColors.blackColor.withOpacity(0.50),
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
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          sourceOfincomeDialog(context);
                        },
                        child: Container(
                          height: 45,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.01),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: TextField(
                            controller: sourceofincomeController,
                            enabled: false,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_medium.ttf',
                            ),
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/images/dropdown.svg',
                                  height: 12,
                                  width: 12,
                                ),
                              ),
                              hintText: 'Source Of Income',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              fillColor: MyColors.whiteColor,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 12,
                              ),

                              hintStyle: TextStyle(
                                color: MyColors.blackColor.withOpacity(0.50),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
                              String dob = selected_date;
                              String accountType =
                                  accountTypeController.text.trim();
                              String documentType =
                                  documentTypeController.text.trim();
                              String idNumber = idNumberController.text.trim();
                              String address = addressController.text.trim();
                              String city = cityController.text.trim();
                              String zipcode = zipcodeController.text.trim();
                              String sourceofincome =
                                  sourceofincomeController.text.trim();
                              if (dob.isEmpty) {
                                Utility.showFlutterToast('Select Date');
                              } else if (accountType.isEmpty) {
                                Utility.showFlutterToast('Select Account Type');
                              } else if (documentType.isEmpty) {
                                Utility.showFlutterToast(
                                  'Select Document Type',
                                );
                              } else if (idNumber.isEmpty) {
                                Utility.showFlutterToast('Enter ID Number');
                              } else if (address.isEmpty) {
                                Utility.showFlutterToast('Enter Address');
                              } else if (city.isEmpty) {
                                Utility.showFlutterToast('Enter City');
                              } else if (zipcode.isEmpty) {
                                Utility.showFlutterToast('Enter Zipcode');
                              } else if (sourceofincome.isEmpty) {
                                Utility.showFlutterToast(
                                  'Enter Source Of Income',
                                );
                              } else {
                                submitStepSecRequest(
                                  context,
                                  dob,
                                  accountType,
                                  documentType,
                                  idNumber,
                                  address,
                                  city,
                                  zipcode,
                                  sourceofincome,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.lightblueColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 17,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
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

  accountTypeDialog(BuildContext context) {
    List<String> accountTypeList = ['Company', 'Individual'];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Account Type',
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: accountTypeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            accountTypeController.text = accountTypeList[index];
                            documentTypeController.text = '';
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.radio_button_off_sharp,
                                  color: MyColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(accountTypeList[index]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  documentTypeDialog(BuildContext context, String type) {
    List<String> documentTypeList = type == 'Company'
        ? ['Company Registration No', 'BUSINESS REGISTRATION NUMBER']
        : ['Passport Number', 'License Number', 'National Id'];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Document Type',
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: documentTypeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            documentTypeController.text =
                                documentTypeList[index];
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.radio_button_off_sharp,
                                  color: MyColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(documentTypeList[index]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sourceOfincomeDialog(BuildContext context) {
    List<String> sourceOfincomeList = [
      'Wages',
      'Salary',
      'Investments',
      'Gifts'
    ];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Document Type',
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sourceOfincomeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            sourceofincomeController.text =
                                sourceOfincomeList[index];
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.radio_button_off_sharp,
                                  color: MyColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    sourceOfincomeList[index],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitStepSecRequest(
    BuildContext context,
    String dob,
    String accountType,
    String documentType,
    String idNumber,
    String Address,
    String City,
    String ZipCode,
    String SourceOfIncome,
  ) async {
    CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var userid = p.getString('userid');
    var auth = p.getString('auth');
    var request = {};
    request['dob'] = dob;
    request['account_type'] = accountType;
    request['identification_type'] = documentType;
    request['identification_number'] = idNumber;
    request['address'] = Address;
    request['city'] = City;
    request['zipcode'] = ZipCode;
    request['source_of_income'] = SourceOfIncome;
    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    var response = await http.post(
      Uri.parse(Apiservices.submitStepSec),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse.toString());
    if (jsonResponse['status'] == true) {
      p.setBool('login', true);
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog(context, false);
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.clear();

      // Navigator.of(context, rootNavigator: true)
      //     .pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (BuildContext context) {
      //       return  DashboardScreen();
      //     },
      //   ),
      //       (_) => false,
      // );
      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreenPage()));
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String VERIFICATION_URL =
          "${AllApiService.personabashurl}personaVerificationWebView?user_id=${sharedPreferences.getString("userid")}&auth_token=${sharedPreferences.getString("auth")}";

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationScreen(
            VERIFICATION_URL: VERIFICATION_URL,
          ),
        ),
      );
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.clear();
      p.setBool('login', false);
      CustomLoader.ProgressloadingDialog(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  Future<void> accountSettingApi(
    BuildContext context,
  ) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    var userid = p.getString('userid');
    var auth = p.getString('auth');
    var request = {};
    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.accountSetting_URl),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      accountSettingResponse = AccountSettingResponse.fromJson(jsonResponse);
      // Fluttertoast.showToast(msg: jsonResponse['message']);

      debugPrint(
        'accountSettingResponse.data!.userData!.dob!.toString()${accountSettingResponse.data!.userData!.dob!}',
      );
      if (accountSettingResponse.data!.userData!.dob != '' ||
          accountSettingResponse.data!.userData!.dob.toString() != 'null') {
        selected_date = accountSettingResponse.data!.userData!.dob!.toString();
        dobController.text =
            accountSettingResponse.data!.userData!.dob.toString() == 'null'
                ? ''
                : Utility.DatefomatToYYYYMMTOMMDD(
                    accountSettingResponse.data!.userData!.dob!.toString(),
                  );

        accountTypeController.text = accountSettingResponse
                    .data!.userData!.accountType
                    .toString() ==
                'null'
            ? ''
            : accountSettingResponse.data!.userData!.accountType!.toString();
        documentTypeController.text = accountSettingResponse
                    .data!.userData!.identificationType
                    .toString() ==
                'null'
            ? ''
            : accountSettingResponse.data!.userData!.identificationType!
                .toString();
        idNumberController.text = accountSettingResponse
            .data!.userData!.identificationNumber!
            .toString();
        addressController.text =
            accountSettingResponse.data!.userData!.address!.toString();
        cityController.text =
            accountSettingResponse.data!.userData!.city!.toString();
        zipcodeController.text =
            accountSettingResponse.data!.userData!.zipcode!.toString();
        sourceofincomeController.text =
            accountSettingResponse.data!.userData!.sourceOfIncome!.toString();
      }

      CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {});
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.ProgressloadingDialog6(context, false);

      setState(() {});
    }
    return;
  }
}
