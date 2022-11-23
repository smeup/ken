


# update method




    *[<Null safety>](https://dart.dev/null-safety)*




void update
([XmlNode](https://pub.dev/documentation/xml/5.3.1/xml/XmlNode-class.html) fieldFromLayout, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) position)








## Implementation

```dart
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
  // TODOA Reload items

  value.descr = _getAttributeFromLayout(fieldFromLayout, "Txt", value.descr);
}
```







