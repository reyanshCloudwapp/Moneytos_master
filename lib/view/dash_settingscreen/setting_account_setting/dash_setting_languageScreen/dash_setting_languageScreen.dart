import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/model/customlists/customLists.dart';

import '../../../../constance/sizedbox/sizedBox.dart';

class LanguageScreen extends StatefulWidget {
   LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenScreenState createState() => _LanguageScreenScreenState();
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
          Container(
            // margin: EdgeInsets.only(top: size.height /9),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  hSizedBox3,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("a_assets/icons/arrow_back.svg")),
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
                                "s_asset/font/raleway/raleway_extrabold.ttf"),
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
                    padding: EdgeInsets.symmetric(horizontal: 23),
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: CustomList.language.length,
                        itemBuilder: (context,int i){
                      return Container(
                        child: GestureDetector(
                          onTap: (){
                            index == i.toString();
                            print("index..${index} ");
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child:CustomCardList(CustomList.language[i].toString(),i)
                          ),
                        ),
                      );
                    })

                    ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  CustomCardList(String title,int i){
return Container(
  child: Material(
    color: MyColors.whiteColor,
    elevation: 0.02,
    shadowColor: MyColors.lightblueColor.withOpacity(0.01),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side:  BorderSide(color: index == i ? MyColors.lightblueColor :  MyColors.border_color)
    ),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 25,horizontal: 25),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color:   i == index ? MyColors.lightblueColor : MyColors.border_color,width: 0.8 )
      ),
      child: Text(title,style: TextStyle(color:  i == index ? MyColors.lightblueColor :  MyColors.blackColor,fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),),
    ),
  ),
);
  }
}
