import 'package:flutter/material.dart';

class SmeupProgressIndicator extends StatelessWidget {
  final Color color;
  SmeupProgressIndicator(this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
