import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_line_model.dart';

class SmeupLine extends StatelessWidget {
  final SmeupLineModel smeupLineModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupLine(
    this.smeupLineModel,
    this.scaffoldKey,
    this.formKey,
  );

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: smeupLineModel.color,
      thickness: smeupLineModel.thickness,
    );
  }
}
