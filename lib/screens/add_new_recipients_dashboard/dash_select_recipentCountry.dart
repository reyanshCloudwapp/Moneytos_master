import 'package:moneytos/screens/customScreens/CustomSelectCountryList.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/SelectCountryListResponse.dart';
import 'package:moneytos/utils/import_helper.dart';

import 'dashaddrecipientinfoscreen.dart';

class DashSelectRecipentCountry extends StatefulWidget {
  const DashSelectRecipentCountry({Key? key}) : super(key: key);

  @override
  State<DashSelectRecipentCountry> createState() =>
      _DashSelectRecipentCountryScreenState();
}

class _DashSelectRecipentCountryScreenState
    extends State<DashSelectRecipentCountry> {
  SelectCountryListResponse selectCountryListResponse =
      SelectCountryListResponse();
  List<SelectCountryList> selectCountryList = <SelectCountryList>[];

  ///Textfield contrller
  TextEditingController searchcountryController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => selectCountryListApi(context));

    setState(() {});
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
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          flexibleSpace: Container(
            padding: const EdgeInsets.only(left: 20, top: 60, right: 20),
            child: Column(
              children: [
                const Text(
                  MyString.Select_Recipient_Country,
                  style: TextStyle(
                    color: MyColors.color_text,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                    fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                  ),
                ),
                hSizedBox4,
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  //  padding:  EdgeInsets.symmetric(horizontal: 20.0),
                  child: searchCountry(),
                  //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
                ),
              ],
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          actions: [
            Container(
              width: 50,
            )
          ],
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          // Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
        },
        child: Container(
          height: 100,
          color: MyColors.whiteColor,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 2.7,
            vertical: 25,
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: CustomButton(
            btnname: MyString.cancel,
            textcolor: MyColors.lightblueColor,
            bordercolor: MyColors.lightblueColor.withOpacity(0.08),
            bg_color: MyColors.lightblueColor.withOpacity(0.14),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //hSizedBox1,
              isLoad == true
                  ? Utility.shrimmerCountryGridLoader(80, 150)
                  : GridView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 0.50,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 0.5,
                      ),
                      children:
                          List.generate(selectCountryList.length, (index) {
                        return GestureDetector(
                          onTap: () async {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashSelectDeliveryMethodScreen()));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DashAddRecipientInfoScreen(),
                              ),
                            );

                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString(
                              'country_Name',
                              selectCountryList[index].name.toString(),
                            );
                            sharedPreferences.setString(
                              'country_Flag',
                              selectCountryList[index].emoji.toString(),
                            );
                            sharedPreferences.setString(
                              'iso3',
                              selectCountryList[index].iso3.toString(),
                            );
                            sharedPreferences.setString(
                              'country_isoCode3',
                              selectCountryList[index].iso3.toString(),
                            );
                            sharedPreferences.setString(
                              'country_Currency_isoCode3',
                              selectCountryList[index].currency.toString(),
                            );
                            sharedPreferences.setString(
                              'phonecode',
                              selectCountryList[index].phonecode.toString(),
                            );
                            sharedPreferences.setString(
                              'phonenumber_min_max_validation',
                              selectCountryList[index]
                                  .phonumberMinMaxValidation
                                  .toString(),
                            );
                            sharedPreferences.setString(
                              'partnerPaymentMethod',
                              selectCountryList[index]
                                  .partnerPaymentMethod
                                  .toString(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 5,
                            ),
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            child: CustomSelectCountryList(
                              title: selectCountryList[index].name.toString(),
                              img: selectCountryList[index].emoji.toString(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

              hSizedBox6,
            ],
          ),
        ),
      ),
    );
  }

  searchCountry() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: MyColors.blueColor.withOpacity(0.02),
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: TextField(
        onChanged: (value) => _searchCountryFilter(value),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: searchFocus,
        controller: searchcountryController,
        cursorColor: MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          hintText: MyString.select_country,
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.30),
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Future<void> selectCountryListApi(
    BuildContext context,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    setState(() {
      isLoad = true;
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
      selectCountryListResponse =
          SelectCountryListResponse.fromJson(jsonResponse);

      for (int i = 0; i < selectCountryListResponse.data!.length; i++) {
        selectCountryList.add(selectCountryListResponse.data![i]);
      }

      // Utility.ProgressloadingDialog(context, false);
      isLoad = false;
      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);
      isLoad = false;
      selectCountryListResponse =
          SelectCountryListResponse.fromJson(jsonResponse);
      setState(() {});
    }

    return;
  }

  void _searchCountryFilter(String enteredKeyword) {
    setState(() {
      List<SelectCountryList> results = <SelectCountryList>[];
      debugPrint('enteredKeyword>>> $enteredKeyword');

      if (enteredKeyword.isEmpty) {
        // if the search field is empty or only contains white-space, we'll display all users
        results = selectCountryListResponse.data!;
      } else {
        results = selectCountryList
            .where(
              (user) => user.name
                  .toString()
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()),
            )
            .toList();
        // we use the toLowerCase() method to make it case-insensitive
      }

      // Refresh the UI
      setState(() {
        selectCountryList = results;
      });
    });
  }
}
