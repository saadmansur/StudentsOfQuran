import 'package:flutter/material.dart';
import 'package:flutterapp/Utils.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';

import 'package:flutterapp/services/address_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/pages/BayanVideosPage.dart';
import 'package:flutterapp/pages/surahListPage.dart';
import 'package:flutterapp/pages/hadeesPage.dart';
import 'package:flutterapp/pages/aboutUsPage.dart';
import 'dart:math';

class homePageWithWidgets extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static const String routeName = '/homePageWithWidgets';
  String hadeesText = "";
}

class _MyHomePageState extends State<homePageWithWidgets> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
/*      final remoteConfig = await RemoteConfig.instance;

      try {
        await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(hours: 4), //cache refresh time
          minimumFetchInterval: Duration.zero,
        ));
        await remoteConfig.fetchAndActivate();

      }
      catch (exception) {
        print('Unable to fetch remote config. Cached or default values will be '
            'used');
        print("exception===>$exception");
      }
      setState(() {
        widget.hadeesText = remoteConfig.getString("home_page_image");

      });*/
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: HexColor("007055"),
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
            shrinkWrap: true,
            children: List.generate(
              6,
              (index) {
                return buildCard(index);
              },
            ),
          )),
/*      body: Stack(
        children: <Widget>[
//          Center(
//            child: Image.asset(
//              "lib/images/home_bg.jpg",
//              width: size.width,
//              height: size.height,
//              fit: BoxFit.fill,
//            ),
//          ),
        widget.hadeesText.length == 0? Image.asset(
              "lib/images/home_bg.jpg",
          width: size.width,
          height: size.height - AppBar().preferredSize.height,
          fit: BoxFit.fill,
        ):
          Image.network(
            widget.hadeesText,
            width: size.width,
            height: size.height - AppBar().preferredSize.height,
            fit: BoxFit.fill,
          ),
        ],
      ),*/
      drawer: NavDrawer(),
    );
  }

  Card buildCard(int index) {
    var tilesText = [
      "Quran Tafseer Lectures by Dr. Israr",
      "Hadees Lectures by Dr. Israr",
      "Kids Corner",
      "Motivational Islamic Lectures ",
      "Hadees of the day",
      "About Us"
    ];
    var tilesIcons = [
      "tafseer.png",
      "hadees.png",
      "kids.png",
      "lectures.png",
      "day.png",
      "info.png"
    ];
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80),
        //set border radius more than 50% of height and width to make circle
      ),
      child: InkWell(
          onTap: () {
            openCardDetailsPage(index);
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
                image: DecorationImage(
                    image: AssetImage("lib/images/home_bg.jpg"),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/images/" + tilesIcons[index],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    tilesText[index],
                    style: TextStyle(
                        color: HexColor("#ffe200"),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
//            Center(
//              child: Text(
//                tilesText[index],
//                style: TextStyle(
//                    color: HexColor("#ffe200"),
//                    fontWeight: FontWeight.bold,
//                    fontSize: 16.0),
//              ),
//            ),
              ],
            ),
          )),
//            Container(
//              padding: EdgeInsets.all(5.0),
//              alignment: Alignment.center,
//              child: Text(supportingText),
//            ),
//          ],
    );
  }

  void openCardDetailsPage(int index) {

    if(index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => surahListPage(),
          settings: RouteSettings(name: 'Surah List Screen View'),
        ),
      );
    }
    else if(index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => surahListPage(),
          settings: RouteSettings(name: 'Surah List Screen View'),
        ),
      );
    }
    else if(index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => surahListPage(),
          settings: RouteSettings(name: 'Surah List Screen View'),
        ),
      );
    }
    else if(index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BayanVideosPage(),
          settings:
          RouteSettings(name: 'Video Lectures List Screen View'),
        ),
      );
    }
    else if(index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => hadeesPage(),
          settings: RouteSettings(name: 'Surah List Screen View'),
        ),
      );
    }
    else if(index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => aboutUsPage(),
          settings: RouteSettings(name: 'Surah List Screen View'),
        ),
      );
    }
  }
}

/*Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore /Users/saadmansur/upload-keystore.jks -destkeystore /Users/saadmansur/upload-keystore.jks -deststoretype pkcs12".*/
