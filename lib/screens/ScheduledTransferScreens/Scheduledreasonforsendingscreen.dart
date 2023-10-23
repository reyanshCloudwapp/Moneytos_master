import 'dart:async';

import 'package:moneytos/model/reasonforSendingModel.dart';
import 'package:moneytos/screens/ScheduledTransferScreens/scheduled_select_payment_method_screen.dart';
import 'package:moneytos/screens/ScheduledTransferScreens/scheduledreasonforsendingpaymethod.dart';
import 'package:moneytos/utils/import_helper.dart';

List<ReasonForSendingFieldSetsModel> reasonforlist = [];
List<ReasongforSendinItemFieldsModel> reasongforSendinItemFieldslist = [];
List<ReasonforSendingOptionsModel> optionlistt = [];

class ScheduledReasonforSendingScreen extends StatefulWidget {
  final String status;
  final bool isMfs;

  const ScheduledReasonforSendingScreen({
    Key? key,
    this.status = '',
    required this.isMfs,
  }) : super(key: key);

  @override
  State<ScheduledReasonforSendingScreen> createState() =>
      _ScheduledReasonforSendingScreenState();
}

class _ScheduledReasonforSendingScreenState
    extends State<ScheduledReasonforSendingScreen> {
  bool load = false;

  String ischeck = '';

  reasonforsendingApi() async {
    reasonforlist.clear();
    reasongforSendinItemFieldslist.clear();
    optionlistt.clear();
    setState(() {
      load = true;
    });

    await Webservices.ReasonForsendingRequest(
      context,
      reasonforlist,
      reasongforSendinItemFieldslist,
      optionlistt,
    );
    paymentmethodsRequest(context);
    setState(() {});
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
                child: GridView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 40,
                  ),
                  scrollDirection: Axis.vertical,
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 0.41,
                    crossAxisSpacing: 1.1,
                    mainAxisSpacing: 0.3,
                  ),
                  children: optionlistt.map((ReasonforSendingOptionsModel url) {
                    return GestureDetector(
                      onTap: () {
                        pref(url.id.toString(), url.name.toString());
                        ischeck == 'already_add'
                            ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ScheduledSelectPaymentMethodScreen(
                                    isMfs: widget.isMfs,
                                    selectedMethodScreen: 0,
                                  ),
                                ),
                              )
                            : widget.status == 'reason_for_sending'
                                ? null
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ScheduledReasonForSendingPaymethod(
                                        isMfs: widget.isMfs,
                                        id: url.id.toString(),
                                      ),
                                    ),
                                  );
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
                            url.name.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: MyColors.color_text,
                              fontSize: 13,
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
            load == true
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: const Center(
                      child: GFLoader(
                        type: GFLoaderType.custom,
                        child: Image(
                          image: AssetImage(
                            'assets/logo/progress_image.png',
                          ),
                        ),
                      ),
                    ),
                  )
                : Container()
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
      Uri.parse(AllApiService.AddMagicSenderBank),
      // body: jsonEncode(request),
      headers: {
        'X-AUTHTOKEN': "${sharedPreferences.getString("auth")}",
        'X-USERID': "${sharedPreferences.getString("userid")}",
        'content-type': 'application/json',
        'accept': 'application/json',
        // "Authorization": AllApiService.client_id,
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
