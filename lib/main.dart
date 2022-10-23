// @dart=2.9
import 'package:flutter/material.dart';
import '../pages/homePage.dart';
import '../pages/homePageWithWidgets.dart';
import '../pages/player_screen.dart';
import '../pages/surahListPage.dart';
import '../routes/drawer_routes.dart';
import 'package:flutter/services.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dart:async';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
  await Firebase.initializeApp();
  runApp(MyApp());
//});
}

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
// THIS FUNCTION WILL NAVIGATE FROM SPLASH SCREEN TO HOME SCREEN.    // USING NAVIGATOR CLASS.

  void navigationToNextPage() {
    Navigator.pushReplacementNamed(context, '/homePageWithWidgets');
  }

  startSplashScreenTimer() async {
    var _duration = new Duration(seconds: 3);
    return Timer(_duration, navigationToNextPage);
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // To make this screen full screen.
    // It will hide status bar and notch.
//    SystemChrome.setEnabledSystemUIOverlays([]);
    Size size = MediaQuery.of(context).size;
    // full screen image for splash screen.
//    return Container(
//      color: Colors.white,
//      padding: const EdgeInsets.all(25),
//        child: Image.asset("lib/images/khuddamLogo.jpeg"));
    return Column(
      children: [
//      Padding(padding: EdgeInsets.symmetric(vertical: 40)),
//      /*Image.asset("lib/images/khuddamLogo.jpeg",
//                  width: 250, height: 250, fit: BoxFit.fill),*/
        Container(
            color: Colors.white,
            alignment: Alignment.center,
            width: size.width,
            height: size.height * 0.88,
            child:
            Image.asset("lib/images/khuddamLogo.jpeg"
            )),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          width: size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          padding: EdgeInsets.only(
              left: 5,
              top: 0,
              right: 5,
              bottom: 0),
          child:  Text("Designed & Developed by Saad Mansur as Sadaqah Jariyah",
              style: TextStyle(
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  decoration: TextDecoration.none,
                  color: Colors.black)),
        ),

      ],
    );
  }
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NavigationDrawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: SplashPage(),
      routes: {
        drawer_routes.home: (context) => homePageWithWidgets(),
//        drawer_routes.contact: (context) => YoutubePlayerDemo(title: 'Youtube Player'),
        drawer_routes.surahList: (context) => surahListPage(),
//        pageRoutes.profile: (context) => profilePage(),
//        pageRoutes.notification: (context) => notificationPage(),
      },
    );
  }
}
