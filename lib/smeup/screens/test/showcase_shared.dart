import 'package:ken/smeup/widgets/smeup_label.dart';

class ShowCaseShared {
  static getTestLabel(_scaffoldKey, _formKey, text) {
    return SmeupLabel(_scaffoldKey, _formKey, [text]);
  }
}
