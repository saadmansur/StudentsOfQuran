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
        widget.surah.ytLink;
    player.play(url);

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
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.surah.englishTitle.length > 0?  widget.surah.englishTitle + "  -\t" + widget.surah.arabicTitle: widget.surah.arabicTitle),
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
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://qurantafseeraudios.b-cdn.net/audio.jpg",
                    width: size.width * 0.9,
                    height: 350,
                    fit: BoxFit.fill,
                  )),
              const SizedBox(height: 30),
              Text(
                widget.surah.arabicTitle,
                style: TextStyle(
                    color: HexColor("#ffe200"),
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
              Slider(
                activeColor: Colors.green, // The color to use for the portion of the slider track that is active.
                inactiveColor: Colors.green[100], // The color for the inactive portion of the slider track.
                thumbColor: Colors.white,
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await player.seek(position);

                  await player.resume();
                },
              ),
                  const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(formatTime(position),style: TextStyle(
                          color: HexColor("#ffe200"),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                      Text(formatTime(duration - position), style: TextStyle(
                          color: HexColor("#ffe200"),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0))
                    ],
                  )),
                  const SizedBox(height: 20),
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.green,
                    ),
                    iconSize: 45,
                    onPressed: () async {
                      if (!isPlaying) {
                        player.play(
                            widget.surah.ytLink);
                      } else {
                        player.pause();
                      }
                    },
                  ))
            ])])
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
