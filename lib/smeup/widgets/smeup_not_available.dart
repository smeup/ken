import 'package:flutter/material.dart';

class SmeupNotAvailable extends StatelessWidget {
  final double height;
  final double width;

  SmeupNotAvailable({this.height = 50, this.width = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Center(
        child: Image.asset(
          "assets/images/not_available.png",
          height: height,
          width: width,
        ),
      ),
    );
  }
}
