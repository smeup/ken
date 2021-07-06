import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_label_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_label_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:provider/provider.dart';
import '../notifiers/smeup_widgets_notifier.dart';

class SmeupLabel extends StatefulWidget {
  final SmeupLabelModel smeupLabelModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupLabel(
    this.smeupLabelModel,
    this.scaffoldKey,
    this.formKey,
  );

  @override
  _SmeupLabelState createState() => _SmeupLabelState();
}

class _SmeupLabelState extends State<SmeupLabel> {
  @override
  void dispose() {
    SmeupWidgetsNotifier.removeWidget(
        widget.scaffoldKey.hashCode, widget.smeupLabelModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupLabelNotifier notifier =
        Provider.of<SmeupLabelNotifier>(context);

    var label = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getLabelComponent(widget.smeupLabelModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupLabel: ${snapshot.error}',
                logType: LogType.error);
            widget.smeupLabelModel.notifyError(context, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    SmeupWidgetsNotifier.addWidget(widget.scaffoldKey.hashCode,
        widget.smeupLabelModel.id, widget.smeupLabelModel.type, notifier);
    return label;
  }

  Future<SmeupWidgetBuilderResponse> _getLabelComponent(
      SmeupLabelModel smeupLabelModel) async {
    Widget children;

    await smeupLabelModel.setData();

    if (!smeupLabelModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupLabelModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupLabelModel, SmeupNotAvailable());
    }

    List<Align> alignes = List<Align>.empty(growable: true);
    double padding = smeupLabelModel.padding;
    double fontSize = smeupLabelModel.fontSize;

    Color backColor = smeupLabelModel.backColor;
    if (smeupLabelModel.colorColName.isNotEmpty &&
        smeupLabelModel.data[0][smeupLabelModel.colorColName] != null) {
      backColor = smeupLabelModel.data[0][smeupLabelModel.colorColName];
    }

    Color fontColor = smeupLabelModel.fontColor;
    if (smeupLabelModel.colorFontColName.isNotEmpty &&
        smeupLabelModel.data[0][smeupLabelModel.colorFontColName] != null) {
      fontColor = smeupLabelModel.data[0][smeupLabelModel.colorFontColName];
    }

    (smeupLabelModel.data as List).forEach((l) {
      var map = (l as Map);
      final align = Align(
        alignment: smeupLabelModel.align,
        child: Text(
          map['value'],
          style: TextStyle(
              color: fontColor,
              fontWeight: smeupLabelModel.fontbold
                  ? FontWeight.bold
                  : FontWeight.normal,
              fontSize: fontSize),
        ),
      );
      alignes.add(align);
    });

    final col = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: alignes);

    if (alignes.length > 0) {
      children = Padding(
        padding: EdgeInsets.all(padding),
        child: col,
      );

      double labelHeight =
          smeupLabelModel.height * alignes.length + padding * (fontSize / 5);

      final label =
          Container(color: backColor, height: labelHeight, child: children);

      int iconData = 0;
      if (smeupLabelModel.iconData != 0) {
        iconData = smeupLabelModel.iconData;
      }
      if (smeupLabelModel.iconColname.isNotEmpty &&
          smeupLabelModel.data[0][smeupLabelModel.iconColname] != null) {
        iconData = smeupLabelModel.data[0][smeupLabelModel.iconColname];
      }

      double iconHeight = smeupLabelModel.iconSize;

      if (iconData == 0) {
        return SmeupWidgetBuilderResponse(smeupLabelModel, label);
      } else {
        final icon = Icon(
          IconData(iconData, fontFamily: 'MaterialIcons'),
          color: fontColor,
          size: smeupLabelModel.iconSize,
        );

        var widget;
        double widgetHeight = labelHeight + iconHeight;

        switch (smeupLabelModel.align.toString()) {
          case 'centerLeft': // text on the left icon on the right
            widget = Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label,
                  icon,
                ],
              ),
              color: backColor,
            );
            break;
          case 'centerRight': // text on the right icon on the left
            widget = Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  label,
                ],
              ),
              color: backColor,
            );
            break;
          case 'topCenter': // text at the top icon at the bottom
            widget = Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label,
                  icon,
                ],
              ),
              color: backColor,
            );
            break;
          case 'bottomCenter': // text at the bottom icon at the top
            widget = Container(
              height: widgetHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: icon),
                  label,
                ],
              ),
              color: backColor,
            );

            break;
          default:
            widget = Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label,
                  icon,
                ],
              ),
              color: backColor,
            );
            break;
        }

        return SmeupWidgetBuilderResponse(smeupLabelModel, widget);
      }
    }

    SmeupLogService.writeDebugMessage('Error SmeupLabel not created',
        logType: LogType.error);

    return SmeupWidgetBuilderResponse(smeupLabelModel, SmeupNotAvailable());
  }

  // MainAxisAlignment _maxAlignFromAlignment(Alignment alignment) {
  //   switch (alignment.toString()) {
  //     case "centerLeft":
  //       return MainAxisAlignment.end;
  //     case "centerRight":
  //       return MainAxisAlignment.start;
  //     case "centerRight":
  //       return MainAxisAlignment.start;
  //     case "centerRight":
  //       return MainAxisAlignment.start;
  //     default:
  //       return MainAxisAlignment.center;
  //   }
  // }
}
