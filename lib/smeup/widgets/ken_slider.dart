import 'package:flutter/material.dart';
import '../models/widgets/ken_slider_model.dart';
import 'ken_slider_widget.dart';

// ignore: must_be_immutable
class KenSlider extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;
  KenSliderModel? model;

  Color? activeTrackColor;
  Color? thumbColor;
  Color? inactiveTrackColor;
  EdgeInsetsGeometry? padding;
  double? value;
  double? sldMin;
  double? sldMax;
  String? id;
  int? divisions;
  String? type;
  String? title;
  String? label;
  Function? clientOnChange;
  Function? onChanged;
  Function? onGetChildren;
  Function? onClientChange;

  KenSlider(this.scaffoldKey, this.formKey,
      {this.activeTrackColor = KenSliderModel.defaultActiveTrackColor,
      this.thumbColor = KenSliderModel.defaultThumbColor,
      this.inactiveTrackColor = KenSliderModel.defaultInactiveTrackColor,
      this.padding = KenSliderModel.defaultPadding,
      this.title,
      this.id = '',
      this.label,
      this.divisions = 10,
      this.type = 'SLD',
      this.value = 0,
      this.sldMax = KenSliderModel.defaultSldMax,
      this.sldMin = KenSliderModel.defaultSldMin,
      this.clientOnChange,
      this.onChanged,
      this.onGetChildren,
      this.onClientChange});

  @override
  KenSliderState createState() => KenSliderState();
}

class KenSliderState extends State<KenSlider> {
  dynamic value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onGetChildren != null) {
      widget.onGetChildren!();
    }

    final children = Center(
      child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: KenSliderWidget(
            widget.scaffoldKey,
            widget.formKey,
            id: widget.id,
            activeTrackColor: widget.activeTrackColor,
            thumbColor: widget.thumbColor,
            inactiveTrackColor: widget.inactiveTrackColor,
            sldMax: widget.sldMax,
            sldMin: widget.sldMin,
            value: widget.value,
            divisions: widget.divisions,
            label: widget.label,
            onChanged: widget.onChanged ?? () {},
            clientOnChange: (value) {
              value = value;
              if (widget.onClientChange != null) {
                widget.onClientChange!(value);
              }
            },
          )),
    );

    return children;
  }
}
