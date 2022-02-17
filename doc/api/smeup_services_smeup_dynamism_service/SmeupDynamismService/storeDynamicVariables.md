


# storeDynamicVariables method








void storeDynamicVariables
(dynamic data, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)








## Implementation

```dart
static void storeDynamicVariables(
    dynamic data, GlobalKey<FormState> formKey) {
  if (data != null && data is Map) {
    for (var i = 0; i < data.entries.length; i++) {
      final element = data.entries.elementAt(i);
      if (element.value != null) {
        String key = element.key;
        if (formKey != null)
          key = key.replaceAll('${formKey.hashCode.toString()}_', '');
        if (key == 'tipo' || key == 't') key = 'T1';
        if (key == 'parametro' || key == 'p') key = 'P1';
        if (key == 'codice' || key == 'k') key = 'K1';
        if (key == 'testo' || key == 'value') key = 'Tx';
        if (key == 'nome') key = 'Nm';

        String value = '';
        if (element.value is Map && element.value['smeupObject'] != null) {
          value = SmeupUtilities.extractValueFromName(element.value);
        } else {
          value = element.value.toString();
        }
        SmeupVariablesService.setVariable(key, value, formKey: formKey);
      }
    }
  }
}
```







