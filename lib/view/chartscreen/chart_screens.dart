import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:moneytos/constance/customLoader/customLoader.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/constance/sizedbox/sizedBox.dart';
import 'package:moneytos/customScreens/customchart_cartList/customChart_cardList.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/chart_Model.dart';
import '../dash_recipentScreen/select_recipient_screen/select_new_recipient_screen.dart';
import '../otpverifyscreen/LoginVerificatrionDetailScreen.dart';

List<ChartDataModel> chartdatalist = [];
List<ChartRecipientDataModel> chartRecipientDatlist = [];
List<TxnGraphDataModel> txnGraphDatalist = [];

class ChartScreen extends StatefulWidget {
   ChartScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  bool _enabled = true;
  String doucument_status = "";
  bool state_verified = false;
  late final List<PricePoint> points;
  int _currentPage = 0;
  var year = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // List<BarChartGroupData> _chartGroups() {
  //   return points.map((point) =>
  //       BarChartGroupData(
  //           x: point.x.toInt(),
  //           barRods: [
  //             BarChartRodData(
  //                 toY: point.y
  //             )
  //           ]
  //       )
  //
  //   ).toList();
  // }
  final _controller = PageController(initialPage: 0);
  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;
  final List<Color> gredient = [Color(0xc2003b73),Color(0xc20fe1c2)];


  prefData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    state_verified = sharedPreferences.getBool("state_verified")!;
    doucument_status = sharedPreferences.getString("document_status")!;
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    prefData();
    WidgetsBinding.instance.addPostFrameCallback((_) => getchartRecipientApi());
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    });
  }

  bool load = false;
  getchartRecipientApi()async{
    chartdatalist.clear();
    chartRecipientDatlist.clear();
    setState((){
      // CustomLoader.ProgressloadingDialog6(context, true);
      load = true;
    });
    await Webservices.ChartRecipientRequest(context, chartdatalist,chartRecipientDatlist,txnGraphDatalist,year.toString(),);

    setState((){
      // CustomLoader.ProgressloadingDialog6(context, false);
      load = false;
      _enabled = false;
    });

  }

  final bool isShowingMainData = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(445),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.whiteColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: MyColors.whiteColor,

            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: 50),
            // padding: EdgeInsets.all(10),
            child: Column(children: [
              // hSizedBox3,
              // hSizedBox1,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //padding: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.topLeft,
                          child: Text(MyString.total_transferred,style: TextStyle(color: MyColors.blackColor,fontSize: 16,fontWeight: FontWeight.w500,fontFamily: "s_asset/font/montserrat/Montserrat-Medium.otf"),),
                        ),
                        hSizedBox1,
                        Container(
                          //padding: EdgeInsets.symmetric(horizontal: 20),
                          child:  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(

                                alignment: Alignment.topLeft,
                                child: Text(chartdatalist.length > 0 ? double.parse(chartdatalist[0].totalSendAmount.toString()).toStringAsFixed(2): "",style: TextStyle(color: MyColors.blackColor,fontSize: 33,fontFamily: "s_asset/font/montserrat/Montserrat-ExtraBold.otf",fontWeight: FontWeight.w700),),
                              ),
                              wSizedBox,
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(MyString.usd,style: TextStyle(fontWeight:FontWeight.w600,color: MyColors.blackColor,fontSize: 18,fontFamily: "s_asset/font/raleway/raleway_bold.ttf",),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => SelectNewRecipientScreen()));
                          !state_verified? Utility().stateDialog(context):
                          doucument_status=="Approved"?
                          pushNewScreen(
                            context,
                            screen: SelectNewRecipientScreen(),
                            withNavBar: false,
                          ):
                          verifyDialog(context, '', doucument_status);


                        },
                        child: SvgPicture.asset("a_assets/icons/send_blue.svg",height: 30,width: 30,)),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [MyColors.lightblueColor.withOpacity(0.01),MyColors.lightblueColor.withOpacity(0.04)],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18),
                height: size.height * 0.4,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 2,
                  child:
                  LineChart(
                    sampleData2,
                    swapAnimationDuration: const Duration(milliseconds: 250),
                  ),

                  /*   LineChart(
                        LineChartData(
                          titlesData: titlesData2,
                          lineTouchData: lineTouchData2,
                          gridData: gridData,
                          borderData: borderData,

                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              gradient: LinearGradient(
                                colors: [MyColors.lightblueColor,MyColors.lightblueColor],
                              ),
                              barWidth: 4,
                              isStrokeCapRound: true,
                              isStepLineChart: false,
                              aboveBarData: BarAreaData(
                                  color: Colors.red
                              ),
                              dotData: FlDotData(show: false),
                              spots: chartdatalist[0].txnGraphData!.map((pointt) => FlSpot(double.parse(pointt.month.toString()), double.parse(pointt.totalSendAmount.toString()))).toList(),

                             *//* isCurved: false,
                              dotData: FlDotData(

                                show: false,
                              ),*//*
                            ),
                          ],
                        ),
                      ),*/
                ),
                // LineChart(
                //   sampleData2,
                //   swapAnimationDuration: const Duration(milliseconds: 250),
                // ),
              ),
            ],),
          ),
        ),
      ),
      body: _enabled==true?Utility.shrimmerVerticalListLoader(100, MediaQuery.of(context).size.width):ListView.builder(

          itemCount:chartdatalist.length > 0? chartdatalist[0].recipientData!.length: chartRecipientDatlist.length,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,int index){
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                child:chartdatalist.length > 0?
                CustomChartCardList(recipient_name: chartdatalist[0].recipientData![index].recipientName.toString(),img:chartdatalist[0].recipientData![index].profileImage.toString(),amount:chartdatalist[0].recipientData![index].totalSendAmount.toString(),totalamount:  chartdatalist.length > 0 ? chartdatalist[0].totalSendAmount.toString(): "")
                    : Container(
                  child: Text("No Recipient"),
                )
            );
          })


      /*Stack(
        children: [
          Container(
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [




                  Container(
                    color: MyColors.lightblueColor.withOpacity(0.02),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:chartdatalist.length > 0? chartdatalist[0].recipientData!.length: chartRecipientDatlist.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,int index){
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                            child:chartdatalist.length > 0?
                            CustomChartCardList(recipient_name: chartdatalist[0].recipientData![index].recipientName.toString(),img:chartdatalist[0].recipientData![index].profileImage.toString(),amount:chartdatalist[0].recipientData![index].totalSendAmount.toString(),totalamount:  chartdatalist.length > 0 ? chartdatalist[0].totalSendAmount.toString(): "")
                                : Container(
                              child: Text("No Recipient"),
                            )
                          );
                        }),
                  ),

                  hSizedBox3,
                ],
              ),
            ),
          ),

         *//* load == true ? Container(
            height: size.height,
            child:  CustomLoader.ProgressloadingDialog4(context),
          ) : Container()*//*
        ],
      )*/,
    );
  }




  LineChartData get sampleData2 => LineChartData(
    lineTouchData: lineTouchData2,
    gridData: gridData,
    titlesData: titlesData2,
    borderData: borderData,
    lineBarsData: lineBarsData2,
     minX: 1,
    // maxX: 12,
   //  maxY: 6,
    minY: -50,
  );

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData1 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  LineTouchData get lineTouchData2 => LineTouchData(
    enabled: false,
  );

  FlTitlesData get titlesData2 => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  List<LineChartBarData> get lineBarsData2 => [
    // lineChartBarData2_1,
    lineChartBarData2_2,
    // lineChartBarData2_3,
  ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '';
        break;
      case 2:
        text = '';
        break;
      case 3:
        text = '';
        break;
      case 4:
        text = '';
        break;
      case 5:
        text = '';
        break;
      default:
        return Container();
    }



    return Text(text, style: style, textAlign: TextAlign.start);
  }

  verifyDialog(BuildContext context,String msg,String status){
    String document_status = status;
    String actual_status = status;
    document_status = document_status == "pending"?"Incomplete":document_status=="completed"?"pending":document_status ;

    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Column(children: [

              InkWell(
                onTap: (){
                  Navigator.of(context,rootNavigator: true).pop();
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset("s_asset/images/closesquare.svg"),
                ),
              ),


              document_status == "Blank"?
              Container():
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Verification status : ${document_status}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                ),
              ),


              SizedBox(height: 20,),

              actual_status == "expired"|| actual_status =="Rejected" || actual_status =="declined"?
              Column(children: [
                Text(
                  "Please re upload verification.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                ),


                SizedBox(height: 20,),

                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    Navigator.of(context,rootNavigator: true);
                    pushNewScreen(
                      context,
                      screen: LoginVerificatrionDetailScreen(),
                      withNavBar: false,
                    );
                  },
                  // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0)),
                  // color: MyColors.darkbtncolor,
                  child: Text(
                    "If you want to update verification Click Here"
                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                  ),
                ),

                SizedBox(height: 20,),
              ],
              ):Container(),




              actual_status == "Blank"?
              Column(children: [



                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    Navigator.of(context,rootNavigator: true);
                    pushNewScreen(
                      context,
                      screen: LoginVerificatrionDetailScreen(),
                      withNavBar: false,
                    );
                  },
                  // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0)),
                  // color: MyColors.darkbtncolor,
                  child: Text(
                    "Verify Your Account"
                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                  ),
                ),

                SizedBox(height: 20,),
              ],
              ):Container(),



              document_status == "Incomplete"?
              Column(children: [
                Text(
                  "Your Verification is incomplete , Please re upload verification.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                ),

                SizedBox(height: 20,),


                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0)),
                      foregroundColor: MaterialStateProperty.all<Color>(MyColors.darkbtncolor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red)
                          )
                      )
                  ),
                  onPressed: () async {
                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    Navigator.of(context,rootNavigator: true);
                    pushNewScreen(
                      context,
                      screen: LoginVerificatrionDetailScreen(),
                      withNavBar: false,
                    );
                  },
                  // padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0)),
                  // color: MyColors.darkbtncolor,
                  child: Text(
                    "If you want to update verification Click Here"
                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: MyColors.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                  ),
                ),

                SizedBox(height: 20,),
              ],
              ):Container(),




              document_status == "pending"?
              Column(children: [
                Text(
                  "We will notify you as soon as you’re approved.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: "s_asset/font/raleway/raleway_regular.ttf"),
                ),


                SizedBox(height: 20,),
              ],
              ):Container(),


            ],),

          );
        });
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        color: MyColors.lightblueColor,
        fontWeight: FontWeight.bold,
        fontSize: 11.50,
        letterSpacing: 0,
        fontFamily: "s_asset/font/raleway/raleway_regular.ttf"
    );
    Widget text;
    switch (value.toInt()) {

      case 0:
        text = const Text(' ', style: style);
        break;
      case 1:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Feb', style: style);
        break;
      case 3:
        text = const Text('  Mar', style: style);
        break;
      case 4:
        text = const Text('   Apr', style: style);
        break;
      case 5:
        text = const Text('   May', style: style);
        break;
      case 6:
        text =const Text('   Jun', style: style);
        break;
      case 7:
        text = const Text('  Jul', style: style);
        break;
      case 8:
        text = const Text('  Aug', style: style);
        break;
      case 9:
        text = const Text('  Sep', style: style);
        break;
      case 10:
        text = const Text('  Oct', style: style);
        break;
      case 11:
        text = const Text('   Nav  ', style: style);
        break;
      case 12:
        text = const Text('    Dec       ', style: style);
        break;
      case 13:
        text = const Text('', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
  //  margin: 10,
    reservedSize: 102,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border:  Border(
      bottom: BorderSide(color: Colors.transparent),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );






  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
    isCurved: true,
    gradient: LinearGradient(
      colors: [MyColors.lightblueColor,MyColors.lightblueColor],
    ),
    barWidth: 4,
    isStrokeCapRound: true,
    isStepLineChart: false,
    aboveBarData: BarAreaData(
        color: Colors.red
    ),
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: true,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [MyColors.lightblueColor.withOpacity(0.60),MyColors.lightblueColor.withOpacity(0.04)],
      ),
    ),
    spots:
    chartdatalist.length > 0?
    List.generate(txnGraphDatalist.length, (index) => FlSpot(double.parse(txnGraphDatalist[index].month.toString()), double.parse(txnGraphDatalist[index].totalSendAmount.toString()))).toList()
   // chartdatalist[0].txnGraphData!.map((pointt) => FlSpot(double.parse(pointt.month.toString()), double.parse(pointt.totalSendAmount.toString()))).toList():
  /*  List<TxnGraphDataModel> spots =
      txnGraphDatalist.asMap().entries.map((e) {
    return FlSpot(e.key.toDouble(), e.value);
  }).toList(),*/
 /*   List.generate(txnGraphDatalist.length, (index) {

     // var xvalue = int.parse(txnGraphDatalist[index].month.toString())
      return   FlSpot(double.parse(txnGraphDatalist[index].totalSendAmount.toString()), double.parse(txnGraphDatalist[index].totalSendAmount.toString()));
    }).toList(),*/
    : [
      FlSpot(1, 0),
      FlSpot(2, 0),
      FlSpot(3, 0),
      FlSpot(4, 0),
      FlSpot(5, 0),
      FlSpot(6, 0),
      FlSpot(7, 0),
      FlSpot(8, 0),
      FlSpot(9, 0),
      FlSpot(10, 0),
      FlSpot(11, 0),
      FlSpot(12, 0),
    ],
  );


}

class PricePoint {
}
