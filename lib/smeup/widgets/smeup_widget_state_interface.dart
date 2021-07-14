import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';

abstract class SmeupWidgetStateInterface {
  Widget runBuild(BuildContext context, SmeupModel model,
      GlobalKey<ScaffoldState> scaffoldKey,
      {Function notifierFunction});
  Future<SmeupWidgetBuilderResponse> getChildren();
  Future<SmeupWidgetBuilderResponse> getFunErrorResponse(
      BuildContext context, SmeupModel model);
  void runDispose(GlobalKey<ScaffoldState> scaffoldKey, SmeupModel model);
}
