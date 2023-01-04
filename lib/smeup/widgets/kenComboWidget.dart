import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_combo_item_model.dart';
import '../services/ken_configuration_service.dart';

class KenComboWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;

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

  final String? selectedValue;
  final List<KenComboItemModel>? data;
  final void Function(String? newValue)? clientOnChange;

  const KenComboWidget(this.scaffoldKey, this.formKey,
      {this.fontColor,
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
      this.clientOnChange});

  @override
  _KenComboWidgetState createState() => _KenComboWidgetState();
}

class _KenComboWidgetState extends State<KenComboWidget> {
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
          dropdownColor: widget.backColor,
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
              if (widget.clientOnChange != null) {
                widget.clientOnChange!(newValue);
              }
            });
          },
          items: _getItems(_data!),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getItems(List<KenComboItemModel> _data) {
    final textStyle = _getTextStile();
    var items =
        _data.map<DropdownMenuItem<String>>((KenComboItemModel element) {
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
    IconThemeData themeData = KenConfigurationService.getTheme()!
        .iconTheme
        .copyWith(size: widget.iconSize, color: widget.iconColor);

    return themeData;
  }

  TextStyle _getTextStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.bodyText1!;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: Colors.transparent);

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  DividerThemeData _getDividerStyle() {
    DividerThemeData dividerData = KenConfigurationService.getTheme()!
        .dividerTheme
        .copyWith(color: widget.fontColor);

    return dividerData;
  }
}
