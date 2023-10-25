import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:moneytos/screens/add_new_recipients_dashboard/dash_select_recipentCountry.dart';
import 'package:moneytos/screens/recipients_opened_sscreen/recipients_opened_screens.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/LatestTransferResponse.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../mfs_select_payment_method.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';
import 'Editrecipientinfoscreen.dart';

class RecipentScreen extends StatefulWidget {
  final VoidCallback backToHome;

  const RecipentScreen({Key? key, required this.backToHome}) : super(key: key);

  @override
  State<RecipentScreen> createState() => _RecipentScreenState();
}

class _RecipentScreenState extends State<RecipentScreen> {
  bool _enabled = true;
  bool _enabled2 = true;

  bool is_search = false;
  bool is_fav = false;

  TextEditingController searchController = TextEditingController();

  String doucument_status = '';
  bool state_verified = false;

  /// FocusNode
  FocusNode searchFocusNode = FocusNode();
  AllAddedRecipientsListResponse addedRecipientsListResponse =
      AllAddedRecipientsListResponse();
  List<Recipientlist> _searchResult = [];
  List<Recipientlist> _recipientResult = [];
  LatestTransferResponse latestTransferResponse = LatestTransferResponse();
  List<TxnSubData> latesttransferList = [];
  bool is_sort = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocusNode.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        prefData(),
        addedAllRecipientsApi(context),
        latesttransferApi(context),
      ]);
    });
    super.initState();

    // prefData();
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => addedAllRecipientsApi(context));
    // latesttransferApi(context);
  }

  Future prefData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    state_verified = sharedPreferences.getBool('state_verified')!;
    doucument_status = sharedPreferences.getString('document_status')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 146,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.whiteColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.whiteColor,
          statusBarIconBrightness: Brightness.dark,
          // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     widget.backToHome();
            //   },
            //   child: const Icon(
            //     Icons.arrow_back_ios_new,
            //     color: MyColors.color_1D2D5F,
            //   ),
            // ),
            // const SizedBox(
            //   height: 26,
            // ),
            Row(
              children: [
                const Text(
                  'Recipients',
                  style: TextStyle(
                    color: MyColors.color_1D2D5F,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                    fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: const DashSelectRecipentCountry(),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.5),
                      color: MyColors
                          .color_BC1B53, // Change the color to your desired color
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/add_user_new.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Add Recipient',
                          style: TextStyle(
                            color: MyColors.whiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily:
                                'assets/fonts/raleway/raleway_semibold.ttf',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) => _searchFilter(value),
                      focusNode: searchFocusNode,

                      textInputAction: TextInputAction.done,
                      style: const TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Name/Mobile',
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/images/ic_search_new.svg',
                          ),
                          iconSize: 20,
                        ),
                        suffixIcon: searchFocusNode.hasFocus
                            ? GestureDetector(
                                onTap: () {
                                  is_search = false;
                                  searchController.clear();
                                  FocusScope.of(context).unfocus();
                                  _searchResult = _recipientResult;
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: MyColors.primaryColor,
                                ),
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: MyColors.color_EBF0FA,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: MyColors.color_EBF0FA,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: MyColors.color_EBF0FA,
                            width: 1,
                          ),
                        ),
                        fillColor: MyColors.whiteColor,
                        contentPadding: const EdgeInsets.all(15),
                        hintStyle: const TextStyle(
                          color: MyColors.color_93999C,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'assets/fonts/raleway/Raleway-Medium.ttf',
                          letterSpacing: 0.1,
                        ),
                        //border: InputBorder.none,
                      ),

                      keyboardType: TextInputType.text,

                      // Only numbers can be entered
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  onPressed: () {
                    debugPrint('is_sort>>>> $is_sort');
                    if (is_sort) {
                      is_sort = false;
                      _searchResult.sort((a, b) {
                        return a.firstName.toString().toLowerCase().compareTo(
                              b.firstName.toString().toLowerCase(),
                            );
                      });
                    } else {
                      is_sort = true;
                      _searchResult.sort((b, a) {
                        return a.firstName.toString().toLowerCase().compareTo(
                              b.firstName.toString().toLowerCase(),
                            );
                      });
                    }

                    setState(() {});
                  },
                  icon: SvgPicture.asset('assets/images/ic_sorting.svg'),
                )
              ],
            ),
          ],
        ),
        /*  actions: [
          Container(
            padding: EdgeInsets.only(top: 5,right: 20),
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              "assets/icons/notification.svg",
              height: 30,
              width: 30,
            ),
          ),
        ],*/
      ),
      body: _enabled2 == true
          ? Utility.shrimmerVerticalListLoader(
              100,
              MediaQuery.of(context).size.width,
            )
          : SingleChildScrollView(
              child: Container(
                color: MyColors.whiteColor,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    addedRecipientsListResponse.status == true
                        ? ListView.builder(
                            itemCount: _searchResult.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, int index) {
                              return Slidable(
                                // Specify a key if the Slidable is dismissible.
                                key: const ValueKey(0),

                                //  The end action pane is the one at the right or the bottom side.
                                endActionPane: ActionPane(
                                  extentRatio: 0.3,
                                  // closeThreshold: 20.0,
                                  motion: const ScrollMotion(),
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        debugPrint('edit >>>>>>> ');
                                        pushNewScreen(
                                          context,
                                          screen: EditRecipientInfoScreen(
                                            recipient_id: _searchResult[index]
                                                .id
                                                .toString(),
                                            recipientlist: _searchResult[index],
                                          ),
                                          withNavBar: false,
                                        );
                                      },
                                      child: Container(
                                        width: 48,
                                        margin: const EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          color: MyColors.blackColor
                                              .withOpacity(0.10),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/icons/edit.svg',
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        debugPrint('delete >>>>>>> ');

                                        dialogDelete(
                                          context,
                                          _searchResult[index]
                                              .recipientId
                                              .toString(),
                                          _searchResult[index].id.toString(),
                                        );

                                        // DeleteRecipientFieldRequest(context, _searchResult[index].recipientId.toString());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.zero,
                                        width: 48,
                                        //    height: 100,
                                        decoration: BoxDecoration(
                                          color: MyColors.red.withOpacity(0.90),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/icons/delete.svg',
                                            color: MyColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // The child of the Slidable is what the user sees when the
                                // component is not dragged.
                                child: GestureDetector(
                                  onTap: () async {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString(
                                      'recpi_id',
                                      _searchResult[index].id.toString(),
                                    );
                                    sharedPreferences.setString(
                                      'country_Name',
                                      _searchResult[index]
                                          .countryName
                                          .toString(),
                                    );
                                    sharedPreferences.setString(
                                      'country_Flag',
                                      _searchResult[index]
                                          .countryEmoji
                                          .toString(),
                                    );
                                    sharedPreferences.setString(
                                      'iso3',
                                      _searchResult[index]
                                          .countryIso3Code
                                          .toString(),
                                    );
                                    sharedPreferences.setString(
                                      'country_isoCode3',
                                      _searchResult[index]
                                          .countryIso3Code
                                          .toString(),
                                    );
                                    sharedPreferences.setString(
                                      'country_Currency_isoCode3',
                                      _searchResult[index]
                                          .currencyIso3Code
                                          .toString(),
                                    );
                                    sharedPreferences.setString(
                                      'phonecode',
                                      _searchResult[index].phonecode.toString(),
                                    );
                                    sharedPreferences.setString(
                                      'recipientId',
                                      _searchResult[index].id.toString(),
                                    );
                                    sharedPreferences.setString(
                                      'senderId',
                                      '23cab527-e802-4e49-8cc1-78e5c5c8e8df',
                                    );
                                    sharedPreferences.setString(
                                      'firstName',
                                      _searchResult[index].firstName.toString(),
                                    );
                                    sharedPreferences.setString(
                                      'lastname',
                                      _searchResult[index].lastName.toString(),
                                    );
                                    sharedPreferences.setString(
                                      'u_first_name',
                                      _searchResult[index].firstName.toString(),
                                    );
                                    sharedPreferences.setString(
                                      'u_last_name',
                                      _searchResult[index].lastName.toString(),
                                    );
                                    sharedPreferences.setString(
                                      'u_phone_number',
                                      _searchResult[index]
                                          .phoneNumber
                                          .toString(),
                                    );
                                    sharedPreferences.setString(
                                      'u_profile_img',
                                      _searchResult[index]
                                          .profileImage
                                          .toString(),
                                    );
                                    sharedPreferences.setString(
                                      'iso2',
                                      _searchResult[index]
                                          .countryIso2Code
                                          .toString(),
                                    );
                                    sharedPreferences.setString(
                                      'partnerPaymentMethod',
                                      _searchResult[index]
                                          .partnerPaymentMethod
                                          .toString(),
                                    );

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RecipientsOpenedScreen(
                                          recipient_id: _searchResult[index]
                                              .id
                                              .toString(),
                                          recipientlist: _searchResult[index],
                                        ),
                                      ),
                                    );
                                    // pushNewScreen(
                                    //   context,
                                    //   screen: DashSelectRecipientHomeDetailScreen(_searchResult[index].firstName.toString(),_searchResult[index].lastName.toString(),_searchResult[index].profileImage.toString(),_searchResult[index].countryIso3Code.toString(),_searchResult[index].phonecode.toString(),_searchResult[index].phoneNumber.toString(),_searchResult[index].countryName.toString(),_searchResult[index].recipientId.toString(),_searchResult[index].currencyIso3Code.toString()),
                                    //   withNavBar: false,
                                    // );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0,
                                    ),
                                    child: RecipentList(_searchResult[index]),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            // height: 10,
                            height: 120,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                              'No Data',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  onSearchTextChanged(String text) async {
    debugPrint('enter text>>>> $text');
    debugPrint('recipientlist text>>>> ${_recipientResult.length}');
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (var userDetail in _recipientResult) {
      debugPrint(userDetail.firstName.toString());
      if (userDetail.firstName
          .toString()
          .toLowerCase()
          .contains(text.toString().toLowerCase())) {
        _searchResult.add(userDetail);
      }
      setState(() {});
    }

    setState(() {});
  }

  void _searchFilter(String enteredKeyword) {
    List<Recipientlist> results = <Recipientlist>[];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _recipientResult;
    } else {
      results = _recipientResult
          .where(
            (user) =>
                ('${user.firstName} ${user.lastName} ${user.phonecode}${user.phoneNumber}')
                    .toString()
                    .toLowerCase()
                    .contains(enteredKeyword.toLowerCase()),
          )
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _searchResult = results;
    });
  }

  searchtextfield(
    TextEditingController controller,
    String hinttext,
    FocusNode focusNode,
    TextInputType textInputType,
    TextInputAction textInputAction,
  ) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: MyColors.lightblueColor.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        onChanged: (value) => _searchFilter(value),
        focusNode: focusNode,

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
          suffixIcon: GestureDetector(
            onTap: () {
              is_search = false;
              controller.clear();
              _searchResult = _recipientResult;
              setState(() {});
            },
            child: const Icon(CupertinoIcons.clear),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: MyColors.lightblueColor, width: 1),
          ),
          fillColor: MyColors.whiteColor,
          contentPadding: const EdgeInsets.all(22),

          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.50),
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            letterSpacing: 0.1,
          ),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  void doNothing(BuildContext context) {}

  Widget CustomCard2(TxnSubData txnsubdata) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: MyColors.lightblueColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FadeInImage(
                height: 156,
                width: 149,
                fit: BoxFit.fill,
                image: NetworkImage(
                  txnsubdata.profileImage.toString(),
                ),
                placeholder: const AssetImage('assets/logo/progress_image.png'),
                placeholderFit: BoxFit.scaleDown,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Text(
                    txnsubdata.recipientName.toString()[0].toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        hSizedBox1,

        ///Recipient name
        Container(
          width: 70,
          alignment: Alignment.topLeft,
          child: Text(
            txnsubdata.recipientName.toString(),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              color: MyColors.blackColor,
              fontSize: 13,
              letterSpacing: 0.1,
              overflow: TextOverflow.ellipsis,
              fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            ),
          ),
        ),
        hSizedBox,
      ],
    );
  }

  Widget RecipentList(Recipientlist recipientlist) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: MyColors.blackColor.withOpacity(.05),
              spreadRadius: 0,
              blurRadius: 30,
            )
          ],
        ),
        /*
        Card(
        elevation: 30,
        shadowColor: MyColors.blackColor.withOpacity(.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
          side: BorderSide(
            color: MyColors.blackColor.withOpacity(.1), // Set the border color
            width: 1.0, // Set the border width
          ),
        ),

         */
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
          child: Row(
            children: [
              CircleAvatar(
                radius: 19.5,
                backgroundColor: MyColors.lightblueColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FadeInImage(
                    height: 156,
                    width: 149,
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      recipientlist.profileImage.toString(),
                    ),
                    placeholder:
                        const AssetImage('assets/logo/progress_image.png'),
                    placeholderFit: BoxFit.scaleDown,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Text(
                        recipientlist.firstName.toString()[0].toUpperCase(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${recipientlist.firstName} ${recipientlist.lastName}',
                      style: const TextStyle(
                        color: MyColors.color_06366F,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      recipientlist.countryName.toString(),
                      style: const TextStyle(
                        color: MyColors.color_676F85,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'assets/fonts/raleway/raleway_regular.ttf',
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async {
                  !state_verified
                      ? Utility().stateDialog(context)
                      : doucument_status == 'Approved'
                          ? recipientlist.partnerPaymentMethod.toString() ==
                                  'nium'
                              ? pushNewScreen(
                                  context,
                                  screen: const SelectPaymentMethodScreen(
                                    isAlreadyRecipient: true,
                                    isMfs: false,
                                  ),
                                  // NewSelectRecipientHomeDetailScreen(
                                  //
                                  //     recipientlist.partnerPaymentMethod.toString() == 'mfs'
                                  //
                                  //
                                  // ),
                                  withNavBar: false,
                                )
                              : pushNewScreen(
                                  context,
                                  screen: SelectPaymentMethodScreen(
                                    isAlreadyRecipient: true,
                                    isMfs: recipientlist.partnerPaymentMethod
                                                .toString() ==
                                            'mfs'
                                        ? true
                                        : false,
                                  ),
                                  withNavBar: false,
                                )

                          // pushNewScreen(
                          //         context,
                          //         screen: NewSelectRecipientHomeDetailScreen(
                          //             recipientlist.firstName.toString(),
                          //             recipientlist.lastName.toString(),
                          //             recipientlist.profileImage.toString(),
                          //             recipientlist.countryIso3Code.toString(),
                          //             recipientlist.phonecode.toString(),
                          //             recipientlist.phoneNumber.toString(),
                          //             recipientlist.countryName.toString(),
                          //             recipientlist.recipientId.toString(),
                          //             recipientlist.currencyIso3Code.toString(),
                          //             recipientlist.countryEmoji.toString(),
                          //           recipientlist.partnerPaymentMethod.toString() == 'mfs'
                          //         ),
                          //         withNavBar: false,
                          //       )
                          : verifyDialog(context, '', doucument_status);

                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setString(
                    'recpi_id',
                    recipientlist.id.toString(),
                  );
                  sharedPreferences.setString(
                    'recpi_userId',
                    recipientlist.userId.toString(),
                  );
                  sharedPreferences.setString(
                    'recipientId',
                    recipientlist.recipientId.toString(),
                  );
                  sharedPreferences.setString(
                    'iso2',
                    recipientlist.countryIso2Code.toString(),
                  );
                  sharedPreferences.setString(
                    'currency',
                    recipientlist.currencyIso3Code.toString(),
                  );
                  sharedPreferences.setString(
                    'rec_address',
                    recipientlist.address.toString(),
                  );
                  sharedPreferences.setString(
                    'rec_city',
                    recipientlist.city.toString(),
                  );
                  sharedPreferences.setString(
                    'postcode',
                    recipientlist.postcode.toString(),
                  );
                  sharedPreferences.setString(
                    'relationship',
                    recipientlist.relationship.toString(),
                  );
                  sharedPreferences.setString(
                    'recipientReceiveBankOrMobileNo',
                    recipientlist.phonecode.toString() +
                        recipientlist.phoneNumber.toString(),
                  );

                  sharedPreferences.setString(
                    'country_Name',
                    recipientlist.countryName.toString(),
                  );
                  sharedPreferences.setString(
                    'country_Flag',
                    recipientlist.countryEmoji.toString(),
                  );
                  sharedPreferences.setString(
                    'iso3',
                    recipientlist.countryIso3Code.toString(),
                  );
                  sharedPreferences.setString(
                    'iso2',
                    recipientlist.countryIso2Code.toString(),
                  );
                  sharedPreferences.setString(
                    'country_isoCode3',
                    recipientlist.countryIso3Code.toString(),
                  );
                  sharedPreferences.setString(
                    'country_Currency_isoCode3',
                    recipientlist.currencyIso3Code.toString(),
                  );
                  sharedPreferences.setString(
                    'phonecode',
                    recipientlist.phonecode.toString(),
                  );
                  sharedPreferences.setString(
                    'phonenumber_min_max_validation',
                    '',
                  );
                  sharedPreferences.setString(
                    'currency',
                    recipientlist.currencyIso3Code.toString(),
                  );
                  sharedPreferences.setString(
                    'partnerPaymentMethod',
                    recipientlist.partnerPaymentMethod.toString(),
                  );
                  sharedPreferences.setString(
                    'recipientReceiveBankOrMobileNo',
                    recipientlist.phonecode.toString() +
                        recipientlist.phoneNumber.toString(),
                  );

                  sharedPreferences.setString(
                    'recipientId',
                    recipientlist.recipientId.toString(),
                  );
                  sharedPreferences.setString(
                    'senderId',
                    '23cab527-e802-4e49-8cc1-78e5c5c8e8df',
                  );
                  sharedPreferences.setString(
                    'firstName',
                    recipientlist.firstName.toString(),
                  );
                  sharedPreferences.setString(
                    'lastname',
                    recipientlist.lastName.toString(),
                  );
                  sharedPreferences.setString(
                    'u_first_name',
                    recipientlist.firstName.toString(),
                  );
                  sharedPreferences.setString(
                    'u_last_name',
                    recipientlist.lastName.toString(),
                  );
                  sharedPreferences.setString(
                    'u_phone_number',
                    recipientlist.phoneNumber.toString(),
                  );
                  sharedPreferences.setString(
                    'u_profile_img',
                    recipientlist.profileImage.toString(),
                  );
                },
                child: Container(
                  //width: 40,
                  margin: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset(
                    'assets/icons/send_blue.svg',
                    color: MyColors.light_primarycolor2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  verifyDialog(BuildContext context, String msg, String status) {
    String documentStatus = status;
    String actualStatus = status;
    documentStatus = documentStatus == 'pending'
        ? 'Incomplete'
        : documentStatus == 'completed'
            ? 'pending'
            : documentStatus;

    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset('assets/images/closesquare.svg'),
                ),
              ),
              documentStatus == 'Blank'
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Verification status : $documentStatus',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily:
                              'assets/fonts/raleway/raleway_regular.ttf',
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              actualStatus == 'expired' ||
                      actualStatus == 'Rejected' ||
                      actualStatus == 'declined'
                  ? Column(
                      children: [
                        const Text(
                          'Please re upload verification.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              MyColors.darkbtncolor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'If you want to update verification Click Here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              actualStatus == 'Blank'
                  ? Column(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              MyColors.darkbtncolor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'Verify Your Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              documentStatus == 'Incomplete'
                  ? Column(
                      children: [
                        const Text(
                          'Your Verification is incomplete , Please re upload verification.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                25.0,
                                12.0,
                                25.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              MyColors.darkbtncolor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            Navigator.of(context, rootNavigator: true);
                            pushNewScreen(
                              context,
                              screen: const LoginVerificatrionDetailScreen(),
                              withNavBar: false,
                            );
                          },
                          // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0)),
                          // color: MyColors.darkbtncolor,
                          child: const Text(
                            'If you want to update verification Click Here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
              documentStatus == 'pending'
                  ? const Column(
                      children: [
                        Text(
                          'We will notify you as soon as you’re approved.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Future<void> favouriteRecipientapi(
    BuildContext context,
    String recipientServerId,
  ) async {
    CustomLoader.progressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['recipient_server_id'] = recipientServerId;

    debugPrint('request $request');

    var response = await http.post(
      Uri.parse(Apiservices.favouriteRecipientapi),
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
      CustomLoader.progressloadingDialog6(context, false);
      Utility.showFlutterToast(jsonResponse['message']);
      WidgetsBinding.instance
          .addPostFrameCallback((_) => addedAllRecipientsApi(context));
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
      CustomLoader.progressloadingDialog6(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  Future<void> DeleteRecipientFieldRequest(
    BuildContext context,
    String recipientId,
    String recipientServerId,
  ) async {
    CustomLoader.progressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    // otpo
    debugPrint(
      "request URL>>>>>  ${"${Apiservices.addrecipientfield}/$recipientId"}",
    );
    debugPrint('request $request');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.delete(
      Uri.parse('${Apiservices.addrecipientfield}/$recipientId'),
      body: jsonEncode(request),
      headers: {
        'Authorization': 'Bearer ${p.getString('auth_Token')}',
        'content-type': 'application/json',
        'accept': 'application/json'
      },
    );
    debugPrint(response.body);

    if (response.statusCode == 200) {
      CustomLoader.progressloadingDialog6(context, false);
      // deleteRecipientapi(context,recipientServerId);
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast('Invalid Request');
      Navigator.of(context, rootNavigator: true).pop(context);
      CustomLoader.progressloadingDialog6(context, false);
      // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  Future<void> deleteRecipientapi(
    BuildContext context,
    String recipientServerId,
  ) async {
    CustomLoader.progressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['recipient_server_id'] = recipientServerId;

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );
    var response = await http.post(
      Uri.parse(Apiservices.deleteRecipientapi),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${p.getString("auth")}",
        'X-USERID': "${p.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );
    debugPrint(response.body);

    if (response.statusCode == 200) {
      Utility.showFlutterToast('Delete Successfully');
      Navigator.of(context, rootNavigator: true).pop(context);
      CustomLoader.progressloadingDialog6(context, false);

      WidgetsBinding.instance
          .addPostFrameCallback((_) => addedAllRecipientsApi(context));
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      Utility.showFlutterToast('Invalid Request');
      // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  Future<void> addedAllRecipientsApi(
    BuildContext context,
  ) async {
    // CustomLoader.ProgressloadingDialog6(context, true);
    // Utility.ProgressloadingDialog(context, true);
    _enabled2 = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
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
      Uri.parse(
        is_fav
            ? Apiservices.favouriteRecipientListapi
            : AllApiService.all_RecipintList_URl,
      ),
      body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    // CustomLoader.ProgressloadingDialog6(context, false);
    if (jsonResponse['status'] == true) {
      addedRecipientsListResponse =
          AllAddedRecipientsListResponse.fromJson(jsonResponse);

      _recipientResult = addedRecipientsListResponse.data!.recipientlist!;
      _searchResult = addedRecipientsListResponse.data!.recipientlist!;

      _enabled2 = false;
      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);
      // addedRecipientsListResponse  = await AllAddedRecipientsListResponse.fromJson(jsonResponse);
      // _searchResult = addedRecipientsListResponse.data!.recipientlist!;
      _enabled2 = false;
      _recipientResult.clear();
      setState(() {});
    }
    return;
  }

  dialogDelete(
    BuildContext context,
    String recipientId,
    String recipientServerId,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Are you sure, you want to Delete?',
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                      25.0,
                                      12.0,
                                      25.0,
                                      12.0,
                                    ),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColors.darkbtncolor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  // Navigator.pop(context);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(context);
                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                /* shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),*/
                                //  color: MyColors.darkbtncolor,
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_regular.ttf',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(
                                      25.0,
                                      12.0,
                                      25.0,
                                      12.0,
                                    ),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColors.darkbtncolor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  // DeleteRequest(context, payment_method_id);
                                  // DeleteRecipientFieldRequest(context, recipientId,recipientServerId);
                                  deleteRecipientapi(
                                    context,
                                    recipientServerId,
                                  );

                                  setState(() {});
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: MyColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_regular.ttf',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> latesttransferApi(
    BuildContext context,
  ) async {
    _enabled = true;
    // Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
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
      Uri.parse(AllApiService.recentRecipientByTxnapi),
      // body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      latestTransferResponse = LatestTransferResponse.fromJson(jsonResponse);
      latesttransferList = latestTransferResponse.data!.txnData!.data!;
      _enabled = false;
      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      _enabled = false;
      // Utility.ProgressloadingDialog(context, false);

      latestTransferResponse = LatestTransferResponse.fromJson(jsonResponse);
      setState(() {});
    }
    return;
  }
}

// old working code

/*
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytos/constance/myColors/my_color.dart';
import 'package:moneytos/constance/myStrings/my_string.dart';
import 'package:moneytos/constance/sizedbox/sized_box.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/view/recipients_opened_sscreen/recipients_opened_screens.dart';
import 'package:moneytos/view/resonforsendingscreen/reasonforsendingscreen.dart';
import 'package:moneytos/view/select_recipent_contry/select_recipentCountry.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../add_new_recipients_dashboard/dash_select_recipentCountry.dart';
import '../../constance/customLoader/custom_loader.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/S_ApiResponse/AllAddedRecipientsListResponse.dart';
import '../../s_Api/S_ApiResponse/LatestTransferResponse.dart';
import '../../s_Api/s_utils/Utility.dart';
import 'dart:convert' as convert;

import '../../services/Apiservices.dart';
import '../home/New_selectRecipientIdemDetailPage.dart';
import '../mfs_select_payment_method.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';
import 'Editrecipientinfoscreen.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RecipentScreen extends StatefulWidget {
  RecipentScreen({Key? key}) : super(key: key);

  @override
  State<RecipentScreen> createState() => _RecipentScreenState();
}

class _RecipentScreenState extends State<RecipentScreen> {
  bool _enabled = true;
  bool _enabled2 = true;

  bool is_search = false;
  bool is_fav = false;

  TextEditingController searchController = TextEditingController();

  String doucument_status = "";
  bool state_verified = false;
  /// FocusNode
  FocusNode searchFocusNode = FocusNode();
  AllAddedRecipientsListResponse addedRecipientsListResponse =
      AllAddedRecipientsListResponse();
  List<Recipientlist> _searchResult = [];
  List<Recipientlist> _recipientResult = [];
  LatestTransferResponse latestTransferResponse = new LatestTransferResponse();
  List<TxnSubData> latesttransferList = [];
  bool is_sort = true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocusNode.unfocus();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefData();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => addedAllRecipientsApi(context));
    latesttransferApi(context);
  }

  prefData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    state_verified = sharedPreferences.getBool("state_verified")!;
    doucument_status = sharedPreferences.getString("document_status")!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          flexibleSpace: Container(
            child: Column(
              children: [
                hSizedBox4,
                hSizedBox3,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.recipients,
                    style: TextStyle(
                      color: MyColors.whiteColor.withOpacity(0.86),
                      fontSize: 25,
                      fontFamily: "assets/fonts/raleway/raleway_extrabold.ttf",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                hSizedBox1,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.select_from_recipent_below,
                    style: TextStyle(
                        color: MyColors.whiteColor.withOpacity(0.60),
                        fontSize: 13.50,
                        fontFamily: "assets/fonts/raleway/raleway_medium.ttf"),
                  ),
                ),
                hSizedBox2,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.or,
                    style: TextStyle(
                        color: MyColors.whiteColor.withOpacity(0.86),
                        fontSize: 18,
                        fontFamily:
                            "assets/fonts/raleway/raleway_extrabold.ttf"),
                  ),
                ),
                hSizedBox3,
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: DashSelectRecipentCountry(),
                      withNavBar: false,
                    );
                  },
                  child: Container(
                    width: 210,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          //  stops: [0.0, 1.0],
                          colors: [
                            MyColors.lightblueColor.withOpacity(0.85),
                            MyColors.lightblueColor.withOpacity(0.90),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/add_user.svg",
                          height: 14,
                          width: 14,
                          color: MyColors.whiteColor.withOpacity(0.85),
                        ),
                        wSizedBox1,
                        Text(MyString.add_new_recipent,
                            style: TextStyle(
                                color: MyColors.whiteColor.withOpacity(0.85),
                                fontSize: 14,
                                fontFamily:
                                    "assets/fonts/raleway/raleway_medium.ttf")),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.light_primarycolor2,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          /*  actions: [
            Container(
              padding: EdgeInsets.only(top: 5,right: 20),
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                "assets/icons/notification.svg",
                height: 30,
                width: 30,
              ),
            ),
          ],*/
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.5,
            decoration: BoxDecoration(
              color: MyColors.light_primarycolor2,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: MyColors.whiteColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hSizedBox3,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.recent_recipent,
                    style: TextStyle(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.50,
                        letterSpacing: 0.3,
                        fontFamily: "assets/fonts/raleway/raleway_bold.ttf"),
                  ),
                ),

                hSizedBox2,
                _enabled == true
                    ? Utility.shrimmerHorizontalListCircularLoader(120, 100)
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35,
                        ),
                        child: latestTransferResponse.status == true
                            ? latestTransferResponse
                                    .data!.txnData!.data!.isEmpty
                                ? Container(
                                    // height: 10,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: latesttransferList
                                          .map((TxnSubData txnsubdata) {
                                        return GestureDetector(
                                          onTap: () async {
                                            Recipientlist recipientdata =
                                                new Recipientlist();
                                            recipientdata.id =
                                                int.parse(txnsubdata.recipientId.toString());
                                            recipientdata.recipientId =
                                                txnsubdata.recipientId;
                                            recipientdata.firstName = txnsubdata
                                                .recipientName
                                                .toString()
                                                .split(" ")[0]
                                                .toString()
                                                .trim();
                                            try {
                                              recipientdata.lastName =
                                                  txnsubdata.recipientName
                                                      .toString()
                                                      .split(" ")[1]
                                                      .toString()
                                                      .trim();
                                            } catch (ex) {
                                              recipientdata.lastName = "";
                                            }

                                            recipientdata.countryIso3Code =
                                                txnsubdata.countryIso3Code;
                                            recipientdata.phonecode =
                                                txnsubdata.phonecode;
                                            recipientdata.phoneNumber =
                                                txnsubdata.phoneNumber;
                                            recipientdata.countryName =
                                                txnsubdata.countryName;
                                            recipientdata.profileImage =
                                                txnsubdata.profileImage;
                                            recipientdata.countryEmoji =
                                                txnsubdata.countryEmoji;
                                            recipientdata.currencyIso3Code =
                                                txnsubdata.receivingCurrency;
                                            recipientdata.partnerPaymentMethod =
                                                txnsubdata.partnerPaymentMethod;
                                            recipientdata.countryIso2Code =
                                                txnsubdata.countryIso2Code;

                                            SharedPreferences
                                                sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            sharedPreferences.setString(
                                                "recpi_id",
                                                txnsubdata.recipientId
                                                    .toString());
                                            sharedPreferences.setString(
                                                "country_Name",
                                                txnsubdata.countryName
                                                    .toString());
                                            sharedPreferences.setString(
                                                "country_Flag",
                                                txnsubdata.countryEmoji
                                                    .toString());
                                            sharedPreferences.setString(
                                                "iso3",
                                                txnsubdata.countryIso3Code
                                                    .toString());
                                            sharedPreferences.setString(
                                                "country_isoCode3",
                                                txnsubdata.countryIso3Code
                                                    .toString());
                                            sharedPreferences.setString(
                                                "country_Currency_isoCode3",
                                                txnsubdata.receivingCurrency
                                                    .toString());
                                            sharedPreferences.setString(
                                                "phonecode",
                                                txnsubdata.phonecode
                                                    .toString());
                                            sharedPreferences.setString(
                                                "recipientId",
                                                txnsubdata.id.toString());
                                            sharedPreferences.setString(
                                                "senderId",
                                                "23cab527-e802-4e49-8cc1-78e5c5c8e8df");
                                            sharedPreferences.setString(
                                                "firstName",
                                                txnsubdata.recipientName
                                                    .toString());
                                            sharedPreferences.setString(
                                                "lastname", "");
                                            sharedPreferences.setString(
                                                "u_first_name",
                                                txnsubdata.recipientName
                                                    .toString());
                                            sharedPreferences.setString(
                                                "u_last_name", "");
                                            sharedPreferences.setString(
                                                "u_phone_number",
                                                txnsubdata.phoneNumber
                                                    .toString());
                                            sharedPreferences.setString(
                                                "u_profile_img",
                                                txnsubdata.profileImage
                                                    .toString());
                                            sharedPreferences.setString(
                                                "iso2",
                                                txnsubdata.countryIso2Code.toString());
                                            sharedPreferences.setString(
                                                "partnerPaymentMethod",
                                                txnsubdata.partnerPaymentMethod.toString());
                                            // sharedPreferences.setString(
                                            //     "iso2",
                                            //     txnsubdata.countryIso2Code
                                            //         .toString());
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        RecipientsOpenedScreen(
                                                          recipient_id:
                                                              recipientdata
                                                                  .recipientId
                                                                  .toString(),
                                                          recipientlist:
                                                              recipientdata,
                                                        )));
                                          },
                                          child: CustomCard2(txnsubdata),
                                        );
                                      }).toList(),
                                    ),
                                  )
                            : Container(
                                // height: 10,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 20),
                                child: Text(
                                  "No Data",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                      ),

                // hSizedBox,
                ///Recent Recipients
                ///
                Container(
                  padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: MyColors.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: is_search == true
                      ? searchtextfield(
                          searchController,
                          "search here..",
                          searchFocusNode,
                          TextInputType.text,
                          TextInputAction.done)
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  MyString.all_recipent,
                                  style: TextStyle(
                                      color: MyColors.blackColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.50,
                                      letterSpacing: 0.5),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              is_fav = is_fav ? false : true;
                                              _recipientResult.clear();
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) =>
                                                      addedAllRecipientsApi(
                                                          context));
                                            });
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icons/recipent_icon/heart.svg",
                                            color: is_fav
                                                ? MyColors.primaryColor
                                                : MyColors.color_dee3e8,
                                          ))),
                                  wSizedBox2,
                                  InkWell(
                                      onTap: () {
                                        debugPrint("is_sort>>>> " +
                                            is_sort.toString());
                                        if (is_sort) {
                                          is_sort = false;
                                          _searchResult.sort((a, b) {
                                            return a.firstName
                                                .toString()
                                                .toLowerCase()
                                                .compareTo(b.firstName
                                                    .toString()
                                                    .toLowerCase());
                                          });
                                        } else {
                                          is_sort = true;
                                          // _searchResult.clear();
                                          // _recipientResult.clear();
                                          _searchResult.sort((b, a) {
                                            return a.firstName
                                                .toString()
                                                .toLowerCase()
                                                .compareTo(b.firstName
                                                    .toString()
                                                    .toLowerCase());
                                          });
                                        }

                                        setState(() {});
                                      },
                                      child: SvgPicture.asset(
                                        "assets/icons/recipent_icon/swap.svg",
                                        color: is_sort
                                            ? MyColors.btncolor
                                            : MyColors.blackColor,
                                      )),
                                  wSizedBox2,
                                  GestureDetector(
                                      onTap: () {
                                        is_search = true;
                                        setState(() {});
                                      },
                                      child: SvgPicture.asset(
                                          "assets/icons/recipent_icon/search.svg")),
                                ],
                              )
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // color: MyColors.whiteColor,
            ),
            child: _enabled2 == true
                ? Utility.shrimmerVerticalListLoader(
                    100, MediaQuery.of(context).size.width)
                : Container(
                    decoration: BoxDecoration(
                        color: MyColors.whiteColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          addedRecipientsListResponse.status == true
                              ? ListView.builder(
                                  itemCount: _searchResult.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, int index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: MyColors.blackColor
                                              .withOpacity(0.80)),
                                      child: Slidable(
                                        // Specify a key if the Slidable is dismissible.
                                        key: const ValueKey(0),

                                        //  The end action pane is the one at the right or the bottom side.
                                        endActionPane: ActionPane(
                                          extentRatio: 0.3,
                                          // closeThreshold: 20.0,
                                          motion: ScrollMotion(),
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                debugPrint("edit >>>>>>> ");
                                                pushNewScreen(
                                                  context,
                                                  screen:
                                                      EditRecipientInfoScreen(
                                                    recipient_id:
                                                        _searchResult[index]
                                                            .id
                                                            .toString(),
                                                    recipientlist:
                                                        _searchResult[index],
                                                  ),
                                                  withNavBar: false,
                                                );
                                              },
                                              child: Container(
                                                width: 48,
                                                decoration: BoxDecoration(
                                                    color: MyColors.blackColor
                                                        .withOpacity(0.10)),
                                                child: SvgPicture.asset(
                                                    "assets/icons/edit.svg"),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                debugPrint("delete >>>>>>> ");

                                                dialogDelete(
                                                    context,
                                                    _searchResult[index]
                                                        .recipientId
                                                        .toString(),
                                                    _searchResult[index]
                                                        .id
                                                        .toString());

                                                // DeleteRecipientFieldRequest(context, _searchResult[index].recipientId.toString());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.zero,
                                                width: 50,
                                                //    height: 100,
                                                decoration: BoxDecoration(
                                                  color: MyColors.red
                                                      .withOpacity(0.90),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                    child: SvgPicture.asset(
                                                  "assets/icons/delete.svg",
                                                  color: MyColors.whiteColor,
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // The child of the Slidable is what the user sees when the
                                        // component is not dragged.
                                        child: GestureDetector(
                                          onTap: () async {
                                            SharedPreferences
                                                sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            sharedPreferences.setString(
                                                "recpi_id",
                                                _searchResult[index]
                                                    .id
                                                    .toString());
                                            sharedPreferences.setString(
                                                "country_Name",
                                                _searchResult[index]
                                                    .countryName
                                                    .toString());
                                            sharedPreferences.setString(
                                                "country_Flag",
                                                _searchResult[index]
                                                    .countryEmoji
                                                    .toString());
                                            sharedPreferences.setString(
                                                "iso3",
                                                _searchResult[index]
                                                    .countryIso3Code
                                                    .toString());
                                            sharedPreferences.setString(
                                                "country_isoCode3",
                                                _searchResult[index]
                                                    .countryIso3Code
                                                    .toString());
                                            sharedPreferences.setString(
                                                "country_Currency_isoCode3",
                                                _searchResult[index]
                                                    .currencyIso3Code
                                                    .toString());
                                            sharedPreferences.setString(
                                                "phonecode",
                                                _searchResult[index]
                                                    .phonecode
                                                    .toString());
                                            sharedPreferences.setString(
                                                "recipientId",
                                                _searchResult[index]
                                                    .id
                                                    .toString());
                                            sharedPreferences.setString(
                                                "senderId",
                                                "23cab527-e802-4e49-8cc1-78e5c5c8e8df");
                                            sharedPreferences.setString(
                                                "firstName",
                                                _searchResult[index]
                                                    .firstName
                                                    .toString());
                                            sharedPreferences.setString(
                                                "lastname",
                                                _searchResult[index]
                                                    .lastName
                                                    .toString());
                                            sharedPreferences.setString(
                                                "u_first_name",
                                                _searchResult[index]
                                                    .firstName
                                                    .toString());
                                            sharedPreferences.setString(
                                                "u_last_name",
                                                _searchResult[index]
                                                    .lastName
                                                    .toString());
                                            sharedPreferences.setString(
                                                "u_phone_number",
                                                _searchResult[index]
                                                    .phoneNumber
                                                    .toString());
                                            sharedPreferences.setString(
                                                "u_profile_img",
                                                _searchResult[index]
                                                    .profileImage
                                                    .toString());
                                            sharedPreferences.setString(
                                                "iso2",
                                                _searchResult[index]
                                                    .countryIso2Code
                                                    .toString());
                                            sharedPreferences.setString(
                                                "partnerPaymentMethod",
                                                _searchResult[index].partnerPaymentMethod.toString());

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        RecipientsOpenedScreen(
                                                          recipient_id:
                                                              _searchResult[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                          recipientlist:
                                                              _searchResult[
                                                                  index],
                                                        )));
                                            // pushNewScreen(
                                            //   context,
                                            //   screen: DashSelectRecipientHomeDetailScreen(_searchResult[index].firstName.toString(),_searchResult[index].lastName.toString(),_searchResult[index].profileImage.toString(),_searchResult[index].countryIso3Code.toString(),_searchResult[index].phonecode.toString(),_searchResult[index].phoneNumber.toString(),_searchResult[index].countryName.toString(),_searchResult[index].recipientId.toString(),_searchResult[index].currencyIso3Code.toString()),
                                            //   withNavBar: false,
                                            // );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.0),
                                            child: RecipentList(
                                                _searchResult[index]),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                              : Container(
                                  // height: 10,
                                  height: 120,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "No Data",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                          hSizedBox6
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    debugPrint("enter text>>>> " + text);
    debugPrint("recipientlist text>>>> " + _recipientResult.length.toString());
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _recipientResult.forEach((userDetail) {
      debugPrint(userDetail.firstName.toString());
      if (userDetail.firstName
          .toString()
          .toLowerCase()
          .contains(text.toString().toLowerCase()))
        _searchResult.add(userDetail);
      setState(() {});
    });

    setState(() {});
  }

  void _searchFilter(String enteredKeyword) {
    List<Recipientlist> results = <Recipientlist>[];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _recipientResult;
    } else {
      results = _recipientResult
          .where((user) => user.firstName
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _searchResult = results;
    });
  }

  searchtextfield(
      TextEditingController controller,
      String hinttext,
      FocusNode focusNode,
      TextInputType textInputType,
      TextInputAction textInputAction) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: MyColors.lightblueColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        onChanged: (value) => _searchFilter(value),
        focusNode: focusNode,

        textInputAction: textInputAction,
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "assets/fonts/raleway/raleway_medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              is_search = false;
              controller.clear();
              _searchResult = _recipientResult;
              setState(() {});
            },
            child: Icon(CupertinoIcons.clear),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyColors.lightblueColor, width: 1)),
          fillColor: MyColors.whiteColor,
          contentPadding: EdgeInsets.all(22),

          hintStyle: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "assets/fonts/raleway/raleway_medium.ttf",
              letterSpacing: 0.1),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  void doNothing(BuildContext context) {}

  CustomCard2(TxnSubData txnsubdata) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: MyColors.lightblueColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FadeInImage(
                height: 156,
                width: 149,
                fit: BoxFit.fill,
                image: NetworkImage(
                  txnsubdata.profileImage.toString(),
                ),
                placeholder: AssetImage("assets/logo/progress_image.png"),
                placeholderFit: BoxFit.scaleDown,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Text(
                      txnsubdata.recipientName.toString()[0].toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: "assets/fonts/raleway/raleway_bold.ttf"));
                },
              ),
            ),
          ),
        ),
        hSizedBox1,

        ///Recipient name
        Container(
          width: 70,
          alignment: Alignment.topLeft,
          child: Text(
            txnsubdata.recipientName.toString(),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                color: MyColors.blackColor,
                fontSize: 13,
                letterSpacing: 0.1,
                overflow: TextOverflow.ellipsis,
                fontFamily: "assets/fonts/raleway/raleway_medium.ttf"),
          ),
        ),
        hSizedBox,
      ],
    );
  }

  RecipentList(Recipientlist recipientlist) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: MyColors.lightblueColor.withOpacity(0.05),
          ),
          height: 50,
          width: 50,

          //    backgroundImage: AssetImage("assets/logo/profile_img.png"),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: FadeInImage(
              height: 200,
              width: 200,
              fit: BoxFit.fill,
              image: NetworkImage(
                recipientlist.profileImage.toString(),
              ),
              placeholder: AssetImage("assets/logo/progress_image.png"),
              placeholderFit: BoxFit.scaleDown,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                    color: MyColors.divider_color,
                    alignment: Alignment.center,
                    child: Text(
                        recipientlist.firstName.toString()[0].toUpperCase(),
                        style: TextStyle(
                            color: MyColors.shedule_color,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                "assets/fonts/raleway/raleway_bold.ttf")));
              },
            ),
          ),
          // backgroundImage: NetworkImage(recipientList[index].profileImage.toString()),
        ),
        title: Text(
          recipientlist.firstName.toString() +
              " " +
              recipientlist.lastName.toString(),
          style: TextStyle(
              color: MyColors.blackColor,
              fontFamily: "assets/fonts/raleway/raleway_medium.ttf",
              fontSize: 13),
        ),
        subtitle: Text(
          "${recipientlist.totalAmount} USD",
          style: TextStyle(
              color: MyColors.blackColor.withOpacity(0.50),
              fontFamily: "assets/fonts/raleway/raleway_medium.ttf",
              fontSize: 12),
        ),
        trailing: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Container(
            alignment: Alignment.centerRight,
            width: 90,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    favouriteRecipientapi(context, recipientlist.id.toString());
                  },
                  child: Container(
                      // width: 40,
                      margin: EdgeInsets.only(left: 20),
                      child: SvgPicture.asset(
                        "assets/icons/recipent_icon/heart.svg",
                        color: recipientlist.isFavourite == "1"
                            ? MyColors.primaryColor
                            : MyColors.color_dee3e8,
                      )),
                ),
                InkWell(
                  onTap: () async {
                    !state_verified? Utility().stateDialog(context):
                    doucument_status == "Approved"
                        ?
                    recipientlist.partnerPaymentMethod.toString() == "nium"?

                    pushNewScreen(
                      context,
                      screen:
                      SelectPaymentMethodScreen(
                        isAlreadyRecipient: true,
                        isMfs: false,
                      ),
                      // NewSelectRecipientHomeDetailScreen(
                      //
                      //     recipientlist.partnerPaymentMethod.toString() == 'mfs'
                      //
                      //
                      // ),
                      withNavBar: false,
                    ):
                    pushNewScreen(
                      context,
                      screen:
                      SelectPaymentMethodScreen(
                        isAlreadyRecipient: true,
                        isMfs: true,
                      ),
                      withNavBar: false,
                    )


                    // pushNewScreen(
                    //         context,
                    //         screen: NewSelectRecipientHomeDetailScreen(
                    //             recipientlist.firstName.toString(),
                    //             recipientlist.lastName.toString(),
                    //             recipientlist.profileImage.toString(),
                    //             recipientlist.countryIso3Code.toString(),
                    //             recipientlist.phonecode.toString(),
                    //             recipientlist.phoneNumber.toString(),
                    //             recipientlist.countryName.toString(),
                    //             recipientlist.recipientId.toString(),
                    //             recipientlist.currencyIso3Code.toString(),
                    //             recipientlist.countryEmoji.toString(),
                    //           recipientlist.partnerPaymentMethod.toString() == 'mfs'
                    //         ),
                    //         withNavBar: false,
                    //       )
                        : verifyDialog(context, "", doucument_status);

                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences
                        .setString(
                        "recpi_id",
                        recipientlist
                            .id
                            .toString());
                    sharedPreferences
                        .setString(
                        "recpi_userId",
                        recipientlist
                            .userId
                            .toString());
                    sharedPreferences
                        .setString(
                        "recipientId",
                        recipientlist
                            .recipientId
                            .toString());
                    sharedPreferences.setString(
                        "iso2",
                        recipientlist
                            .countryIso2Code
                            .toString());
                    sharedPreferences.setString(
                        "currency",
                        recipientlist
                            .currencyIso3Code
                            .toString());
                    sharedPreferences
                        .setString(
                        "rec_address",
                        recipientlist
                            .address
                            .toString());
                    sharedPreferences
                        .setString(
                        "rec_city",
                        recipientlist
                            .city
                            .toString());
                    sharedPreferences
                        .setString(
                        "postcode",
                        recipientlist
                            .postcode
                            .toString());
                    sharedPreferences.setString(
                        "relationship",
                        recipientlist
                            .relationship
                            .toString());
                    sharedPreferences.setString("recipientReceiveBankOrMobileNo", recipientlist
                        .phonecode
                        .toString()+recipientlist
                        .phoneNumber
                        .toString());

                    sharedPreferences.setString("country_Name",
                        recipientlist.countryName.toString());
                    sharedPreferences.setString("country_Flag",
                        recipientlist.countryEmoji.toString());
                    sharedPreferences.setString("iso3",
                        recipientlist.countryIso3Code.toString());
                    sharedPreferences.setString("iso2",
                        recipientlist.countryIso2Code.toString());
                    sharedPreferences.setString("country_isoCode3",
                        recipientlist.countryIso3Code.toString());
                    sharedPreferences.setString(
                        "country_Currency_isoCode3",
                        recipientlist.currencyIso3Code.toString());
                    sharedPreferences.setString(
                        "phonecode",
                        recipientlist
                            .phonecode
                            .toString());
                    sharedPreferences.setString(
                        "phonenumber_min_max_validation",
                        "");
                    sharedPreferences.setString("currency",
                        recipientlist.currencyIso3Code.toString());
                    sharedPreferences.setString(
                        "partnerPaymentMethod",
                        recipientlist
                            .partnerPaymentMethod
                            .toString());
                    sharedPreferences.setString(
                        "recipientReceiveBankOrMobileNo",
                        recipientlist
                            .phonecode
                            .toString()+recipientlist
                            .phoneNumber
                            .toString());

                    sharedPreferences.setString("recipientId", recipientlist.recipientId.toString());
                    sharedPreferences.setString("senderId", "23cab527-e802-4e49-8cc1-78e5c5c8e8df");
                    sharedPreferences.setString("firstName", recipientlist.firstName.toString());
                    sharedPreferences.setString("lastname", recipientlist.lastName.toString());
                    sharedPreferences.setString("u_first_name", recipientlist.firstName.toString());
                    sharedPreferences.setString("u_last_name", recipientlist.lastName.toString());
                    sharedPreferences.setString("u_phone_number", recipientlist.phoneNumber.toString());
                    sharedPreferences.setString("u_profile_img", recipientlist.profileImage.toString());
                  },
                  child: Container(
                      //width: 40,
                      margin: EdgeInsets.only(left: 20),
                      child: SvgPicture.asset("assets/icons/send_blue.svg")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verifyDialog(BuildContext context, String msg, String status) {
    String document_status = status;
    String actual_status = status;
    document_status = document_status == "pending"
        ? "Incomplete"
        : document_status == "completed"
            ? "pending"
            : document_status;

    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset("assets/images/closesquare.svg"),
                  ),
                ),
                document_status == "Blank"
                    ? Container()
                    : Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          "Verification status : ${document_status}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  "assets/fonts/raleway/raleway_regular.ttf"),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                actual_status == "expired" ||
                        actual_status == "Rejected" ||
                        actual_status == "declined"
                    ? Column(
                        children: [
                          Text(
                            "Please re upload verification.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    "assets/fonts/raleway/raleway_regular.ttf"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(
                                        25.0, 12.0, 25.0, 12.0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MyColors.darkbtncolor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context, rootNavigator: true);
                              pushNewScreen(
                                context,
                                screen: LoginVerificatrionDetailScreen(),
                                withNavBar: false,
                              );
                            },
                            // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10.0)),
                            // color: MyColors.darkbtncolor,
                            child: Text(
                              "If you want to update verification Click Here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      "assets/fonts/raleway/raleway_regular.ttf"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
                actual_status == "Blank"
                    ? Column(
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(
                                        25.0, 12.0, 25.0, 12.0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MyColors.darkbtncolor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context, rootNavigator: true);
                              pushNewScreen(
                                context,
                                screen: LoginVerificatrionDetailScreen(),
                                withNavBar: false,
                              );
                            },
                            // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10.0)),
                            // color: MyColors.darkbtncolor,
                            child: Text(
                              "Verify Your Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      "assets/fonts/raleway/raleway_regular.ttf"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
                document_status == "Incomplete"
                    ? Column(
                        children: [
                          Text(
                            "Your Verification is incomplete , Please re upload verification.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    "assets/fonts/raleway/raleway_regular.ttf"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.fromLTRB(
                                        25.0, 12.0, 25.0, 12.0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MyColors.darkbtncolor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ))),
                            onPressed: () async {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              Navigator.of(context, rootNavigator: true);
                              pushNewScreen(
                                context,
                                screen: LoginVerificatrionDetailScreen(),
                                withNavBar: false,
                              );
                            },
                            // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10.0)),
                            // color: MyColors.darkbtncolor,
                            child: Text(
                              "If you want to update verification Click Here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      "assets/fonts/raleway/raleway_regular.ttf"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
                document_status == "pending"
                    ? Column(
                        children: [
                          Text(
                            "We will notify you as soon as you’re approved.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                    "assets/fonts/raleway/raleway_regular.ttf"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          );
        });
  }

  Future<void> favouriteRecipientapi(
    BuildContext context,
    String recipient_server_id,
  ) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();
    var request = {};
    request['recipient_server_id'] = recipient_server_id;

    debugPrint("request ${request}");

    var response = await http.post(Uri.parse(Apiservices.favouriteRecipientapi),
        body: jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });
    debugPrint(response.body);

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint(jsonResponse);
    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog6(context, false);
      Fluttertoast.showToast(msg: jsonResponse['message']);
      WidgetsBinding.instance
          .addPostFrameCallback((_) => addedAllRecipientsApi(context));
    } else {
      Fluttertoast.showToast(msg: jsonResponse['message']);
      CustomLoader.ProgressloadingDialog6(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    return;
  }

  Future<void> DeleteRecipientFieldRequest(BuildContext context,
      String recipientId, String recipientServerId) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};

    // otpo
    debugPrint(
        "request URL>>>>>  ${Apiservices.addrecipientfield + "/" + recipientId.toString()}");
    debugPrint("request ${request}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.delete(
        Uri.parse(Apiservices.addrecipientfield + "/" + recipientId.toString()),
        body: jsonEncode(request),
        headers: {
          'Authorization': 'Bearer ${p.getString('auth_Token')}',
          "content-type": "application/json",
          "accept": "application/json"
        });
    debugPrint(response.body);

    if (response.statusCode == 200) {
      CustomLoader.ProgressloadingDialog6(context, false);
      // deleteRecipientapi(context,recipientServerId);
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      Fluttertoast.showToast(msg: "Invalid Request");
      Navigator.of(context, rootNavigator: true).pop(context);
      CustomLoader.ProgressloadingDialog6(context, false);
      // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  Future<void> deleteRecipientapi(
      BuildContext context, String recipientServerId) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    debugPrint("auth_tocken....${p.getString('auth_Token')}");

    var request = {};
    request['recipient_server_id'] = recipientServerId;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Apiservices.deleteRecipientapi),
        body: jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });
    debugPrint(response.body);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Delete Successfully");
      Navigator.of(context, rootNavigator: true).pop(context);
      CustomLoader.ProgressloadingDialog6(context, false);

      WidgetsBinding.instance
          .addPostFrameCallback((_) => addedAllRecipientsApi(context));
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      Fluttertoast.showToast(msg: "Invalid Request");
      // CustomLoader.ProgressloadingDialog(context, false);
    }
    return;
  }

  Future<void> addedAllRecipientsApi(
    BuildContext context,
  ) async {
    // CustomLoader.ProgressloadingDialog6(context, true);
    // Utility.ProgressloadingDialog(context, true);
    _enabled2 = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};

    debugPrint("request ${request}");
    debugPrint("userid ${userid}");
    debugPrint("auth ${auth}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(
        Uri.parse(is_fav
            ? Apiservices.favouriteRecipientListapi
            : AllApiService.all_RecipintList_URl),
        body: jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    // CustomLoader.ProgressloadingDialog6(context, false);
    if (jsonResponse['status'] == true) {
      addedRecipientsListResponse =
          await AllAddedRecipientsListResponse.fromJson(jsonResponse);

      _recipientResult = addedRecipientsListResponse.data!.recipientlist!;
      _searchResult = addedRecipientsListResponse.data!.recipientlist!;

      _enabled2 = false;
      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      // Utility.ProgressloadingDialog(context, false);
      // addedRecipientsListResponse  = await AllAddedRecipientsListResponse.fromJson(jsonResponse);
      // _searchResult = addedRecipientsListResponse.data!.recipientlist!;
      _enabled2 = false;
      _recipientResult.clear();
      setState(() {});
    }
    return;
  }

  dialogDelete(
      BuildContext context, String recipientId, String recipientServerId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Are you sure, you want to Delete?",
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  "assets/fonts/raleway/raleway_regular.ttf"),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.fromLTRB(
                                                25.0, 12.0, 25.0, 12.0)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            MyColors.darkbtncolor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    ))),
                                onPressed: () {
                                  // Navigator.pop(context);
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(context);
                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                /* shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),*/
                                //  color: MyColors.darkbtncolor,
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily:
                                          "assets/fonts/raleway/raleway_regular.ttf"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.fromLTRB(
                                                25.0, 12.0, 25.0, 12.0)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            MyColors.darkbtncolor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      // side: BorderSide(color: Colors.red)
                                    ))),
                                onPressed: () async {
                                  // DeleteRequest(context, payment_method_id);
                                  // DeleteRecipientFieldRequest(context, recipientId,recipientServerId);
                                  deleteRecipientapi(
                                      context, recipientServerId);

                                  setState(() {});
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily:
                                          "assets/fonts/raleway/raleway_regular.ttf"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> latesttransferApi(
    BuildContext context,
  ) async {
    _enabled = true;
    // Utility.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};

    debugPrint("request ${request}");
    debugPrint("userid ${userid}");
    debugPrint("auth ${auth}");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response =
        await http.post(Uri.parse(AllApiService.recentRecipientByTxnapi),
            // body: jsonEncode(request),
            headers: {
          "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      latestTransferResponse =
          await LatestTransferResponse.fromJson(jsonResponse);
      latesttransferList = latestTransferResponse.data!.txnData!.data!;
      _enabled = false;
      // Utility.ProgressloadingDialog(context, false);
      setState(() {});
    } else {
      _enabled = false;
      // Utility.ProgressloadingDialog(context, false);

      latestTransferResponse =
          await LatestTransferResponse.fromJson(jsonResponse);
      setState(() {});
    }
    return;
  }
}

*/
