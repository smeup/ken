import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';

abstract class SmeupWidgetStateInterface {
  Widget runBuild(BuildContext context, SmeupComponentModel model);
  Future<SmeupWidgetBuilderResponse> getChildren();
  Future<SmeupWidgetBuilderResponse> getFunErrorResponse(
      BuildContext context, SmeupModel model);
}
