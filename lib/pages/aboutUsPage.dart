import 'package:flutter/material.dart';
import 'package:flutterapp/Utils.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';

import 'package:flutterapp/services/address_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class aboutUsPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static const String routeName = '/homePage';
  String hadeesText =
      "Biyan ul Quran (Tafseer of Quran Majeed), Muntakhab Nisab (Detailed commentary on selective Surah / Ayyah of Quran Majeed) and Arbaeen Nabawi (Commentary on 40 Ahadees) by Dr Israr Ahmed (RA) are precious and well-known sources of inspiration for all Muslims around the world. Alhamdulilah.\n\n" + "By Toufeeq of Allah SWT, we have made an effort to bring this treasure of Quran and Hadees to one platform with elimination of any dependency on media providers. Alhamdulilah." +

          "This application enables its users to access video as well as audio lectures of Quran Tafseer. Another unique feature of this application is the privilege to access Tafseer of individual Surah. Alhamdulilah.\n\n" +

          "Motivational lectures, kid's corner, Digital Quranic Arabic dictionary are value adding features of this application.\n\n" +

          "Please join our hands by using and sharing this application and become a part of Sadqah e Jariyah in-Shaa-Allah. May Allah SWT Accept our little efforts. Ameen. \n\n" +
          "For feedback:\nkhudaamulqurannz@gmail.com\n\n" +
          "Saad Mansur (Principal Developer)\n\n" +
          "Powered by Khuddam ul Quran NZ";
}

class _MyHomePageState extends State<aboutUsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: HexColor("007055"),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              color: HexColor("214C40"),
              width: size.width,
              height: size.height,
            ),
          ),
          Column(
            children: [
//              Padding(padding: EdgeInsets.symmetric(vertical: 40)),
              /*Image.asset("lib/images/khuddamLogo.jpeg",
                  width: 250, height: 250, fit: BoxFit.fill),*/
//              ClipRRect(
//                  borderRadius: BorderRadius.circular(20),
//                  child: Image.asset("lib/images/khuddamLogo.jpeg",
//                    width: size.height * 0.23,
//                    height: size.height * 0.23,
//                    fit: BoxFit.fill,
//                  )),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 15, bottom: 15, right: 15, top: 15),
                          //apply padding to some sides only
                          child: Text(widget.hadeesText,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 17.0,
                                  color: Colors.white)))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore /Users/saadmansur/upload-keystore.jks -destkeystore /Users/saadmansur/upload-keystore.jks -deststoretype pkcs12".*/
