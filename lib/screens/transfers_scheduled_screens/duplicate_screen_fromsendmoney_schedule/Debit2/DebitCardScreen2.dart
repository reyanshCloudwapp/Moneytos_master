import 'package:moneytos/screens/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/Select_PaymentMethod_from_ScheduleScreen2.dart';
import 'package:moneytos/utils/import_helper.dart';

import '../../../bank_accountnumber/bank_accountNumber.dart';

class DebitCardScreen2 extends StatefulWidget {
  const DebitCardScreen2({super.key});

  @override
  State<DebitCardScreen2> createState() => _DebitCardScreenState2();
}

class _DebitCardScreenState2 extends State<DebitCardScreen2> {
  TextEditingController ibanController = TextEditingController();
  FocusNode ibanFocus = FocusNode();

  int debitcard = 1;

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(5),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.primaryColor,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: MyColors.primaryColor,
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
          ),
        ),
        backgroundColor: MyColors.whiteColor,
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: MyColors.whiteColor,
          height: 80,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Custombtn(MyString.back, 70, 140, context),
            ),
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  color: MyColors.primaryColor,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Add New Debit Card',
                                style: TextStyle(
                                  color: MyColors.whiteColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                  fontFamily:
                                      'assets/fonts/raleway/raleway_extrabold.ttf',
                                ),
                              ),
                            ),
                            Container()
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 22, 0, 0),
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 0,
                          color: MyColors.whiteColor,
                          margin: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              hSizedBox3,
                              Image.asset(
                                'assets/images/visa.png',
                                width: 300,
                              ),
                              hSizedBox3,
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 22,
                                  right: 22,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: MyColors.blueColor.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.infinity,
                                child: TextField(
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  //  focusNode: ibanFocus,
                                  // controller: ibanController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                    fillColor:
                                        MyColors.blueColor.withOpacity(0.40),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyColors.whiteColor,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyColors.whiteColor,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyColors.whiteColor,
                                      ),
                                    ),
                                    // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                    hintText: 'Card holder name',

                                    hintStyle: TextStyle(
                                      color:
                                          MyColors.blackColor.withOpacity(0.30),
                                      fontSize: 14,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_medium.ttf',
                                    ),
                                  ),
                                ),
                              ),
                              hSizedBox3,
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 22,
                                  right: 22,
                                ),
                                height: 48,
                                decoration: BoxDecoration(
                                  color: MyColors.blueColor.withOpacity(0.02),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.infinity,
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  // focusNode: ibanFocus,
                                  // controller: ibanController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                    fillColor:
                                        MyColors.blueColor.withOpacity(0.40),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyColors.whiteColor,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyColors.whiteColor,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: MyColors.whiteColor,
                                      ),
                                    ),
                                    // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                    hintText: 'Card Number',

                                    hintStyle: TextStyle(
                                      color:
                                          MyColors.blackColor.withOpacity(0.30),
                                      fontSize: 14,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_medium.ttf',
                                    ),
                                  ),
                                ),
                              ),
                              hSizedBox3,
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 22,
                                      right: 22,
                                    ),
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color:
                                          MyColors.blueColor.withOpacity(0.02),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 150,
                                    child: TextField(
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.text,
                                      //focusNode: ibanFocus,
                                      // controller: ibanController,
                                      cursorColor: MyColors.primaryColor,
                                      decoration: InputDecoration(
                                        fillColor: MyColors.blueColor
                                            .withOpacity(0.40),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.whiteColor,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.whiteColor,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.whiteColor,
                                          ),
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                        hintText: 'MM / YYYY',

                                        hintStyle: TextStyle(
                                          color: MyColors.blackColor
                                              .withOpacity(0.30),
                                          fontSize: 14,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 0.0,
                                      right: 22,
                                    ),
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color:
                                          MyColors.blueColor.withOpacity(0.02),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: 150,
                                    child: TextField(
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.text,
                                      //  focusNode: ibanFocus,
                                      // controller: ibanController,
                                      cursorColor: MyColors.primaryColor,
                                      decoration: InputDecoration(
                                        fillColor: MyColors.blueColor
                                            .withOpacity(0.40),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.whiteColor,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.whiteColor,
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.whiteColor,
                                          ),
                                        ),
                                        // contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                        hintText: 'CCV',

                                        hintStyle: TextStyle(
                                          color: MyColors.blackColor
                                              .withOpacity(0.30),
                                          fontSize: 14,
                                          fontFamily:
                                              'assets/fonts/raleway/raleway_medium.ttf',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                color: MyColors.whiteColor,
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  top: 30,
                                  right: 10,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectPayMethScheduleScreen2(
                                          selectedMethodScheduleScreen: 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 150,
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
                                      left: 30,
                                      right: 30,
                                      bottom: 16,
                                      top: 16,
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: 0,
                                      top: 20.0,
                                    ),
                                    child: const Text(
                                      'Add Card',
                                      textAlign: TextAlign.center,
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
                              hSizedBox7,
                              hSizedBox4,
                              hSizedBox3,
                            ],
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
}
