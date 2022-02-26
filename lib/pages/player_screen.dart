import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../Utils.dart';
import '../model/youtube_model.dart';
import '../model/SurahInfo.dart';

class YoutubePlayerDemo extends StatefulWidget {
  YoutubePlayerDemo({Key? key, required this.surah}) : super(key: key);
  final SurahInfo surah;

  @override
  _YoutubePlayerDemoState createState() => _YoutubePlayerDemoState();
}

class _YoutubePlayerDemoState extends State<YoutubePlayerDemo> {
  late YoutubePlayerController _ytbPlayerController;

  List<YoutubeModel> videosList = [
    YoutubeModel(id: 1, youtubeId: '3XuRexhrRCo'),
    YoutubeModel(id: 2, youtubeId: 'UQGoVB_zMYQ'),
    YoutubeModel(id: 3, youtubeId: 'FLcRb289uEM'),
    YoutubeModel(id: 4, youtubeId: 'g2nMKzhkvxw'),
    YoutubeModel(id: 5, youtubeId: 'qoDPvFAk2Vg'),
  ];

  @override
  void initState() {
    super.initState();

    _setOrientation([
//      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
//      DeviceOrientation.portraitUp,
//      DeviceOrientation.portraitDown,
    ]);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _setOrientation([
//    DeviceOrientation.landscapeRight,
//    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
    ]);

    _ytbPlayerController.close();
  }

  _setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  _buildYtbView() {
    print(widget.surah.ytLink);
    _ytbPlayerController = YoutubePlayerController(
      initialVideoId: widget.surah.ytLink/*videosList[0].youtubeId*/,
      params: YoutubePlayerParams(
        showFullscreenButton: true,
      ),
    );
    return SizedBox.expand(
      child: Container(
        color: Colors.black,
        child: _ytbPlayerController != null
            ? YoutubePlayerIFrame(controller: _ytbPlayerController)
            : Center(child: CircularProgressIndicator()),
      ),
    );

//    return LayoutBuilder(
//      builder: (context, constraints) =>  AspectRatio(
//        aspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height),
//        // _controller.value.aspectRatio,
//        child: _ytbPlayerController != null
//          ? YoutubePlayerIFrame(controller: _ytbPlayerController)
//          : Center(child: CircularProgressIndicator()),
//      )
//    );

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
     onWillPop: () async {
       _setOrientation([
//    DeviceOrientation.landscapeRight,
//    DeviceOrientation.landscapeLeft,
         DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
       ]);
     return true;},
//      child: OrientationBuilder(builder:
//          (BuildContext context, Orientation orientation) {
//        if (orientation == Orientation.landscape) {
           child:Scaffold(
            appBar: AppBar(
                backgroundColor: HexColor("007055"),
                iconTheme: IconThemeData(color: Colors.white),
                title: Text(widget.surah.arabicTitle, style: TextStyle(color: Colors.white))
            ),
            body: _buildYtbView(),
          ));
//        } else {
//          return Scaffold(
//            appBar: AppBar(
//              iconTheme: IconThemeData(color: Colors.black),
//              title: Text(widget.title),
//            ),
//            drawer: NavDrawer(),
//            body: _buildYtbView(),
//          );
//        }
//      }),
//    );
  }

//  _youtubeHierarchy() {
//    return Container(
//      child: Align(
//        alignment: Alignment.center,
//        child: FittedBox(
//          fit: BoxFit.fill,
//          child: YoutubePlayer(
//            controller: _ytbPlayerController,
//          ),
//        ),
//      ),
//    );
//  }

//  _buildMoreVideoTitle() {
//    return Padding(
//      padding: const EdgeInsets.fromLTRB(14, 10, 182, 10),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: [
//          Text(
//            "More videos",
//            style: TextStyle(fontSize: 16, color: Colors.black),
//          ),
//        ],
//      ),
//    );
//  }

//  _buildMoreVideosView() {
//    return Expanded(
//      child: Container(
//        padding: EdgeInsets.symmetric(horizontal: 15),
//        child: ListView.builder(
//            itemCount: videosList.length,
//            physics: AlwaysScrollableScrollPhysics(),
//            itemBuilder: (context, index) {
//              return GestureDetector(
//                onTap: () {
//                  final _newCode = videosList[index].youtubeId;
//                  _ytbPlayerController.load(_newCode);
//                  _ytbPlayerController.stop();
//                },
//                child: Container(
//                  height: MediaQuery.of(context).size.height,
//                  margin: EdgeInsets.symmetric(vertical: 7),
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(18),
//                    child: Stack(
//                      fit: StackFit.expand,
//                      children: <Widget>[
//                        Positioned(
//                          child: CachedNetworkImage(
//                            imageUrl:
//                                "https://img.youtube.com/vi/${videosList[index].youtubeId}/0.jpg",
//                            fit: BoxFit.cover,
//                          ),
//                        ),
//                        Positioned(
//                          child: Align(
//                            alignment: Alignment.center,
//                            child: Image.asset(
//                              'assets/ytbPlayBotton.png',
//                              height: 30,
//                              width: 30,
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              );
//            }),
//      ),
//    );
//  }
}
