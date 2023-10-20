import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moneytos/constance/customLoader/customLoader.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home_history/transfer_bottomsheet.dart';
import '../../s_Api/AllApi/ApiService.dart';
import '../../s_Api/S_ApiResponse/LatestTransferResponse.dart';
import 'dart:convert' as convert;

import '../../s_Api/S_ApiResponse/NotificationlistResponse.dart';
import '../../s_Api/s_utils/Utility.dart';
import '../../services/Apiservices.dart';

class HomeNotificationScreen extends StatefulWidget {
  const HomeNotificationScreen({Key? key}) : super(key: key);

  @override
  State<HomeNotificationScreen> createState() => _HomeNotificationScreenState();
}

class _HomeNotificationScreenState extends State<HomeNotificationScreen> {
  bool is_search = false;
  bool _enabled = true;
  TextEditingController searchController = TextEditingController();

  /// FocusNode
  FocusNode searchFocusNode = FocusNode();

  NotificationlistResponse notificationlistResponse = new NotificationlistResponse();

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
    WidgetsBinding.instance.addPostFrameCallback((_) => latesttransferApi(context));
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
            padding: EdgeInsets.only( left: 22,top: 30,bottom: 5),
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
                        "s_asset/images/leftarrow.svg",
                          height: 32,
                          width: 32
                      )),
                ),

                // wSizedBox3,
                // wSizedBox3,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    MyString.notification,
                    style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        fontFamily:
                        "s_asset/font/raleway/raleway_extrabold.ttf"),
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
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                  "s_asset/font/raleway/Raleway-SemiBold.ttf"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              is_search = true;
                              setState(() {});
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "a_assets/icons/Search.svg",
                                //height: 100,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),*/
                    // hSizedBox4,
                    hSizedBox2,
                    _enabled==true?Utility.shrimmerVerticalListLoader(130, MediaQuery.of(context).size.width):
                    notificationlistResponse.status == true?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: notificationlistResponse.data!.notificationData!.length,
                        itemBuilder: (context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            child: CustomCardList(notificationlistResponse.data!.notificationData![index]),
                          );
                        }):
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Text("No Data",style: TextStyle(fontSize: 18),),),

                    hSizedBox5,
                    hSizedBox2,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // transferbottomsheet(String readyremit_transferId){
  //   return showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30)
  //       ),
  //       // anchorPoint: Offset(20.0, 30.0),
  //         backgroundColor: Colors.transparent,
  //       builder: (context) {
  //         return Container(
  //             color: Colors.transparent,
  //             height: MediaQuery.of(context).size.height * 0.76,
  //             child: Container(
  //                 decoration: new BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: new BorderRadius.only(
  //                         topLeft: const Radius.circular(30.0), topRight: const Radius.circular(30.0))),
  //                 child: TransferBottomsheet(readyremit_transferId: readyremit_transferId,))
  //         );}
  //   );
  // }

  CustomCardList(NotificationData notificationData) {
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
        child: Image.asset("a_assets/logo/female_profile.jpg",fit: BoxFit.cover,height: 100,width: 100,))),
    ),*/


    Container(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
      width: 300,
    child: Text(
      notificationData.title.toString(),
    style: TextStyle(
    fontSize: 16,
    fontFamily:
    "s_asset/font/raleway/raleway_medium.ttf",
    fontWeight: FontWeight.w500,
    color: MyColors.blackColor),
    ),
    ),
    hSizedBox,
      Container(
        width: 300,
        child: Text(
          notificationData.description.toString(),
          style: TextStyle(
              fontSize: 14,
              fontFamily:
              "s_asset/font/raleway/raleway_medium.ttf",
              color: MyColors.blackColor.withOpacity(0.50),
              fontWeight: FontWeight.w400),
        ),
      ),
    hSizedBox,
    Container(
      width: MediaQuery.of(context).size.width/1.2,
      alignment: Alignment.centerRight,
    child: Text(
      Utility.DatefomatToDateTime(notificationData.createdAt.toString()),
    style: TextStyle(
    fontSize: 12,
    fontFamily:
    "s_asset/font/raleway/raleway_medium.ttf",
    color: MyColors.blackColor.withOpacity(0.50),
    fontWeight: FontWeight.w500),
    ),
    )
    ],
    ),
    ),
    ],
    ),

    ]
    ),
    ))
    );
  }
  Future <void> latesttransferApi(BuildContext context,) async {

    _enabled = true;
    // CustomLoader.ProgressloadingDialog(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};

    print("request ${request}");
    print("userid ${userid}");
    print("auth ${auth}");


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.notificationlistapi),
        // body: convert.jsonEncode(request),
        headers: {

          "X-AUTHTOKEN":"${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      _enabled = false;
      // CustomLoader.ProgressloadingDialog6(context, false);
      notificationlistResponse = await NotificationlistResponse.fromJson(jsonResponse);

      setState(() {

      });
    } else {
      _enabled = false;
      // CustomLoader.ProgressloadingDialog6(context, false);
      setState(() {

      });
    }
    return;
  }


}
