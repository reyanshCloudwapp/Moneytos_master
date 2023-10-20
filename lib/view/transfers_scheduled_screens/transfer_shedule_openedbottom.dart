import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:moneytos/constance/custombuttom/CustomButton.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/view/dash_recipentScreen/select_recipient_screen/select_new_recipient_screen.dart';

import 'package:moneytos/view/select_recipent_contry/select_recipentCountry.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transfer_select_recipientAScreen2.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transfers_scheduled_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ScheduledTransferScreens/edit_sheduled_trnsferScreen.dart';
import '../../constance/customLoader/customLoader.dart';
import '../../constance/myStrings/myString.dart';
import '../../constance/sizedbox/sizedBox.dart';
import '../../s_Api/S_ApiResponse/ScheduleDetailResponse.dart';
import '../../s_Api/s_ModelClass/ScheduleTransferResponse.dart';
import '../../services/Apiservices.dart';
import 'dart:convert' as convert;

class TransferSheduleBottom extends StatefulWidget {
  String schedule_id;
  Function Oncallback;
  TransferSheduleBottom({Key? key,required this.schedule_id,required this.Oncallback}) : super(key: key);

  @override
  State<TransferSheduleBottom> createState() => _TransferSheduleBottomState();
}

class _TransferSheduleBottomState extends State<TransferSheduleBottom> {
  bool isload = false;
  bool isSwitched_pin = false;
  DateTime endDate = DateTime(1947,08,15);
  DateTime startDate = DateTime.now();
  List<DateTime> dateList = [];
  List<DateTime> weeklydateList = [];
  List<DateTime> monthlydateList = [];
  ScheduleDetailResponse scheduleDetailResponse = new ScheduleDetailResponse();

  void Update(){
    this.widget.Oncallback();
    Navigator.pop(context);
        setState(() {

        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scheduleDetailapi(context);





  }

  void main() {

    List<DateTime> getDays({
      required DateTime start,
      required DateTime end
    }) {
      final days = end.difference(start).inDays;

      return [
        for (int i = 0; i < days; i++)
          start.add(Duration(days: i))
      ];
    }

    List<DateTime> days = getDays(
      start: startDate,
      end: endDate,
    );
    dateList = days;
    dateList.add(endDate);

    print(days);

    setState(() {

    });

    // [
    //  2021-10-25 12:00:00.000,
    //  2021-10-26 12:00:00.000,
    //  2021-10-27 12:00:00.000
    // ]
  }


  void mainweelkly() {

    List<DateTime> getDays({
      required DateTime start,
      required DateTime end
    }) {
      final days = end.difference(start).inDays;

      return [
        for (int i = 0; i < days; i++)
          start.add(Duration(days: i))
      ];
    }

    List<DateTime> days = getDays(
      start: startDate,
      end: endDate,
    );
    // weeklydateList = days;
    for(int i=0; i < days.length; i++){


      if((i%7)==0){
        weeklydateList.add(days[i]);
        print("weekly dates>>>>> "+weeklydateList.toString());
      }

    }

    print(days);

    setState(() {

    });

    // [
    //  2021-10-25 12:00:00.000,
    //  2021-10-26 12:00:00.000,
    //  2021-10-27 12:00:00.000
    // ]
  }

  void mainmonthly() {

    List<DateTime> getDays({
      required DateTime start,
      required DateTime end
    }) {
      final days = end.difference(start).inDays;

      return [
        for (int i = 0; i < days; i++)
          start.add(Duration(days: i))
      ];
    }

    List<DateTime> days = getDays(
      start: startDate,
      end: endDate,
    );
    // weeklydateList = days;
    for(int i=0; i < days.length; i++){


      print("all dates forenfflksg>>>> "+Utility.DatefomatToMonth(days[i].toString()));
      if(Utility.DatefomatToMonth(days[i].toString())=="Jan"){
        print("dates>>>>> "+days[i].toString());
        if((i%31)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }else if(Utility.DatefomatToMonth(days[i].toString())=="Feb"){
        if((i%28)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Mar"){
        if((i%31)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Apr"){
        if((i%30)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="May"){
        if((i%31)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Jun"){
        if((i%30)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Jul"){
        if((i%31)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Aug"){
        if((i%31)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Sep"){
        if((i%30)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Oct"){
        if((i%31)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Nov"){
        if((i%30)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }
      else if(Utility.DatefomatToMonth(days[i].toString())=="Dec"){
        if((i%31)==0){
          monthlydateList.add(days[i]);
          print("weekly dates>>>>> "+weeklydateList.toString());
        }
      }else{
        monthlydateList.add(endDate);
      }


    }

    print(days);

    setState(() {

    });

    // [
    //  2021-10-25 12:00:00.000,
    //  2021-10-26 12:00:00.000,
    //  2021-10-27 12:00:00.000
    // ]
  }

  // List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
  //   List<DateTime> days = [];
  //   for (DateTime d = startDate;
  //   d.isBefore(endDate);
  //   d.add(Duration(days: 1))) {
  //     days.add(d);
  //   }
  //   return days;
  // }

  @override
  Widget build(BuildContext context) {
    return isload?Container(
      // color: MyColors.blackColor.withOpacity(0.30),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const GFLoader(
          type: GFLoaderType.custom,
          child: Image(image: AssetImage("a_assets/logo/progress_image.png"),
          )),
    ):Container(
      color: MyColors.primaryColor.withOpacity(0.01),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            //padding: EdgeInsets.only(top: 10),
            child: Container(
              height: 5,
              width: 150,
              decoration: BoxDecoration(
                  color: MyColors.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
          ),
          Container(
            color: MyColors.whiteColor,
            margin: const EdgeInsets.symmetric( vertical: 26),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  hSizedBox2,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.primaryColor.withOpacity(0.02)),
                    child: Column(
                      children: [
                        usercard(),
                       // hSizedBox,
                        deliveryMethid(),
                        hSizedBox2,

                      ],
                    ),
                  ),

                  hSizedBox2,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      MyString.new_transfer_at,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                          fontWeight: FontWeight.w500,
                          color: MyColors.blackColor.withOpacity(0.30)),
                    ),
                  ),
                  hSizedBox,
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child:   SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          scheduleDetailResponse.data!.scheduledata!.scheduleType=="Once"?
                          CalenderList(startDate.day.toString(), Utility.DatefomatToMonth(startDate.toString()),Utility.DatefomatToDDMMYYYY(startDate.toString())):
                          scheduleDetailResponse.data!.scheduledata!.scheduleType=="Daily"?
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 100,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: dateList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CalenderList(dateList[index].day.toString(), Utility.DatefomatToMonth(dateList[index].toString()),Utility.DatefomatToDDMMYYYY(dateList[index].toString()));
                                }
                            ),
                          ):
                          scheduleDetailResponse.data!.scheduledata!.scheduleType=="Weekly"?
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 100,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: weeklydateList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CalenderList(weeklydateList[index].day.toString(), Utility.DatefomatToMonth(weeklydateList[index].toString()), Utility.DatefomatToDDMMYYYY(weeklydateList[index].toString()));
                                }
                            ),
                          ):
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 100,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: monthlydateList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CalenderList(startDate.day.toString(), Utility.DatefomatToMonth(monthlydateList[index].toString()), Utility.DatefomatToDDMMYYYY(monthlydateList[index].toString()));
                                }
                            ),
                          )
                          ,
                          // CalenderList("14", "jan"),
                          // CalenderList("20", "jan"),
                          // CalenderList("28", "jan"),
                          // CalenderList("11", "jan"),
                          // CalenderList("30", "jan"),
                          // CalenderList("18", "jan"),
                          // CalenderList("5", "jan"),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    height: 30,
                    color: MyColors.lightblueColor.withOpacity(0.03),
                  ),
                  //hSizedBox3,

                  ///
                  exchangeRatecard(),


                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.primaryColor.withOpacity(0.02)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "a_assets/icons/bank4.svg",
                        ),

                        wSizedBox1,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(scheduleDetailResponse.data!.scheduledata!.senderSendMethod.toString()=="card"?"Card":"Bank",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "s_asset/font/montserrat/Montserrat-Bold.otf",color: MyColors.blackColor),),
                            ),

                            hSizedBox,
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(scheduleDetailResponse.data!.scheduledata!.senderSendMethod.toString()=="card"?"Card - ${scheduleDetailResponse.data!.scheduledata!.senderSendMethodLast4digit.toString()}":"Account - ${scheduleDetailResponse.data!.scheduledata!.senderSendMethodLast4digit.toString()}",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/montserrat/MontserratAlternates-Medium.otf",color: MyColors.blackColor),),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  hSizedBox2,
                 // hSizedBox,

                  /// alert strings................

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("All scheduled transfer will be processed at 4pm CST. Transfers scheduled after 4 pm CST will be processed the following day at 4pm CST.‏",
                       textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "s_asset/font/montserrat/MontserratAlternates-Medium.otf",color: MyColors.blackColor.withOpacity(0.70),letterSpacing: 0.7)),
                  ),

                 // hSizedBox2,

                  // GestureDetector(
                  //   onTap:(){
                  //
                  //     pushNewScreen(
                  //       context,
                  //       screen: TransferSelectRecipientScreen2(),
                  //       withNavBar: false,
                  //     );
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //
                  //     child: CustomButton2(btnname: MyString.send_money,bordercolor: MyColors.lightblueColor,),
                  //   ),
                  // ),
                  hSizedBox2,
                  Container(
                    margin:
                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // pincodeShowbottomsheet(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                            child: const Text(
                              "Schedule Status",
                              style: TextStyle(
                                  color:
                                  MyColors.color_text,
                                  fontWeight:
                                  FontWeight.w600,
                                  fontSize: 14,
                                  fontFamily:
                                  "s_asset/font/raleway/raleway_bold.ttf"),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: isSwitched_pin,
                            activeColor:  MyColors.lightblueColor.withOpacity(0.30),
                            trackColor: MyColors.lightblueColor.withOpacity(0.20),
                            thumbColor: isSwitched_pin == true? MyColors.lightblueColor:MyColors.lightblueColor4,
                            onChanged: (bool value) {
                              setState(() {
                                isSwitched_pin = value;

                                changeScheduleStatusapi(context, scheduleDetailResponse.data!.scheduledata!.id.toString());
                              });

                            },
                          ),
                        ),
                        // Switch(
                        //   activeColor: MyColors.color_3F84E5
                        //       .withOpacity(0.20),
                        //   activeTrackColor: MyColors.color_3F84E5.withOpacity(0.20),
                        //   thumbColor: MaterialStateColor.resolveWith((states) => MyColors.color_3F84E5.withOpacity(0.20)) ,
                        //   value: isSwitched_pin,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       isSwitched_pin = value;
                        //       pincodeShowbottomsheet(context);
                        //     });
                        //   },
                        // ),
                        /*   Container(
                                        height: 30,
                                        // width: 55,
                                        child: ToggleSwitch(
                                          minWidth: 28.0,
                                          cornerRadius: 20.0,
                                          activeBgColors: [
                                            [
                                              MyColors.color_3F84E5
                                                  .withOpacity(0.20)
                                            ],
                                            [
                                              MyColors.color_3F84E5
                                                  .withOpacity(0.20)
                                            ]
                                          ],
                                          activeFgColor: Colors.white,
                                          inactiveBgColor: MyColors
                                              .color_3F84E5
                                              .withOpacity(0.10),
                                          inactiveFgColor: Colors.white,
                                          initialLabelIndex: 0,
                                          totalSwitches: 2,
                                          labels: ['', ''],
                                          radiusStyle: true,
                                          onToggle: (index) {},
                                        ),
                                      ),*/
                      ],
                    ),
                  ),
                  hSizedBox2,

                  scheduleDetailResponse.data!.scheduledata!.isCancelled == 1?
                      const Text("Cancelled",style: TextStyle(color: MyColors.darkred),):
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                        foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // side: BorderSide(color: Colors.red)
                            )
                        )
                    ),
                    onPressed: () {

                      dialogCancel(context, scheduleDetailResponse.data!.scheduledata!.id.toString());

                    },
                    // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10.0)),
                    // color: MyColors.darkbtncolor,
                    child: const Text(
                      "Cancel Schedule",
                      style: TextStyle(
                          fontSize: 15,
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                    ),
                  ),

                  hSizedBox5,


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  usercard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
     /* margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),*/
    /*  decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.lightblueColor.withOpacity(0.03)),*/
      child: Column(
        children: [
          /// top
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: MyColors.divider_color,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child:  FadeInImage(
                      height: 156,width: 149,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        scheduleDetailResponse.data!.scheduledata!.recipientImage.toString(),),
                      placeholder: const AssetImage(
                          "a_assets/logo/progress_image.png"),
                      placeholderFit: BoxFit.scaleDown,
                      imageErrorBuilder:
                          (context, error, stackTrace) {
                        return Container(alignment:Alignment.center,child: Text(scheduleDetailResponse.data!.scheduledata!.recipientName.toString()[0].toUpperCase(),style: const TextStyle(
                            color: MyColors.shedule_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: "s_asset/font/raleway/raleway_bold.ttf"),));
                      },
                    )),
              ),
              wSizedBox1,
              wSizedBox,
              Container(
                // width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          alignment: Alignment.topLeft,
                          child: Text(
                            scheduleDetailResponse.data!.scheduledata!.recipientName.toString(),
                            style: const TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 15,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_semibold.ttf",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                       wSizedBox2,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            scheduleDetailResponse.data!.scheduledata!.isCancelled == 1?
                            Container():
                            InkWell(
                              onTap: (){
                                pushNewScreen(
                                  context,
                                  screen: EditSheduledTransferScreen(schedule_id: widget.schedule_id.toString(), Oncallback: Update,),
                                  withNavBar: false,
                                );
                              },
                              child: Container(
                                child: SvgPicture.asset(
                                  "a_assets/icons/edit.svg",
                                  color: MyColors.blackColor,
                                ),
                              ),
                            ),
                            wSizedBox,
                            InkWell(
                              onTap: (){
                                dialogDelete(context, scheduleDetailResponse.data!.scheduledata!.id.toString());
                              },
                              child: Container(
                                width: 55,
                                child: Center(
                                    child: SvgPicture.asset(
                                  "a_assets/icons/delete.svg",
                                )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    hSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "(+${scheduleDetailResponse.data!.scheduledata!.recipientPhonecode.toString()}) ${scheduleDetailResponse.data!.scheduledata!.recipientPhoneNumber.toString()}",
                        style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.50),
                            fontSize: 12,
                            fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          hSizedBox1,
          hSizedBox,

          /// bottom

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// left text
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Will Receive (Approx.)",
                        style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.40),
                            fontSize: 12,
                            fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    hSizedBox,
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            scheduleDetailResponse.data!.scheduledata!.recipientRecivedAmount.toString(),
                            style: const TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 14,
                                fontFamily:
                                    "s_asset/font/montserrat/Montserrat-ExtraBold.otf",
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        wSizedBox,

                        /// aud
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            scheduleDetailResponse.data!.scheduledata!.receivingCurrency.toString(),
                            style: const TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 8,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_semibold.ttf",
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// right text
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Transfer Reason",
                        style: TextStyle(
                            color: MyColors.blackColor.withOpacity(0.40),
                            fontSize: 12,
                            fontFamily:
                                "s_asset/font/raleway/raleway_medium.ttf",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    hSizedBox,
                    Row(
                      children: [
                        Container(
                          width: 150,
                          alignment: Alignment.topLeft,
                          child: Text(
                            scheduleDetailResponse.data!.scheduledata!.trasnsferReason.toString(),
                            style: const TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 13.60,
                                fontFamily:
                                    "s_asset/font/raleway/raleway_medium.ttf",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /// Delivery Method..

  deliveryMethid() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
     // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     color: MyColors.lightblueColor.withOpacity(0.03)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              MyString.delivery_method,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily:
                      "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                  color: MyColors.blackColor.withOpacity(0.30)),
            ),
          ),
          hSizedBox,
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "a_assets/icons/bank.svg",
                      color: MyColors.blackColor,
                    ),
                    wSizedBox1,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        scheduleDetailResponse.data!.scheduledata!.senderSendMethod.toString()=="check"?'Bank Account' : scheduleDetailResponse.data!.scheduledata!.senderSendMethod.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                            color: MyColors.blackColor),
                      ),
                    ),
                  ],
                ),
               /* new Container(
                  // gray box
                  child: new Center(
                    child: new Transform(
                      child: SvgPicture.asset(
                        "a_assets/icons/arrow_left.svg",
                        color: MyColors.blackColor.withOpacity(0.10),
                      ),
                      alignment: FractionalOffset.center,
                      transform: new Matrix4.identity()
                        ..rotateZ(10 * 3.1415927 / 150),
                    ),
                  ),
                )*/
              ],
            ),
          ),
          hSizedBox1,
          hSizedBox1,
          Container(
            child: Row(
              children: [
                SvgPicture.asset(
                  "a_assets/icons/bank4.svg",
                ),
                wSizedBox1,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 220,
                      alignment: Alignment.topLeft,
                      child: Text(
                        scheduleDetailResponse.data!.scheduledata!.recipientReceiveMethod.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily:
                                "s_asset/font/montserrat/Montserrat-Bold.otf",
                            color: MyColors.blackColor),
                      ),
                    ),
                    hSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "****"+scheduleDetailResponse.data!.scheduledata!.recipientReceiveMethodLast4digit.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily:
                                "s_asset/font/montserrat/MontserratAlternates-Medium.otf",
                            color: MyColors.blackColor.withOpacity(0.80)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// calenderlist
  CalenderList(String date, String month,String CheckDate) {
    print("CheckDate>> "+CheckDate);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,),
      child: Material(
        elevation: 60,
       shadowColor: MyColors.lightblueColor.withOpacity(0.08),
        color: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),

        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            color: MyColors.whiteColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            children: [
              Text(date,style: TextStyle(color: MyColors.lightblueColor.withOpacity(0.50),fontWeight: FontWeight.w700,fontFamily: "s_asset/font/montserrat/Montserrat-Bold.otf",fontSize: 18),),
              hSizedBox,


              Text(month,style: TextStyle(color: MyColors.lightblueColor.withOpacity(0.50),fontWeight: FontWeight.w500,fontFamily: " s_asset/font/raleway/raleway_medium.ttf",fontSize: 12)),
              hSizedBox,

              scheduleDetailResponse.data!.scheduledata!.scheduleDatesOnpaymentdone!.contains(CheckDate)?
              SvgPicture.asset(
                "a_assets/logo/check_mark.svg",
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }


  ///exchangeRate
 exchangeRatecard(){
    return Container(

     // color: MyColors.lightblueColor.withOpacity(0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MyColors.lightblueColor.withOpacity(0.03),
            MyColors.lightblueColor.withOpacity(0.01),
          ]
        )
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [

          ///
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.exchange_rate,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    MyString.depend_on_day_of_transfer,
                    style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          hSizedBox2,

          ///
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.you_send,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        scheduleDetailResponse.data!.scheduledata!.sendAmount.toString(),
                        style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                            fontWeight: FontWeight.w800),
                      ),
                    ),

                    wSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        scheduleDetailResponse.data!.scheduledata!.sendingCurrency.toString(),
                        style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 8,
                            fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          hSizedBox2,

          ///
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.fees,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        scheduleDetailResponse.data!.scheduledata!.monyetosfee.toString(),
                        style: const TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 14,
                            fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                            fontWeight: FontWeight.w800),
                      ),
                    ),

                    wSizedBox,
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        MyString.usd,
                        style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: 8,
                            fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          hSizedBox3,

         /* Container(
            height: 0.5,
            child: DottedBorder(
              color: Colors.black.withOpacity(0.30),
              strokeWidth: 0.5,
              dashPattern: [8, 4],
              child: Container(),
            ),
          ),*/
          Container(
            height: 0.5,
            child: DottedBorder(
              color: const Color(0xffE9EDF2),
              strokeWidth: 0.5,
              dashPattern: const [8, 4],
              child: Container(),
            ),
          ),
          hSizedBox2,
          ///
          Container(
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    MyString.total,
                    style: TextStyle(
                        color: MyColors.blackColor.withOpacity(0.30),
                        fontSize: 12,
                        fontFamily: "s_asset/font/raleway/raleway_medium.ttf",
                        fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          (double.parse(scheduleDetailResponse.data!.scheduledata!.sendAmount.toString())+double.parse(scheduleDetailResponse.data!.scheduledata!.monyetosfee.toString())).toString(),
                          style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 20,
                              fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf",
                              fontWeight: FontWeight.w800),
                        ),
                      ),

                      wSizedBox,
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          MyString.usd,
                          style: TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 10,
                              fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]
                ),
              ],
            ),
          ),
          hSizedBox2,
        ],
      ),
    );
 }

  Future<void> changeScheduleStatusapi(BuildContext context,schedule_id
      ) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences p = await SharedPreferences.getInstance();

    var request = {};
    request['schedule_id'] = schedule_id;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.changeScheduleStatusapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN": "${p.getString("auth")}",
          "X-USERID": "${p.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog6(context, false);
      scheduleDetailResponse.data!.scheduledata!.scheduleStatus = isSwitched_pin?"ON":"OFF";
    } else {
      Utility.showFlutterToast( jsonResponse['message']);
      CustomLoader.ProgressloadingDialog6(context, false);
      //  show_custom_toast(msg: "Register Failed");
    }
    setState((){});
    return;
  }

  dialogCancel(BuildContext context,String schedule_id) {

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: Container(
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


                        const SizedBox(height: 10,),




                        const Text(
                          "Are you sure, you want to Cancel?",
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                        ),


                        const SizedBox(height: 40,),

                        Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                                    foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          // side: BorderSide(color: Colors.red)
                                        )
                                    )
                                ),
                                onPressed: () {

                                  Navigator.of(context, rootNavigator: true).pop(context);

                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                // color: MyColors.darkbtncolor,
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              flex:1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                                    foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          // side: BorderSide(color: Colors.red)
                                        )
                                    )
                                ),
                                onPressed: () async {
                                  // DeleteRequest(context, payment_method_id);
                                  cancelScheduleapi(context, schedule_id);

                                  setState(() {

                                  });

                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                // color: MyColors.darkbtncolor,
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),),



              ],
            ),
          ),
        ),
      ),
    );

  }

  dialogDelete(BuildContext context,String schedule_id) {

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: Container(
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


                        const SizedBox(height: 10,),




                        const Text(
                          "Are you sure, you want to Delete?",
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColors.blackColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                        ),


                        const SizedBox(height: 40,),

                        Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                                    foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          // side: BorderSide(color: Colors.red)
                                        )
                                    )
                                ),
                                onPressed: () {

                                  Navigator.of(context, rootNavigator: true).pop(context);

                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                // color: MyColors.darkbtncolor,
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              flex:1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                                    foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          // side: BorderSide(color: Colors.red)
                                        )
                                    )
                                ),
                                onPressed: () async {
                                  // DeleteRequest(context, payment_method_id);
                                  deleteScheduleapi(context, schedule_id);

                                  setState(() {

                                  });

                                },
                                // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                // color: MyColors.darkbtncolor,
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),),



              ],
            ),
          ),
        ),
      ),
    );

  }

  Future <void> deleteScheduleapi(BuildContext context,String schedule_id) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    request['schedule_id'] = schedule_id;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.deleteScheduleapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN":"${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog6(context, false);
      Navigator.of(context, rootNavigator: true).pop(context);
      Navigator.pop(context);
      this.widget.Oncallback();
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      // Navigator.push(context, MaterialPageRoute(builder: (_) => TransferSheduledScreen()));

        // pushNewScreen(
        //   context,
        //   screen: TransferSheduledScreen(),
        //   withNavBar: true,
        // );


      setState(() {});
    } else {
      CustomLoader.ProgressloadingDialog6(context, false);
      Utility.showFlutterToast( jsonResponse['message']);
      setState(() {});
    }

    return;

  }

  Future <void> scheduleDetailapi(BuildContext context,) async {

    setState((){
      isload = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userid = sharedPreferences.getString("userid");
    var auth = sharedPreferences.getString("auth");
    var request = {};
    request['schedule_id'] = widget.schedule_id.toString();


    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.get(Uri.parse(Apiservices.scheduleDetailapi+"?schedule_id="+widget.schedule_id.toString()),
        // body: convert.jsonEncode(request),
        headers: {

          "X-AUTHTOKEN":"${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      isload = false;
      scheduleDetailResponse = await ScheduleDetailResponse.fromJson(jsonResponse);

      isSwitched_pin = scheduleDetailResponse.data!.scheduledata!.scheduleStatus=="ON"?true:false;


      startDate = DateTime(int.parse(scheduleDetailResponse.data!.scheduledata!.scheduleDate.toString().split("-")[0]),int.parse(scheduleDetailResponse.data!.scheduledata!.scheduleDate.toString().split("-")[1]),int.parse(scheduleDetailResponse.data!.scheduledata!.scheduleDate.toString().split("-")[2]));
      if(scheduleDetailResponse.data!.scheduledata!.scheduleExpDate!=null){
        endDate = DateTime(int.parse(scheduleDetailResponse.data!.scheduledata!.scheduleExpDate.toString().split("-")[0]),int.parse(scheduleDetailResponse.data!.scheduledata!.scheduleExpDate.toString().split("-")[1]),int.parse(scheduleDetailResponse.data!.scheduledata!.scheduleExpDate.toString().split("-")[2]));
      }


      print("start date>>> "+startDate.toString());
      print("end date>>> "+endDate.toString());
      setState((){});
      if(scheduleDetailResponse.data!.scheduledata!.scheduleType=="Daily"){
        main();
      }else if(scheduleDetailResponse.data!.scheduledata!.scheduleType=="Weekly"){
        mainweelkly();
      }else{
        mainmonthly();
      }

      print("payment done dates>>>>> "+scheduleDetailResponse.data!.scheduledata!.scheduleDatesOnpaymentdone.toString());
      setState(() {

      });
    } else {
      isload = false;
      setState(() {

      });
    }
    return;
  }

  Future <void> cancelScheduleapi(BuildContext context,String schedule_id) async {
    CustomLoader.ProgressloadingDialog6(context, true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request = {};
    request['schedule_id'] = schedule_id;

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    var response = await http.post(Uri.parse(Apiservices.cancelScheduleapi),
        body: convert.jsonEncode(request),
        headers: {
          "X-AUTHTOKEN":"${sharedPreferences.getString("auth")}",
          "X-USERID": "${sharedPreferences.getString("userid")}",
          "content-type": "application/json",
          "accept": "application/json",
        });


    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

    if (jsonResponse['status'] == true) {
      CustomLoader.ProgressloadingDialog6(context, false);
      Navigator.of(context, rootNavigator: true).pop(context);
      Navigator.pop(context);
      this.widget.Oncallback();
      // Fluttertoast.showToast(msg: jsonResponse['message']);
      // Navigator.push(context, MaterialPageRoute(builder: (_) => TransferSheduledScreen()));

      // pushNewScreen(
      //   context,
      //   screen: TransferSheduledScreen(),
      //   withNavBar: true,
      // );


      setState(() {});
    } else {
      CustomLoader.ProgressloadingDialog6(context, false);
      Navigator.of(context, rootNavigator: true).pop(context);
      Utility.showFlutterToast( jsonResponse['message']);
      setState(() {});
    }

    return;

  }
}
