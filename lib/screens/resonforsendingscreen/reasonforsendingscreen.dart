import 'dart:async';

import 'package:moneytos/model/reasonforSendingModel.dart';
import 'package:moneytos/screens/ScheduledTransferScreens/scheduled_select_payment_method_screen.dart';
import 'package:moneytos/screens/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:moneytos/utils/import_helper.dart';

import '../../model/purpose_code_response.dart';

List<ReasonForSendingFieldSetsModel> reasonforlist = [];
List<ReasongforSendinItemFieldsModel> reasongforSendinItemFieldslist = [];
List<PurposeData> optionlistt = [];

class ReasonforSendingScreen extends StatefulWidget {
  final String status;

  const ReasonforSendingScreen({Key? key, this.status = ''}) : super(key: key);

  @override
  State<ReasonforSendingScreen> createState() => _ReasonforSendingScreenState();
}

class _ReasonforSendingScreenState extends State<ReasonforSendingScreen> {
  PurposeCodesResponse purposeCodesResponse = PurposeCodesResponse();
  bool load = true;

  String ischeck = '';

  reasonforsendingApi() async {
    // reasonforlist.clear();
    // reasongforSendinItemFieldslist.clear();
    // optionlistt.clear();
    // setState((){
    //   load = true;
    // });
    //
    // await Webservices.ReasonForsendingRequest(context, reasonforlist, reasongforSendinItemFieldslist, optionlistt);
    // paymentmethodsRequest(context);
    // setState((){
    //
    // });

    niumPurposeCodesApi(context);
  }

  Future<void> niumPurposeCodesApi(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        "${Apiservices.niumPurposeCodesapi}?partner_payment_method=${sharedPreferences.getString("partnerPaymentMethod").toString()}",
      ),
      headers: {
        'X-CLIENT': AllApiService.x_client,
        'content-type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == true) {
        purposeCodesResponse = PurposeCodesResponse.fromJson(jsonResponse);
        optionlistt = purposeCodesResponse.data!;
      }
      load = false;
      setState(() {});
    } else {
      // List<dynamic> errorres = json.decode(response.body);
      // Fluttertoast.showToast(msg: errorres[0]["message"]);
      //Fluttertoast.showToast(msg: "Minimum amount was not met for this transaction.");
      load = false;
      setState(() {});
    }
  }

  onnavigate() {
    Timer(const Duration(seconds: 0), () {
      reasonforsendingApi();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reasonforsendingApi();
    //  onnavigate();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
              child: Row(
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
                  const Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        MyString.Reason_for_Sending,
                        style: TextStyle(
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          fontFamily:
                              'assets/fonts/raleway/raleway_extrabold.ttf',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: MyColors.color_03153B,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.color_03153B,
              statusBarIconBrightness: Brightness.light,
              // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
          ),
        ),
        // bottomSheet: load == true ? Container(height: 0,) : GestureDetector(
        //   behavior: HitTestBehavior.translucent,
        //   onTap: (){
        //     widget.status == "reason_for_sending"?
        //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SelectNewRecipientScreen())):
        //     Navigator.pop(context);
        //   },
        //   child: Container(
        //     padding: EdgeInsets.only(top: 10),
        //     color: Colors.white,
        //     height: 70,
        //     alignment: Alignment.topCenter,
        //     child: Text("Skip",style: TextStyle(fontSize: 16,fontFamily: "assets/fonts/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: MyColors.lightblueColor),),
        //   ),
        // ),
        backgroundColor: MyColors.color_03153B,
        body: Stack(
          children: <Widget>[
            Container(
              color: MyColors.color_03153B,
              height: 300,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                child: load == true
                    ? Utility.shrimmerReasonGridLoader(80, 150)
                    : GridView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 40,
                        ),
                        scrollDirection: Axis.vertical,
                        // physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 0.50,
                          crossAxisSpacing: 1.1,
                          mainAxisSpacing: 0.3,
                        ),
                        children: optionlistt.map((PurposeData url) {
                          return GestureDetector(
                            onTap: () async {
                              pref(
                                url.purposeCode.toString(),
                                url.purposeCodeDescription.toString(),
                              );
                              // widget.status == "already_add"?Navigator.push(context, MaterialPageRoute(builder: (_) => LinkNewMethodScreen())):
                              // widget.status == "reason_for_sending"? Navigator.push(context, MaterialPageRoute(builder: (_) => LinkNewMethodScreen())):
                              // widget.status == "schedule_reason_for_sending"? Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduledLinkNewMethodScreen(isMfs: false,))):
                              // widget.status == "schedule_already_add"? Navigator.push(context, MaterialPageRoute(builder: (_) => ScheduledLinkNewMethodScreen(isMfs: false,))):
                              // null;

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ReasonForSendingPaymethod(id: url.id.toString(),)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 8,
                                top: 12,
                                right: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                border: Border.all(
                                  color: MyColors.color_text.withOpacity(0.2),
                                  width: 1.0,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 0.0,
                              ),
                              child: Center(
                                child: Text(
                                  url.purposeCodeDescription.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: MyColors.color_text,
                                    fontSize: 10,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_medium.ttf',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pref(String id, String name) async {
    debugPrint('selected id>>>> $id');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('reasonsending_id', id);
    sharedPreferences.setString('reasonsending_name', name);
    widget.status == 'already_add'
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SelectPaymentMethodScreen(
                isMfs: sharedPreferences
                            .getString('partnerPaymentMethod')
                            .toString() ==
                        'mfs'
                    ? true
                    : false,
                selectedMethodScreen: 1,
              ),
            ),
          )
        : widget.status == 'reason_for_sending'
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SelectPaymentMethodScreen(
                    isMfs: sharedPreferences
                                .getString('partnerPaymentMethod')
                                .toString() ==
                            'mfs'
                        ? true
                        : false,
                    selectedMethodScreen: 1,
                  ),
                ),
              )
            : widget.status == 'schedule_reason_for_sending'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScheduledSelectPaymentMethodScreen(
                        isMfs: sharedPreferences
                                    .getString('partnerPaymentMethod')
                                    .toString() ==
                                'mfs'
                            ? true
                            : false,
                        selectedMethodScreen: 1,
                      ),
                    ),
                  )
                : widget.status == 'schedule_already_add'
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ScheduledSelectPaymentMethodScreen(
                            isMfs: sharedPreferences
                                        .getString('partnerPaymentMethod')
                                        .toString() ==
                                    'mfs'
                                ? true
                                : false,
                            selectedMethodScreen: 1,
                          ),
                        ),
                      )
                    : null;
    setState(() {});
  }

  Future<void> paymentmethodsRequest(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        "${AllApiService.payment_methods}${sharedPreferences.getString("customer_id")}/payment-methods",
      ),
      // body: jsonEncode(request),
      headers: {
        // "X-AUTHTOKEN": "${sharedPreferences.getString("auth")}",
        // "X-USERID": "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': AllApiService.client_id,
      },
    );

    if (response.statusCode == 200) {
      // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // debugPrint("nsklvnsf>> "+jsonResponse.toString());
      ischeck = 'already_add';
    } else {}
    load = false;

    // if (jsonResponse['status'] == true) {
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Fluttertoast.showToast(msg: jsonResponse['message']);
    //
    //
    //   setState(() {});
    // } else {
    //   CustomLoader.ProgressloadingDialog(context, false);
    //   Fluttertoast.showToast(msg: jsonResponse['message']);
    setState(() {});
    // }
    return;
  }
}
