import 'package:flutter/material.dart';

import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';

class KenSliderWidget extends StatefulWidget {
  final Color? activeTrackColor;
  final Color? thumbColor;
  final Color? inactiveTrackColor;
  final String? label;
  final String id;
  final int? divisions;
  final double? value;
  final double? sldMin;
  final double? sldMax;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;
  const KenSliderWidget(
    this.scaffoldKey,
    this.formKey, {
    super.key,
    this.activeTrackColor,
    this.thumbColor,
    this.inactiveTrackColor,
    required this.id,
    this.divisions,
    this.label,
    required this.value,
    this.sldMax,
    this.sldMin,
  });

  @override
  KenSliderWidgetState createState() => KenSliderWidgetState();
}

class KenSliderWidgetState extends State<KenSliderWidget> {
  double? _value;
  String? _label;

  @override
  void initState() {
    _value = widget.value;
    _label = widget.label;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print('label = $_label , value=$_value');
    return SliderTheme(
      data: SliderThemeData(
        valueIndicatorColor: widget.activeTrackColor,
        valueIndicatorTextStyle: const TextStyle(
            // color: _value == 0.0 ? Colors.grey : Colors.orange,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
      child: Slider(
        key: ValueKey(widget.id),
        activeColor: widget.activeTrackColor,
        thumbColor: widget.thumbColor,
        inactiveColor: widget.inactiveTrackColor,
        label: _label,
        onChanged: (value) => setState(() {
          _value = value;
          _label = value.round().toString();
          KenMessageBus.instance.fireEvent(
            SliderOnChangeRealtimeEvent(
              widgetId: widget.id,
              value: value,
            ),
          );
        }),
        value: _value!,
        divisions: widget.divisions,
        onChangeEnd: (value) {
          KenMessageBus.instance.fireEvent(
            SliderOnChangedEvent(
              widgetId: widget.id,
              value: value,
            ),
          );
        },
        min: widget.sldMin!,
        max: widget.sldMax!,
      ),
    );
  }
}
