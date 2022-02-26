import 'package:flutter/material.dart';

class SurahScreen extends StatelessWidget {
  int currentPage = 0;

  SurahScreen(index) {
    currentPage = index;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: new Image.asset(
          "lib/images/$currentPage.png",
          width: size.width,
          height: size.height - AppBar().preferredSize.height,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}