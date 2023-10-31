import 'package:flutter/material.dart';
import '../services/ken_configuration_service.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';

class KenSwitchWidget extends StatefulWidget {
  final Color? thumbColor;
  final Color? trackColor;

  final bool? data;
  final String? id;

  const KenSwitchWidget(
      {super.key, this.data, this.id, this.thumbColor, this.trackColor});

  @override
  KenSwitchWidgetState createState() => KenSwitchWidgetState();
}

class KenSwitchWidgetState extends State<KenSwitchWidget> {
  bool? _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var style = _getSwitchStile(_data!);
    return Switch(
      thumbColor: style.thumbColor,
      trackColor: style.trackColor,
      value: _data!,
      onChanged: (changedValue) {
        setState(() {
          _data = changedValue;
          KenMessageBus.instance.fireEvent(SwitchOnChangeEvent(
            messageBusId: widget.id!,
            value: changedValue,
          ));
        });
      },
    );
  }

  SwitchThemeData _getSwitchStile(bool data) {
    SwitchThemeData style = KenConfigurationService.getTheme()!
        .switchTheme
        .copyWith(
            thumbColor: MaterialStateProperty.all<Color?>(
                data ? widget.thumbColor : const Color(0xFFf2f2f2)),
            trackColor: MaterialStateProperty.all<Color?>(
                data ? widget.trackColor : const Color(0xFFcccccc)));
    return style;
  }
}
