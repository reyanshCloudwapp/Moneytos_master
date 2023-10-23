import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:moneytos/screens/ScheduledTransferScreens/schedule_select_recipient_screen.dart';
import 'package:moneytos/utils/import_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

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
  String Selected_Date = '';
  String start_date = 'Start Date', end_date = 'End Date';
  String selected_start_date = '', selected_end_date = '';
  DateTime _currentStartDate = DateTime.now();
  DateTime _currentStartDate2 = DateTime.now();
  String _currentStartMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetStartDateTime = DateTime.now();
  String is_date_select = 'start_date';

  DateTime currentEndDate = DateTime.now();
  DateTime currentEndDate2 = DateTime.now();
  String _currentEndMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetEndDateTime = DateTime.now();

  late CalendarCarousel _calendarCarouselNoHeader;
  late CalendarCarousel _calendarCarouselStartDate;
  late CalendarCarousel _calendarCarouselEndDate;

  static final Widget _eventIcon = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: Colors.blue, width: 2.0),
    ),
    child: const Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2020, 2, 10): [
        Event(
          date: DateTime(2020, 2, 14),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        Event(
          date: DateTime(2020, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        Event(
          date: DateTime(2020, 2, 15),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  @override
  void initState() {
    _markedDateMap.add(
      DateTime(2020, 2, 25),
      Event(
        date: DateTime(2020, 2, 25),
        title: 'Event 5',
        icon: _eventIcon,
      ),
    );

    _markedDateMap.add(
      DateTime(2020, 2, 10),
      Event(
        date: DateTime(2020, 2, 10),
        title: 'Event 4',
        icon: _eventIcon,
      ),
    );

    _markedDateMap.addAll(DateTime(2019, 2, 11), [
      Event(
        date: DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      Event(
        date: DateTime(2019, 2, 11),
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
        setState(() => _currentDate2 = date);
        for (var event in events) {
          debugPrint(event.title);
        }
        Selected_Date =
            Utility.DatefomatToScheduleDate(_currentDate2.toString());
      },
      // daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.black,
      ),
      selectedDayButtonColor: MyColors.color_1F4287,

      //  thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      weekDayFormat: WeekdayFormat.short,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      weekdayTextStyle: const TextStyle(color: MyColors.greycolor),
      height: 420.0,
      selectedDateTime: Selected_Date.isEmpty ? null : _currentDate2,
      targetDateTime: _targetDateTime,

      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          const CircleBorder(side: BorderSide(color: MyColors.primaryColor)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.black,
      ),

      todayButtonColor: MyColors.whiteColor,
      selectedDayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.add(const Duration(days: -1)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black38,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.black38,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        debugPrint('long pressed date $date');
      },
    );
    _calendarCarouselStartDate = CalendarCarousel<Event>(
      //todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() => _currentStartDate2 = date);
        for (var event in events) {
          debugPrint(event.title);
        }
        start_date =
            Utility.DatefomatToTimezoneDate(_currentStartDate2.toString());
        selected_start_date =
            Utility.DatefomatToScheduleDate(_currentStartDate2.toString());
      },
      // daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.black,
      ),
      selectedDayButtonColor: MyColors.color_1F4287,

      //  thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      weekDayFormat: WeekdayFormat.short,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      weekdayTextStyle: const TextStyle(color: MyColors.greycolor),
      height: 420.0,
      selectedDateTime: selected_start_date.isEmpty ? null : _currentStartDate2,
      targetDateTime: _targetStartDateTime,

      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          const CircleBorder(side: BorderSide(color: MyColors.primaryColor)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.black,
      ),

      todayButtonColor: MyColors.whiteColor,
      selectedDayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentStartDate.add(const Duration(days: -1)),
      maxSelectedDate: _currentStartDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black38,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.black38,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetStartDateTime = date;
          _currentStartMonth = DateFormat.yMMM().format(_targetStartDateTime);
          end_date = 'End Date';
          selected_end_date = '';
        });
      },
      onDayLongPressed: (DateTime date) {
        debugPrint('long pressed date $date');
      },
    );
    _calendarCarouselEndDate = CalendarCarousel<Event>(
      //todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() => currentEndDate2 = date);
        for (var event in events) {
          debugPrint(event.title);
        }
        end_date = Utility.DatefomatToTimezoneDate(currentEndDate2.toString());
        selected_end_date =
            Utility.DatefomatToScheduleDate(currentEndDate2.toString());
      },
      // daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.black,
      ),
      selectedDayButtonColor: MyColors.color_1F4287,

      //  thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      weekDayFormat: WeekdayFormat.short,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      weekdayTextStyle: const TextStyle(color: MyColors.greycolor),
      height: 420.0,
      selectedDateTime: selected_end_date.isEmpty ? null : currentEndDate2,
      targetDateTime: _targetEndDateTime,

      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          const CircleBorder(side: BorderSide(color: MyColors.primaryColor)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.black,
      ),

      todayButtonColor: MyColors.whiteColor,
      selectedDayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: currentEndDate.add(const Duration(days: -1)),
      maxSelectedDate: currentEndDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black38,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.black38,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetEndDateTime = date;
          _currentEndMonth = DateFormat.yMMM().format(_targetEndDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        debugPrint('long pressed date $date');
      },
    );

    return Scaffold(
      backgroundColor: MyColors.light_primarycolor2,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: MyColors.light_primarycolor2,
          elevation: 0,
          centerTitle: true,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 25, top: 35),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        'assets/images/leftarrow.svg',
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          MyString.scheduled_Transfer,
                          style: TextStyle(
                            color: MyColors.whiteColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 26,
                            fontFamily:
                                'assets/fonts/raleway/raleway_extrabold.ttf',
                          ),
                        ),
                        //   SizedBox(height: 3,),

                        hSizedBox,
                        Text(
                          MyString.select_date_of_start,
                          style: TextStyle(
                            color: MyColors.whiteColor.withOpacity(0.90),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                          ),
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
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.light_primarycolor2,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
        ),
      ),
      bottomSheet: Container(
        height: 150,
        color: MyColors.whiteColor,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 20),
        child: GestureDetector(
          onTap: () {
            if (statustext == MyString.once) {
              setDatePrefences(Selected_Date, '');
              Selected_Date == ''
                  ? Utility.showFlutterToast('Select Date')
                  : pushNewScreen(
                      context,
                      screen: const ScheduleSelectRecipientScreen(),
                      // screen: TransferSelectRecipientScreen2(),
                      withNavBar: false,
                    );
            } else {
              setDatePrefences(selected_start_date, selected_end_date);
              if (selected_start_date.isEmpty) {
                Utility.showFlutterToast('Select Start Date');
              } else if (selected_end_date.isEmpty) {
                Utility.showFlutterToast('Select End Date');
              } else {
                if (_currentStartDate2.isAfter(currentEndDate2)) {
                  Utility.showFlutterToast(
                    'End date cannot be lower than start date.',
                  );
                } else {
                  pushNewScreen(
                    context,
                    screen: const ScheduleSelectRecipientScreen(),
                    // screen: TransferSelectRecipientScreen2(),
                    withNavBar: false,
                  );
                }
              }
            }
          },
          child: Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      MyString.next,
                      style: TextStyle(
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                        color: MyColors.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: MyColors.whiteColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox3,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Text(
                        MyString.all_shedule,
                        style: TextStyle(
                          color: MyColors.yellow,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.6,
                          fontSize: 11,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        ),
                      ),
                    ),
                    hSizedBox3,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            statustext = MyString.once;
                            setState(() {});
                          },
                          child: customtextcard(
                            MyString.once,
                            statustext == MyString.once
                                ? MyColors.lightblueColor
                                : MyColors.whiteColor,
                            statustext == MyString.once
                                ? MyColors.lightblueColor
                                : MyColors.blackColor,
                          ),
                        ),
                        wSizedBox1,
                        GestureDetector(
                          onTap: () {
                            statustext = MyString.daily;
                            setState(() {});
                          },
                          child: customtextcard(
                            MyString.daily,
                            statustext == MyString.daily
                                ? MyColors.lightblueColor
                                : MyColors.whiteColor,
                            statustext == MyString.daily
                                ? MyColors.lightblueColor
                                : MyColors.blackColor,
                          ),
                        ),
                        wSizedBox1,
                        GestureDetector(
                          onTap: () {
                            statustext = MyString.weekly;
                            setState(() {});
                          },
                          child: customtextcard(
                            MyString.weekly,
                            statustext == MyString.weekly
                                ? MyColors.lightblueColor
                                : MyColors.whiteColor,
                            statustext == MyString.weekly
                                ? MyColors.lightblueColor
                                : MyColors.blackColor,
                          ),
                        ),
                        wSizedBox1,
                        GestureDetector(
                          onTap: () {
                            statustext = MyString.monthly;
                            setState(() {});
                          },
                          child: customtextcard(
                            MyString.monthly,
                            statustext == MyString.monthly
                                ? MyColors.lightblueColor
                                : MyColors.whiteColor,
                            statustext == MyString.monthly
                                ? MyColors.lightblueColor
                                : MyColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    hSizedBox1,
                    Visibility(
                      visible: statustext == MyString.once ? false : true,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                is_date_select = 'start_date';
                                setState(() {});
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Material(
                                  elevation: 0,
                                  color: MyColors.accent_F3F3F3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: is_date_select == 'start_date'
                                            ? MyColors.lightblueColor
                                            : MyColors.accent_F3F3F3,
                                      ),
                                    ),
                                    child: Text(
                                      start_date,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_semibold.ttf',
                                        fontWeight: FontWeight.w600,
                                        color: MyColors.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                is_date_select = 'end_date';
                                setState(() {});
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: Material(
                                  elevation: 0,
                                  color: MyColors.accent_F3F3F3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: is_date_select == 'end_date'
                                            ? MyColors.lightblueColor
                                            : MyColors.accent_F3F3F3,
                                      ),
                                    ),
                                    child: Text(
                                      end_date,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontFamily:
                                            'assets/fonts/raleway/raleway_semibold.ttf',
                                        fontWeight: FontWeight.w600,
                                        color: MyColors.blackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 16.0,
                        left: 22.0,
                        right: 22.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              statustext == MyString.once
                                  ? _currentMonth
                                  : is_date_select == 'start_date'
                                      ? _currentStartMonth
                                      : _currentEndMonth,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                fontFamily:
                                    'assets/fonts/raleway/raleway_bold.ttf',
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                child:
                                    SvgPicture.asset('assets/images/prev.svg'),
                                onPressed: () {
                                  setState(() {
                                    if (statustext == MyString.once) {
                                      _targetDateTime = DateTime(
                                        _targetDateTime.year,
                                        _targetDateTime.month - 1,
                                      );
                                      _currentMonth = DateFormat.yMMM()
                                          .format(_targetDateTime);
                                    } else {
                                      if (is_date_select == 'start_date') {
                                        _targetStartDateTime = DateTime(
                                          _targetStartDateTime.year,
                                          _targetStartDateTime.month - 1,
                                        );
                                        _currentStartMonth = DateFormat.yMMM()
                                            .format(_targetStartDateTime);
                                      } else {
                                        _targetEndDateTime = DateTime(
                                          _targetEndDateTime.year,
                                          _targetEndDateTime.month - 1,
                                        );
                                        _currentEndMonth = DateFormat.yMMM()
                                            .format(_targetEndDateTime);
                                      }
                                    }
                                  });
                                },
                              ),
                              TextButton(
                                child: SvgPicture.asset(
                                  'assets/images/next.svg',
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (statustext == MyString.once) {
                                      _targetDateTime = DateTime(
                                        _targetDateTime.year,
                                        _targetDateTime.month + 1,
                                      );
                                      _currentMonth = DateFormat.yMMM()
                                          .format(_targetDateTime);
                                    } else {
                                      if (is_date_select == 'start_date') {
                                        _targetStartDateTime = DateTime(
                                          _targetStartDateTime.year,
                                          _targetStartDateTime.month + 1,
                                        );
                                        _currentStartMonth = DateFormat.yMMM()
                                            .format(_targetStartDateTime);
                                      } else {
                                        _targetEndDateTime = DateTime(
                                          _targetEndDateTime.year,
                                          _targetEndDateTime.month + 1,
                                        );
                                        _currentEndMonth = DateFormat.yMMM()
                                            .format(_targetEndDateTime);
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
                      visible: statustext == MyString.once ? true : false,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: _calendarCarouselNoHeader,
                      ),
                    ),
                    Visibility(
                      visible: statustext != MyString.once ? true : false,
                      child: is_date_select == 'start_date'
                          ? Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: _calendarCarouselStartDate,
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
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
    return Material(
      elevation: 30,
      shadowColor: MyColors.lightblueColor.withOpacity(0.10),
      color: MyColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                  backgroundColor: MyColors.lightblueColor.withOpacity(0.10),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset(
                        'assets/logo/female_profile.jpg',
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
                wSizedBox1,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      MyString.recipient_name,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        fontWeight: FontWeight.w500,
                        color: MyColors.blackColor,
                      ),
                    ),
                    hSizedBox,
                    Column(
                      children: [
                        Text(
                          'Today, 03:27pm',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily:
                                'assets/fonts/raleway/raleway_medium.ttf',
                            color: MyColors.blackColor.withOpacity(0.50),
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1,473',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily:
                            'assets/fonts/montserrat/Montserrat-ExtraBold.otf',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                        color: MyColors.color_3F84E5,
                      ),
                    ),
                    wSizedBox,
                    Text(
                      MyString.usd,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                        fontWeight: FontWeight.w600,
                        color: MyColors.lightblueColor,
                      ),
                    ),
                  ],
                ),
                hSizedBox1,
              ],
            ),
          ],
        ),
      ),
    );
  }

  customtextcard(String title, Color color, Color textcolor) {
    return Material(
      elevation: 1,
      color: MyColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'assets/fonts/raleway/raleway_semibold.ttf',
            fontWeight: FontWeight.w600,
            color: textcolor,
          ),
        ),
      ),
    );
  }

  setDatePrefences(String SelectedStartDate, String SelectedEndDate) async {
    debugPrint('SelectedStartDate>>> $SelectedStartDate');
    debugPrint('SelectedEndDate>>> $SelectedEndDate');
    debugPrint('Selectedstatus>>> $statustext');
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('ScheduleStartDate', SelectedStartDate);
    pre.setString('ScheduleEndDate', SelectedEndDate);
    pre.setString('ScheduleType', statustext);
  }
}
