import 'package:flutter/material.dart';
import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class KenSwitchWidget extends StatefulWidget {
  Color? thumbColor;
  Color? trackColor;

  final bool? data;
  final String? id;
  final Function? onClientChange;

  KenSwitchWidget(
      {this.data,
      this.id,
      this.onClientChange,
      this.thumbColor,
      this.trackColor});

  @override
  _KenSwitchWidgetState createState() => _KenSwitchWidgetState();
}

class _KenSwitchWidgetState extends State<KenSwitchWidget> {
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
          if (widget.onClientChange != null)
            widget.onClientChange!(changedValue);
        });
      },
    );
  }

  SwitchThemeData _getSwitchStile(bool data) {
    SwitchThemeData style = KenConfigurationService.getTheme()!
        .switchTheme
        .copyWith(
            thumbColor: MaterialStateProperty.all<Color?>(
                data ? widget.thumbColor : Color(0xFFf2f2f2)),
            trackColor: MaterialStateProperty.all<Color?>(
                data ? widget.trackColor : Color(0xFFcccccc)));
    return style;
  }
}
