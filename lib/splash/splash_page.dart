import 'package:flutter/material.dart';
import '../style/theme.dart' as Style;

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: screen.height,
        width: screen.width,
        decoration: BoxDecoration(gradient: Style.Colors.bannerGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          SizedBox(
              width: 250.0,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset("assets/images/boxlogo.jpg"))),
          SizedBox()
        ]),
      ),
    );
  }
}
