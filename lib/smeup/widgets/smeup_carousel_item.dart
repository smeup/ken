import 'package:flutter/material.dart';

class SmeupCarouselItem extends StatelessWidget {
  final String? imageFileName;
  final String? text;
  SmeupCarouselItem(this.imageFileName, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
