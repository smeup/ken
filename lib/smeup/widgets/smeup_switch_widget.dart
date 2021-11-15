import 'package:flutter/material.dart';

class SmeupSwitchWidget extends StatefulWidget {
  final bool data;
  final String id;
  final Function onClientChange;

  const SmeupSwitchWidget({this.data, this.id, this.onClientChange});

  @override
  _SmeupSwitchWidgetState createState() => _SmeupSwitchWidgetState();
}

class _SmeupSwitchWidgetState extends State<SmeupSwitchWidget> {
  bool _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _data,
      onChanged: (changedValue) {
        setState(() {
          _data = changedValue;
          if (widget.onClientChange != null)
            widget.onClientChange(changedValue);
        });
      },
    );
  }
}
