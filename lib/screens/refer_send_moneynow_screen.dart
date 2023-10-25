import 'package:flutter_share/flutter_share.dart';
import 'package:moneytos/services/s_Api/S_ApiResponse/ReferListResponse.dart';
import 'package:moneytos/utils/import_helper.dart';

class ReferSendMoneyScreen extends StatefulWidget {
  const ReferSendMoneyScreen({Key? key}) : super(key: key);

  @override
  State<ReferSendMoneyScreen> createState() => _ReferSendMoneyScreenState();
}

class _ReferSendMoneyScreenState extends State<ReferSendMoneyScreen> {
  ReferlistResponse referlistResponse = ReferlistResponse();
  String referral_id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pref();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => referral_listapi(context));
  }

  void Update() {
    debugPrint('Refer Update');
    WidgetsBinding.instance
        .addPostFrameCallback((_) => referral_listapi(context));
  }

  Future<void> pref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    referral_id = sharedPreferences.getString('referral_id').toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: MyColors.light_primarycolor2,
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(22, 50, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                //  wSizedBox,
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.refe_friend,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      fontFamily: 'assets/fonts/raleway/raleway_extrabold.ttf',
                    ),
                  ),
                ),
                wSizedBox2
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: MyColors.light_primarycolor2,
            height: 300,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            //padding: EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 0,
              color: MyColors.whiteColor,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: MyColors.light_primarycolor2,
                        height: 70,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: MyColors.pink,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 165,
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 30,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Refer your friend and earn free transfers!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_bold.ttf',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Refer & Earn: Get a free transfer when your referral signs up and makes their first transfer.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_bold.ttf',
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Your Referrals',
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        hSizedBox,
                        Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              referlistResponse.status == true
                                  ? referlistResponse
                                          .data!.referralData!.isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: referlistResponse
                                              .data!.referralData!.length,
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 20,
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      referlistResponse
                                                          .data!
                                                          .referralData![index]
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color:
                                                            MyColors.blackColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            'assets/fonts/raleway/raleway_bold.ttf',
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  const Divider()
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : Container(
                                          height: size.height / 1.5,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'No Data',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        )
                                  : Container(
                                      height: size.height / 1.5,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'No Data',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                              // userlistcard("Today",MyColors.blackColor.withOpacity(0.05),"Sent",MyColors.primaryColor),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.blackColor.withOpacity(0.05),"Sent",MyColors.primaryColor),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.orange.withOpacity(0.08),"Viewed",MyColors.orange),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.greenColor.withOpacity(0.08),"Joined",MyColors.greenColor),
                              // hSizedBox3,
                              // youearnedcard(),
                              // hSizedBox3,
                              // userlistcard("Today",MyColors.blackColor.withOpacity(0.05),"Sent",MyColors.primaryColor),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.blackColor.withOpacity(0.05),"Sent",MyColors.primaryColor),
                              // hSizedBox2,
                              // userlistcard("Today",MyColors.orange.withOpacity(0.08),"Viewed",MyColors.orange),
                              // hSizedBox6,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        // color: MyColors.whiteColor,
        height: 140,
        decoration: const BoxDecoration(
          color: MyColors.whiteColor,
          /*gradient: LinearGradient(
           begin: Alignment.center,
           end: Alignment.bottomCenter,
           //  stops: [0.0, 1.0],
           colors: [
             MyColors.lightblueColor
                 .withOpacity(0.01),
             MyColors.lightblueColor
                 .withOpacity(0.01),
           ],
         ),*/
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: GestureDetector(
          onTap: () {
            share();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(
              bottom: 25,
              left: 20,
              right: 20,
            ),
            child: Material(
              elevation: 2,
              shadowColor: MyColors.light_primarycolor2,
              //shadowColor: MyColors.lightblueColor.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    //  stops: [0.0, 1.0],
                    colors: [
                      MyColors.light_primarycolor2,
                      MyColors.light_primarycolor2,
                    ],
                  ),
                  //    border: Border.all(color: bordercolor,width: 1.4)
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.share,
                    style: TextStyle(
                      fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                      color: MyColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Moneytos',
      text:
          'Sign up with my referral code $referral_id \n${AllApiService.personabashurl}refferallink',
      chooserTitle: 'Moneytos',
    );
  }

  userlistcard(String day, Color color, btnname, Color textcolor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: MyColors.lightblueColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Friend Name',
                style: TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                ),
              ),
              Text(
                day,
                style: TextStyle(
                  color: MyColors.blackColor.withOpacity(0.50),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                ),
              )
            ],
          ),
          hSizedBox,
          const Text(
            'heshamsqrat@gmail.com',
            style: TextStyle(
              color: MyColors.blackColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
            ),
          ),
          hSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '121345646545',
                style: TextStyle(
                  color: MyColors.blackColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  btnname,
                  style: TextStyle(
                    color: textcolor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  youearnedcard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You Earned',
              style: TextStyle(
                color: MyColors.blackColor.withOpacity(0.50),
                fontSize: 10,
                fontWeight: FontWeight.w500,
                fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
              ),
            ),
            Row(
              children: [
                const Text(
                  '2',
                  style: TextStyle(
                    color: MyColors.lightblueColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily:
                        'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                  ),
                ),
                wSizedBox,
                Text(
                  'Free Transaction',
                  style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.50),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 100,
          child: CustomButton2(
            btnname: 'Redeem',
            fontsize: 14,
            bg_color: MyColors.lightblueColor,
            bordercolor: MyColors.lightblueColor,
            height: 45,
          ),
        )
      ],
    );
  }

  Future<void> referral_listapi(
    BuildContext context,
  ) async {
    CustomLoader.progressloadingDialog(context, true);
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
      Uri.parse(Apiservices.referral_listapi),
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
      CustomLoader.progressloadingDialog6(context, false);
      referlistResponse = ReferlistResponse.fromJson(jsonResponse);

      setState(() {});
    } else {
      CustomLoader.progressloadingDialog6(context, false);
      setState(() {});
    }
    return;
  }
}
