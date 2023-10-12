import 'package:flutter/material.dart';

import '../services/ken_defaults.dart';

// ignore: must_be_immutable
class KenProgressBar extends StatelessWidget {
  Color? color;
  Color? linearTrackColor;
  String? title;
  String? id;
  String? type;
  String? valueField;
  double? progressBarMinimun;
  double? progressBarMaximun;
  double? height;
  EdgeInsetsGeometry? padding;
  double? borderRadius;

  double? data;

  KenProgressBar({
    this.color = KenProgressBarDefaults.defaultColor,
    this.linearTrackColor = KenProgressBarDefaults.defaultLinearTrackColor,
    this.id = '',
    this.type = 'FLD',
    this.valueField = KenProgressBarDefaults.defaultValueField,
    this.title = '',
    this.height = KenProgressBarDefaults.defaultHeight,
    this.data = 0,
    this.padding = KenProgressBarDefaults.defaultPadding,
    this.progressBarMinimun = KenProgressBarDefaults.defaultProgressBarMinimun,
    this.progressBarMaximun = KenProgressBarDefaults.defaultProgressBarMaximun,
    this.borderRadius = KenProgressBarDefaults.defaultBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(borderRadius!)),
          padding: padding,
          child: LinearProgressIndicator(
            color: color,
            backgroundColor: linearTrackColor,
            minHeight: height,
            key: ValueKey(id),
            value: progressBarMaximun == 0 ? 0 : data! / progressBarMaximun!,
          )),
    );
  }
}
