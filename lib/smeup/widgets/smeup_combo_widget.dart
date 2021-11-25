import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_combo_item_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';

class SmeupComboWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  final double fontSize;
  final Color fontColor;
  final bool fontBold;
  final bool captionFontBold;
  final double captionFontSize;
  final Color captionFontColor;
  final double iconSize;
  final Color iconColor;

  final String selectedValue;
  final List<SmeupComboItemModel> data;
  final void Function(String newValue) clientOnChange;

  const SmeupComboWidget(this.scaffoldKey, this.formKey,
      {this.fontColor,
      this.fontSize,
      this.fontBold,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.iconSize,
      this.iconColor,
      this.selectedValue,
      this.data,
      this.clientOnChange});

  @override
  _SmeupComboWidgetState createState() => _SmeupComboWidgetState();
}

class _SmeupComboWidgetState extends State<SmeupComboWidget> {
  String _selectedValue;
  List<SmeupComboItemModel> _data;

  @override
  void initState() {
    _data = widget.data;
    _selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IconThemeData iconTheme = _getIconTheme();

    return DropdownButton<String>(
      //isExpanded: true,
      value: _selectedValue,
      icon: Icon(
        Icons.arrow_downward,
        color: iconTheme.color,
        size: iconTheme.size,
      ),
      elevation: 20,
      //style: const TextStyle(color: Colors.deepPurple),
      // underline: Container(
      //   height: 3,
      //   color: widget.fontColor,
      // ),
      onChanged: (String newValue) {
        setState(() {
          _selectedValue = newValue;
          if (widget.clientOnChange != null) {
            widget.clientOnChange(newValue);
          }
        });
      },
      items: _getItems(_data),
    );
  }

  List<DropdownMenuItem<String>> _getItems(List<SmeupComboItemModel> _data) {
    final textStyle = _getTextStile();
    var items =
        _data.map<DropdownMenuItem<String>>((SmeupComboItemModel element) {
      return DropdownMenuItem<String>(
        value: element.code,
        child: Text(
          element.value,
          style: textStyle,
        ),
      );
    }).toList();
    return items;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = SmeupConfigurationService.getTheme()
        .iconTheme
        .copyWith(size: widget.iconSize, color: widget.iconColor);

    return themeData;
  }

  TextStyle _getTextStile() {
    TextStyle style =
        SmeupConfigurationService.getTheme().textTheme.copyWith().bodyText1;

    style = style.copyWith(
      color: widget.fontColor,
      fontSize: widget.fontSize,
    );

    if (widget.fontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}
