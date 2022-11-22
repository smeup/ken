import 'package:flutter/material.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';

abstract class KenWidgetStateInterface {
  Widget runBuild(BuildContext context, String id, String type,
      GlobalKey<ScaffoldState> scaffoldKey, bool initialDataLoad,
      {Function? notifierFunction});
  Future<KenWidgetBuilderResponse> getChildren();
  Future<KenWidgetBuilderResponse> getFunErrorResponse(
      BuildContext context, KenModel model);
  void runDispose(GlobalKey<ScaffoldState> scaffoldKey, String id);
}
