import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notifiers/ken_text_password_rule_notifier.dart';
import '../models/widgets/ken_model.dart';
import 'kenTextPasswordRule.dart';

class KenTextPasswordIndicators extends StatefulWidget {
  final bool? showRulesIcon;
  final TextStyle captionStyle;
  final IconThemeData iconTheme;

  KenTextPasswordIndicators(
      this.showRulesIcon, this.captionStyle, this.iconTheme);

  @override
  _KenTextPasswordIndicatorsState createState() =>
      _KenTextPasswordIndicatorsState();
}

class _KenTextPasswordIndicatorsState extends State<KenTextPasswordIndicators> {
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
          backgroundColor: KenModel.kSecondary200,
          valueColor:
              AlwaysStoppedAnimation<Color>(_getIndicatorColor(passwordModel)),
        ),
      ));

      for (var rule in passwordModel.rules) {
        final ruleWidget = KenTextPasswordRule(
            rule['description'],
            _getRuleColor(rule['isValid'] ?? false),
            _getRuleIcon(rule['isValid'] ?? false),
            widget.showRulesIcon,
            widget.captionStyle,
            widget.iconTheme);
        list.add(ruleWidget);
      }
    }

    return list;
  }

  Color _getRuleColor(bool value) {
    return value ? Colors.green : KenModel.kSecondary200;
  }

  Color _getIndicatorColor(KenTextPasswordRuleNotifier passwordModel) {
    double perc = passwordModel.satisfiedRules / passwordModel.totalRules * 100;
    if (perc <= 50.0) {
      return KenModel.kRed;
    } else if (perc <= 75.0) {
      return KenModel.kOrange;
    } else if (perc <= 99.0) {
      return KenModel.kYellow;
    } else {
      return KenModel.kGreen;
    }
  }

  IconData _getRuleIcon(bool value) {
    return value ? Icons.check : Icons.error;
  }
}
