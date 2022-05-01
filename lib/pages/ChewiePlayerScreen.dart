import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/pages/ChewieListItem.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../Utils.dart';
import '../model/SurahInfo.dart';

class ChewieDemo extends StatefulWidget {
//  const ChewieDemo({
//    Key? key,
//    this.title = 'Chewie Demo',
//  }) : super(key: key);

//  final String title;

  ChewieDemo({Key? key, required this.surah}) : super(key: key);
  final SurahInfo surah;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        Wakelock.enable();
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
//    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();

    _setOrientation([
//    DeviceOrientation.landscapeRight,
//    DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
    ]);
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

//  List<String> srcs = [
//    "https://qurantafseervideos.b-cdn.net/Surah%20Taghabun_Final.mp4",
//    "https://qurantafseervideos.b-cdn.net/Surah%20Taghabun_Final.mp4"
//  ];

  Future<void> initializePlayer() async {
    _videoPlayerController1 =
        VideoPlayerController.network(widget.surah.ytLink);
//    _videoPlayerController2 =
//        VideoPlayerController.network(srcs[currPlayIndex]);
    await Future.wait([
      _videoPlayerController1.initialize(),
//      _videoPlayerController2.initialize()
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

//    final subtitles = [
//      Subtitle(
//        index: 0,
//        start: Duration.zero,
//        end: const Duration(seconds: 10),
//        text: const TextSpan(
//          children: [
//            TextSpan(
//              text: 'Hello',
//              style: TextStyle(color: Colors.red, fontSize: 22),
//            ),
//            TextSpan(
//              text: ' from ',
//              style: TextStyle(color: Colors.green, fontSize: 20),
//            ),
//            TextSpan(
//              text: 'subtitles',
//              style: TextStyle(color: Colors.blue, fontSize: 18),
//            )
//          ],
//        ),
//      ),
//      Subtitle(
//        index: 0,
//        start: const Duration(seconds: 10),
//        end: const Duration(seconds: 20),
//        text: 'Whats up? :)',
//        // text: const TextSpan(
//        //   text: 'Whats up? :)',
//        //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
//        // ),
//      ),
//    ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: false,
      showOptions: false,

//      additionalOptions: (context) {
//        return <OptionItem>[
//          OptionItem(
//            onTap: toggleVideo,
//            iconData: Icons.live_tv_sharp,
//            title: 'Toggle Video Src',
//          ),
//        ];
//      },
//      subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );

    _chewieController?.enterFullScreen();
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex = currPlayIndex == 0 ? 1 : 0;
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return /* WillPopScope(
        onWillPop: () async {
          return true;},
     child:*/
        MaterialApp(
      title: widget.surah.arabicTitle,
//      theme: AppTheme.light.copyWith(
//        platform: _platform ?? Theme.of(context).platform,
//      ),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: HexColor("007055"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            title: Text(
                widget.surah.englishTitle.length > 0?  widget.surah.englishTitle + "  -\t" + widget.surah.arabicTitle: widget.surah.arabicTitle,
                style: TextStyle(color: Colors.white))),
        /*appBar: AppBar(
            backgroundColor: HexColor("007055"),
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(widget.surah.arabicTitle, style: TextStyle(color: Colors.white))
        ),*/
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: _chewieController != null &&
                          _chewieController!
                              .videoPlayerController.value.isInitialized
                      ? Chewie(
                          controller: _chewieController!,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 15, bottom: 15, right: 15, top: 15),
                                //apply padding to some sides only
                                child: Text(
                                    'Loading Video. It can take upto 15 seconds. Replay the video if it is still not loaded.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                        color: Colors.white))),
                          ],
                        ),
                ),
              ),
            ),
            /*TextButton(
              onPressed: () {
                _chewieController?.enterFullScreen();
              },
              child: const Text('Fullscreen'),
            ),
             Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _videoPlayerController1.pause();
                        _videoPlayerController1.seekTo(Duration.zero);
                        _createChewieController();
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Landscape Video"),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _videoPlayerController2.pause();
                        _videoPlayerController2.seekTo(Duration.zero);
                        _chewieController = _chewieController!.copyWith(
                          videoPlayerController: _videoPlayerController2,
                          autoPlay: true,
                          looping: true,
                          /* subtitle: Subtitles([
                            Subtitle(
                              index: 0,
                              start: Duration.zero,
                              end: const Duration(seconds: 10),
                              text: 'Hello from subtitles',
                            ),
                            Subtitle(
                              index: 0,
                              start: const Duration(seconds: 10),
                              end: const Duration(seconds: 20),
                              text: 'Whats up? :)',
                            ),
                          ]),
                          subtitleBuilder: (context, subtitle) => Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              subtitle,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ), */
                        );
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Portrait Video"),
                    ),
                  ),
                )
              ],
            ),
      Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.android;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Android controls"),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.iOS;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("iOS controls"),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.windows;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Desktop controls"),
                    ),
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: ListView(
        children: <Widget>[
//          ChewieListItem(
//            videoPlayerController: VideoPlayerController.asset(
//              'assets/StartVideo.mp4',
//            ),
//            looping: true, key: Key(""),
//          ),
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ), looping: false, key: Key(""),
          ),
//          ChewieListItem(
//            // This URL doesn't exist - will display an error
//            videoPlayerController: VideoPlayerController.network(
//              'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/error.mp4',
//            ), key: Key(""), looping: false,
//          ),
        ],
      ),
    );
  }
}*/

/*
* /*,
    "surahParts":["1 | Rukooh 1 to Rukooh 6 | 3XuRexhrRCo | Rukooh 1 to Rukooh 6",
      "2 | Rukooh 6 to Rukooh 12 | 3XuRexhrRCo | Rukooh 6 to Rukooh 12",
      "3 | Rukooh 12 to Rukooh 18 | 3XuRexhrRCo | Rukooh 12 to Rukooh 18",
      "3 | Rukooh 12 to Rukooh 18 | 3XuRexhrRCo | Rukooh 12 to Rukooh 18",
      "3 | Rukooh 12 to Rukooh 18 | rerrrr | Rukooh 12 to Rukooh 18",
      "3 | Rukooh 12 to Rukooh 18 | rerrrr | Rukooh 12 to Rukooh 18",
      "3 | Rukooh 12 to Rukooh 18 | rerrrr | Rukooh 12 to Rukooh 18",
      "3 | Rukooh 12 to Rukooh 18 | rerrrr | Rukooh 12 to Rukooh 18"
    ]*/*/
