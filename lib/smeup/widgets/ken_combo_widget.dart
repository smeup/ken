// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../models/widgets/ken_combo_item_model.dart';
import '../helpers/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';

class KenComboWidget extends StatefulWidget {
  final String? id;
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final Color? backColor;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;
  final Color? captionBackColor;
  final double? iconSize;
  final Color? iconColor;
  final Color? dropdownColor;
  final GlobalKey<ScaffoldState>? formKey;

  final String? selectedValue;
  final List<KenComboItemModel>? data;

  const KenComboWidget({
    super.key,
    this.id,
    this.fontColor,
    this.fontSize,
    this.fontBold,
    this.backColor,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.iconSize,
    this.iconColor,
    this.selectedValue,
    this.data,
    this.dropdownColor,
    this.formKey,
  });

  @override
  KenComboWidgetState createState() => KenComboWidgetState();
}

class KenComboWidgetState extends State<KenComboWidget> {
  String? _selectedValue;
  List<KenComboItemModel>? _data;

  @override
  void initState() {
    _data = widget.data;
    _selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IconThemeData iconTheme = _getIconTheme();
    DividerThemeData dividerStyle = _getDividerStyle();

    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: false,
        child: DropdownButton(
          value: _selectedValue,
          dropdownColor: widget.dropdownColor,
          style: _getTextStile(),
          icon: Icon(
            Icons.keyboard_arrow_down_sharp,
            color: iconTheme.color,
            size: iconTheme.size,
          ),

          //elevation: 20,
          underline: Container(
            height: dividerStyle.thickness,
            color: dividerStyle.color,
          ),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue;
              KenMessageBus.instance.fireEvent(
                ComboOnChangeEvent(
                    messageBusId: KenUtilities.getMessageBusId(
                        widget.id!, widget.formKey),
                    value: newValue),
              );
            });
          },
          items: _getItems(_data!),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getItems(List<KenComboItemModel> data) {
    final textStyle = _getTextStile();
    var items = data.map<DropdownMenuItem<String>>((KenComboItemModel element) {
      return DropdownMenuItem<String>(
        value: element.code,
        child: Text(
          element.value ?? '',
          style: textStyle,
        ),
      );
    }).toList();
    return items;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = IconThemeData(color: widget.iconColor);

    return themeData;
  }

  TextStyle _getTextStile() {
    TextStyle style = TextStyle(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: Colors.transparent);

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }

  DividerThemeData _getDividerStyle() {
    DividerThemeData dividerData = DividerThemeData(color: widget.fontColor);

    return dividerData;
  }
}
