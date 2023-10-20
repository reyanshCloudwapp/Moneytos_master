import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webviewx/webviewx.dart';

import '../constance/myColors/mycolor.dart';
import '../constance/myStrings/myString.dart';
import '../s_Api/AllApi/ApiService.dart';
import 'dashboardScreen/dashboard.dart';

class VerificationScreen extends StatefulWidget {
  String VERIFICATION_URL;
  VerificationScreen({Key? key,required this.VERIFICATION_URL}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late WebViewXController webviewController;

  verificationFunc() {
  print("VERIFICATION_URL>> "+widget.VERIFICATION_URL);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationFunc();
  }
  Future<bool> _willPopCallback() async {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        DashboardScreen()), (Route<dynamic> route) => false);
    return true; // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: InAppWebViewPage());
  }
}

class InAppWebViewPage extends StatefulWidget {
  InAppWebViewPage({Key? key}) : super(key: key);
  @override
  _InAppWebViewPageState createState() => new _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  late InAppWebViewController _webViewController;
  String url = "";

  bool isLoad = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataset();
  }
  dataset() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    url = AllApiService.personabashurl+"personaVerificationWebView?user_id=${sharedPreferences.getString("userid")}&auth_token=${sharedPreferences.getString("auth")}";
    print("url>>>>>   "+url);

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.light_primarycolor2,
            flexibleSpace:    Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(22, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("a_assets/icons/arrow_back.svg")
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      MyString.verification,
                      style: TextStyle(
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          fontFamily:
                          "s_asset/font/raleway/raleway_extrabold.ttf"),
                    ),
                  ),
                  Container(width: 20,)
                ],
              ),
            ),

          ),
        ),
        body:
        Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: url==""?Container():Stack(
                    children: [
                      InAppWebView(
                        // initialUrl: "https://itmates.digital/Bookthefinest/serviceProviderBrodcast?spid=10&role=host&autotoken=pmyxKe9RJr0TtNmOl6cCRetmcsvHmKybSePiE1",
                          initialUrlRequest: URLRequest(
                            url: Uri.parse(url),
                          ),
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                              mediaPlaybackRequiresUserGesture: false,
                              // debuggingEnabled: true,
                            ),
                            ios: IOSInAppWebViewOptions(
                              allowsInlineMediaPlayback: true, // <-- add this line
                            ),
                          ),
                          onWebViewCreated: (InAppWebViewController controller) {
                            _webViewController = controller;
                          },
                          onLoadStart: (InAppWebViewController? controller, Uri? url) {
                            setState(() {
                              print("onLoad start");
                            });
                          },
                          onLoadStop: (InAppWebViewController controller, Uri? url) {
                            setState(() {
                              print("onLoad stop>>>>>>>> ");
                              Future.delayed(const Duration(seconds: 5), () {

// Here you can write your code
                                isLoad = false;
                                setState(() {
                                  // Here you can write your code for open new view
                                });

                              });

                            });
                          },
                          onConsoleMessage: (InAppWebViewController controller,ConsoleMessage consolemsg) {
                            print("consolemsg>>> "+consolemsg.toMap().toString());
                            if(consolemsg.toMap().toString().contains("Sending finished inquiry")){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  DashboardScreen(currentpage_index:0)), (Route<dynamic> route) => false);
                            }if(consolemsg.toMap().toString().contains("onCancel")){
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  DashboardScreen(currentpage_index:0)), (Route<dynamic> route) => false);
                            }
                          },
                          androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                            return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                          }
                      ),
                      Visibility(
                        visible: isLoad==true?true:false,
                        child: Center(
                            child:GFLoader(
                                type: GFLoaderType.custom,
                                child: Image(image: AssetImage("a_assets/logo/txn_loader_new.gif"),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                ))
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]))
    );
  }
}