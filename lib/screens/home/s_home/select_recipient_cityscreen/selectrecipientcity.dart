import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/screens/home/s_home/selectdeliverymethod/selectdeliverymethod.dart';
import 'package:moneytos/utils/import_helper.dart';

class SelectRecipientCity extends StatefulWidget {
  const SelectRecipientCity({super.key});

  @override
  State<SelectRecipientCity> createState() => _SelectRecipientCityState();
}

class _SelectRecipientCityState extends State<SelectRecipientCity> {
  TextEditingController searchcountryController = TextEditingController();

  FocusNode searchFocus = FocusNode();

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
        preferredSize: const Size.fromHeight(240),
        child: AppBar(
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          centerTitle: true,
          actions: const [],
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 65, left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.Select_Recipient_City,
                    style: TextStyle(
                      color: MyColors.color_text,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                    ),
                  ),
                ),
                hSizedBox4,
                Container(
                  width: double.infinity,
                  height: 50,
                  // margin:  EdgeInsets.fromLTRB(12.0, 26.0, 0.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 0, 20.0, 0.0),
                  decoration: const BoxDecoration(
                    color: MyColors.whiteColor,
                    //border: Border.all(color: MyColors.color_gray_transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.color_linecolor,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/flag2.svg',
                            width: 26,
                            height: 26,
                          ),
                          wSizedBox1,
                          const Text(
                            MyString.country_name,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_medium.ttf',
                              fontWeight: FontWeight.w500,
                              color: MyColors.color_text,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                        child: SvgPicture.asset('assets/icons/clear_red.svg'),
                      ),
                    ],
                  ),
                ),
                hSizedBox2,
                Container(
                  child: searchCity(),
                  //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
                ), //
              ],
            ),
          ),
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
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 0.40,
                      crossAxisSpacing: 1.1,
                      mainAxisSpacing: 0.3,
                    ),
                    children: CustomList.countrylist.map((String url) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SelectDeliveryMethodScreen(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(
                              color: MyColors.color_text.withOpacity(0.2),
                              width: 1.0,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 5,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          child: const Center(
                            child: Text(
                              MyString.city_name,
                              style: TextStyle(
                                color: MyColors.color_text,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  hSizedBox5,
                  hSizedBox4,
                  hSizedBox4,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchCity() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: MyColors.blueColor.withOpacity(0.02),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: TextField(
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
          enabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.lightblueColor),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: MyString.Search_City,
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.30),
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
