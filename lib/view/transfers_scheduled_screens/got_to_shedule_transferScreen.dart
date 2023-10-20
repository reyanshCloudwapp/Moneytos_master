import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../constance/myColors/mycolor.dart';
import '../../constance/myStrings/myString.dart';

class GoToSheduleTransfer_Screene extends StatefulWidget {
  const GoToSheduleTransfer_Screene({Key? key}) : super(key: key);

  @override
  State<GoToSheduleTransfer_Screene> createState() => _GoToSheduleTransfer_ScreeneState();
}

class _GoToSheduleTransfer_ScreeneState extends State<GoToSheduleTransfer_Screene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "a_assets/logo/confirm_img.svg",
                    height: 100,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text(MyString.please_confirm,textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),),
                ),

                Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text(MyString.exchange_rate_will_be_calculated_on_the,textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf"),),
                ),


                Container(
                  padding: EdgeInsets.only(top: 50,left: 25,right: 25),
                  //  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (_) => TransferReasonforSendingScreen2()));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        //  width: 100,
                        child: Material(
                          color: MyColors.whiteColor,
                          elevation: 0.1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyColors.lightblueColor
                                //  border: Border.all(color: bordercolor,width: 1.4)
                              ),
                              child: Center(child: Text(MyString.confirm,style: TextStyle(fontFamily: "s_asset/font/raleway/raleway_bold.ttf",color:MyColors.whiteColor,fontSize:18,fontWeight: FontWeight.w700,letterSpacing: 0.4 ),))),
                        )

                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
