import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

class KenProgressIndicator extends StatelessWidget {
  final Color? color;
  final Color? circularTrackColor;
  final String? title;
  final String? id;
  final String? type;
  final double? size;

  const KenProgressIndicator(
      {super.key,
      this.id = '',
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
