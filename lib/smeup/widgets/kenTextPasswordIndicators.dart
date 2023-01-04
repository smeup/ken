import 'package:flutter/material.dart';
import 'package:ken/smeup/widgets/kenTextPasswordRule.dart';
import 'package:ken/smeup/models/notifiers/ken_text_password_rule_notifier.dart';
import 'package:provider/provider.dart';

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

    if (passwordModel.rules.length > 0) {
      list.add(Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: LinearProgressIndicator(
          minHeight: 10,
          value: passwordModel.satisfiedRules / passwordModel.totalRules,
          backgroundColor: Color.fromRGBO(128, 128, 128, 0.5),
          valueColor:
              AlwaysStoppedAnimation<Color>(_getIndicatorColor(passwordModel)),
        ),
      ));

      passwordModel.rules.forEach((rule) {
        final ruleWidget = KenTextPasswordRule(
            rule['description'],
            _getRuleColor(rule['isValid'] ?? false),
            _getRuleIcon(rule['isValid'] ?? false),
            widget.showRulesIcon,
            widget.captionStyle,
            widget.iconTheme);
        list.add(ruleWidget);
      });
    }

    return list;
  }

  Color _getRuleColor(bool value) {
    return value ? Colors.green : Colors.red;
  }

  Color _getIndicatorColor(KenTextPasswordRuleNotifier passwordModel) {
    double perc = passwordModel.satisfiedRules / passwordModel.totalRules * 100;
    if (perc <= 50.0) {
      return Colors.red;
    } else if (perc <= 75.0) {
      return Colors.orange;
    } else if (perc <= 99.0) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  IconData _getRuleIcon(bool value) {
    return value ? Icons.check : Icons.error;
  }
}
