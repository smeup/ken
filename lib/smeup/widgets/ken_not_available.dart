import 'package:flutter/material.dart';

class KenNotAvailable extends StatelessWidget {
  final double height;
  final double width;

  const KenNotAvailable({super.key, this.height = 50, this.width = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Image.asset(
          "packages/ken/assets/images/not_available.png",
          height: height,
          width: width,
        ),
      ),
    );
  }
}
