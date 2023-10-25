import 'package:flutter/cupertino.dart';
import 'package:moneytos/screens/home_history/transfer_bottomsheet.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/LatestTransferResponse.dart';
import 'package:moneytos/utils/import_helper.dart';

class HomeHistoryScreen extends StatefulWidget {
  const HomeHistoryScreen({Key? key}) : super(key: key);

  @override
  State<HomeHistoryScreen> createState() => _HomeHistoryScreenState();
}

class _HomeHistoryScreenState extends State<HomeHistoryScreen> {
  bool _enabled = true;

  bool is_search = false;

  TextEditingController searchController = TextEditingController();

  /// FocusNode
  FocusNode searchFocusNode = FocusNode();

  LatestTransferResponse latestTransferResponse = LatestTransferResponse();
  List<TxnSubData> _searchResult = [];
  List<TxnSubData> _latesttransferResult = [];

  var scrollcontroller = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocusNode.unfocus();
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => latesttransferApi(context, 1));
    super.initState();
    scrollcontroller.addListener(pagination);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 146,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.whiteColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.whiteColor,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.arrow_back_ios_new,color: MyColors.color_1D2D5F,),
                Text(
                  'History',
                  style: TextStyle(
                    color: MyColors.color_1D2D5F,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                    fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 31,
            ),
            searchtextfield(
              searchController,
              'Name/Mobile',
              searchFocusNode,
              TextInputType.text,
              TextInputAction.done,
            )
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
      body: _enabled == true
          ? Utility.shrimmerVerticalListLoader(
              100,
              MediaQuery.of(context).size.width,
            )
          : latestTransferResponse.status == true
              ? latestTransferResponse.data!.txnData!.data!.isNotEmpty
                  ? ListView.builder(
                      controller: scrollcontroller,
                      itemCount: _searchResult.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            transferbottomsheet(
                              _searchResult[index]
                                  .readyremitTransferId
                                  .toString(),
                              _searchResult[index],
                            );
                          },
                          child: CustomCardList(_searchResult[index]),
                        );
                      },
                    )
                  : Container(
                      // margin: EdgeInsets.only(top: 50),
                      height: size.height / 1.5,
                      alignment: Alignment.center,
                      child: const Text(
                        'No Data',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
              : Container(
                  // margin: EdgeInsets.only(top: 50),
                  height: size.height / 1.5,
                  alignment: Alignment.center,
                  child: const Text(
                    'No Data',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
    );
  }

  transferbottomsheet(String readyremitTransferid, TxnSubData txnSubData) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // anchorPoint: Offset(20.0, 30.0),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.76,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: TransferBottomsheet(
              isMfs: false,
              readyremit_transferId: readyremitTransferid,
              selected_acc_id: txnSubData.senderSendMethodId.toString(),
              selected_payment_type: txnSubData.senderSendMethod.toString(),
              selected_acc_name: txnSubData.recipientName.toString(),
              selected_last4: txnSubData.senderSendMethodLast4digit.toString(),
              txnSubData: txnSubData,
            ),
          ),
        );
      },
    );
  }

  searchtextfield(
    TextEditingController controller,
    String hinttext,
    FocusNode focusNode,
    TextInputType textInputType,
    TextInputAction textInputAction,
  ) {
    return SizedBox(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: (value) => _searchFilter(value),
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        style: const TextStyle(
          color: MyColors.blackColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: 'assets/fonts/raleway/Raleway-Medium.ttf',
        ),
        decoration: InputDecoration(
          hintText: hinttext,
          prefixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/ic_search_new.svg'),
            iconSize: 20,
          ),
          suffixIcon: focusNode.hasFocus
              ? GestureDetector(
                  onTap: () {
                    is_search = false;
                    searchController.clear();
                    FocusScope.of(context).unfocus();
                    _searchResult = _latesttransferResult;
                    setState(() {});
                  },
                  child: const Icon(CupertinoIcons.clear),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: MyColors.color_EBF0FA, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: MyColors.color_EBF0FA, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: MyColors.color_EBF0FA, width: 1),
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

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  CustomCardList(TxnSubData txnSubData) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
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
                                          shadowColor: MyColors.blackColor
                                              .withOpacity(.3),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            // Adjust the radius as needed
                                            side: BorderSide(
                                              color: MyColors.blackColor
                                                  .withOpacity(.05),
                                              // Set the border color
                                              width:
                                                  1.0, // Set the border width
                                            ),


                                          ),

                                           */
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
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
                    txnSubData.profileImage.toString(),
                  ),
                  placeholder:
                      const AssetImage('assets/logo/progress_image.png'),
                  placeholderFit: BoxFit.scaleDown,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Text(
                      txnSubData.recipientName.toString()[0].toUpperCase(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txnSubData.recipientName.toString(),
                    style: const TextStyle(
                      color: MyColors.color_06366F,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    txnSubData.newCreatedAt.toString().toLowerCase(),
                    style: const TextStyle(
                      color: MyColors.color_676F85,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'assets/fonts/raleway/raleway_regular.ttf',
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${txnSubData.sendAmount}',
                  style: const TextStyle(
                    color: MyColors.color_1D2D5F,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily:
                        'assets/fonts/circularstd/circular_std_medium.ttf',
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  txnSubData.readyremitStatus.toString(),
                  style: TextStyle(
                    color: txnSubData.readyremitStatus == 'pending'
                        ? MyColors.dark_yellow
                        : MyColors.greenColor2.withOpacity(0.60),
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _searchFilter(String enteredKeyword) {
    List<TxnSubData> results = <TxnSubData>[];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _latesttransferResult;
    } else {
      results = _latesttransferResult
          .where(
            (user) =>
                ('${user.recipientName} ${user.phonecode}${user.phoneNumber}')
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

  void pagination() {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (latestTransferResponse.data!.txnData!.data!.length == 10)) {
      setState(() {
        isLoading = true;
        if (isLoading) {
          page += 1;
          WidgetsBinding.instance
              .addPostFrameCallback((_) => latesttransferApi(context, page));
        }

        //add api for load the more data according to new page
      });
    }
  }

  Future<void> latesttransferApi(BuildContext context, int page) async {
    _enabled = true;
    // CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString('userid');
    var auth = sharedPreferences.getString('auth');
    var request = {};
    request['page'] = page;

    debugPrint('request $request');
    debugPrint('userid $userid');
    debugPrint('auth $auth');

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.post(
      Uri.parse(AllApiService.latesttransferapi),
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
      // _searchResult = latestTransferResponse.data!.txnData!.data!;
      _latesttransferResult = latestTransferResponse.data!.txnData!.data!;
      for (int i = 0;
          i < latestTransferResponse.data!.txnData!.data!.length;
          i++) {
        _searchResult.add(latestTransferResponse.data!.txnData!.data![i]);
      }

      _enabled = false;
      // CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {});
    } else {
      _enabled = false;
      // CustomLoader.ProgressloadingDialog6(context, false);

      latestTransferResponse = LatestTransferResponse.fromJson(jsonResponse);
      setState(() {});
    }
    return;
  }
}

//old working code
/*
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/customLoader/custom_loader.dart';
import 'package:moneytos/constance/myColors/my_color.dart';
import 'package:moneytos/constance/myStrings/my_string.dart';
import 'package:moneytos/constance/sizedbox/sized_box.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home_history/transfer_bottomsheet.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/S_ApiResponse/LatestTransferResponse.dart';
import 'dart:convert' as convert;

import '../../s_Api/s_utils/Utility.dart';

class HomeHistoryScreen extends StatefulWidget {
  const HomeHistoryScreen({Key? key}) : super(key: key);

  @override
  State<HomeHistoryScreen> createState() => _HomeHistoryScreenState();
}

class _HomeHistoryScreenState extends State<HomeHistoryScreen> {

  bool _enabled = true;

  bool is_search = false;

  TextEditingController searchController = TextEditingController();

  /// FocusNode
  FocusNode searchFocusNode = FocusNode();

  LatestTransferResponse latestTransferResponse = new LatestTransferResponse();
  List<TxnSubData> _searchResult = [];
  List<TxnSubData>  _latesttransferResult= [];

  var scrollcontroller = ScrollController();
  bool isLoading = false;
  int page = 1;

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
    scrollcontroller.addListener(pagination);
    WidgetsBinding.instance.addPostFrameCallback((_) => latesttransferApi(context,1));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: MyColors.light_primarycolor2,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.light_primarycolor2,
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only( left: 22,top: 40,bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only( top: 5),

                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        "assets/images/leftarrow.svg",
                        height: 32,
                        width: 32,
                      )),
                ),

                // wSizedBox3,
                // wSizedBox3,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.history,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        fontFamily:
                        "assets/fonts/raleway/Raleway-ExtraBold.ttf"),
                  ),
                ),
                Container(
                  width: 50,
                )
              ],
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),

      body: Stack(
        children: [
          Container(
            height: size.height * 0.3,
            color: MyColors.light_primarycolor2,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Card(
              elevation: 0,
              color: MyColors.whiteColor,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                controller: scrollcontroller,
                child: Column(
                  children: [
                    //  hSizedBox3,
                    /* is_search == true
                        ? searchtextfield(
                        searchController,
                        "search here..",
                        searchFocusNode,
                        TextInputType.text,
                        TextInputAction.done)
                        : Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(
                                00, 5, 0, 0),
                            child: Text(
                              MyString.latest_transfers,
                              style: TextStyle(
                                  color: MyColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily:
                                  "assets/fonts/raleway/Raleway-SemiBold.ttf"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              is_search = true;
                              setState(() {});
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/icons/Search.svg",
                                //height: 100,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),*/
                    hSizedBox4,
                    hSizedBox3,
                    _enabled==true?Utility.shrimmerVerticalListLoader(100, MediaQuery.of(context).size.width):
                    latestTransferResponse.status == true?
                    latestTransferResponse.data!.txnData!.data!.isNotEmpty?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _searchResult.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            onTap: (){
                              transferbottomsheet(_searchResult[index].readyremitTransferId.toString(),_searchResult[index]);

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              child: CustomCardList(_searchResult[index]),
                            ),
                          );
                        }):Container(
                      // margin: EdgeInsets.only(top: 50),
                      height: size.height/1.5,
                      alignment: Alignment.center,
                      child: Text("No Data",style: TextStyle(fontSize: 18),),):
                    Container(
                      // margin: EdgeInsets.only(top: 50),
                      height: size.height/1.5,
                      alignment: Alignment.center,
                      child: Text("No Data",style: TextStyle(fontSize: 18),),),

                    hSizedBox5,
                    hSizedBox2,
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: MyColors.whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)),
            ),

            child:  is_search == true
                ? searchtextfield(
                searchController,
                "search here..",
                searchFocusNode,
                TextInputType.text,
                TextInputAction.done)
                : Container(
              height: 50,
              padding:
              EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(
                        00, 5, 0, 0),
                    child: Text(
                      MyString.latest_transfers,
                      style: TextStyle(
                          color: MyColors.blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily:
                          "assets/fonts/raleway/Raleway-SemiBold.ttf"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      is_search = true;
                      setState(() {});
                    },
                    child: Container(
                      child: SvgPicture.asset(
                        "assets/icons/Search.svg",
                        //height: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  transferbottomsheet(String readyremit_transferId,TxnSubData txnSubData){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        // anchorPoint: Offset(20.0, 30.0),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.76,
              child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(30.0), topRight: const Radius.circular(30.0))),
                  child: TransferBottomsheet(isMfs: false,readyremit_transferId: readyremit_transferId, selected_acc_id: txnSubData.senderSendMethodId.toString(), selected_payment_type: txnSubData.senderSendMethod.toString(), selected_acc_name: txnSubData.recipientName.toString(), selected_last4: txnSubData.senderSendMethodLast4digit.toString(), txnSubData: txnSubData,))
          );}
    );
  }

  searchtextfield(TextEditingController controller,
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
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: TextField(
        onChanged: (value) => _searchFilter(value),
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "assets/fonts/raleway/Raleway-Medium.ttf"),
        decoration: InputDecoration(
          hintText: hinttext,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: (){
              is_search = false;
              searchController.clear();
              _searchResult = _latesttransferResult;
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
              fontFamily: "assets/fonts/raleway/Raleway-Medium.ttf",
              letterSpacing: 0.1),
          //border: InputBorder.none,
        ),

        keyboardType: textInputType,

        // Only numbers can be entered
      ),
    );
  }

  CustomCardList(TxnSubData txnSubData) {
    return Container(
        child: Material(
            elevation: 30,
            shadowColor: MyColors.lightblueColor.withOpacity(0.10),
            color: MyColors.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*  CircleAvatar(
    radius: 30,
    backgroundColor: MyColors.lightblueColor.withOpacity(0.10),
    child: Center(child:ClipRRect(
        borderRadius: BorderRadius.circular(150),
        child: Image.asset("assets/logo/female_profile.jpg",fit: BoxFit.cover,height: 100,width: 100,))),
    ),*/

                        CircleAvatar(
                          radius: 25,
                          backgroundColor: MyColors.divider_color,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: FadeInImage(
                              height: 156,width: 149,
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                txnSubData.profileImage.toString(),),
                              placeholder: AssetImage(
                                  "assets/logo/progress_image.png"),
                              placeholderFit: BoxFit.scaleDown,
                              imageErrorBuilder:
                                  (context, error, stackTrace) {
                                return Container(
                                  child: Text(txnSubData.recipientName.toString()[0].toUpperCase(),style: TextStyle(
                                      color: MyColors.shedule_color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "assets/fonts/raleway/Raleway-Bold.ttf")),
                                );
                              },
                            ),
                          ),
                        ),
                        wSizedBox1,
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 180,
                                child: Text(
                                  txnSubData.recipientName.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily:
                                      "assets/fonts/raleway/Raleway-Medium.ttf",
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.blackColor),
                                ),
                              ),
                              hSizedBox,
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                txnSubData.createdAt.toString(),
                                        // Utility.CurrentDate()==(txnSubData.createdAt.toString().split("T")[0])?"Today "+Utility.DatefomatToTime(txnSubData.createdAt.toString()):Utility.DatefomatToDateTime(txnSubData.createdAt.toString()),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                            "assets/fonts/raleway/Raleway-Medium.ttf",
                                            color: MyColors.blackColor.withOpacity(0.50),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        txnSubData.sendAmount.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            "assets/fonts/montserrat/Montserrat-ExtraBold.otf",
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.2,
                                            color: MyColors.color_3F84E5),
                                      ),
                                      wSizedBox,
                                      Text(
                                        MyString.usd,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily:
                                            "assets/fonts/raleway/Raleway-Bold.ttf",
                                            fontWeight: FontWeight.w600,
                                            color: MyColors.lightblueColor),
                                      ),
                                    ],
                                  ),
                                ),
                                hSizedBox,


                                Container(
                                  width: 55,
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:  txnSubData.readyremitStatus == "pending"
                                        ? MyColors.lightorange.withOpacity(
                                        0.12)
                                        : txnSubData.readyremitStatus == MyString.with_partner
                                        ? MyColors.lightorange.withOpacity(
                                        0.12)
                                        : MyColors.greenColor2.withOpacity(
                                        0.12),
                                  ),
                                  child: Text(
                                    txnSubData.readyremitStatus.toString(),
                                    style: TextStyle(
                                        color: txnSubData.readyremitStatus == "pending"
                                            ? MyColors.dark_yellow
                                            : txnSubData.readyremitStatus == MyString.with_partner
                                            ? MyColors.lightorange
                                            : MyColors.greenColor2.withOpacity(
                                            0.60),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        fontFamily: "assets/fonts/raleway/Raleway-Bold.ttf"),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
              ),
            ))
    );
  }
  void _searchFilter(String enteredKeyword) {
    List<TxnSubData> results =<TxnSubData> [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _latesttransferResult;
    } else {
      results = _latesttransferResult.where((user) => user.recipientName.toString().toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _searchResult = results;
    });
  }

  void pagination() {
    if ((scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent) && (latestTransferResponse.data!.txnData!.data!.length==10)) {
      setState(() {
        isLoading = true;
        if(isLoading){
          page += 1;
          WidgetsBinding.instance.addPostFrameCallback((_) => latesttransferApi(context,page));
        }

        //add api for load the more data according to new page
      });
    }
  }

  Future <void> latesttransferApi(BuildContext context,int page) async {

    _enabled = true;
    // CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};
    request['page'] = page;

    debugPrint("request ${request}");
    debugPrint("userid ${userid}");
    debugPrint("auth ${auth}");


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(AllApiService.latesttransferapi),
        // body: jsonEncode(request),
        headers: {

          "X-AUTHTOKEN":"${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });


    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      latestTransferResponse  = await LatestTransferResponse.fromJson(jsonResponse);
      // _searchResult = latestTransferResponse.data!.txnData!.data!;
      _latesttransferResult = latestTransferResponse.data!.txnData!.data!;
      for(int i=0;i<latestTransferResponse.data!.txnData!.data!.length;i++){
        _searchResult.add(latestTransferResponse.data!.txnData!.data![i]);
      }

      _enabled = false;
      // CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {

      });
    } else {
      _enabled = false;
      // CustomLoader.ProgressloadingDialog6(context, false);

      latestTransferResponse  = await LatestTransferResponse.fromJson(jsonResponse);
      setState(() {

      });
    }
    return;
  }


}
*/
