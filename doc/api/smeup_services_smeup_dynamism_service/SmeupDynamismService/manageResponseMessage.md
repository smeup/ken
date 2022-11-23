


# manageResponseMessage method








dynamic manageResponseMessage
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, dynamic response, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey)








## Implementation

```dart
static manageResponseMessage(BuildContext context, dynamic response,
    GlobalKey<ScaffoldState> scaffoldKey) async {
  try {
    if (response.data['messages'] != null) {
      List messages = response.data['messages'];
      if (messages.length > 0) {
        messages.forEach((message) {
          MessagesPromptMode mode =
              message['mode'] ?? MessagesPromptMode.snackbar;
          LogType severity = message['gravity'] ?? LogType.info;
          String text = message['message'];

          Color backColor;
          switch (severity) {
            case LogType.error:
              backColor = SmeupConfigurationService.getTheme().errorColor;
              break;
            case LogType.warning:
              backColor = Colors.orange;
              break;
            default:
              backColor = Colors.green;
          }

          if (text.isNotEmpty) {
            switch (mode) {
              case MessagesPromptMode.snackbar:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(text,
                        style: TextStyle(
                            color: SmeupConfigurationService.getTheme()
                                .textTheme
                                .bodyText2
                                .color)),
                    backgroundColor: backColor,
                  ),
                );

                break;
              default:
            }
          }
        });
        await new Future.delayed(const Duration(seconds: 1));
      }
    }
  } catch (e) {}
}
```







