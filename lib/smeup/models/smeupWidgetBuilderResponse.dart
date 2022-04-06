import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';

class SmeupWidgetBuilderResponse {
  SmeupModel? parentState;
  Widget? children;
  int? serviceStatusCode = 0;

  SmeupWidgetBuilderResponse(this.parentState, this.children,
      {this.serviceStatusCode});
}
