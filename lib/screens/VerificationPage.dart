import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:webviewx/webviewx.dart';

import 'dashboardScreen/dashboard.dart';

class VerificationScreen extends StatefulWidget {
  final String VERIFICATION_URL;

  const VerificationScreen({Key? key, required this.VERIFICATION_URL})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late WebViewXController webviewController;

  verificationFunc() {
    debugPrint('VERIFICATION_URL>> ${widget.VERIFICATION_URL}');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificationFunc();
  }

  Future<bool> _willPopCallback() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
      (Route<dynamic> route) => false,
    );
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: const InAppWebViewPage(),
    );
  }
}

class InAppWebViewPage extends StatefulWidget {
  const InAppWebViewPage({Key? key}) : super(key: key);

  @override
  State<InAppWebViewPage> createState() => _InAppWebViewPageState();
}

class _InAppWebViewPageState extends State<InAppWebViewPage> {
  late InAppWebViewController _webViewController;
  String url = '';

  bool isLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataset();
  }

  dataset() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    url =
        "${AllApiService.personabashurl}personaVerificationWebView?user_id=${sharedPreferences.getString("userid")}&auth_token=${sharedPreferences.getString("auth")}";
    debugPrint('url>>>>>   $url');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(22, 30, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/icons/arrow_back.svg'),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.verification,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      fontFamily: 'assets/fonts/raleway/raleway_extrabold.ttf',
                    ),
                  ),
                ),
                Container(
                  width: 20,
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: url == ''
                  ? Container()
                  : Stack(
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
                              allowsInlineMediaPlayback:
                                  true, // <-- add this line
                            ),
                          ),
                          onWebViewCreated:
                              (InAppWebViewController controller) {
                            _webViewController = controller;
                          },
                          onLoadStart:
                              (InAppWebViewController? controller, Uri? url) {
                            setState(() {
                              debugPrint('onLoad start');
                            });
                          },
                          onLoadStop:
                              (InAppWebViewController controller, Uri? url) {
                            setState(() {
                              debugPrint('onLoad stop>>>>>>>> ');
                              Future.delayed(const Duration(seconds: 5), () {
// Here you can write your code
                                isLoad = false;
                                setState(() {
                                  // Here you can write your code for open new view
                                });
                              });
                            });
                          },
                          onConsoleMessage: (
                            InAppWebViewController controller,
                            ConsoleMessage consolemsg,
                          ) {
                            debugPrint('consolemsg>>> ${consolemsg.toMap()}');
                            if (consolemsg
                                .toMap()
                                .toString()
                                .contains('Sending finished inquiry')) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(
                                    currentpage_index: 0,
                                  ),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }
                            if (consolemsg
                                .toMap()
                                .toString()
                                .contains('onCancel')) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(
                                    currentpage_index: 0,
                                  ),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            }
                          },
                          androidOnPermissionRequest: (
                            InAppWebViewController controller,
                            String origin,
                            List<String> resources,
                          ) async {
                            return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT,
                            );
                          },
                        ),
                        Visibility(
                          visible: isLoad == true ? true : false,
                          child: Center(
                            child: GFLoader(
                              type: GFLoaderType.custom,
                              child: Image(
                                image: const AssetImage(
                                  'assets/logo/txn_loader_new.gif',
                                ),
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
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
}
