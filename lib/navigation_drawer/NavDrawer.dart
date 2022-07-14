import 'package:flutter/material.dart';
import 'package:flutterapp/pages/homePage.dart';
import 'package:flutterapp/pages/player_screen.dart';
import 'package:flutterapp/routes/drawer_routes.dart';
import 'package:flutterapp/pages/homePageWithWidgets.dart';

import '../pages/kidsSurahScreen.dart';
import '../pages/surahListPage.dart';
import '../pages/BayanVideosPage.dart';
import '../widgets/createDrawerHeader.dart';
import '../Utils.dart';

class NavDrawer extends StatelessWidget {
  static final List<String> surahs = [
    "Surah Nas",
    "Surah Falaq",
    "Surah Ikhlas",
    "Surah Qadar",
    "More",
  ];

  static final List<String> surahs_tafseer = [
    "Surah Baqrah",
    "Surah Nas",
    "Surah Falaq",
    "Surah Kafiroon",
    "More",
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: HexColor("#4F7B6E"),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(),
            ListTile(
              title: Text('Home',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: HexColor("#ffe200"))),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, drawer_routes.home);
              },
            ),
            ListTile(
              title: Text("Tafseer by Dr. Israr",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: HexColor("#ffe200"))),
              onTap: () {
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => surahListPage()),settings: RouteSettings(name: 'Surah List Screen View'));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => surahListPage(),
                    settings: RouteSettings(name: 'Surah List Screen View'),
                  ),
                );
              },
            ),
            ExpansionTile(
              title: Text("Surah's' Illustration for kids",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: HexColor("#ffe200"))),
              children: surahs
                  .map((data) => ListTile(
                //leading: Icon(Icons.person),
                contentPadding: EdgeInsets.only(left: 45),
                title: Text(data,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: HexColor("#ffe200"))),
                // subtitle: Text("a subtitle here"),
                onTap: () {
                  openSurahFragment(surahs.indexOf(data), context);
                },
              ))
                  .toList(),
            ),
/*            ListTile(
              title: Text('Hadees Lectures by Dr. Israr',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: HexColor("#ffe200"))),
              onTap: () {
                Navigator.of(context).pop();
//                Navigator.of(context).push(MaterialPageRoute(
//                    builder: (BuildContext context) => SubPage()));
              },
            ),*/
            ListTile(
              title: Text('Video Lectures',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: HexColor("#ffe200"))),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BayanVideosPage(),
                    settings: RouteSettings(name: 'Video Lectures List Screen View'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  openSurahFragment(number, context) {
    if (number <= 3) {
      // termination case
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => SurahScreen(number)));
    } else {
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => homePageWithWidgets()));
      // function invokes itself
    }
  }
}