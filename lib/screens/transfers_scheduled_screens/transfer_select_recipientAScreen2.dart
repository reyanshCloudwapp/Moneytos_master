import 'package:flutter/cupertino.dart';
import 'package:moneytos/screens/recipients_opened_sscreen/custom_recipientsopenedList.dart';
import 'package:moneytos/screens/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:moneytos/screens/transfers_scheduled_screens/transfer_send_moneyfromRecipient2.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TransferSelectRecipientScreen2 extends StatefulWidget {
  final bool isMfs;

  const TransferSelectRecipientScreen2({super.key, required this.isMfs});

  @override
  State<TransferSelectRecipientScreen2> createState() =>
      _TransferSelectRecipientScreen2State();
}

class _TransferSelectRecipientScreen2State
    extends State<TransferSelectRecipientScreen2> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(265),
        child: AppBar(
          backgroundColor: MyColors.light_primarycolor2,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, top: 65, right: 20),
            child: Column(
              children: [
                /// appbar ui....

                Column(
                  children: [
                    /// Profile image
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 16, 0.0, 10.0),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40,
                            backgroundImage: AssetImage(
                              'assets/logo/female_profile.jpg',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 26,
                            width: 26,
                            decoration: const BoxDecoration(
                              color: MyColors.accent_ED5565_red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: AssetImage('assets/images/closeimg.png'),
                              ),
                            ),
                            margin: const EdgeInsets.fromLTRB(26, 0, 0.0, 10.0),
                          ),
                        ),
                      ],
                    ),

                    /// recipent name

                    hSizedBox1,
                    const Text(
                      MyString.recipient_name,
                      style: TextStyle(
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                      ),
                    ),
                    hSizedBox,

                    Text(
                      '(+61) 124-335-547',
                      style: TextStyle(
                        color: MyColors.whiteColor.withOpacity(0.50),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                      ),
                    ),

                    hSizedBox1,
                    hSizedBox,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, right: 1),
                          child: SvgPicture.asset(
                            'assets/icons/au_australia.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        wSizedBox,
                        Container(
                          margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
                          child: const Text(
                            'Sydney, AU',
                            style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_semibold.ttf',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.light_primarycolor2,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
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
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 0),
            width: double.infinity,
            height: size.height,
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(30),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: MyColors.whiteColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  hSizedBox1,

                  /// create listview....

                  // hSizedBox2,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        //CustomList.countrylist.map((String url) {
                        // return
                        Container(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 10,
                            bottom: 10,
                          ),
                          child: const CustomRecipientOpenedCardList(
                            title: MyString.qnb_ba,
                            icon: 'assets/icons/edit.svg',
                            subtitle: MyString.bank_deposit,
                            bordercolor: MyColors.lightblueColor,
                            status: true,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          child: CustomRecipientOpenedCardList(
                            title: 'Vodafone',
                            icon: 'assets/icons/edit.svg',
                            subtitle: 'Mobile Money',
                            bordercolor:
                                MyColors.lightblueColor.withOpacity(0.05),
                          ),
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            debugPrint('hbdhjbdf');
                            pushNewScreen(
                              context,
                              screen: SelectPaymentMethodScreen(
                                selectedMethodScreen: 0,
                                isMfs: widget.isMfs,
                              ),
                              withNavBar: false,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.45,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 30,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  MyColors.lightblueColor.withOpacity(0.70),
                                  MyColors.lightblueColor.withOpacity(0.90),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: MyColors.lightblueColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        MyColors.whiteColor,
                                        MyColors.whiteColor
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.add,
                                    color: MyColors.lightblueColor,
                                  ),
                                ),
                                hSizedBox2,
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    MyString.add_new_method,
                                    style: TextStyle(
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily:
                                          'assets/fonts/raleway/raleway_bold.ttf',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                      //}).toList(),
                    ),
                  ),

                  hSizedBox2,

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 8),
                        child: const Text(
                          MyString.receive_methods,
                          style: TextStyle(
                            color: MyColors.color_text_a,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 12.0, left: 8),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/bank.svg',
                          height: 20,
                          width: 20,
                          color: MyColors.blackColor,
                        ),
                        wSizedBox1,
                        const Text(
                          MyString.bank_deposite,
                          style: TextStyle(
                            color: MyColors.color_text,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
                        ),
                      ],
                    ),
                  ),
                  hSizedBox3,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              MyString.bank_name,
                              style: TextStyle(
                                color: MyColors.color_text_a,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                              ),
                            ),
                            hSizedBox1,
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/bankicon1.png',
                                  height: 26,
                                  width: 26,
                                ),
                                wSizedBox1,
                                const Text(
                                  'QNB',
                                  style: TextStyle(
                                    color: MyColors.color_text,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    fontFamily:
                                        'assets/fonts/raleway/raleway_bold.ttf',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              MyString.Swift_Code,
                              style: TextStyle(
                                color: MyColors.color_text_a,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_medium.ttf',
                              ),
                            ),
                            hSizedBox1,
                            Text(
                              'QNB212XXX57',
                              style: TextStyle(
                                color: MyColors.color_text,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_semibold.ttf',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 24.0, left: 8),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MyString.iban_code,
                          style: TextStyle(
                            color: MyColors.color_text_a,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
                        ),
                        hSizedBox1,
                        Text(
                          'SAF548215445REW214874521',
                          style: TextStyle(
                            color: MyColors.color_text,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily:
                                'assets/fonts/raleway/raleway_semibold.ttf',
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (Context) =>
                              const TransferSendMoneyFromRecipient2(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width / 5,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 50,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [
                            MyColors.lightblueColor.withOpacity(0.80),
                            MyColors.lightblueColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: MyColors.lightblueColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              MyString.Next,
                              style: TextStyle(
                                color: MyColors.whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_bold.ttf',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}