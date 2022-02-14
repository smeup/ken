import 'package:ken/smeup/widgets/smeup_label.dart';

class ShowCaseShared {
  static getTestLabel(_scaffoldKey, _formKey, text, {height: 15}) {
    return SmeupLabel(_scaffoldKey, _formKey, [text]);
  }
}
