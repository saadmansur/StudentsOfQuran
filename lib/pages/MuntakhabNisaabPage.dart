import 'package:flutter/material.dart';
import 'package:flutterapp/Utils.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';

import 'package:flutterapp/services/address_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/SurahInfo.dart';
import 'package:flutterapp/pages/ChewiePlayerScreen.dart';

class MuntakhabNisaabPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
  static const String routeName = '/bayanVideoPage';

}

class _MyHomePageState extends State<MuntakhabNisaabPage> {

  final CollectionReference _videos =
  FirebaseFirestore.instance.collection('muntikhab_nisaab_videos');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Muntakhib Nisaab Video Lectures"),
        backgroundColor: HexColor("007055"),
      ),
      body: StreamBuilder(
        stream: _videos.orderBy("order", descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Container(
                padding: EdgeInsets.all(1.0),
                alignment: Alignment.center,
                color: HexColor("05302D"),
                child:ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                    SurahInfo surahToPlay = SurahInfo(
                        surahNumber: documentSnapshot['video_name'],
                        arabicTitle: documentSnapshot['video_name'],
                        ytLink: documentSnapshot['video_link'],
                        englishTitle: "");
                    return Container(
                      color: HexColor("05302D"),
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, left: 16, right: 16),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChewieDemo(surah: surahToPlay),
                                settings: RouteSettings(name: 'Muntakhib Nisaab Video Player Screen' + surahToPlay.arabicTitle),
                              ),
                            );
                          },

                          child: Card(
                            color: HexColor("4F7B6E"),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Container(
                                            width:size.width * 0.8, //width must be less than the width of Row(),
                                            child:Text(
                                              documentSnapshot['video_name'],
                                              //'Note Title',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0,
                                                  color: HexColor("#ffe200")),
                                            ),
                                          )
                                        ],
                                      )
                                      /*Text(
                                    documentSnapshot['video_name'],
                                    //'Note Title',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                        color: HexColor("#ffe200")),
                                  )*/,
                                      Text(
                                        documentSnapshot['video_author'],
                                        //'Note Text',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                    );
                  },
                ));
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

//      drawer: NavDrawer(),
    );
  }
}
