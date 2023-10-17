import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

class KenSplash extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;

  final Color? color;
  final String? id;
  final String? type;
  final String? title;

  const KenSplash(this.scaffoldKey, this.formKey,
      {super.key,
      this.color = KenSplashDefaults.defaultColor,
      this.id = '',
      this.title = KenSplashDefaults.title,
      this.type = 'SPL'});

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
