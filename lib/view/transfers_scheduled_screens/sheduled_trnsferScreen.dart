import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/model/customlists/customLists.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transfer_select_recipientAScreen2.dart';
import 'package:moneytos/view/transfers_scheduled_screens/transfer_shedule_openedbottom.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ScheduledTransferScreens/schedule_select_recipient_screen.dart';

class SheduledTransferScreen extends StatefulWidget {
  const SheduledTransferScreen({Key? key}) : super(key: key);

  @override
  State<SheduledTransferScreen> createState() => _SheduledTransferScreenState();
}

class _SheduledTransferScreenState extends State<SheduledTransferScreen> {
  String statustext = MyString.once;


  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  String Selected_Date = "";
  String start_date = "Start Date",end_date = "End Date";
  String selected_start_date = "",selected_end_date="";
  DateTime _currentStartDate = DateTime.now();
  DateTime _currentStartDate2 = DateTime.now();
  String _currentStartMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetStartDateTime = DateTime.now();
  String is_date_select="start_date";

  DateTime _currentEndDate = DateTime.now();
  DateTime _currentEndDate2 = DateTime.now();
  String _currentEndMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetEndDateTime = DateTime.now();

  late CalendarCarousel _calendarCarouselNoHeader;
  late CalendarCarousel _calendarCarouselStartDate;
  late CalendarCarousel _calendarCarouselEndDate;

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2020, 2, 10): [
        new Event(
          date: new DateTime(2020, 2, 14),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2020, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2020, 2, 15),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  void initState() {
    _markedDateMap.add(
        new DateTime(2020, 2, 25),
        new Event(
          date: new DateTime(2020, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2020, 2, 10),
        new Event(
          date: new DateTime(2020, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2019, 2, 11), [
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;



    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      //todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
        Selected_Date = Utility.DatefomatToScheduleDate(_currentDate2.toString());
      },
     // daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      selectedDayButtonColor: MyColors.color_1F4287,




    //  thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      weekDayFormat: WeekdayFormat.short,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      weekdayTextStyle:TextStyle(color: MyColors.greycolor) ,
      height: 420.0,
      selectedDateTime: Selected_Date.isEmpty?null:_currentDate2,
      targetDateTime: _targetDateTime,

      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
      CircleBorder(side: BorderSide(color: MyColors.primaryColor)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.black,
      ),

      todayButtonColor: MyColors.whiteColor,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.add(Duration(days: -1)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black38,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.black38,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    _calendarCarouselStartDate = CalendarCarousel<Event>(
      //todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentStartDate2 = date);
        events.forEach((event) => print(event.title));
        start_date = Utility.DatefomatToTimezoneDate(_currentStartDate2.toString());
        selected_start_date = Utility.DatefomatToScheduleDate(_currentStartDate2.toString());
      },
     // daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      selectedDayButtonColor: MyColors.color_1F4287,




    //  thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      weekDayFormat: WeekdayFormat.short,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      weekdayTextStyle:TextStyle(color: MyColors.greycolor) ,
      height: 420.0,
      selectedDateTime: selected_start_date.isEmpty?null:_currentStartDate2,
      targetDateTime: _targetStartDateTime,

      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
      CircleBorder(side: BorderSide(color: MyColors.primaryColor)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.black,
      ),

      todayButtonColor: MyColors.whiteColor,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentStartDate.add(Duration(days: -1)),
      maxSelectedDate: _currentStartDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black38,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.black38,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetStartDateTime = date;
          _currentStartMonth = DateFormat.yMMM().format(_targetStartDateTime);
          end_date = "End Date";
          selected_end_date = "";
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    _calendarCarouselEndDate = CalendarCarousel<Event>(
      //todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentEndDate2 = date);
        events.forEach((event) => print(event.title));
        end_date = Utility.DatefomatToTimezoneDate(_currentEndDate2.toString());
        selected_end_date = Utility.DatefomatToScheduleDate(_currentEndDate2.toString());
      },
     // daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      selectedDayButtonColor: MyColors.color_1F4287,




    //  thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      weekDayFormat: WeekdayFormat.short,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      weekdayTextStyle:TextStyle(color: MyColors.greycolor) ,
      height: 420.0,
      selectedDateTime: selected_end_date.isEmpty?null:_currentEndDate2,
      targetDateTime: _targetEndDateTime,

      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
      CircleBorder(side: BorderSide(color: MyColors.primaryColor)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.black,
      ),

      todayButtonColor: MyColors.whiteColor,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentEndDate.add(Duration(days: -1)),
      maxSelectedDate: _currentEndDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.black38,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.black38,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetEndDateTime = date;
          _currentEndMonth = DateFormat.yMMM().format(_targetEndDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );



    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: MyColors.light_primarycolor2,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only( left: 25,top: 35),
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
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          MyString.scheduled_Transfer,
                          style: TextStyle(
                              color: MyColors.whiteColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                              fontFamily: "s_asset/font/raleway/raleway_extrabold.ttf"),
                        ),
                        //   SizedBox(height: 3,),

                        hSizedBox,
                        Text(
                          MyString.select_date_of_start,
                          style: TextStyle(
                              color: MyColors.whiteColor.withOpacity(0.90),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50,
                  )
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.light_primarycolor2,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
        ),
      ),


      bottomSheet: Container(
          height: 150,
          color: MyColors.whiteColor,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 38,horizontal: 20),
          child:  GestureDetector(
            onTap:(){

              if(statustext==MyString.once){
                setDatePrefences(Selected_Date,"");
                Selected_Date == ""?Utility.showFlutterToast( "Select Date"):
                pushNewScreen(
                  context,
                  screen: ScheduleSelectRecipientScreen(),
                  // screen: TransferSelectRecipientScreen2(),
                  withNavBar: false,
                );
              }else{
                setDatePrefences(selected_start_date,selected_end_date);
                if(selected_start_date.isEmpty){
                  Utility.showFlutterToast( "Select Start Date");
                }else if(selected_end_date.isEmpty){
                  Utility.showFlutterToast( "Select End Date");
                }else{
                  if(_currentStartDate2.isAfter(_currentEndDate2)){
                    Utility.showFlutterToast( "End date cannot be lower than start date.");
                  }else{
                    pushNewScreen(
                      context,
                      screen: ScheduleSelectRecipientScreen(),
                      // screen: TransferSelectRecipientScreen2(),
                      withNavBar: false,
                    );
                  }

                }

              }

            },
            child: Container(
                width:80,
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                child: Material(
                    shadowColor: MyColors.lightblueColor.withOpacity(0.05),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          //  stops: [0.0, 1.0],
                          colors: [

                            MyColors.color_3F84E5.withOpacity(0.90),
                            MyColors.color_3F84E5,

                          ],
                        ),
                        //    border: Border.all(color: bordercolor,width: 1.4)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(MyString.next,style: TextStyle(fontFamily: "s_asset/font/raleway/raleway_bold.ttf",color:MyColors.whiteColor,fontSize: 18,fontWeight: FontWeight.w700,letterSpacing: 0.7 ),),
                        ],
                      ),
                    )
                )
            ),
          )
      ),

      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.2,
              color: MyColors.light_primarycolor2,
            ),
            Container(
              height: size.height,
              width: double.infinity,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: MyColors.whiteColor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox3,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        MyString.all_shedule,
                        style: TextStyle(
                            color: MyColors.yellow,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                            fontSize: 11,
                            fontFamily: "s_asset/font/raleway/raleway_medium.ttf"),
                      ),
                    ),

                    hSizedBox3,
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: (){
                                statustext = MyString.once;
                                setState(() {
                                });
                              },
                              child: customtextcard(MyString.once, statustext == MyString.once ? MyColors.lightblueColor : MyColors.whiteColor,statustext == MyString.once ? MyColors.lightblueColor :MyColors.blackColor)
                          ),
                          wSizedBox1,
                          GestureDetector(
                              onTap: (){
                                statustext = MyString.daily;
                                setState(() {
                                });
                              },
                              child: customtextcard(MyString.daily, statustext == MyString.daily ? MyColors.lightblueColor : MyColors.whiteColor,statustext == MyString.daily ? MyColors.lightblueColor :MyColors.blackColor)
                          ),
                          wSizedBox1,
                          GestureDetector(
                              onTap: (){
                                statustext = MyString.weekly;
                                setState(() {
                                });
                              },
                              child: customtextcard(MyString.weekly, statustext == MyString.weekly ? MyColors.lightblueColor : MyColors.whiteColor,statustext == MyString.weekly ? MyColors.lightblueColor :MyColors.blackColor)
                          ),
                          wSizedBox1,
                          GestureDetector(
                              onTap: (){
                                statustext = MyString.monthly;
                                setState(() {
                                });
                              },
                              child: customtextcard(MyString.monthly, statustext == MyString.monthly ? MyColors.lightblueColor : MyColors.whiteColor,statustext == MyString.monthly ? MyColors.lightblueColor :MyColors.blackColor)
                          ),
                        ],
                      ),
                    ),
                    hSizedBox1,
                    Visibility(
                      visible: statustext == MyString.once?false:true,
                      child: Row(children: [
                        Expanded(child: GestureDetector(
                            onTap: (){
                              is_date_select = "start_date";
                              setState(() {
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Material(
                                elevation: 0,
                                color: MyColors.accent_F3F3F3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: is_date_select == "start_date" ? MyColors.lightblueColor : MyColors.accent_F3F3F3)
                                  ),
                                  child: Text(start_date,style: TextStyle(fontSize: 11,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600,color: MyColors.blackColor),),
                                ),
                              ),
                            ),
                        ),),

                        Expanded(child: GestureDetector(
                            onTap: (){
                              is_date_select = "end_date";
                              setState(() {
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Material(
                                elevation: 0,
                                color: MyColors.accent_F3F3F3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: is_date_select == "end_date" ? MyColors.lightblueColor : MyColors.accent_F3F3F3)
                                  ),
                                  child: Text(end_date,style: TextStyle(fontSize: 11,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600,color: MyColors.blackColor),),
                                ),
                              ),
                            )
                        ),)

                      ],),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.0,
                        bottom: 16.0,
                        left: 22.0,
                        right: 22.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin:EdgeInsets.only(left: 16),
                            child: Text(
                              statustext==MyString.once?_currentMonth:is_date_select == "start_date"?_currentStartMonth:_currentEndMonth,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                fontFamily: "s_asset/font/raleway/raleway_bold.ttf"
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(

                                child: SvgPicture.asset("s_asset/images/prev.svg"),
                                onPressed: () {
                                  setState(() {
                                    if(statustext==MyString.once){
                                      _targetDateTime = DateTime(
                                          _targetDateTime.year, _targetDateTime.month - 1);
                                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                                    }else{
                                      if(is_date_select == "start_date"){
                                        _targetStartDateTime = DateTime(
                                            _targetStartDateTime.year, _targetStartDateTime.month - 1);
                                        _currentStartMonth = DateFormat.yMMM().format(_targetStartDateTime);
                                      }else{
                                        _targetEndDateTime = DateTime(
                                            _targetEndDateTime.year, _targetEndDateTime.month - 1);
                                        _currentEndMonth = DateFormat.yMMM().format(_targetEndDateTime);
                                      }
                                    }


                                  });
                                },
                              ),
                              TextButton(
                                child: SvgPicture.asset("s_asset/images/next.svg",),
                                onPressed: () {
                                  setState(() {
                                    if(statustext==MyString.once){
                                      _targetDateTime = DateTime(
                                          _targetDateTime.year, _targetDateTime.month + 1);
                                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                                    }else{
                                      if(is_date_select == "start_date"){
                                        _targetStartDateTime = DateTime(
                                            _targetStartDateTime.year, _targetStartDateTime.month + 1);
                                        _currentStartMonth = DateFormat.yMMM().format(_targetStartDateTime);
                                      }else{
                                        _targetEndDateTime = DateTime(
                                            _targetEndDateTime.year, _targetEndDateTime.month + 1);
                                        _currentEndMonth = DateFormat.yMMM().format(_targetEndDateTime);
                                      }
                                    }

                                    //  _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                                  });
                                },
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                    Visibility(
                      visible: statustext == MyString.once?true:false,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 22.0),
                        child: _calendarCarouselNoHeader,
                      ),
                    ),

                    Visibility(
                      visible: statustext != MyString.once?true:false,
                      child: is_date_select == "start_date"?
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 22.0),
                        child: _calendarCarouselStartDate,
                      ):
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 22.0),
                        child: _calendarCarouselEndDate,
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  CustomCardList(String title) {
    return Container(
        child: Material(
            elevation: 30,
            shadowColor: MyColors.lightblueColor.withOpacity(0.10),
            color: MyColors.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor:
                          MyColors.lightblueColor.withOpacity(0.10),
                          child: Center(
                              child:ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Image.asset("a_assets/logo/female_profile.jpg",fit: BoxFit.cover,height: 100,width: 100,))),
                        ),
                        wSizedBox1,
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  MyString.recipient_name,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily:
                                      "s_asset/font/raleway/raleway_medium.ttf",
                                      fontWeight: FontWeight.w500,
                                      color: MyColors.blackColor),
                                ),
                              ),
                              hSizedBox,
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        "Today, 03:27pm",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily:
                                            "s_asset/font/raleway/raleway_medium.ttf",
                                            color: MyColors.blackColor
                                                .withOpacity(0.50),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "1,473",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                            "s_asset/font/montserrat/Montserrat-ExtraBold.otf",
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.2,
                                            color: MyColors.color_3F84E5),
                                      ),
                                      wSizedBox,
                                      Text(
                                        MyString.usd,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily:
                                            "s_asset/font/raleway/raleway_bold.ttf",
                                            fontWeight: FontWeight.w600,
                                            color: MyColors.lightblueColor),
                                      ),
                                    ],
                                  ),
                                ),
                                hSizedBox1,
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            )));
  }

  customtextcard(String title,Color color,Color textcolor){
    return Container(
      child: Material(
        elevation: 1,
        color: MyColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color)
          ),
          child: Text(title,style: TextStyle(fontSize: 11,fontFamily: "s_asset/font/raleway/raleway_semibold.ttf",fontWeight: FontWeight.w600,color: textcolor),),
        ),
      ),
    );
  }

  setDatePrefences(String SelectedStartDate,String SelectedEndDate)async{
    print("SelectedStartDate>>> "+SelectedStartDate);
    print("SelectedEndDate>>> "+SelectedEndDate);
    print("Selectedstatus>>> "+statustext);
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString("ScheduleStartDate", SelectedStartDate);
    pre.setString("ScheduleEndDate", SelectedEndDate);
    pre.setString("ScheduleType", statustext);
  }
}
