import 'package:flutter/material.dart';
import '../managers/ken_configuration_manager.dart';
import '../helpers/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';

class KenSwitchWidget extends StatefulWidget {
  final Color? thumbColor;
  final Color? trackColor;

  final bool? data;
  final String? id;

  final GlobalKey<ScaffoldState>? formKey;

  const KenSwitchWidget({
    super.key,
    this.data,
    this.id,
    this.thumbColor,
    this.trackColor,
    this.formKey,
  });

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
            messageBusId:
                KenUtilities.getMessageBusId(widget.id!, widget.formKey),
            value: changedValue,
          ));
        });
      },
    );
  }

  SwitchThemeData _getSwitchStile(bool data) {
    SwitchThemeData style = KenConfigurationManager.getTheme()!
        .switchTheme
        .copyWith(
            thumbColor: MaterialStateProperty.all<Color?>(
                data ? widget.thumbColor : const Color(0xFFf2f2f2)),
            trackColor: MaterialStateProperty.all<Color?>(
                data ? widget.trackColor : const Color(0xFFcccccc)));
    return style;
  }
}
