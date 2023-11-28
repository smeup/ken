import 'package:flutter/material.dart';

import '../services/ken_defaults.dart';

class KenProgressBar extends StatelessWidget {
  final Color? color;
  final Color? linearTrackColor;
  final String? title;
  final String? id;
  final String? type;
  final String? valueField;
  final double? progressBarMinimun;
  final double? progressBarMaximun;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  final double? data;

  const KenProgressBar({
    super.key,
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
