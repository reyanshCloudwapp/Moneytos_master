import 'package:moneytos/screens/home/s_home/pin/TransferPinCodeScreen2.dart';
import 'package:moneytos/screens/home/s_home/sendsuccessfullytransferscreen/sendsuccessfulyscreen.dart';
import 'package:moneytos/utils/import_helper.dart';

class TransferVerificationTouchFaceId extends StatefulWidget {
  const TransferVerificationTouchFaceId({super.key});

  @override
  State<TransferVerificationTouchFaceId> createState() =>
      _TransferVerificationTouchFaceIdState();
}

class _TransferVerificationTouchFaceIdState
    extends State<TransferVerificationTouchFaceId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightblueColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.lightblueColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: MyColors.lightblueColor,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // hSizedBox5,
            hSizedBox2,

            ///title
            Container(
              alignment: Alignment.center,
              child: const Text(
                MyString.verification1,
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                ),
              ),
            ),
            hSizedBox,

            /// des
            Container(
              alignment: Alignment.center,
              child: Text(
                MyString.using_one_of_below_to_proceed_transaction,
                style: TextStyle(
                  color: MyColors.whiteColor.withOpacity(0.80),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                ),
              ),
            ),
            hSizedBox4,
            hSizedBox1,

            /// usin touch id
            ///title
            Container(
              alignment: Alignment.center,
              child: const Text(
                MyString.using_touch_id,
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                ),
              ),
            ),
            hSizedBox2,
            hSizedBox1,

            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SendSuccessfullyTransferScreen(
                      readyremit_transferId: '',
                      sendAmount: '',
                      transfer_reason: '',
                      fees: '',
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/logo/touch_id.svg'),
              ),
            ),

            hSizedBox5,
            hSizedBox2,

            /// usin face id
            ///title
            Container(
              alignment: Alignment.center,
              child: const Text(
                MyString.using_face_id,
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                ),
              ),
            ),
            hSizedBox2,
            hSizedBox1,

            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/logo/face_d.svg'),
            ),
            hSizedBox5,

            /// usin pincode
            ///title
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                transferbottomsheet(context);
              },
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  MyString.or_using_pin_code,
                  style: TextStyle(
                    color: MyColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
                  ),
                ),
              ),
            ),
            hSizedBox5,
          ],
        ),
      ),
    );
  }

  transferbottomsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      // anchorPoint: Offset(20.0, 30.0),
      backgroundColor: MyColors.lightblueColor.withOpacity(0.10),
      builder: (context) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.86,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const TransferPinCodeScreen2(),
          ),
        );
      },
    );
  }
}
