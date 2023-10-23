import 'package:moneytos/screens/home/s_home/selectbankaccounnum/selectdeliveryaddmethod.dart';
import 'package:moneytos/utils/import_helper.dart';

class SelectDeliveryMethodBankAccNum extends StatefulWidget {
  const SelectDeliveryMethodBankAccNum({super.key});

  @override
  State<SelectDeliveryMethodBankAccNum> createState() =>
      _SelectDeliveryMethodBankAccNumState();
}

class _SelectDeliveryMethodBankAccNumState
    extends State<SelectDeliveryMethodBankAccNum> {
  TextEditingController ibanController = TextEditingController();
  FocusNode ibanFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ibanFocus.unfocus();
  }

  cleartextfield() {
    ibanController.clear();
  }

  oncallback() {
    cleartextfield();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.whiteColor,
        centerTitle: true,
        actions: const [],
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.whiteColor,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: const Text(
          MyString.Select_Delivery_Method,
          style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
      ),
      bottomSheet: Container(
        // alignment: Alignment.center,

        // margin: EdgeInsets.symmetric(vertical: 12) ,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        decoration: const BoxDecoration(
          color: MyColors.whiteColor,
        ),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                //  padding: EdgeInsets.only(top: size.height / 2),
                // alignment: Alignment.bottomRight,
                child: Custombtn(MyString.back, 80, 140, context),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SelectDeliveryAddMethodScreen(),
                  ),
                );
              },
              child: addMathodButton(MyString.add_method, 80, 200),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox2,
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
              padding: const EdgeInsets.fromLTRB(16.0, 0, 20.0, 0.0),
              decoration: const BoxDecoration(
                color: MyColors.whiteColor,
                //border: Border.all(color: MyColors.color_gray_transparent),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.color_linecolor,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/flag2.svg',
                        width: 26,
                        height: 26,
                      ),
                      wSizedBox1,
                      const Text(
                        MyString.country_name,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                          fontWeight: FontWeight.w500,
                          color: MyColors.color_text,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                    child: SvgPicture.asset('assets/icons/clear_red.svg'),
                  ),
                ],
              ),
            ),
            hSizedBox2,
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
              padding: const EdgeInsets.fromLTRB(16.0, 0, 20.0, 0.0),
              decoration: const BoxDecoration(
                color: MyColors.whiteColor,
                //  border: Border.all(color: MyColors.color_gray_transparent),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.color_linecolor,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      // SvgPicture.asset("assets/images/flag2.svg",width: 24,height: 24,),
                      //wSizedBox1,
                      Text(
                        MyString.city_name,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                          fontWeight: FontWeight.w500,
                          color: MyColors.color_text,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                    child: SvgPicture.asset('assets/icons/clear_red.svg'),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                hSizedBox3,
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 20),
                  alignment: Alignment.center,
                  child: const Text(
                    MyString.Bank_Account_Number,
                    style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                    ),
                  ),
                ),
                hSizedBox4,
                IBAN(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(right: 12, top: 12),
                    alignment: Alignment.bottomRight,
                    child: Custombtn(MyString.check, 70, 140, context),
                  ),
                ),
              ],
            ),
          ],
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
          hintText: MyString.iban_code,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/paste.svg',
              height: 15,
            ),
          ),
          hintStyle: TextStyle(
            color: MyColors.blackColor.withOpacity(0.30),
            fontSize: 14,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
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

Custombtn(String text, double height, double width, BuildContext context) {
  return Container(
    height: height,
    width: width,
    color: MyColors.whiteColor,
    //  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 6,vertical:MediaQuery.of(context).size.width / 8 ),
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
            MyColors.lightblueColor.withOpacity(0.36),
          ],
        ),
        //color: Colors.deepPurple.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: MyColors.lightblueColor,
            fontSize: 16,
            fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
