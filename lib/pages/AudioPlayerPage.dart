import 'package:flutter/material.dart';
import 'package:flutterapp/Utils.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';

import 'package:flutterapp/services/address_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';
import '../model/SurahInfo.dart';
class AudioPlayerPage extends StatefulWidget {

  AudioPlayerPage({ required this.surah}) : super();
  final SurahInfo surah;
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
  static const String routeName = '/homePage';
  }

class _MyHomePageState extends State<AudioPlayerPage> {
  AudioPlayer player = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    final url =
        'https://qurantafseeraudios.b-cdn.net/102%20%5BQuran%20Tafseer%20Urdu%5D%20AL-HAAQ_QAH.mp3';
    player.setUrl(url);

    player.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      if (!mounted) return;
      setState(() {
        duration = newDuration;
      });
    });

    player.onAudioPositionChanged.listen((newPosition) {
      if (!mounted) return;
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
          backgroundColor: HexColor("007055"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://videoLectutures.b-cdn.net/Zulhajj.jpg",
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.fill,
                  )),
              const SizedBox(height: 20),
              Text(
                widget.surah.arabicTitle,
                style: TextStyle(
                    color: HexColor("#ffe200"),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await player.seek(position);

                  await player.resume();
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(formatTime(position)),
                      Text(formatTime(duration - position))
                    ],
                  )),
              CircleAvatar(
                  radius: 35,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    iconSize: 50,
                    onPressed: () async {
                      if (!isPlaying) {
                        player.play(
                            'https://qurantafseeraudios.b-cdn.net/102%20%5BQuran%20Tafseer%20Urdu%5D%20AL-HAAQ_QAH.mp3');
                      } else {
                        player.pause();
                      }
                    },
                  ))
            ]))
        /*body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: cow button
                player.play();
              },
              child: Text('Cow'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: horse button
              },
              child: Text('Horse'),
            ),
          ],
        ),
      ),*/
        );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}

/*Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore /Users/saadmansur/upload-keystore.jks -destkeystore /Users/saadmansur/upload-keystore.jks -deststoretype pkcs12".*/
