import 'package:flutter/material.dart';

class SmeupTextPasswordRule extends StatelessWidget {
  final Color color;
  final String text;
  final IconData icon;
  final bool showRulesIcon;
  SmeupTextPasswordRule(this.text, this.color, this.icon, this.showRulesIcon);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        if (showRulesIcon) Icon(icon),
        Text(
          text,
          style: TextStyle(color: color),
        )
      ],
    ));
  }
}
