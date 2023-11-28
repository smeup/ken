import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notifiers/ken_text_password_rule_notifier.dart';
import '../services/ken_defaults.dart';
import 'ken_text_password_rule.dart';

class KenTextPasswordIndicators extends StatefulWidget {
  final bool? showRulesIcon;
  final TextStyle captionStyle;
  final IconThemeData iconTheme;

  const KenTextPasswordIndicators(
      this.showRulesIcon, this.captionStyle, this.iconTheme,
      {super.key});

  @override
  KenTextPasswordIndicatorsState createState() =>
      KenTextPasswordIndicatorsState();
}

class KenTextPasswordIndicatorsState extends State<KenTextPasswordIndicators> {
  @override
  Widget build(BuildContext context) {
    return Column(children: getColumns());
  }

  List<Widget> getColumns() {
    var list = List<Widget>.empty(growable: true);

    final passwordModel =
        Provider.of<KenTextPasswordRuleNotifier>(context, listen: true);

    if (passwordModel.rules.isNotEmpty) {
      list.add(Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: LinearProgressIndicator(
          minHeight: 10,
          value: passwordModel.satisfiedRules / passwordModel.totalRules,
          backgroundColor: kSecondary200,
          valueColor:
              AlwaysStoppedAnimation<Color>(_getIndicatorColor(passwordModel)),
        ),
      ));

      int ind = 0;
      for (var rule in passwordModel.rules) {
        ind++;
        final ruleWidget = KenTextPasswordRule(
          rule['description'],
          _getRuleColor(rule['isValid'] ?? false),
          _getRuleIcon(rule['isValid'] ?? false),
          widget.showRulesIcon,
          widget.captionStyle,
          widget.iconTheme,
          key: Key(
              '${(widget.key as ValueKey).value}_password_indicators_rule_$ind'),
        );
        list.add(ruleWidget);
      }
    }

    return list;
  }

  Color _getRuleColor(bool value) {
    return value ? Colors.green : kSecondary200;
  }

  Color _getIndicatorColor(KenTextPasswordRuleNotifier passwordModel) {
    double perc = passwordModel.satisfiedRules / passwordModel.totalRules * 100;
    if (perc <= 50.0) {
      return kRed;
    } else if (perc <= 75.0) {
      return kOrange;
    } else if (perc <= 99.0) {
      return kYellow;
    } else {
      return kGreen;
    }
  }

  IconData _getRuleIcon(bool value) {
    return value ? Icons.check : Icons.error;
  }
}
