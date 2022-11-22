import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';

class KenWidgetBuilderResponse {
  KenModel? parentState;
  Widget? children;
  int? serviceStatusCode = 0;

  KenWidgetBuilderResponse(this.parentState, this.children,
      {this.serviceStatusCode});
}
