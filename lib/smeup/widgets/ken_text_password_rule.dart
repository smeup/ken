import 'package:flutter/material.dart';

class KenTextPasswordRule extends StatelessWidget {
  final Color color;
  final String? text;
  final IconData icon;
  final bool? showRulesIcon;
  final TextStyle captionStyle;
  final IconThemeData iconTheme;

  KenTextPasswordRule(this.text, this.color, this.icon, this.showRulesIcon,
      this.captionStyle, this.iconTheme);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showRulesIcon!)
          Icon(
            icon,
            color: iconTheme.color,
            size: iconTheme.size,
          ),
        SizedBox(
          width: 5,
        ),
        Text(
          text!,
          style: captionStyle.copyWith(color: color),
        )
      ],
    );
  }
}
