import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

class KenSplash extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? color;
  String? id;
  String? type;
  String? title;

  KenSplash(this.scaffoldKey, this.formKey,
      {this.color = KenSplashDefaults.defaultColor,
      id = '',
      this.title = KenSplashDefaults.title,
      type = 'SPL'});

  @override
  State<KenSplash> createState() => KenSplashState();
}

class KenSplashState extends State<KenSplash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget splash;

    splash = Container(
      color: widget.color,
    );

    return splash;
  }
}
