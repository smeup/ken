import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_model.dart';

class SmeupWidgetBuilderResponse {
  SmeupModel parentState;
  Widget children;
  int serviceStatusCode = 0;

  SmeupWidgetBuilderResponse(this.parentState, this.children,
      {this.serviceStatusCode});
}
