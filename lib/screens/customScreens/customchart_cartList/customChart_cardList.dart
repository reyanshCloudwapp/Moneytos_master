import 'package:moneytos/utils/import_helper.dart';

class CustomChartCardList extends StatelessWidget {
  final String recipient_name;
  final String img;
  final String amount;
  final String totalamount;

  const CustomChartCardList({
    Key? key,
    required this.recipient_name,
    required this.img,
    required this.amount,
    required this.totalamount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: MyColors.lightblueColor.withOpacity(0.05),
                  ),
                  height: 40,
                  width: 40,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: FadeInImage(
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        img.toString(),
                      ),
                      placeholder: const AssetImage(
                        'assets/logo/progress_image.png',
                      ),
                      placeholderFit: BoxFit.scaleDown,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: MyColors.divider_color,
                          alignment: Alignment.center,
                          child: Text(
                            recipient_name.toString()[0].toUpperCase(),
                            style: const TextStyle(
                              color: MyColors.shedule_color,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_bold.ttf',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // backgroundImage: NetworkImage(recipientList[index].profileImage.toString()),
                ),
                /*CircleAvatar(
                  radius: 20,
                  backgroundImage: img.isEmpty ?  AssetImage("assets/logo/profile_img.png",) : NetworkImage(url),
                ),*/
                wSizedBox1,

                ///Recipient name
                Container(
                  width: 160,
                  alignment: Alignment.topLeft,
                  child: Text(
                    recipient_name,
                    style: const TextStyle(
                      color: MyColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      double.parse(amount).toStringAsFixed(2),
                      style: const TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  wSizedBox,
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      MyString.usd,
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        hSizedBox1,
        hSizedBox,
        LinearProgressIndicator(
          value: double.parse(totalamount) / double.parse(amount),
          color: MyColors.lightblueColor,
          semanticsLabel: 'Linear progress indicator',
        ),
        hSizedBox1,
      ],
    );
  }
}
