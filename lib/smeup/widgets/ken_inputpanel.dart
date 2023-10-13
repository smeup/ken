import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../models/widgets/ken_combo_item_model.dart';
import '../models/widgets/ken_input_panel_value.dart';
import '../services/ken_defaults.dart';
import '../services/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_button.dart';
import 'ken_combo.dart';
import 'ken_label.dart';
import 'kenQrcodeReader.dart';
import 'ken_radio_buttons.dart';
import 'ken_text_autocomplete.dart';
import 'ken_text_field.dart';

class KenInputPanel extends StatelessWidget {
  EdgeInsetsGeometry? padding;
  double? fontSize;
  double? width;
  double? height;
  String? id;
  String? type;
  String? title;
  List<SmeupInputPanelField>? data;
  Color? backgroundColor;
  double? parentWidth;
  double? parentHeight;
  double confirmButtonRowHeight = 110;
  bool? autoAdaptHeight = true;
  bool? isConfirmedEnabled = false;

  KenInputPanel(
      {this.id = '',
      this.type = 'INP',
      this.title = '',
      this.padding = KenInputPanelDefaults.defaultPadding,
      this.fontSize = KenInputPanelDefaults.defaultFontSize,
      this.width = KenInputPanelDefaults.defaultWidth,
      this.height = KenInputPanelDefaults.defaultHeight,
      this.data,
      this.backgroundColor,
      this.parentWidth,
      this.parentHeight,
      this.isConfirmedEnabled});

  @override
  Widget build(BuildContext context) {
    double? inputPanelHeight = height;
    double? inputPanelWidth = width;
    if (parentWidth != null && parentHeight != null) {
      if (inputPanelWidth == 0) {
        inputPanelWidth = parentWidth;
      }
      if (inputPanelHeight == 0) {
        inputPanelHeight = parentHeight;
      }
    } else {
      if (inputPanelWidth == 0) {
        inputPanelWidth = KenUtilities.getDeviceInfo().safeWidth;
      }
      if (inputPanelHeight == 0) {
        inputPanelWidth = KenUtilities.getDeviceInfo().safeHeight;
      }
    }

    double? innerPanelHeight = inputPanelHeight;

    if (autoAdaptHeight! && isConfirmedEnabled!) {
      innerPanelHeight = innerPanelHeight! - confirmButtonRowHeight;
    }

    return SizedBox(
      height: inputPanelHeight,
      width: inputPanelWidth,
      child: Scaffold(
          floatingActionButton:
              autoAdaptHeight == true ? _getConfirmButton(this) : null,
          floatingActionButtonLocation: autoAdaptHeight == true
              ? FloatingActionButtonLocation.centerDocked
              : null,
          body: SizedBox(
            height: innerPanelHeight,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title!.isNotEmpty)
                    Text(
                      title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  if (title!.isNotEmpty)
                    const SizedBox(
                      height: 16,
                    ),
                  _getFields(context),
                  if (autoAdaptHeight == false) _getConfirmButton(this)
                ],
              ),
            ),
          )),
    );
  }

  Widget _getFields(BuildContext context) {
    List<Widget> fields = data!.where((field) => field.visible!).map((field) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getInputFieldWidget(field, context),
          const SizedBox(
            height: 13,
          ),
        ],
      );
    }).toList();
    return Container(
      color: backgroundColor, // background color input panel
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: fields,
        ),
      ),
    );
  }

  Widget _getInputFieldWidget(SmeupInputPanelField field, BuildContext context) {
    switch (field.component) {
      case ShiroInputPanelSupportedComp.rad:
        return _getRadioList(field);

      case ShiroInputPanelSupportedComp.bcd:
        return KenQRCodeReader(id: field.id, data: field.value.code);

      case ShiroInputPanelSupportedComp.cmb:
        return _getComboWidget(field, context);

      case ShiroInputPanelSupportedComp.acp:
        return _getTextAutocompleteWidget(field);

      default:
        return _getTextFieldWidget(field);
    }
  }

  Widget _getTextFieldWidget(SmeupInputPanelField field) {
    return Column(
      children: [
        _getLabel(field.label),
        SizedBox(
          height: 30,
          child: KenTextField(
            id: field.id!,
            data: field.value.code,
            // clientOnChange: (value) {
            //   field.value.code = field.value.description = value;
            // },
          ),
        )
      ],
    );
  }

  Widget _getRadioList(SmeupInputPanelField field) {
    field.items ??= [];
    return Column(children: <Widget>[
      _getLabel(field.label),
      KenRadioButtons(
        id: field.id,
        // title: field.label,
        backColor: Colors.transparent,
        data: const [
          {"code": "0", "value": "< 3 people"},
          {"code": "1", "value": "4 - 7 people"},
          {"code": "2", "value": '8 - 10 people'},
          {"code": "3", "value": '> 11 people'},
        ],
        selectedValue: field.value.code,
        clientOnPressed: (value) {
          field.value.code = field.value.description = value;
        },
      )
    ]);
  }

  Widget _getComboWidget(SmeupInputPanelField field, BuildContext context) {
    KenMessageBus.instance.event<ComboOnChangeEvent>(field.id!)
      .takeWhile((element) => context.mounted).listen(
      (event) {
        field.value.code = field.value.description = event.value;
      },
    );
    field.items ??= [];
    return Column(
      children: <Widget>[
        _getLabel(field.label),
        KenCombo(
          id: field.id,
          width: 0,
          underline: false,
          innerSpace: 0,
          showBorder: true,
          selectedValue: field.value.code == "" ? null : field.value.code,
          items: field.items!
              .map((e) => KenComboItemModel(e.code, e.description))
              .toList(),
        ),
      ],
    );
  }

  Widget _getTextAutocompleteWidget(SmeupInputPanelField field) {
    field.items ??= [];
    KenMessageBus.instance.event<TextAutocompleteOnChange>(field.id!).listen(
      (event) {
        field.value.code = event.value;
      },
    );
    KenMessageBus.instance.event<TextAutocompleteOnTapSelectedEvent>(field.id!).listen(
      (event) {
        field.value.code = event.value['code'];
        field.value.description = event.value['value'];
      },
    );
    return Column(
      children: <Widget>[
        _getLabel(field.label),
        KenTextAutocomplete(
          id: field.id,
          valueField: "value",
          defaultValue: field.id,
          showborder: true,
          underline: false,
          data: field.items!
            .map((e) => {"code": e.code, "value": e.description})
            .toList(),
        ),
      ],
    );
  }

  Widget _getConfirmButton(widget) {
    final buttonId = '${widget.id}_confirmButton';
    KenMessageBus.instance.event<ButtonOnPressedEvent>(buttonId).listen(
      (event) {
        KenMessageBus.instance.fireEvent(
          InputPanelSubmittedEvent(
            widgetId: widget.id!,
            value: widget.data,
          ),
        );
      },
    );
    if (widget.isConfirmedEnabled) {
      return SizedBox(
        height: confirmButtonRowHeight,
        child: Row(
          children: [
            Expanded(
              child: KenButton(
                id: buttonId,
                data: "Conferma",
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  KenLabel _getLabel(String? label) {
    return KenLabel(
      [label ?? ''],
      align: Alignment.bottomLeft,
      height: 8,
    );
  }
}
