import 'package:moneytos/utils/import_helper.dart';
import 'package:webviewx/webviewx.dart';

class TermsNConditionScreen extends StatefulWidget {
  const TermsNConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsNConditionScreen> createState() => _TermsNConditionState();
}

class _TermsNConditionState extends State<TermsNConditionScreen> {
  late WebViewXController webviewController;
  String html_desc = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => termsconditionapi(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.light_primarycolor2,
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(22, 30, 20, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                    child: const Text(
                      MyString.termscondition,
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
                Container(
                  width: 20,
                )
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
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
              child: Container(
                child: html_desc == ''
                    ? Container()
                    : WebViewX(
                        initialContent: html_desc,
                        initialSourceType: SourceType.html,
                        onWebViewCreated: (controller) =>
                            webviewController = controller,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> termsconditionapi(BuildContext context) async {
    Utility.ProgressloadingDialog(context, true);
    var request = {};

    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(Apiservices.termsconditionapi),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
        'content-type': 'application/json',
        'accept': 'application/json',
      },
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      Utility.ProgressloadingDialog(context, false);

      debugPrint("about response>>>>>${jsonResponse['data']['description']}");
      html_desc = jsonResponse['data']['description'].toString();
      setState(() {});
    } else {
      Utility.ProgressloadingDialog(context, false);
      setState(() {});
    }

    return;
  }
}
