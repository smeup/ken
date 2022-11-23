


# getComponents method




    *[<Null safety>](https://dart.dev/null-safety)*




[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md)> getComponents
(dynamic jsonMap, dynamic componentName)








## Implementation

```dart
List<SmeupModel> getComponents(jsonMap, componentName) {
  final components = List<SmeupModel>.empty(growable: true);

  if (jsonMap.containsKey(componentName)) {
    List<dynamic> componentsJson = jsonMap[componentName];
    componentsJson.forEach((v) async {
      SmeupModel? model;

      try {
        switch (v['type']) {
          case 'LAB': // ok
            model = SmeupLabelModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'GAU':
            model = SmeupGaugeModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'CAU':
            model =
                SmeupCarouselModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'TRE':
            model = SmeupTreeModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'CAL':
            model =
                SmeupCalendarModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'CHA':
            model = SmeupChartModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'BTN':
            model =
                SmeupButtonsModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'BOX':
            model =
                SmeupListBoxModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'DSH':
            model =
                SmeupDashboardModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'LIN':
            model = SmeupLineModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'IMG':
            model = SmeupImageModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'IML':
            model =
                SmeupImageListModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'FLD':
            switch (v['options']['FLD']['default']['type']) {
              case 'acp':
                model = SmeupTextAutocompleteModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;
              case 'cal':
                model = SmeupDatePickerModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;
              case 'cmb':
                model = SmeupComboModel.fromMap(
                    v, formKey, scaffoldKey, context, this);
                break;
              case 'itx':
                model = SmeupTextFieldModel.fromMap(
                    v, formKey, scaffoldKey, context, this);
                break;
              case 'pgb':
                model = SmeupProgressBarModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;
              case 'pgi':
                model = SmeupProgressIndicatorModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;
              case 'pwd':
                model = SmeupTextPasswordModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;
              case 'qrc':
                model = SmeupQRCodeReaderModel.fromMap(
                    v, formKey, scaffoldKey, context, this);
                break;
              case 'rad':
                model = SmeupRadioButtonsModel.fromMap(
                    v, formKey, scaffoldKey, context, this);
                break;
              case 'sld':
                model = SmeupSliderModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;
              case 'spl':
                model = SmeupSplashModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;
              case 'swt':
                model = SmeupSwitchModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;
              case 'tpk':
                model = SmeupTimePickerModel.fromMap(
                    v, formKey, scaffoldKey, context);
                break;

              default:
            }

            break;
          case 'SCH':
            model = SmeupFormModel.fromMap(v, formKey, scaffoldKey, context);
            break;
          case 'DRW':
            break;

          case 'INP': // ok
            model = SmeupInputPanelModel.fromMap(
                v, formKey, scaffoldKey, context);
            break;
          default:
            SmeupLogService.writeDebugMessage(
                'component not defined: ${v['type']}',
                logType: LogType.error);
        }
      } catch (e) {
        final msg =
            'SmeupSectionModel - getComponents - Error while creating the model ${v['type']} ';
        SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
        throw (msg);
      }

      if (model != null) {
        if (model.parent == null) model.parent = this;
        components.add(model);
      }
    });
  }

  return components;
}
```







