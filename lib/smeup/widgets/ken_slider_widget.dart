import 'package:flutter/material.dart';

class KenSliderWidget extends StatefulWidget {
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
  const KenSliderWidget(this.scaffoldKey, this.formKey,
      {this.activeTrackColor,
      this.thumbColor,
      this.inactiveTrackColor,
      this.id,
      this.value,
      this.sldMax,
      this.sldMin,
      this.clientOnChange});

  @override
  _KenSliderWidgetState createState() => _KenSliderWidgetState();
}

class _KenSliderWidgetState extends State<KenSliderWidget> {
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
