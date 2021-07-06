import 'package:flutter/material.dart';

class SmeupSwitch extends StatefulWidget {
  final bool parValue;
  final String parLabelText;
  final Function parOnChange;
  SmeupSwitch(this.parValue, this.parLabelText, this.parOnChange);

  @override
  _SmeupSwitchState createState() => _SmeupSwitchState();
}

class _SmeupSwitchState extends State<SmeupSwitch> {
  bool _value;

  @override
  void initState() {
    _value = widget.parValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.parLabelText,
            style: const TextStyle(fontSize: 18),
          ),
          Switch(
            value: _value,
            onChanged: (changedValue) {
              setState(() {
                _value = changedValue;
              });
              if (widget.parOnChange != null) widget.parOnChange(changedValue);
            },
          ),
        ],
      ),
    );
  }
}
