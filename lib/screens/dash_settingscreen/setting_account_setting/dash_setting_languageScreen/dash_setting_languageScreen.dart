import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/utils/import_helper.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenScreenState();
}

class _LanguageScreenScreenState extends State<LanguageScreen> {
  String? index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: size.height * 0.3,
            color: MyColors.primaryColor,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                hSizedBox3,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/arrow_back.svg',
                        ),
                      ),
                      wSizedBox3,
                      wSizedBox1,
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          MyString.language,
                          style: TextStyle(
                            color: MyColors.whiteColor.withOpacity(0.86),
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            fontFamily:
                                'assets/fonts/raleway/raleway_extrabold.ttf',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                hSizedBox3,

                /// body..

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: CustomList.language.length,
                    itemBuilder: (context, int i) {
                      return GestureDetector(
                        onTap: () {
                          index == i.toString();
                          debugPrint('index..$index ');
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CustomCardList(
                            CustomList.language[i].toString(),
                            i,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  CustomCardList(String title, int i) {
    return Material(
      color: MyColors.whiteColor,
      elevation: 0.02,
      shadowColor: MyColors.lightblueColor.withOpacity(0.01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: (index == i.toString())
              ? MyColors.lightblueColor
              : MyColors.border_color,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: i.toString() == index
                ? MyColors.lightblueColor
                : MyColors.border_color,
            width: 0.8,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: i.toString() == index
                ? MyColors.lightblueColor
                : MyColors.blackColor,
            fontSize: 14,
            fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
          ),
        ),
      ),
    );
  }
}
