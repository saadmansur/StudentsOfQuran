import 'package:flutter/material.dart';
import 'package:flutterapp/Utils.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';

import 'package:flutterapp/services/address_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

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
      final remoteConfig = await RemoteConfig.instance;
//      final defaultValue=<String,dynamic>{
//        'author':'developer',
//        "channel":"developer"
//      };
      try {
        await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(hours: 4), //cache refresh time
          minimumFetchInterval: Duration.zero,
        ));
        await remoteConfig.fetchAndActivate();

//      } on PlatformException catch (exception) {
//// Fetch exception.
//        print(exception);
//        print("exception===>" + remoteConfig.getString("hadees_text"));
//        widget.hadeesText = remoteConfig.getString("hadees_text");
      }
      catch (exception) {
        print('Unable to fetch remote config. Cached or default values will be '
            'used');
        print("exception===>$exception");
      }
      setState(() {
        widget.hadeesText = remoteConfig.getString("hadees_text");

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
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.only(
                      left: 0, top: MediaQuery.of(context).size.height * 0.2, right: 0, bottom:50),
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
//    ),
                // SingleChildScrollView contains a
                // single child which is scrollable
//                child: SingleChildScrollView(
//                  // for Vertical scrolling
//                  scrollDirection: Axis.vertical,
//                  child: Text(
//                      ".mclcmlsdmcldscmdls;msl;cmdsl;ls;mls;m,clds;cmdls;cmdls; l; csl;cmdls;mclds;msl;msl;mls;mcldsml dscdlscmdslmslmcdlsmllmsl;mls; dcmdslmledmelas;dmeal;dmeal;mdal;edma;lmc;almca;lsmcsla;dma;elmx;lasmclsamcsa;lmcxsal;mcsl;amxcasl;mclacdal;sdmcsal;mdcl;adml;asmcxls;amd;lamlscmsal;msal;m sal;cmsl;admwalmdx;ljlsmxl;mswdwl;adwdmw;almdwl;dlmml;dmwl;dswl;mdxw;lamdl;amdwl;mdwlmdwl;as sl;dmwal;mdl;wmdsl;wcnwq ;ldnsqw;ldlw;dw;lndlشَهْرُ رَمَضَانَ الَّذِي أُنزِلَ فِيهِ الْقُرْآنُ هُدًى لِّلنَّاسِ وَبَيِّنَاتٍ مِّنَ الْهُدَىٰ وَالْفُرْقَانِ",
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 28.0,
//                          color: Colors.white)),
//                ),
              ),
            ],
          ),
        ],
      ),
      drawer: NavDrawer(),
    );
  }
}
