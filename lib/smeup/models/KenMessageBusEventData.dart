import 'package:flutter/cupertino.dart';

import 'widgets/ken_model.dart';

class KenMessageBusEventData {
  BuildContext? context;
  Widget? widget;
  KenModel? model;
  dynamic data;
  List<dynamic>? parameters;

  KenMessageBusEventData({
    this.context,
    this.widget,
    this.model,
    this.parameters,
    required this.data,
  });
}
