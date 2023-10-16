import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_slider_widget.dart';

class KenSlider extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;

  final Color? activeTrackColor;
  final Color? thumbColor;
  final Color? inactiveTrackColor;
  final EdgeInsetsGeometry? padding;
  final double? value;
  final double? sldMin;
  final double? sldMax;
  final String? id;
  final int? divisions;
  final String? type;
  final String? title;
  final String? label;

  const KenSlider(
    this.scaffoldKey,
    this.formKey, {
    super.key,
    this.activeTrackColor = KenSliderDefaults.defaultActiveTrackColor,
    this.thumbColor = KenSliderDefaults.defaultThumbColor,
    this.inactiveTrackColor = KenSliderDefaults.defaultInactiveTrackColor,
    this.padding = KenSliderDefaults.defaultPadding,
    this.title,
    this.id = '',
    this.label,
    this.divisions = 10,
    this.type = 'SLD',
    this.value = 0,
    this.sldMax = KenSliderDefaults.defaultSldMax,
    this.sldMin = KenSliderDefaults.defaultSldMin,
  });

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
    KenMessageBus.instance
        .event<SliderOnChangedEvent>(widget.id!)
        .takeWhile((element) => context.mounted)
        .listen((event) {
      value = event.value;
    });
    final children = Center(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: KenSliderWidget(
          widget.scaffoldKey,
          widget.formKey,
          id: widget.id!,
          activeTrackColor: widget.activeTrackColor,
          thumbColor: widget.thumbColor,
          inactiveTrackColor: widget.inactiveTrackColor,
          sldMax: widget.sldMax,
          sldMin: widget.sldMin,
          value: widget.value,
          divisions: widget.divisions,
          label: widget.label,
        ),
      ),
    );

    return children;
  }
}
