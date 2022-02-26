import 'package:flutter/material.dart';
import 'package:flutterapp/navigation_drawer/NavDrawer.dart';



class videoPage extends StatelessWidget {
  static const String routeName = '/videoPage';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
        ),
        drawer: NavDrawer(),
        body: Center(child: Text("This is contacts page")));
  }
}