import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_password_rule_model.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_text_password_rule.dart';

import 'package:provider/provider.dart';

class SmeupTextPasswordIndicators extends StatefulWidget {
  final bool showRulesIcon;

  SmeupTextPasswordIndicators(this.showRulesIcon);

  @override
  _SmeupTextPasswordIndicatorsState createState() =>
      _SmeupTextPasswordIndicatorsState();
}

class _SmeupTextPasswordIndicatorsState
    extends State<SmeupTextPasswordIndicators> {
  @override
  Widget build(BuildContext context) {
    final passwordModel =
        Provider.of<SmeupTextPasswordRuleModel>(context, listen: true);

    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
        child: LinearProgressIndicator(
          minHeight: 10,
          value: passwordModel.satisfiedRules / passwordModel.totalRules,
          backgroundColor: Color.fromRGBO(128, 128, 128, 0.5),
          valueColor:
              AlwaysStoppedAnimation<Color>(_getIndicatorColor(passwordModel)),
        ),
      ),
      //Divider(),
      SmeupTextPasswordRule(
          'Almeno 8 caratteri',
          _getRuleColor(passwordModel.isCharsRule ?? false),
          _getRuleIcon(passwordModel.isCharsRule ?? false),
          widget.showRulesIcon),
      // UpickPasswordRule(
      //     'Almeno 1 lettera minuscola',
      //     _getRuleColor(passwordModel.isLowerCaseRule),
      //     _getRuleIcon(passwordModel.isLowerCaseRule),
      //     widget.showRulesIcon),
      // UpickPasswordRule(
      //     'Almeno 1 lettera maiuscola',
      //     _getRuleColor(passwordModel.isUpperCaseRule),
      //     _getRuleIcon(passwordModel.isUpperCaseRule),
      //     widget.showRulesIcon),
      SmeupTextPasswordRule(
          'Almeno 1 un numero',
          _getRuleColor(passwordModel.isNumberRule ?? false),
          _getRuleIcon(passwordModel.isNumberRule ?? false),
          widget.showRulesIcon),
    ]);
  }

  Color _getRuleColor(bool value) {
    return value == null
        ? Colors.grey
        : value
            ? Colors.green
            : Colors.red;
  }

  Color _getIndicatorColor(SmeupTextPasswordRuleModel passwordModel) {
    switch (passwordModel.satisfiedRules) {
      case 0:
      case 1:
        return Colors.red;
      case 2:
        //   return Colors.orange;
        // case 3:
        //   return Colors.yellow;
        // case 4:
        return Colors.green;
      default:
        return Colors.green;
    }
  }

  IconData _getRuleIcon(bool value) {
    return value == null
        ? Icons.edit
        : value
            ? Icons.check
            : Icons.error;
  }
}
