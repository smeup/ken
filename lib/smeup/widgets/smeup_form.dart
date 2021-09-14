import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_form_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_section.dart';

class SmeupForm extends StatefulWidget {
  final SmeupFormModel smeupFormModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupForm(this.smeupFormModel, this.scaffoldKey, this.formKey);

  @override
  _SmeupFormState createState() => _SmeupFormState();
}

class _SmeupFormState extends State<SmeupForm> with SmeupWidgetStateMixin {
  @override
  Widget build(BuildContext context) {
    //MediaQueryData deviceInfo = MediaQuery.of(context);

    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getFormChildren(widget.smeupFormModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupFormModel.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupForm: ${snapshot.error}',
                logType: LogType.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );
  }

  Future<SmeupWidgetBuilderResponse> _getFormChildren(
      SmeupFormModel smeupFormModel) async {
    await smeupFormModel.setData();

    if (smeupFormModel.type != null && smeupFormModel.type != 'EXD') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Il form deve essere di tipo EXD.'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupFormModel, SmeupNotAvailable());
    }

    if (!hasSections(smeupFormModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Non sono presenti sezioni nel form.'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupFormModel, SmeupNotAvailable());
    }

    if (smeupFormModel.hasVariables()) {
      smeupFormModel.formVariables.forEach((element) {
        SmeupDynamismService.storeFormVariables(element);
      });
    }

    Widget children;
    var sections = List<Widget>.empty(growable: true);
    double maxDim = 100;

    double totalDim = 0;
    bool useDim = true;
    int sectionWithNoDim = 0;
    smeupFormModel.smeupSectionsModels.forEach((section) {
      totalDim += section.dim;
      if (section.dim == 0) sectionWithNoDim += 1;
    });
    if (totalDim <= maxDim && sectionWithNoDim > 0) {
      double dimToSplit = maxDim - totalDim;
      double singleDim = (dimToSplit / sectionWithNoDim).floor().toDouble();
      double spareDim = dimToSplit - (singleDim * sectionWithNoDim);
      for (var i = 0; i < smeupFormModel.smeupSectionsModels.length; i++) {
        var s = smeupFormModel.smeupSectionsModels[i];
        if (s.dim == 0) {
          if (i == smeupFormModel.smeupSectionsModels.length - 1) {
            s.dim = singleDim + spareDim;
          } else {
            s.dim = singleDim;
          }
        }
      }
      totalDim = maxDim;
    }
    if (totalDim > maxDim) {
      SmeupLogService.writeDebugMessage('Section \'dim\' greater than 100%',
          logType: LogType.error);
      useDim = false;
    }
    if (totalDim == 0) {
      SmeupLogService.writeDebugMessage('Section \'dim\' 0%',
          logType: LogType.error);
      useDim = false;
    }

    smeupFormModel.smeupSectionsModels.forEach((s) {
      var section;
      if (useDim && totalDim > 0) {
        section = OrientationBuilder(builder: (context, orientation) {
          final routeArgs =
              ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
          bool isDialog =
              routeArgs == null ? false : routeArgs['isDialog'] ?? false;
          final formHeight = isDialog ? 300 : SmeupOptions.deviceHeight;

          return Container(
              height: smeupFormModel.layout == 'column'
                  ? (formHeight - 70) / totalDim * s.dim
                  : formHeight,
              child: SmeupSection(s, widget.scaffoldKey, widget.formKey));
        });
      } else {
        section = Container(
            child: SmeupSection(s, widget.scaffoldKey, widget.formKey));
      }
      sections.add(section);
    });

    if (smeupFormModel.layout == 'column') {
      children = Container(
        padding: getPadding(smeupFormModel),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: sections),
        ),
      );
    } else {
      children = Container(
        padding: getPadding(smeupFormModel),
        child: SingleChildScrollView(
          child: Row(children: sections),
        ),
      );
    }

    return SmeupWidgetBuilderResponse(smeupFormModel, children);
  }

  EdgeInsets getPadding(SmeupFormModel smeupFormModel) {
    return smeupFormModel.padding > 0
        ? EdgeInsets.all(smeupFormModel.padding)
        : EdgeInsets.only(
            top: smeupFormModel.topPadding,
            bottom: smeupFormModel.bottomPadding,
            right: smeupFormModel.rightPadding,
            left: smeupFormModel.leftPadding);
  }
}
