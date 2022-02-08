import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_form_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_not_available.dart';
import 'package:ken/smeup/widgets/smeup_wait.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';
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
    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getFormChildren(widget.smeupFormModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupFormModel.showLoader
              ? SmeupWait(widget.scaffoldKey, widget.formKey)
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupForm: ${snapshot.error}. StackTrace: ${snapshot.stackTrace}',
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
    //await smeupFormModel.setData();

    if (smeupFormModel.type != null && smeupFormModel.type != 'EXD') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Il form deve essere di tipo EXD.'),
          backgroundColor: SmeupConfigurationService.getTheme().errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupFormModel, SmeupNotAvailable());
    }

    if (!hasSections(smeupFormModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Non sono presenti sezioni nel form.'),
          backgroundColor: SmeupConfigurationService.getTheme().errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupFormModel, SmeupNotAvailable());
    }

    if (smeupFormModel.hasVariables()) {
      smeupFormModel.formVariables.forEach((element) {
        SmeupDynamismService.storeFormVariables(
            element, smeupFormModel.formKey);
      });
    }

    Widget form;
    var sections = List<Widget>.empty(growable: true);
    Widget container;

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
    if (!smeupFormModel.autoAdaptHeight && totalDim > maxDim) {
      SmeupLogService.writeDebugMessage('Section \'dim\' greater than 100%',
          logType: LogType.error);
      useDim = false;
    }
    if (!smeupFormModel.autoAdaptHeight && totalDim == 0) {
      SmeupLogService.writeDebugMessage('Section \'dim\' 0%',
          logType: LogType.error);
      useDim = false;
    }

    smeupFormModel.smeupSectionsModels.forEach((s) {
      //MediaQueryData deviceInfo = MediaQuery.of(context);

      if (useDim && totalDim > 0) {
        final routeArgs =
            ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
        bool isDialog =
            routeArgs == null ? false : routeArgs['isDialog'] ?? false;

        double formHeight = isDialog
            ? 300
            : SmeupUtilities.getDeviceInfo().safeHeight -
                SmeupConfigurationService.getTheme().appBarTheme.toolbarHeight;
        double formWidth =
            isDialog ? 300 : SmeupUtilities.getDeviceInfo().safeWidth;

        s.height = smeupFormModel.layout == 'column'
            ? (formHeight) / totalDim * s.dim
            : formHeight;

        s.width = smeupFormModel.layout == 'row'
            ? formWidth / totalDim * s.dim
            : formWidth;
      } else {
        s.height = SmeupUtilities.getDeviceInfo().safeHeight;
        s.width = SmeupUtilities.getDeviceInfo().safeWidth;
      }
    });

    smeupFormModel.smeupSectionsModels.forEach((s) {
      var section;
      if (!smeupFormModel.autoAdaptHeight && useDim && totalDim > 0) {
        section = Container(
            height: s.height,
            width: s.width,
            child: SmeupSection(
                s, widget.scaffoldKey, widget.smeupFormModel.formKey));
      } else {
        section = Container(
            child: SmeupSection(
                s, widget.scaffoldKey, widget.smeupFormModel.formKey));
      }
      sections.add(section);
    });

    if (smeupFormModel.layout == 'column') {
      if (smeupFormModel.autoAdaptHeight) {
        container = Container(
          constraints: BoxConstraints(minHeight: 0),
          padding: smeupFormModel.padding,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: sections),
          ),
        );
      } else {
        container = Container(
          padding: smeupFormModel.padding,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: sections),
        );
      }
    } else {
      container = Container(
        padding: smeupFormModel.padding,
        child: SingleChildScrollView(
          child: Row(children: sections),
        ),
      );
    }

    form = Form(key: widget.smeupFormModel.formKey, child: container);

    return SmeupWidgetBuilderResponse(smeupFormModel, form);
  }
}
