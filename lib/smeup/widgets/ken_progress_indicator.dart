import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

class KenProgressIndicator extends StatelessWidget {
  Color? color;
  Color? circularTrackColor;
  String? title;
  String? id;
  String? type;
  double? size;

  KenProgressIndicator(
      {this.id = '',
      this.type = 'FLD',
      this.color = KenProgressIndicatorDefaults.defaultColor,
      this.circularTrackColor =
          KenProgressIndicatorDefaults.defaultCircularTrackColor,
      this.size = KenProgressIndicatorDefaults.defaultSize,
      this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color,
          backgroundColor: circularTrackColor,
        ),
      ),
    );
  }
}
