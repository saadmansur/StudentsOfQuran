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


Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
//SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
  await Firebase.initializeApp();
runApp(MyApp());
//});
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
      home: homePageWithWidgets(),
      routes:  {
        drawer_routes.home: (context) => homePageWithWidgets(),
//        drawer_routes.contact: (context) => YoutubePlayerDemo(title: 'Youtube Player'),
        drawer_routes.surahList: (context) => surahListPage(),
//        pageRoutes.profile: (context) => profilePage(),
//        pageRoutes.notification: (context) => notificationPage(),
      },
    );
  }
}
