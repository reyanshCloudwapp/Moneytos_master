import 'package:moneytos/utils/import_helper.dart';

class FrontImageScreen extends StatefulWidget {
  const FrontImageScreen({Key? key}) : super(key: key);

  @override
  State<FrontImageScreen> createState() => _FrontImageScreenState();
}

class _FrontImageScreenState extends State<FrontImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            hSizedBox4,
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
              child: const Text(
                MyString.front_image,
                style: TextStyle(
                  color: MyColors.blackColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                  fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                ),
              ),
            ),
            hSizedBox,
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(00, 5, 0, 0),
              child: const Text(
                MyString.position_the_front_of_your_proof,
                style: TextStyle(
                  color: MyColors.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                ),
              ),
            ),
            hSizedBox4,
            hSizedBox,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InkWell(
                onTap: () {
                  //  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  'assets/images/face_id.svg',
                ),
              ),
            ),
            hSizedBox5,
            Container(
              // height: 50,
              // width: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  //  stops: [0.0, 1.0],
                  colors: [
                    MyColors.color_3F84E5.withOpacity(0.10),
                    MyColors.color_3F84E5.withOpacity(0.40),
                  ],
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  'assets/icons/choose_doc/camera.svg',
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            hSizedBox5,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: const CustomButton2(
                btnname: MyString.confirm,
                bg_color: MyColors.lightblueColor,
                bordercolor: MyColors.lightblueColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
