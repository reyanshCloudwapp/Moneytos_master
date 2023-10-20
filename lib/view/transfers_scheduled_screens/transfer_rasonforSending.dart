import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/customScreens/custom_selectbanklist.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/view/dash_settingscreen/manage_payment_method/menage_payment_methodScreen.dart';
import 'package:moneytos/view/home/s_home/reasonforsendingpaymethod/reasonforsendingpaymethod.dart';
import 'package:moneytos/view/select_payment_method_screen/select_payment_method_screen.dart';
import 'package:moneytos/view/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/LinkNew_ScedulePayment_MethodScreen2.dart';
import 'package:moneytos/view/transfers_scheduled_screens/duplicate_screen_fromsendmoney_schedule/ReasonFor_SendingSchedule_PaymethodScreen2.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transferreview_and_confirmScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TransferReasonforSendingScreen2 extends StatefulWidget{
  final bool isMfs;

  const TransferReasonforSendingScreen2({super.key, required this.isMfs});

  @override
  State<TransferReasonforSendingScreen2> createState() => _TransferReasonforSendingScreen2State();
}

class _TransferReasonforSendingScreen2State extends State<TransferReasonforSendingScreen2> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQueryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              backgroundColor: MyColors.light_primarycolor2,
              elevation: 0,
              centerTitle: true,
              flexibleSpace: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only( left: 25,top: 20),
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only( top: 5),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              "s_asset/images/leftarrow.svg",
                                height: 32,
                                width: 32
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(00, 5, 0, 0),
                        child:  Text(
                          MyString.Reason_for_Sending,
                          style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: "s_asset/font/raleway/raleway_medium.ttf"
                          ),
                        )
                        ,
                      ),
                      Container(
                        width: 40,
                      )
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ),
          bottomSheet: GestureDetector(
            onTap: (){
             Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              height: 70,
              alignment: Alignment.topCenter,
              child: Text("Skip",style: TextStyle(fontSize: 16,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500,color: MyColors.lightblueColor),),
            ),
          ),
          backgroundColor: MyColors.light_primarycolor2,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(color: MyColors.light_primarycolor2,height: 300,width: MediaQuery.of(context).size.width,),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: MyColors.whiteColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 40),
                      scrollDirection: Axis.vertical,
                    //  physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1/0.42 ,
                        crossAxisSpacing: 1.1,
                        mainAxisSpacing: 0.3,
                      ),
                      children:CustomList.titlelist.map((String url) {
                        return GestureDetector(
                            onTap: (){
                            /*  pushNewScreen(
                                context,
                                screen: TransferReview_andConfirmScreen(),
                                withNavBar: false,
                              );*/

                              pushNewScreen(
                                context,
                                screen: ReasonForSendingPaymethodScreen2(isMfs: widget.isMfs),
                                withNavBar: false,
                              );


                            },
                            child:  Container(

                                margin: EdgeInsets.only(left: 8,top: 12,right: 8),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(color: MyColors.color_text.withOpacity(0.2),width: 1.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 0.0),
                                child:Center(child: Text(MyString.Education,style: TextStyle(color: MyColors.color_text,fontSize: 14,fontFamily: "s_asset/font/raleway/raleway_medium.ttf",fontWeight: FontWeight.w500),))
                            )
                        );
                      }).toList(),
                    ),

                  ),
                )
              ],
            ),
          ),

        )
    );
  }
}