import 'package:flutter/material.dart';

import '../services/ken_defaults.dart';
import '../services/ken_widget_orientation.dart';
import 'ken_button.dart';

class KenButtons extends StatelessWidget {
  final WidgetOrientation? orientation;
  final List<KenButton> children;

  const KenButtons({
    super.key,
    this.orientation = KenButtonsDefaults.defaultOrientation,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    Widget widgets;

    if (children.isNotEmpty) {
      if (orientation == WidgetOrientation.vertical) {
        widgets = SingleChildScrollView(
            scrollDirection: Axis.vertical, child: Column(children: children));
      } else {
        widgets = SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Row(children: children));
      }
    } else {
      widgets = Column(children: [Container()]);
    }
    return widgets;
  }
}
