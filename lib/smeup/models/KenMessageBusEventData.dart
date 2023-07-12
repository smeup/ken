import 'package:flutter/cupertino.dart';

import 'widgets/ken_model.dart';

class KenMessageBusEventData {
  BuildContext? context;
  Widget? widget;
  KenModel? model;
  dynamic data;

  KenMessageBusEventData({
    this.context,
    this.widget,
    this.model,
    required this.data,
  });
}
