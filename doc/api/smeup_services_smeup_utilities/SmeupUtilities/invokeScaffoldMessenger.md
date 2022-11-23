


# invokeScaffoldMessenger method




    *[<Null safety>](https://dart.dev/null-safety)*




void invokeScaffoldMessenger
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) text)








## Implementation

```dart
static void invokeScaffoldMessenger(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: Duration(milliseconds: 500)));
}
```







