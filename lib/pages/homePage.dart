import 'package:flutter/material.dart';
import 'package:flutterapp/Utils.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';

import 'package:flutterapp/services/address_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static const String routeName = '/homePage';
   String hadeesText = "";

}
class _MyHomePageState extends State<homePage> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {

      setState(() {
        // widget.hadeesText = remoteConfig.getString("hadees_text");

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Hadees"),
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
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height ,
                  padding: EdgeInsets.only(
                      left: 0, top: MediaQuery.of(context).size.height * 0.2, right: 0, bottom:0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding (padding: EdgeInsets.only(left:15, bottom: 15, right: 15, top:15), //apply padding to some sides only
                      child: Text(
                          widget.hadeesText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0,
                              color: Colors.white)) )
                  ),
                ),
              ),
            ],
          ),
//          Container(
//              height: 10,
//              width: 10,
//              decoration: BoxDecoration(
//                  image: DecorationImage(
//                      fit: BoxFit.none,
//                      image:  AssetImage('lib/images/white_arrow.png'))))
//          Expanded(
//            // 5
//              child: ClipRRect(
//                  child: Image.asset('lib/images/white_arrow.png',
//                      fit: BoxFit.cover),
//                  borderRadius: BorderRadius.circular(12))),
/*          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.none,
                      image:  AssetImage('lib/images/white_arrow.png'))))*/
        ],
      ),
      drawer: NavDrawer(),
    );
  }
}


/*Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore /Users/saadmansur/upload-keystore.jks -destkeystore /Users/saadmansur/upload-keystore.jks -deststoretype pkcs12".*/