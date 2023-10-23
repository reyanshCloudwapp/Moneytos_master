import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/screens/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/screens/home/s_home/mobile_money_number_screen_serviceProvider/mobile_money_number_servicePro.dart';
import 'package:moneytos/utils/import_helper.dart';

class SelectServiceProviderScreen extends StatefulWidget {
  final bool isMfs;

  const SelectServiceProviderScreen({super.key, required this.isMfs});

  @override
  State<SelectServiceProviderScreen> createState() =>
      _SelectServiceProviderScreenState();
}

class _SelectServiceProviderScreenState
    extends State<SelectServiceProviderScreen> {
  ///Textfield contrller
  TextEditingController searchMobileCompanyController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.whiteColor,
            flexibleSpace: Column(
              children: [
                Container(
                  color: MyColors.color_03153B,
                  padding: const EdgeInsets.only(top: 60, left: 22, right: 22),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop(false);
                            },
                            child: SvgPicture.asset(
                              'assets/images/leftarrow.svg',
                              height: 32,
                              width: 32,
                            ),
                          ),
                          const Center(
                            child: Text(
                              MyString.Select_Service_Provider,
                              style: TextStyle(
                                color: MyColors.whiteColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                              ),
                            ),
                          ),
                          Container(
                            width: 20,
                          )
                        ],
                      ),
                      hSizedBox3,
                    ],
                  ),
                ),
                Container(
                  color: MyColors.color_03153B,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 45,
                      left: 22,
                      right: 22,
                    ),
                    decoration: const BoxDecoration(
                      color: MyColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    // padding:  EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        searchStore(),
                      ],
                    ),
                    //CustomTextFields(controller: searchController, focus: searchFocus, textInputAction: TextInputAction.done, keyboardtype: TextInputType.text,border_color: MyColors.whiteColor.withOpacity(0.05),hinttext: MyString.search_bank,),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: MyColors.whiteColor,
        bottomSheet: Container(
          margin: const EdgeInsets.only(bottom: 30),
          color: MyColors.whiteColor,
          height: 60,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              //   Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              height: 50,
              width: 100,
              color: MyColors.whiteColor,
              child: CustomButton(
                btnname: MyString.back,
                textcolor: MyColors.lightblueColor,
                bordercolor: MyColors.lightblueColor.withOpacity(0.08),
                bg_color: MyColors.lightblueColor.withOpacity(0.14),
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: MyColors.whiteColor,
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
            SizedBox(
              // margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: MyColors.whiteColor,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 80.0),
                        child: GridView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 0.60,
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
                                        MobileMoneypinServicePro(
                                      isMfs: widget.isMfs,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 10,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 5,
                                ),
                                child: const CustomSelectBankList(
                                  title: MyString.Company_name,
                                  img: 'assets/images/companyimg.png',
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  searchStore() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: MyColors.blueColor.withOpacity(0.02),
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: searchFocus,
        controller: searchMobileCompanyController,
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
          hintText: MyString.Search_Mobile_Company,
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.30),
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
