import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/s_Api/AllApi/ApiService.dart';
import 'package:moneytos/s_Api/s_utils/Utility.dart';
import 'package:moneytos/s_Api/s_utils/timer_change_notifier.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/home/s_home/reasonforsendingpaymethod/reasonforsendingpaymethod.dart';
import 'package:moneytos/view/loginscreen/loginscreen.dart';
import 'package:moneytos/view/onBoardingScreen/onboardingScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'model/documentDetailModel.dart';

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

int? initScreen;
bool? islogin;

/// Api call
List<DocumentDataDetailModel> documentdetaillist = [];
bool doc_load = false;

///

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }
  // Or do other work.
}

String messageTitle = "Empty";
String notificationAlert = "alert";
FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin? fltNotification;
String fcmtoken = "";

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  setNotifications(BuildContext context) async {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
      (message) async {
        print("message...${message}");
        AllApiService.isNotification = "1";
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);

        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

        notificationTitle.isNotEmpty || notificationTitle != ''
            ? null
            : null;
        FirebaseMessaging.instance.getInitialMessage().then((value) {
          print('getInitialMessage data: ${message.data}');

          //_serialiseAndNavigate(message);
        });
      },
    );
    // With this token you can test it easily on your phone
    final token =
        _firebaseMessaging.getToken().then((value) => print('Token: $value'));

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // RemoteNotification? notification = message!.notification;
      // AndroidNotification? android = message.notification?.android;
      /*if (notification != null && android != null) {
        message.notification!.title! == "Kobi Ifrach" ?
        navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (_) => ChatScreen(webviewurl: AllApiService.chatUrl+"userChat?uuid="+userId,)))
            :
        message.notification!.title! == "Meating Aleart" ?
        navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (_) => Dashboard(selectedIndex: 2, status: 'Home')))
            :
        navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (_) => Dashboard(selectedIndex: 0, status: 'Home')));
      }*/
    });

    /// openapp

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          'A new onMessageOpenedApp event was published!... ${message.notification!.title!}');

      /* message.notification!.title! == "Kobi Ifrach" ?
      navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (_) => ChatScreen(webviewurl: AllApiService.chatUrl+"userChat?uuid="+userId,)))
          :
      message.notification!.title! == "Meating Aleart" ?
      navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (_) => Dashboard(selectedIndex: 2, status: 'Home')))
          :
      navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (_) => Dashboard(selectedIndex: 0, status: 'Home')));*/
    });
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initMessaging() async {
  var androiInit = const AndroidInitializationSettings("@mipmap/ic_launcher");
  var iosInit = const IOSInitializationSettings();
  var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);
  fltNotification = FlutterLocalNotificationsPlugin();
  fltNotification!.initialize(initSetting);
  var androidDetails = const AndroidNotificationDetails(
    '1',
    "channelName",
  );
  var iosDetails = const IOSNotificationDetails();
  var generalNotificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      fltNotification!.show(notification.hashCode, notification.title,
          notification.body, generalNotificationDetails);
    }
  });
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void pushFCMtoken() async {
  String? token = await messaging.getToken();
  fcmtoken = token.toString();
  print("fcmtoken>>>>" + fcmtoken.toString());
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString("fcmtoken", fcmtoken.toString());

  initMessaging();
//you will get token here in the console
}

void main() async {
  await init();
  FCM();
  pushFCMtoken();

  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: MyColors.whiteColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemStatusBarContrastEnforced: true,
      statusBarBrightness:
          Brightness.dark, // ios         dark >white<   , light>black<
      statusBarColor: MyColors.light_primarycolor2, // status bar color
    ),
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  islogin = await preferences.getBool('login');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(
    // const MyApp(),
    ChangeNotifierProvider(
      create: (context) => CountdownTimerState(context),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);
  @override
  void initState() {
    super.initState();
    getDocumentApi();
    setState(() {});
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: "@mipmap/ic_launcher",
            ),
          ),
        );
      }
    });

    getToken();
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications(context);

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
  }

  late String token;
  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
  }

  getDocumentApi() async {
    documentdetaillist.clear();
    setState(() {
      doc_load = true;
    });
    await Webservices.DocumentDetailRequest(context, documentdetaillist);
    setState(() {
      doc_load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: MyString.app_name,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // primarySwatch: Colors.blue,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              // backwardsCompatibility: false, // 1
              systemOverlayStyle: SystemUiOverlayStyle.light, // 2
            ),
            //  appBarTheme: w
            //     textTheme: GoogleFonts.raleway().copyWith(
            // //  body1: GoogleFonts.oswald(textStyle: textTheme.body1),
            //     )
          ),
          builder: (context, widget) {
            return ScrollConfiguration(
                behavior: const ScrollBehaviorModified(), child: widget!);
          },
          home: initScreen == 0 || initScreen == null
              ? const OnBoardingPage()
              : islogin == true
                  ? DashboardScreen()
                  : LoginScreenPage(),
          // home: ReasonForSendingPaymethod() ,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/*
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneytos/constance/myColors/mycolor.dart';
import 'package:moneytos/constance/myStrings/myString.dart';
import 'package:moneytos/view/dashboardScreen/dashboard.dart';
import 'package:moneytos/view/loginscreen/loginscreen.dart';
import 'package:moneytos/view/onBoardingScreen/onboardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
int? initScreen;
bool? islogin;
void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MyColors.light_primarycolor2,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
    systemStatusBarContrastEnforced: true,
    statusBarBrightness: Brightness.dark, // ios         dark >white<   , light>black<
    statusBarColor: MyColors.light_primarycolor2, // status bar color
  ));
  init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen =  await preferences.getInt('initScreen');
  islogin =  await preferences.getBool('login');
  await preferences.setInt('initScreen', 1); //if already shown -> 1 else 0
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Sizer(
        builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: MyString.app_name,
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
           // primarySwatch: Colors.blue,
      brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              backwardsCompatibility: false, // 1
              systemOverlayStyle: SystemUiOverlayStyle.light, // 2
            ),
  //  appBarTheme: w
      //     textTheme: GoogleFonts.raleway().copyWith(
      // //  body1: GoogleFonts.oswald(textStyle: textTheme.body1),
      //     )
      ),

        home: initScreen == 0 || initScreen == null ?  OnBoardingPage() : islogin == true ? DashboardScreen() : LoginScreenPage() ,
      );
        },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/

String notificationTitle = '';
String notificationBody = '';
String notificationData = '';

void showLoader(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
            title: new Text(notificationTitle),
            content: Wrap(
              children: [
                new Text(notificationData),
                new Text(notificationBody),
              ],
            ),
            actions: <Widget>[
              Container(
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                child: new IconButton(
                    icon: const Text(
                      "Done",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              const SizedBox(
                width: 30,
              )
            ],
          ));
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics());
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
