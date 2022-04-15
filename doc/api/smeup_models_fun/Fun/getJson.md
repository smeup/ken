


# getJson method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic getJson
()








## Implementation

```dart
getJson() {
  var fun = Map();
  fun['fun'] = Map();

  fun['fun']['component'] = identifier.component;
  fun['fun']['service'] = identifier.service;
  fun['fun']['function'] = identifier.function;

  for (var i = 1; i < 7; i++) {
    FunObject funObject = getObjectByName('obj$i');
    fun['fun']['obj$i'] = Map();
    fun['fun']['obj$i']['t'] = funObject.t;
    fun['fun']['obj$i']['p'] = funObject.p;
    fun['fun']['obj$i']['k'] = funObject.k;
  }

  if (parameters.length > 0) {
    String parmsStr = 'P(';
    for (var p = 0; p < parameters.length; p++) {
      final parm = parameters[p];
      final sep = p < parameters.length - 1 ? ' ' : '';
      parmsStr += '${parm["key"]}(${parm["value"]})$sep';
    }
    parmsStr += ')';
    fun['fun']['P'] = ' $parmsStr';
  } else {
    fun['fun']['P'] = '';
  }

  if (server.length > 0) {
    String serverStr = 'SERVER(';
    for (var p = 0; p < server.length; p++) {
      final parm = server[p];
      final sep = p < server.length - 1 ? ' ' : '';
      serverStr += '${parm["key"]}(${parm["value"]})$sep';
    }
    serverStr += ')';
    fun['fun']['SERVER'] = ' $serverStr';
  }

  fun['fun']['INPUT'] = input;
  fun['fun']['SG'] = {'cache': funSG.cache, 'forceCache': funSG.forceCache};
  fun['fun']['G'] = G;
  fun['fun']['NOTIFY'] = notify;

  return fun;
}
```







