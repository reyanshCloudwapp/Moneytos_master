import 'package:flutter/material.dart';
import 'package:moneytos/utils/constance/myColors/mycolor.dart';

class CustomButton extends StatelessWidget {
  final String btnname;
  final Color bg_color, textcolor, bordercolor;
  final double height;
  final double fontsize;

  const CustomButton({
    Key? key,
    this.btnname = '',
    this.bg_color = MyColors.primaryColor,
    this.textcolor = MyColors.whiteColor,
    this.bordercolor = MyColors.primaryColor,
    this.height = 50,
    this.fontsize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Material(
        elevation: 1,
        shadowColor: MyColors.btncolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              //  stops: [0.0, 1.0],
              colors: [
                MyColors.btncolor.withOpacity(0.30),
                MyColors.btncolor.withOpacity(0.80),
              ],
            ),
            //    border: Border.all(color: bordercolor,width: 1.4)
          ),
          child: Center(
            child: Text(
              btnname,
              style: TextStyle(
                fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                color: textcolor,
                fontSize: fontsize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  addressList() {
    return const Column(
      children: [
        Row(
          children: [],
        )
      ],
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String btnname;
  final Color bg_color, textcolor, bordercolor;
  final double height;
  final double fontsize;

  const CustomButton2({
    Key? key,
    this.btnname = '',
    this.bg_color = MyColors.primaryColor,
    this.textcolor = MyColors.whiteColor,
    this.bordercolor = MyColors.primaryColor,
    this.height = 50,
    this.fontsize = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Material(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              //  stops: [0.0, 1.0],
              colors: [
                MyColors.darkbtncolor.withOpacity(0.90),
                MyColors.darkbtncolor,
              ],
            ),
            border: Border.all(color: bordercolor, width: 1.4),
          ),
          child: Center(
            child: Text(
              btnname,
              style: TextStyle(
                fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                color: textcolor,
                fontSize: fontsize,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ),
      ),
    );
  }

  addressList() {
    return const Column(
      children: [
        Row(
          children: [],
        )
      ],
    );
  }
}
