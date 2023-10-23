import 'package:moneytos/screens/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/Select_PaymentMethod_from_ScheduleScreen2.dart';
import 'package:moneytos/utils/import_helper.dart';

class MobileMoneypinServiceProScreen2 extends StatefulWidget {
  const MobileMoneypinServiceProScreen2({super.key});

  @override
  State<MobileMoneypinServiceProScreen2> createState() =>
      _MobileMoneypinServiceProScreen2State();
}

class _MobileMoneypinServiceProScreen2State
    extends State<MobileMoneypinServiceProScreen2> {
  TextEditingController ibanController = TextEditingController();

  FocusNode ibanFocus = FocusNode();

  /// create number list
  List<int> firstlist = [1, 2, 3];

  List<int> secondlist = [4, 5, 6];

  List<int> thirdlist = [7, 8, 9];

  int pinlength = 6;

  String pinEntered = '';

  String workingpin = '123456';

  String alert = '';

  bool is_keyboard = false;

  numberClicked(int item) {
    pinEntered = pinEntered + item.toString();
    debugPrint('object$pinEntered');
    if (pinEntered.length == pinlength) {
      alert = (pinEntered == workingpin)
          ? 'Good luck'
          : 'Incorrect please try again';
    }
    setState(() {});
  }

  backSpace() {
    if (pinEntered.isNotEmpty) {
      pinEntered = pinEntered.substring(0, pinEntered.length - 1);
      alert = '';
      debugPrint('pinentered..$pinEntered');
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ibanFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.color_03153B,
          elevation: 0,
          centerTitle: true,
          leading: Container(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: SvgPicture.asset(
                'assets/images/leftarrow.svg',
                height: 32,
                width: 32,
              ),
            ),
          ),
          title: const Column(
            children: [
              Text(
                MyString.Mobile_Money_Number,
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                ),
              )
            ],
          ),
        ),
        backgroundColor: MyColors.whiteColor,
        bottomSheet: Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          color: MyColors.whiteColor,
          height: 60,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              //   Navigator.push(context, MaterialPageRoute(builder: (_) => BankAccountNumber() ));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              height: 50,
              width: 100,
              color: MyColors.whiteColor,
              child: CustomButton(
                btnname: MyString.back,
                textcolor: MyColors.lightblueColor,
                bordercolor: MyColors.lightblueColor.withOpacity(0.08),
                bg_color: MyColors.lightblueColor.withOpacity(0.14),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  color: MyColors.color_03153B,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                hSizedBox2,
                                Column(
                                  children: [
                                    hSizedBox2,
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 16,
                                        bottom: 20,
                                        left: 26,
                                        right: 26,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'a small amount will be deducted and \n refunded again for verified and\n linked your Mobile Money',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: MyColors.color_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                    ),
                                    hSizedBox4,
                                    IBAN(),
                                    is_keyboard == true
                                        ? keyboardNum()
                                        : Container(),
                                    hSizedBox2,
                                    hSizedBox2,
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        debugPrint('shivangi');

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SelectPayMethScheduleScreen2(
                                              selectedMethodScheduleScreen: 2,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 46,
                                        width: 210,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              MyColors.lightblueColor
                                                  .withOpacity(0.80),
                                              MyColors.lightblueColor,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: MyColors.lightblueColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Link Mobile Money ',
                                            style: TextStyle(
                                              color: MyColors.whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              fontFamily:
                                                  'assets/fonts/raleway/raleway_bold.ttf',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                hSizedBox5,
                                hSizedBox7,
                                hSizedBox5,
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  IBAN() {
    return Container(
      margin: const EdgeInsets.only(left: 22, right: 22),
      height: 48,
      decoration: BoxDecoration(
        color: MyColors.blueColor.withOpacity(0.02),
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        focusNode: ibanFocus,
        onTap: () {
          is_keyboard = true;
          setState(() {});
        },
        controller: ibanController,
        cursorColor: MyColors.primaryColor,
        decoration: InputDecoration(
          fillColor: MyColors.blueColor.withOpacity(0.40),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.whiteColor),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          hintText: '12xx-xxx-xxx-xx',
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/paste.svg',
              height: 15,
            ),
          ),
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.30),
            fontSize: 12,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  keyboardNum() {
    return Column(
      children: [
        hSizedBox2,

        /// number ui
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: firstlist.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: numberButton(e),
              );
            }).toList(),
          ),
        ),

        hSizedBox3,

        /// number button2
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: secondlist.map((e) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: numberButton(e),
            );
          }).toList(),
        ),

        hSizedBox3,

        /// number button3
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: thirdlist.map((e) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: numberButton(e),
            );
          }).toList(),
        ),

        hSizedBox3,

        /// number button4
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: InkWell(
                onTap: () {
                  backSpace();
                },
                child: Container(
                  width: 50,
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    'assets/icons/close_square.svg',
                    height: 25,
                    width: 25,
                  ),
                ),
                //Icon(CupertinoIcons.clear_fill,color: MyColors.blackColor,)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: SizedBox(
                width: 50,
                child: numberButton(0),
              ),
            ),
            (pinEntered != workingpin && pinEntered.length == pinlength)
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: Container(
                      // height: 20,
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(top: 22),
                      child: const Text(
                        '.',
                        style: TextStyle(
                          color: MyColors.lightblueColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
        // hSizedBox4,
        // (pinEntered != workingpin && pinEntered.length == pinlength) ?
        // Container():
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   child: CustomButton2(btnname:MyString.submit,bg_color: MyColors.lightblueColor,bordercolor: MyColors.lightblueColor,),
        // ),
        // hSizedBox4,
      ],
    );
  }

  numberButton(int item) {
    return GestureDetector(
      onTap: () {
        numberClicked(item);
      },
      child: SizedBox(
        width: 40,
        height: 30,
        child: Text(
          item.toString(),
          style: const TextStyle(
            color: MyColors.blackColor,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            fontFamily: 'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
          ),
        ),
      ),
    );
  }

  addMathodButton(
    String text,
    double height,
    double width,
  ) {
    return Container(
      height: height,
      // width: width,
      color: MyColors.whiteColor,
      //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
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
              MyColors.color_3F84E5.withOpacity(0.88),
              MyColors.color_3F84E5,
            ],
          ),
          //color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 22),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: MyColors.whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              fontFamily: 'assets/fonts/raleway/Bold.ttf',
            ),
          ),
        ),
      ),
    );
  }
}
