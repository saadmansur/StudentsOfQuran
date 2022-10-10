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
      "This app mainly consists of Tafseer Quran lectures by Dr. Israr Ahmed.\n\nPowered by: Khuddam ul Quran NZ \n\nDeveloped by: Saad Mansur \n\nFor feedback please email us at: \nsaad_mansur@hotmail.com\nkhudaamulqurannz@gmail.com";
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
            child: Image.asset(
              "lib/images/home_bg.jpg",
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 40)),
              /*Image.asset("lib/images/khuddamLogo.jpeg",
                  width: 250, height: 250, fit: BoxFit.fill),*/
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("lib/images/khuddamLogo.jpeg",
                    width: size.height * 0.23,
                    height: size.height * 0.23,
                    fit: BoxFit.fill,
                  )),
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
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22.0,
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
