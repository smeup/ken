import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';

abstract class SmeupWidgetStateInterface {
  Widget runBuild(BuildContext context, String id, String type,
      GlobalKey<ScaffoldState> scaffoldKey, bool initialDataLoad,
      {Function? notifierFunction});
  Future<SmeupWidgetBuilderResponse> getChildren();
  Future<SmeupWidgetBuilderResponse> getFunErrorResponse(
      BuildContext context, SmeupModel model);
  void runDispose(GlobalKey<ScaffoldState> scaffoldKey, String id);
}
