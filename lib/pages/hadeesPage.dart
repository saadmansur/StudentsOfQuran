import 'package:flutter/material.dart';
import 'package:flutterapp/Utils.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';

import 'package:flutterapp/services/address_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/pages/BayanVideosPage.dart';
import 'package:flutterapp/pages/surahListPage.dart';
import 'dart:math';

class hadeesPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static const String routeName = '/homePageWithWidgets';
  String hadeesText = "";
}

class _MyHomePageState extends State<hadeesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final remoteConfig = await RemoteConfig.instance;

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

      });
    });
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hadees of the day"),
        backgroundColor: HexColor("007055"),
      ),

      body: Stack(
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
        Center(
          child: Image.network(
            widget.hadeesText,
            width: size.width,
            height: (size.height - AppBar().preferredSize.height)  * 0.6,
            fit: BoxFit.cover,
          )),
        ],
      ),
    );
  }
}

/*Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore /Users/saadmansur/upload-keystore.jks -destkeystore /Users/saadmansur/upload-keystore.jks -deststoretype pkcs12".*/
