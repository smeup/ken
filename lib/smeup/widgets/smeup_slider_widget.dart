import 'package:flutter/material.dart';

class SmeupSliderWidget extends StatefulWidget {
  final Color? activeTrackColor;
  final Color? thumbColor;
  final Color? inactiveTrackColor;
  final String? id;
  final double? value;
  final double? sldMin;
  final double? sldMax;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;
  final Function? clientOnChange;
  const SmeupSliderWidget(this.scaffoldKey, this.formKey,
      {this.activeTrackColor,
      this.thumbColor,
      this.inactiveTrackColor,
      this.id,
      this.value,
      this.sldMax,
      this.sldMin,
      this.clientOnChange});

  @override
  _SmeupSliderWidgetState createState() => _SmeupSliderWidgetState();
}

class _SmeupSliderWidgetState extends State<SmeupSliderWidget> {
  double? _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      key: ValueKey(widget.id),
      activeColor: widget.activeTrackColor,
      thumbColor: widget.thumbColor,
      inactiveColor: widget.inactiveTrackColor,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
      value: _value!,
      onChangeEnd: widget.clientOnChange as void Function(double)?,
      min: widget.sldMin!,
      max: widget.sldMax!,
    );
  }
}
