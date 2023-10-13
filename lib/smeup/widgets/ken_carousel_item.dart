import 'package:flutter/material.dart';

class KenCarouselItem extends StatelessWidget {
  final String? imageFileName;
  final String? text;
  final Color? fontColor; // Add fontColor parameter

  KenCarouselItem(this.imageFileName, this.text,
      {this.fontColor}); // Update the constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 250.0,
      height: 250.0,
      child: Column(
        children: [
          Image.asset(
            "$imageFileName",
            fit: BoxFit.scaleDown,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Text(
              text!,
              style: TextStyle(color: fontColor), // Use fontColor here
            ),
          ),
        ],
      ),
    );
  }
}
