import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';

class CustomSelectCountryList extends StatelessWidget {
  String title,img;
  CustomSelectCountryList({Key? key,this.title="",required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyColors.blackColor.withOpacity(0.20),width: 0.5),
      ),
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(height: 10,),
          CircledFlag(flag: img, radius: 15,),

          Text(title,textAlign: TextAlign.center,style: TextStyle(color: MyColors.color_text,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontSize: 16,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),)
        ],
      ),
    );
  }


}

class CircledFlag extends StatelessWidget {
  const CircledFlag({
    Key? key,
    required this.flag,
    required this.radius,
  }) : super(key: key);

  final String flag;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _FlagClipper(radius),
      child: Text(
        flag,
        style: TextStyle(fontSize:2* radius),
      ),
    );
  }
}

class _FlagClipper extends CustomClipper<Path> {
  const _FlagClipper(this.radius);

  final double radius;

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);

    path.addOval(Rect.fromCircle(center: center, radius: radius));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


