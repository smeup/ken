import 'package:xml/xml.dart';

enum KenInputPanelSupportedComp { Cmb, Rad, Itx, Bcd, Acp }

class SmeupInputPanelValue {
  String? code;
  String? description;

  SmeupInputPanelValue({this.code = "", this.description = ""});

  bool operator ==(o) => o is SmeupInputPanelValue && code == o.code;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + code.hashCode;
    return result;
  }

  @override
  String toString() {
    return "{$code,$description}";
  }
}

class SmeupInputPanelField {
  static const String defaultCodeField = 'codice';
  static const String defaultDescriptionField = 'testo';

  KenInputPanelSupportedComp? component;
  String? id;
  String? label;
  bool? visible;
  late int position;
  late SmeupInputPanelValue value;
  List<SmeupInputPanelValue>? items;
  String? fun;
  String? codeField;
  String? descriptionField;
  String? object;
  bool isFirestore;
  String? validation;

  SmeupInputPanelField(
      {this.label = "",
      required String this.id,
      required this.value,
      this.items,
      this.component = KenInputPanelSupportedComp.Itx,
      this.fun,
      this.object,
      this.visible = true,
      this.position = 0,
      this.codeField,
      this.descriptionField,
      this.isFirestore = false,
      this.validation})
      : assert(position >= 0) {
    _setDefaults();
  }

  // SmeupInputPanelField.fromMap(dynamic dataList) {
  //   _setDefaults();
  // }

  _setDefaults() {
    if (this.codeField == null) {
      if (isFirestore)
        this.codeField = 'code';
      else
        this.codeField = defaultCodeField;
    }

    if (this.descriptionField == null) {
      if (isFirestore)
        this.descriptionField = 'description';
      else
        this.descriptionField = defaultDescriptionField;
    }
  }

  void update(XmlNode fieldFromLayout, int position) {
    this.visible = true;
    this.position = position;
    if (fieldFromLayout.getAttribute("Cmp") != null) {
      KenInputPanelSupportedComp.values.forEach((comp) {
        String name = comp.toString().split('.').last;
        if (name == fieldFromLayout.getAttribute("Cmp")) {
          component = comp;
        }
      });
    }

    fun = _getAttributeFromLayout(fieldFromLayout, "PfK", fun);
    // TODOA Reload items

    value.description =
        _getAttributeFromLayout(fieldFromLayout, "Txt", value.description);
  }

  String? _getAttributeFromLayout(
      XmlNode fieldFromLayout, String attrName, String? defaultValue) {
    return fieldFromLayout.getAttribute(attrName) != null &&
            fieldFromLayout.getAttribute(attrName) != ""
        ? fieldFromLayout.getAttribute(attrName)
        : defaultValue;
  }
}
