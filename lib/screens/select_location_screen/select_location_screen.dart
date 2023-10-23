import 'package:moneytos/utils/import_helper.dart';

import '../../model/RecipientFiealdModel.dart';
import '../../model/location_response.dart';
import '../home/s_home/sendmoneyquatationfromNewRecipient/sendmoneyquatationfromNewRecipient.dart';

class SelectLocationScreen extends StatefulWidget {
  final bool? isAlreadyRecipient;

  const SelectLocationScreen({
    super.key,
    this.isAlreadyRecipient = false,
  });

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  String url =
      'https://sandbox-api.readyremit.com/v1/recipient-fields?recipientType=PERSON&dstCountryIso3Code=MEX&dstCurrencyIso3Code=MXN&transferMethod=BANK_ACCOUNT';

  String slectedcountrCode = '+91';
  String? selectedCategory;
  String? selectedCategory2;
  List<FieldSetsModel> fieldsetlist = [];
  List<RecipientFieldsModel> recipientfieldsetlist = [];
  List<Options> optionlist = [];
  bool load = false;
  List<Locationdata> locationList = [];
  int selectedIndex = -1;

  List<TextEditingController> _controllers1 = [];
  List<TextEditingController> _controllers2 = [];

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();

  FocusNode firstFocusNode = FocusNode();
  FocusNode lastFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode address1FocusNode = FocusNode();
  FocusNode address2FocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode zipFocusNode = FocusNode();

  String img_error = '';

  XFile? _frontimage;
  String front_images = '';
  String? frontimg = '';

  SharedPreferences? p;
  int phone_min_val = 0;
  int phone_max_val = 0;

  getPrefences() async {
    p = await SharedPreferences.getInstance();

    debugPrint(
      "partnerPaymentMethod>>>> ${p!.getString("partnerPaymentMethod")}",
    );
    debugPrint(
      "select_payment_method_status>>>> ${p!.getString("select_payment_method_status")}",
    );
    debugPrint("currency iso>>>> ${p!.getString("country_Currency_isoCode3")}");
    debugPrint("country_isoCode3 iso>>>> ${p!.getString("country_isoCode3")}");
    debugPrint(
      "phonecode iso>>>> ${p!.getString("phonenumber_min_max_validation")}",
    );
    // phone_min_val = p!.getString("partnerPaymentMethod").toString() == "mfs"
    //     ? 0
    //     : int.parse(p!
    //         .getString("phonenumber_min_max_validation")
    //         .toString()
    //         .split("-")[0]);
    // phone_max_val = p!.getString("partnerPaymentMethod").toString() == "mfs"
    //     ? 0
    //     : int.parse(p!
    //         .getString("phonenumber_min_max_validation")
    //         .toString()
    //         .split("-")[1]);
    setState(() {});
  }

  bool frontimageSelected = false;

  final ImagePicker imagePicker = ImagePicker();

  getfieldrecipient() async {
    fieldsetlist.clear();
    recipientfieldsetlist.clear();
    optionlist.clear();
    setState(() {
      load = true;
    });
    await Webservices.RecipientFieldRequest(
      context,
      fieldsetlist,
      recipientfieldsetlist,
      optionlist,
    );

    setState(() {
      load = false;
    });
  }

  List<TextEditingController> _controllers = [];

  frontDocumentbottoms(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('camera'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('gallery'),
              onTap: () {
                Navigator.pop(context);
                getfrontCameraImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void compressImage(imageSource) async {
    var image =
        await imagePicker.getImage(source: imageSource, imageQuality: 10);
    if (image == null) {
      debugPrint('+++++++++null');
    } else {
      _frontimage = XFile(image.path);
      front_images = _frontimage!.path;
      frontimg = _frontimage!.path;
      setState(() {});

      debugPrint('image path is $frontimg');
    }
  }

  Future getfrontCameraImage(imageSource) async {
    var image =
        await imagePicker.getImage(source: imageSource, imageQuality: 5);
    if (mounted) {
      setState(() {
        frontimageSelected = true;

        if (image == null) {
          debugPrint('+++++++++null');
        } else {
          _frontimage = XFile(image.path);
          front_images = _frontimage!.path;
          frontimg = _frontimage!.path;
          setState(() {});
          debugPrint('image path is $frontimg');
        }
        //  Navigator.pop(context);
      });
    }
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: MyColors.lightBlackColor,
      actions: [
        KeyboardActionsItem(
          focusNode: mobileFocusNode,
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstFocusNode.unfocus();
    lastFocusNode.unfocus();
    mobileFocusNode.unfocus();
    address1FocusNode.unfocus();
    address2FocusNode.unfocus();
    cityFocusNode.unfocus();
    zipFocusNode.unfocus();
  }

  List<AddRecipientFieldModel> addfieldlist = [];
  bool field_load = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocationListApi(context);
    });
    super.initState();
    /*
    getPrefences();
    getfieldrecipient();

     */
  }

/*  Oncallback(bool load){
    field_load = load;
  }*/

  addRecipientField() async {
    // setState(() {
    //   field_load= true;
    // });
    await Webservices.AddRecipientFieldRequest(
      context,
      addfieldlist,
      frontimg.toString(),
    );
    // setState(() {
    //   field_load = false;
    // });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          backgroundColor: MyColors.whiteColor,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
        color: MyColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 4),
                      blurRadius: 5.0,
                    )
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    //  stops: [0.0, 1.0],
                    colors: [
                      MyColors.lightblueColor.withOpacity(0.10),
                      MyColors.lightblueColor.withOpacity(0.10),
                    ],
                  ),
                  //color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: 0,
                  top: 0,
                ),
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 0,
                  top: 0.0,
                ),
                child: const Center(
                  child: Text(
                    MyString.back,
                    style: TextStyle(
                      color: MyColors.lightblueColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                    ),
                  ),
                ),
              ),
            ),
            wSizedBox3,
            GestureDetector(
              onTap: () => onNextTap(context),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 4),
                      blurRadius: 5.0,
                    )
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    //  stops: [0.0, 1.0],
                    colors: [
                      MyColors.lightblueColor,
                      MyColors.lightblueColor,
                    ],
                  ),
                  //color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: 0,
                  top: 0,
                ),
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 0,
                  top: 0.0,
                ),
                child: const Center(
                  child: Text(
                    MyString.next,
                    style: TextStyle(
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: KeyboardActions(
        autoScroll: false,
        config: _buildKeyboardActionsConfig(context),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  hSizedBox2,
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      MyString.selectLocation,
                      style: TextStyle(
                        color: MyColors.color_text,
                        fontSize: 18,
                        fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // hSizedBox2,
                  // const Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     MyString.selectMobileOperator,
                  //     style: TextStyle(
                  //       color: MyColors.color_text,
                  //       fontSize: 16,
                  //       fontFamily: "assets/fonts/raleway/raleway_semibold.ttf",
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //   ),
                  // ),
                  hSizedBox3,
                  Visibility(
                    visible: locationList.isNotEmpty,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(locationList.length, (index) {
                        var item = locationList[index];
                        return GestureDetector(
                          onTap: () async {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Card(
                            shape: selectedIndex == index
                                ? RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: MyColors.lightblueColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  )
                                : RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: MyColors.whiteColor,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                            margin: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: MyColors.blackColor.withOpacity(0.20),
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Image.asset("assets/images/companyimg.png"),
                                  const Icon(
                                    Icons.my_location,
                                    color: MyColors.primaryColor,
                                    size: 30,
                                  ),
                                  wSizedBox1,
                                  Expanded(
                                    child: Text(
                                      item.address ?? '',
                                      style: const TextStyle(
                                        color: MyColors.color_text,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_medium.ttf',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FieldSetsModel model

  Future<void> getLocationListApi(
    BuildContext context,
  ) async {
    // Utility.ProgressloadingDialog(context, true);
    CustomLoader.ProgressloadingDialog6(context, true);

    load = true;
    setState(() {});
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var iso3 = sharedPreferences.getString('iso3');
    var request = {'country_iso2': iso3};
    HttpWithMiddleware http = HttpWithMiddleware.build(
      middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ],
    );

    var response = await http.get(
      Uri.parse(
        '${AllApiService.pickuplocationsbycountryiso3URL}?country_iso3=$iso3',
      ),
      // body: jsonEncode(request),
      headers: {
        'X-CLIENT': AllApiService.x_client,
      },
    );
    CustomLoader.ProgressloadingDialog6(context, false);
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      LocationResponse locationResponse =
          LocationResponse.fromJson(jsonResponse);
      locationList = locationResponse.data!.locationdata!;
    } else {
      Utility.showFlutterToast(jsonResponse['message']);
    }
    load = false;
    setState(() {});
    return;
  }

  onNextTap(BuildContext context) async {
    if (selectedIndex < 0) {
      Utility.showFlutterToast('Please select mobile operator');
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
        'mfs_mobile_operator_name',
        locationList[selectedIndex].address.toString(),
      );
      sharedPreferences.setString(
        'recipientReceiveBankNameOrOperatorName',
        locationList[selectedIndex].agentName.toString(),
      );
      sharedPreferences.setString(
        'juba_NominatedCode',
        locationList[selectedIndex].agentCode.toString(),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => (widget.isAlreadyRecipient ?? false)
              ? const SendMoneyQuotationFromNewRecipient(
                  isAlreadyRecipient: true,
                )
              : const SendMoneyQuotationFromNewRecipient(),
        ),
      );
    }
  }
}
