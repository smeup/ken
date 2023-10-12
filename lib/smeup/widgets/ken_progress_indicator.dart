import 'package:flutter/material.dart';
import '../models/widgets/ken_progress_indicator_model.dart';
import '../services/ken_utilities.dart';

// ignore: must_be_immutable
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
      this.color = KenProgressIndicatorModel.defaultColor,
      this.circularTrackColor =
          KenProgressIndicatorModel.defaultCircularTrackColor,
      this.size = KenProgressIndicatorModel.defaultSize,
      this.title = ''});

  @override
  Widget build(BuildContext context) {
    @override
    Widget children;

    return children = Center(
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
