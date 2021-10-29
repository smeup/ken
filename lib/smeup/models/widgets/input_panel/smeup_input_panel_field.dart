import 'package:flutter/cupertino.dart';
import 'package:xml/xml.dart';

enum SmeupInputPanelSupportedComp { Cmb, Rad, Itx, Bcd }

class SmeupInputPanelValue {
  String code;
  String descr;

  SmeupInputPanelValue({this.code = "", this.descr = ""});

  bool operator ==(o) => o is SmeupInputPanelValue && code == o.code;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + code.hashCode;
    return result;
  }

  @override
  String toString() {
    return "{$code,$descr}";
  }
}

class SmeupInputPanelField {
  SmeupInputPanelSupportedComp component;
  String id;
  String label;
  bool visible;
  int position;
  SmeupInputPanelValue value;
  List<SmeupInputPanelValue> items;
  String fun;

  SmeupInputPanelField({
    this.label = "",
    @required this.id,
    this.value,
    this.items,
    this.component = SmeupInputPanelSupportedComp.Itx,
    this.visible = true,
    this.position = 0,
  })  : assert(id != null),
        assert(value != null),
        assert(position >= 0);

  SmeupInputPanelField.fromMap(dynamic dataList) {
    // assert((dataList as List).length > 0);
    // (dataList as List).forEach((dataRow) {
    //   (dataRow["items"] as List).forEach((item) {
    //     value.add(SmeupInputPanelValue(item["code"], item["descr"]));
    //   });
    //   component = SmeupInputPanelSupportedComp.Itx;
    //   visible = dataRow["visible"] != null ? dataRow["visible"] : visible;
    // });
  }

  void update(XmlNode fieldFromLayout, int position) {
    this.visible = true;
    this.position = position;
    if (fieldFromLayout.getAttribute("Cmp") != null) {
      SmeupInputPanelSupportedComp.values.forEach((comp) {
        String name = comp.toString().split('.').last;
        if (name == fieldFromLayout.getAttribute("Cmp")) {
          component = comp;
        }
      });
    }

    fun = _getAttributeFromLayout(fieldFromLayout, "PfK", fun);
    // TODO Reload items

    value.descr = _getAttributeFromLayout(fieldFromLayout, "Txt", value.descr);
  }

  String _getAttributeFromLayout(
      XmlNode fieldFromLayout, String attrName, String defaultValue) {
    return fieldFromLayout.getAttribute(attrName) != null &&
            fieldFromLayout.getAttribute(attrName) != ""
        ? fieldFromLayout.getAttribute(attrName)
        : defaultValue;
  }
}
