


# replaceVariables method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic replaceVariables
()








## Implementation

```dart
replaceVariables() {
  String funString = this.getSmeupFormatString();
  funString = SmeupDynamismService.replaceVariables(funString, formKey);
  Fun newFun = Fun(funString, this.formKey, this.scaffoldKey, this.context);
  parameters = newFun.parameters;
  server = newFun.server;
  identifier = newFun.identifier;
  objects = newFun.objects;
  input = newFun.input;
  funSG = newFun.funSG;
  G = newFun.G;
  notify = newFun.notify;
}
```







