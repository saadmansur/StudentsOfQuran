import 'package:flutter/material.dart';
import 'package:flutterapp/Utils.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';

import 'package:flutterapp/services/address_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/pages/BayanVideosPage.dart';
import 'package:flutterapp/pages/surahListPage.dart';
import 'package:flutterapp/pages/surahAudiosListPage.dart';
import 'package:flutterapp/pages/hadeesPage.dart';
import 'package:flutterapp/pages/aboutUsPage.dart';
import 'package:flutterapp/pages/AudioPlayerPage.dart';
import 'package:flutterapp/pages/kidsSurahScreen.dart';
import 'dart:math';
import 'package:flutterapp/model/SurahInfo.dart';

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
//    WidgetsBinding.instance!.addPostFrameCallback((_) async {
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
//    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: HexColor("007055"),
      ),
      body: Stack(children: <Widget>[
//
//      Center(
//          child: Image.asset("lib/images/khuddamLogo.jpeg")),
        Container(
            padding: EdgeInsets.all(15.0),
            alignment: Alignment.center,
            color: HexColor("B9D187"),
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
            ))
      ]),
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
//      drawer: NavDrawer(),
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
      elevation: 5.0,
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
    if (index == 0) {
      createTafseerLecturesContainer();
    } else if (index == 1) {
      SurahInfo surahToPlay = SurahInfo(
          surahNumber: "11",
          arabicTitle: "Safaat",
          ytLink:
              "https://qurantafseeraudios.b-cdn.net/102%20%5BQuran%20Tafseer%20Urdu%5D%20AL-HAAQ_QAH.mp3",
          englishTitle: "");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AudioPlayerPage(surah: surahToPlay),
          settings: RouteSettings(name: 'Surah List Screen View'),
        ),
      );
    } else if (index == 2) {
      createKidsSurahContainer();
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BayanVideosPage(),
          settings: RouteSettings(name: 'Video Lectures List Screen View'),
        ),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => hadeesPage(),
          settings: RouteSettings(name: 'Surah List Screen View'),
        ),
      );
    } else if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => aboutUsPage(),
          settings: RouteSettings(name: 'Surah List Screen View'),
        ),
      );
    }
  }

  void createTafseerLecturesContainer() {
    String _selectedGender = 'male';
    var _result;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: HexColor("007055"),
            /*  title: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Quran Tafseer",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: HexColor("#ffe200")),
                    ),
                  ),
                  color: HexColor("05302D"),
                )
              ]),*/
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile(
                          title: const Text('Listen Audio Lectures',
                              style: TextStyle(
                                color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0)),
                          value: 4,
                          groupValue: _result,
                          onChanged: (value) {
                            setState(() {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => surahAudiosListPage(),
                                  settings: RouteSettings(
                                      name: 'Surah List Audio Screen View'),
                                ),
                              );
                            });
                          }),
                      RadioListTile(
                          title: const Text('Watch Video Lectures',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0)),
                          value: 5.4,
                          groupValue: _result,
                          onChanged: (value) {
                            setState(() {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => surahListPage(),
                                  settings: RouteSettings(
                                      name: 'Surah List Video Screen View'),
                                ),
                              );
                            });
                          }),
                    ],
                  );
                },
              ));
        });
  }

  void createKidsSurahContainer() {
    List<String> surahs = [
      "Surah Nas",
      "Surah Falaq",
      "Surah Ikhlas",
      "Surah Qadar"
    ];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: HexColor("007055"),
            title: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Surah's",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: HexColor("#ffe200")),
                  ),
                ),
                color: HexColor("05302D"),
              )
            ]),
            content: setupAlertDialoadContainer(context, surahs),
          );
        });
  }

  Widget setupAlertDialoadContainer(context, List<String> surahPartsList) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: HexColor("05302D"),
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: surahPartsList.length,
            itemBuilder: (BuildContext context, int index) {
//              SurahInfo surah = createSurahInstance(surahPartsList[index]);

              return Container(
                  color: HexColor("05302D"),
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 8, right: 8),
                  child: InkWell(
                      onTap: () {
                        openSurahFragment(index, context);
                      },
                      child: Card(
                        color: HexColor("4F7B6E"),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
//                                height: MediaQuery.of(context).size.height * 0.8,
//                                padding: EdgeInsets.only(
//                                    left: 0, top: MediaQuery.of(context).size.height * 0.2, right: 0, bottom:50),
//                                child: SingleChildScrollView(
//                                    scrollDirection: Axis.vertical,
//                                    physics: AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, bottom: 5, right: 15, top: 5),
                                    //apply padding to some sides only
                                    child: Text(surahPartsList[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            color: HexColor("#ffe200")))),
                              ))
                            ],
                          ),
                        ),
                      )));
            },
          ),
        ),
      ],
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

/*Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore /Users/saadmansur/upload-keystore.jks -destkeystore /Users/saadmansur/upload-keystore.jks -deststoretype pkcs12".*/
