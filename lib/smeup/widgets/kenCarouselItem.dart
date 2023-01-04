import 'package:flutter/material.dart';

class KenCarouselItem extends StatelessWidget {
  final String? imageFileName;
  final String? text;
  KenCarouselItem(this.imageFileName, this.text);
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
          Expanded(child: Text(text!))
        ],
      ),
    );
  }
}
