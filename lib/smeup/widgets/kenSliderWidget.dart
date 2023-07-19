import 'package:flutter/material.dart';

class KenSliderWidget extends StatefulWidget {
  final Color? activeTrackColor;
  final Color? thumbColor;
  final Color? inactiveTrackColor;
  final String? label;
  final String? id;
  final int? divisions;
  final double? value;
  final double? sldMin;
  final double? sldMax;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;
  final Function? clientOnChange;
  final Function? onChange;
  final Function onChanged;
  const KenSliderWidget(this.scaffoldKey, this.formKey,
      {super.key,
      this.activeTrackColor,
      this.thumbColor,
      this.inactiveTrackColor,
      this.id,
      this.divisions,
      this.label,
      required this.value,
      this.sldMax,
      this.sldMin,
      this.onChange,
      this.clientOnChange,
      required this.onChanged});

  @override
  _KenSliderWidgetState createState() => _KenSliderWidgetState();
}

class _KenSliderWidgetState extends State<KenSliderWidget> {
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
    print('label = $_label , value=$_value');
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
          // widget.onChanged(_value);
        }),
        value: _value!,
        divisions: widget.divisions,
        onChangeEnd: widget.clientOnChange as void Function(double)?,
        min: widget.sldMin!,
        max: widget.sldMax!,
      ),
    );
  }
}
