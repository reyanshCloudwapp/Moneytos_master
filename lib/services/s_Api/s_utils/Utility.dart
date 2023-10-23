import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:intl/intl.dart';
import 'package:moneytos/model/pak_code.dart';
import 'package:moneytos/utils/constance/myColors/mycolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {
  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  static showFlutterToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 10,
    );
  }

  static ProgressloadingDialog(BuildContext context, bool status) {
    if (status) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: GFLoader(
              type: GFLoaderType.custom,
              child: Image(
                image: AssetImage('assets/logo/progress_image.png'),
              ),
            ),
          );
        },
      );
      // return pr.show();
    } else {
      Navigator.pop(context);
      // return pr.hide();
    }
  }

  static String DatefomatToDate(String bigTime) {
    DateTime tempDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(bigTime);
    var dateFormat = DateFormat('MM-dd-yyyy'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToDDMMYYYY(String bigTime) {
    DateTime tempDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(bigTime);
    var dateFormat = DateFormat('dd-MM-yyyy'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToMonth(String bigTime) {
    DateTime tempDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(bigTime);
    var dateFormat = DateFormat('MMM'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToDDMMM(String bigTime) {
    DateTime tempDate = DateFormat('yyyy-MM-dd').parse(bigTime);
    var dateFormat = DateFormat('dd MMM'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToTime(String bigTime) {
    DateTime tempDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(bigTime);
    var dateFormat = DateFormat('hh:mm a'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToDateTime(String bigTime) {
    DateTime tempDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(bigTime);
    var dateFormat =
        DateFormat('MM-dd-yyyy hh:mm a'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToReferDate(String bigTime) {
    DateTime tempDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(bigTime);
    var dateFormat = DateFormat('MM-dd-yyyy'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToReferDateMMMddTime(String bigTime) {
    DateTime tempDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(bigTime);
    var dateFormat =
        DateFormat('MMM dd - hh:mma'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToReferDateMMMddyyyyTime(String bigTime) {
    DateTime tempDate = DateFormat('MM-dd-yyyy hh:mm a').parse(bigTime);
    var dateFormat =
        DateFormat('MMM dd - hh:mma'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToTimezoneDate(String bigTime) {
    DateTime tempDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(bigTime);
    var dateFormat = DateFormat('MM-dd-yyyy'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToYYYYMMTOMMDD(String bigTime) {
    DateTime tempDate = DateFormat('yyyy-MM-dd').parse(bigTime);
    var dateFormat = DateFormat('MM-dd-yyyy'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String DatefomatToScheduleDate(String bigTime) {
    DateTime tempDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(bigTime);
    var dateFormat = DateFormat('yyyy-MM-dd'); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    debugPrint('------------$createdDate');
    return createdDate;
  }

  static String CurrentDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyyy-MM-dd');
    String actualDate = formatterDate.format(now);
    return actualDate;
  }

  static transactionloadingDialog(BuildContext context, bool status) {
    if (status) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GFLoader(
              type: GFLoaderType.custom,
              child: Image(
                image: const AssetImage('assets/logo/txn_loader_new.gif'),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      );
      // return pr.show();
    } else {
      Navigator.pop(context);
      // return pr.hide();
    }
  }

  static transactionfinishloadingDialog(BuildContext context, bool status) {
    if (status) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GFLoader(
              type: GFLoaderType.custom,
              child: Image(
                image: const AssetImage(
                  'assets/logo/txnfinishedloadernew.gif',
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      );
      // return pr.show();
    } else {
      Navigator.pop(context);
      // return pr.hide();
    }
  }

  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(const Duration(days: 1));
  }

  static dialogError(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            'assets/images/failed.svg',
                            height: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          msg,
                          // "Something went Wrong",
                          style: const TextStyle(
                            fontSize: 16,
                            color: MyColors.blackColor,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                'assets/fonts/raleway/raleway_regular.ttf',
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.fromLTRB(
                                50.0,
                                12.0,
                                50.0,
                                12.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                              MyColors.darkbtncolor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop(context);
                          },
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                              fontSize: 15,
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily:
                                  'assets/fonts/raleway/raleway_regular.ttf',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static shrimmerGridLoader(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: GridView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: 2.7,
        ),
        itemBuilder: (context, index) {
          return Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: height,
              ),
            ),
          );
        },
      ),
    );
  }

  static shrimmerReasonGridLoader(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: GridView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.7,
        ),
        itemBuilder: (context, index) {
          return Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: height,
              ),
            ),
          );
        },
      ),
    );
  }

  static shrimmerCountryGridLoader(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: GridView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.7,
        ),
        itemBuilder: (context, index) {
          return Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: height,
              ),
            ),
          );
        },
      ),
    );
  }

  static shrimmerVerticalListLoader(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: height,
              ),
            ),
          );
        },
      ),
    );
  }

  static shrimmerVerticalRecentListLoader(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: height,
              ),
            ),
          );
        },
      ),
    );
  }

  static shrimmerHorizontalListLoader(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: SizedBox(
        height: height,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  height: height,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static shrimmerHorizontalListCircularLoader(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: SizedBox(
        height: height,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: width,
              height: height,
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
                child: SizedBox(
                  height: height,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  dialogAccountType(BuildContext context, Function update) {
    List<PakCodeModel> pakModelList = [];
    pakModelList.add(
      PakCodeModel(code: 'ABPL', name: 'Al Barak Bank Pakistan Ltd'),
    );
    pakModelList.add(PakCodeModel(code: 'BURJ', name: 'Burj Bank Limited'));
    pakModelList
        .add(PakCodeModel(code: 'SCB', name: 'STANDARD CHARTERED BANK'));
    pakModelList.add(PakCodeModel(code: 'SAMBA', name: 'SAMBA BANK LIMITED'));
    pakModelList.add(
      PakCodeModel(code: 'ABB', name: 'Al Baraka Bank Pakistan Limited'),
    );
    pakModelList.add(PakCodeModel(code: 'SILK', name: 'SILK BANK'));
    pakModelList.add(PakCodeModel(code: 'BOP', name: 'BANK OF PUNJAB'));
    pakModelList.add(PakCodeModel(code: 'NIB', name: 'NIB BANK'));
    pakModelList.add(
      PakCodeModel(code: 'BIPL', name: 'BANK ISLAMI PAKISTAN LIMITED'),
    );
    pakModelList.add(PakCodeModel(code: 'FBL', name: 'FAYSAL BANK LIMITED'));
    pakModelList.add(PakCodeModel(code: 'SUMMIT', name: 'SUMMIT BANK'));
    pakModelList.add(PakCodeModel(code: 'BAHL', name: 'BANK ALHABIB'));
    pakModelList.add(PakCodeModel(code: 'SBL', name: 'SONERI BANK LIMITED'));
    pakModelList.add(PakCodeModel(code: 'Meezan', name: 'MEEZAN BANK LIMITED'));
    pakModelList
        .add(PakCodeModel(code: 'HMBL', name: 'HABIB METROPOLITAN BANK'));
    pakModelList.add(PakCodeModel(code: 'DIB', name: 'DUBAI ISLAMIC BANK'));
    pakModelList.add(PakCodeModel(code: 'BAFL', name: 'BANK AL FALAH'));
    pakModelList.add(PakCodeModel(code: 'JSBL', name: 'JS BANK LIMITED'));
    pakModelList.add(PakCodeModel(code: 'KASB', name: 'KASB BANK LIMITED'));
    pakModelList.add(PakCodeModel(code: 'MCB', name: 'MCB Bank Limited'));
    pakModelList.add(PakCodeModel(code: 'HBL', name: 'HABIB BANK LIMITED'));
    pakModelList.add(PakCodeModel(code: 'UBL', name: 'UNITED BANK LIMITED'));
    pakModelList
        .add(PakCodeModel(code: 'NBP', name: 'NATIONAL BANK OF PAKISTAN'));
    pakModelList.add(PakCodeModel(code: 'BOK', name: 'BANK OF KHYBER'));
    pakModelList
        .add(PakCodeModel(code: 'FWB', name: 'FIRST WOMEN BANK LIMITED'));
    pakModelList.add(PakCodeModel(code: 'SIND', name: 'Sind Bank'));
    pakModelList.add(
      PakCodeModel(code: 'TMBL', name: 'Tameer MicroFinance Bank Ltd'),
    );
    pakModelList.add(PakCodeModel(code: 'SMEB', name: 'SME Bank Limited'));
    pakModelList.add(
      PakCodeModel(code: 'NRSP', name: 'NRSP MicroFinance Bank Ltd'),
    );
    pakModelList.add(
      PakCodeModel(code: 'APNA', name: 'Apna MicroFinance Bank Ltd'),
    );
    pakModelList.add(
      PakCodeModel(code: 'FINCA', name: 'FINCA MicroFinance Bank Ltd'),
    );
    pakModelList.add(
      PakCodeModel(code: 'WMBL', name: 'MobiLink MicroFinance Bank Ltd'),
    );
    pakModelList.add(
      PakCodeModel(code: 'UMBL', name: 'U MicroFinance Bank Limited'),
    );
    pakModelList.add(PakCodeModel(code: 'AKBL', name: 'Askari Bank Limited'));
    pakModelList.add(PakCodeModel(code: 'BBL', name: 'BARCLAYS BANK LIMITED'));
    pakModelList.add(
      PakCodeModel(code: 'BOJK', name: 'BANK OF AZAD JAMMU KASHMIR'),
    );
    pakModelList.add(
      PakCodeModel(
        code: 'FMBL',
        name: 'FIRST MICRO FINANCE BANK LIMITED',
      ),
    );
    pakModelList.add(PakCodeModel(code: 'HSBC', name: 'HSBC Bank Limited'));
    pakModelList.add(PakCodeModel(code: 'CITI', name: 'CITI BANK'));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        content: SizedBox(
          width: 300.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Bank Code',
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily:
                            'assets/fonts/raleway/raleway_extrabold.ttf',
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pakModelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            update(
                              pakModelList[index].code,
                              pakModelList[index].name,
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.radio_button_off_sharp,
                                  color: MyColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    '${pakModelList[index].code} - ${pakModelList[index].name}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future launchUrlApp(url) async {
    if (await canLaunchUrl(url)) {
      /// old code
      // await launch(url, forceWebView: true, enableJavaScript: true);
      await launchUrl(
        url,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
        ),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future stateDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                child: Container(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset('assets/icons/clear_red.svg'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const Text(
                'Moneytos is not available in your state at moment.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'assets/fonts/raleway/raleway_regular.ttf',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'We will notify you as soon as the application becomes available in your state. We apologize for any inconvenience caused and Thank you for understanding.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'assets/fonts/raleway/raleway_regular.ttf',
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // SizedBox(height: 50,),
            ],
          ),
        );
      },
    );
  }

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input; // Handle null or empty strings
    }

    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }
}
