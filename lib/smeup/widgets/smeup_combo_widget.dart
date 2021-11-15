import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_combo_item_model.dart';

class SmeupComboWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final String selectedValue;
  final List<SmeupComboItemModel> data;
  final double iconSize;
  final Color fontColor;
  final double fontSize;
  final void Function(String newValue) clientOnChange;

  const SmeupComboWidget(this.scaffoldKey, this.formKey,
      {this.selectedValue,
      this.data,
      this.fontColor,
      this.iconSize,
      this.fontSize,
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
    return DropdownButton<String>(
      //isExpanded: true,
      value: _selectedValue,
      icon: Icon(Icons.arrow_downward, color: widget.fontColor),
      iconSize: widget.iconSize,
      elevation: 20,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 3,
        color: widget.fontColor,
      ),
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
    var items =
        _data.map<DropdownMenuItem<String>>((SmeupComboItemModel element) {
      return DropdownMenuItem<String>(
        value: element.code,
        child: Text(
          element.value,
          style: TextStyle(fontSize: widget.fontSize, color: widget.fontColor),
        ),
      );
    }).toList();
    return items;
  }
}
