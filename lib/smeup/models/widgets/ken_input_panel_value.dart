import 'package:xml/xml.dart';

enum ShiroInputPanelSupportedComp { cmb, rad, itx, bcd, acp }

class SmeupInputPanelValue {
  String? code;
  String? description;

  SmeupInputPanelValue({this.code = "", this.description = ""});

  @override
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

  ShiroInputPanelSupportedComp? component;
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
      this.component = ShiroInputPanelSupportedComp.itx,
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
    if (codeField == null) {
      if (isFirestore) {
        codeField = 'code';
      } else {
        codeField = defaultCodeField;
      }
    }

    if (descriptionField == null) {
      if (isFirestore) {
        descriptionField = 'description';
      } else {
        descriptionField = defaultDescriptionField;
      }
    }
  }

  void update(XmlNode fieldFromLayout, int position) {
    visible = true;
    this.position = position;
    if (fieldFromLayout.getAttribute("Cmp") != null) {
      for (var comp in ShiroInputPanelSupportedComp.values) {
        String name = comp.toString().split('.').last;
        if (name == fieldFromLayout.getAttribute("Cmp")) {
          component = comp;
        }
      }
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
