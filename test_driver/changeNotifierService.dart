import 'package:ken/smeup/models/notifiers/smeup_carousel_indicator_notifier.dart';
import 'package:ken/smeup/models/notifiers/smeup_error_notifier.dart';
import 'package:ken/smeup/models/notifiers/smeup_screen_notifier.dart';
import 'package:ken/smeup/models/notifiers/smeup_text_password_rule_notifier.dart';
import 'package:ken/smeup/models/notifiers/smeup_text_password_visibility_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ChangeNotifierService {
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider.value(
        value: SmeupScreenNotifier(),
      ),
      ChangeNotifierProvider.value(
        value: SmeupCarouselIndicatorNotifier(),
      ),
      ChangeNotifierProvider.value(
        value: SmeupErrorNotifier(),
      ),
      ChangeNotifierProvider.value(
          value: SmeupTextPasswordVisibilityNotifier(false)),
      ChangeNotifierProvider.value(
        value: SmeupTextPasswordRuleNotifier([
          {
            'regex': '(?=.*[0-9])',
            'code': 'numberRule',
            'description': 'Almeno 1 un numero',
            'isValid': false
          },
          {
            'regex': '(?=.{8,})',
            'code': 'charsRule',
            'description': 'Almeno 8 caratteri',
            'isValid': false
          },
          {
            'regex': '(?=.*[A-Z])',
            'code': 'upperCaseRule',
            'description': 'Almeno 1 lettera maiuscola',
            'isValid': false
          },
          {
            'regex': '(?=.*[a-z])',
            'code': 'lowerCaseRule',
            'description': 'Almeno 1 lettera minuscola',
            'isValid': false
          }
        ]),
      ),
    ];
  }
}
