


# manageResponseMessage method








dynamic manageResponseMessage
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, dynamic response)








## Implementation

```dart
static manageResponseMessage(BuildContext context, dynamic response) async {
  try {
    if (response.data['messages'] != null) {
      List messages = response.data['messages'];
      if (messages.length > 0) {
        messages.forEach((message) {
          MessagesPromptMode mode =
              message['mode'] ?? MessagesPromptMode.snackbar;
          LogType severity = message['gravity'] ?? LogType.info;
          String text = message['message'];
          int milliseconds = message['milliseconds'] ?? 500;

          Color backColor;
          switch (severity) {
            case LogType.error:
              backColor = SmeupConfigurationService.getTheme().errorColor;
              break;
            case LogType.warning:
              backColor = Colors.orange;
              break;
            default:
              backColor = SmeupConfigurationService.getTheme()
                  .snackBarTheme
                  .backgroundColor;
          }

          if (text.isNotEmpty) {
            switch (mode) {
              case MessagesPromptMode.snackbar:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(text),
                      backgroundColor: backColor,
                      duration: Duration(milliseconds: milliseconds)),
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







