import 'package:moneytos/utils/import_helper.dart';

class EditRecipientScreen extends StatefulWidget {
  const EditRecipientScreen({Key? key}) : super(key: key);

  @override
  State<EditRecipientScreen> createState() => _EditRecipientScreenState();
}

class _EditRecipientScreenState extends State<EditRecipientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: AppBar(
          backgroundColor: MyColors.whiteColor,
          elevation: 0,
          centerTitle: true,
          title: Container(
            padding: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: const Text(
              MyString.edit_recipient,
              style: TextStyle(
                fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
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
              onTap: () {
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
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
              },
              child: Container(
                height: 50,
                width: 120,
                color: MyColors.whiteColor,
                //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
                child: CustomButton2(
                  btnname: 'Save',
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
              decoration: const BoxDecoration(
                color: MyColors.whiteColor,
                // border: Border.all(color: MyColors.lightblueColor),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  hSizedBox4,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      // controller: FullName,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                      decoration: InputDecoration(
                        hintText: MyString.country_name,
                        border: InputBorder.none,
                        fillColor: MyColors.whiteColor,
                        contentPadding: const EdgeInsets.all(22),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            'assets/icons/clear_red.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            'assets/icons/au_australia.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        hintStyle: const TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                          letterSpacing: 0.3,
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
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                // controller: FullName,
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                ),
                decoration: InputDecoration(
                  hintText: MyString.city_name,
                  border: InputBorder.none,
                  fillColor: MyColors.whiteColor,
                  contentPadding: const EdgeInsets.all(22),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      'assets/icons/clear_red.svg',
                      height: 20,
                      width: 20,
                    ),
                  ),
                  hintStyle: const TextStyle(
                    color: MyColors.blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                    letterSpacing: 0.3,
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
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: const TextField(
                      // controller: FullName,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                      decoration: InputDecoration(
                        hintText: MyString.first_name,
                        border: InputBorder.none,
                        fillColor: MyColors.whiteColor,
                        contentPadding: EdgeInsets.all(22),
                        hintStyle: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                          letterSpacing: 0.3,
                        ),
                        //border: InputBorder.none,
                      ),

                      keyboardType: TextInputType.emailAddress,

                      // Only numbers can be entered
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: const TextField(
                      // controller: FullName,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                      decoration: InputDecoration(
                        hintText: MyString.first_name,
                        border: InputBorder.none,
                        fillColor: MyColors.whiteColor,
                        contentPadding: EdgeInsets.all(22),
                        hintStyle: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                          letterSpacing: 0.3,
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
              margin: const EdgeInsets.only(left: 18.0, top: 30),
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: _onCountryChange,
                    // enabled: false,

                    initialSelection: 'CA',
                    // favorite: ['+91','IN'],
                    showCountryOnly: false,
                    textStyle: const TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      fontSize: 16,
                    ),
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    showFlag: false,
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: const TextField(
                      // controller: FullName,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
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

  String slectedcountrCode = '+1';
  Future<void> _onCountryChange(CountryCode countryCode) async {
    //TODO : manipulate the selected country code here
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    slectedcountrCode = countryCode.toString();
    debugPrint('New Country selected:>>>>$slectedcountrCode');
    debugPrint('Country ISO code :>>>>${countryCode.code}');
    debugPrint('Country name code :>>>>${countryCode.name}');
    debugPrint('Country dialCode code :>>>>${countryCode.dialCode}');
    sharedPreferences.setString('CountryISOCode', countryCode.code.toString());
    setState(() {});
  }
}
