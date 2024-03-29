// import 'dart:ui';

// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/notifiers/ken_text_password_rule_notifier.dart';
import '../models/notifiers/ken_text_password_visibility_notifier.dart';
import '../services/ken_defaults.dart';
import '../helpers/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_text_field.dart';
import 'ken_text_password_indicators.dart';
import 'package:provider/provider.dart';

class KenTextPassword extends StatefulWidget {
  final Color? backColor;
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;
  final Color? captionBackColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? iconSize;
  final Color? iconColor;
  final Color? buttonBackColor;

  final String? label;
  final String? submitLabel;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showBorder;
  final String? data;
  final bool? underline;
  final bool? autoFocus;
  final String id;
  final String? type;
  final String? valueField;
  final bool? showSubmit;
  final bool? showRules;
  final bool? showRulesIcon;
  final bool? checkRules;
  final bool? readOnly;

  final Function? clientValidator;

  final List<TextInputFormatter>? inputFormatters;

  final GlobalKey<ScaffoldState>? formKey;

  const KenTextPassword({
    super.key,
    required this.id,
    this.type = 'FLD',
    this.backColor = KenTextFieldPasswordDefaults.defaultBackColor,
    this.fontSize = KenTextFieldPasswordDefaults.defaultFontSize,
    this.fontBold = KenTextFieldPasswordDefaults.defaultFontBold,
    this.fontColor = KenTextFieldPasswordDefaults.defaultFontColor,
    this.captionBackColor =
        KenTextFieldPasswordDefaults.defaultCaptionBackColor,
    this.captionFontBold = KenTextFieldPasswordDefaults.defaultFontBold,
    this.captionFontColor = KenTextFieldPasswordDefaults.defaultFontColor,
    this.captionFontSize = KenTextFieldPasswordDefaults.defaultFontSize,
    this.borderColor = KenTextFieldPasswordDefaults.defaultBorderColor,
    this.borderRadius = KenTextFieldPasswordDefaults.defaultBorderRadius,
    this.borderWidth = KenTextFieldPasswordDefaults.defaultBorderWidth,
    this.iconSize = KenTextFieldPasswordDefaults.defaultIconSize,
    this.iconColor = KenTextFieldPasswordDefaults.defaultIconColor,
    this.buttonBackColor = KenTextFieldPasswordDefaults.defaultButtonBackColor,
    this.label = KenTextFieldPasswordDefaults.defaultLabel,
    this.submitLabel = KenTextFieldPasswordDefaults.defaultSubmitLabel,
    this.width = KenTextFieldPasswordDefaults.defaultWidth,
    this.height = KenTextFieldPasswordDefaults.defaultHeight,
    this.padding = KenTextFieldPasswordDefaults.defaultPadding,
    this.showBorder = KenTextFieldPasswordDefaults.defaultShowBorder,
    this.data,
    this.underline = KenTextFieldPasswordDefaults.defaultUnderline,
    this.autoFocus = KenTextFieldPasswordDefaults.defaultAutoFocus,
    this.valueField = KenTextFieldPasswordDefaults.defaultValueField,
    this.showSubmit = KenTextFieldPasswordDefaults.defaultShowSubmit,
    this.showRules = KenTextFieldPasswordDefaults.defaultShowRules,
    this.showRulesIcon = KenTextFieldPasswordDefaults.defaultShowRulesIcon,
    this.checkRules = KenTextFieldPasswordDefaults.defaultCheckRules,
    this.clientValidator, // ?
    this.inputFormatters, // ?
    this.readOnly = KenTextFieldDefaults.defaultReadOnly,
    this.formKey,
  });

  @override
  KenTextPasswordState createState() => KenTextPasswordState();
}

class KenTextPasswordState extends State<KenTextPassword> {
  dynamic _data;
  late StreamSubscription changeSubscription;
  // bool _passwordVisible;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    changeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passwordModel =
        Provider.of<KenTextPasswordRuleNotifier>(context, listen: false);
    final passwordFieldModel =
        Provider.of<KenTextPasswordVisibilityNotifier>(context, listen: false);

    final iconTheme = _getIconTheme();
    final dividerStyle = _getDividerStyle();
    final captionStyle = _getCaptionStile();

    changeSubscription = KenMessageBus.instance
        .event<TextFieldOnChangeEvent>(
            KenUtilities.getMessageBusId(widget.id, widget.formKey))
        .listen(
      (event) {
        passwordModel.checkProgress(event.value);
        _data = event.value;
      },
    );

    final children = Column(
      children: [
        Container(
          decoration: widget.showBorder!
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  border: Border.all(
                      color: widget.borderColor!, width: widget.borderWidth!))
              : null,
          child: Row(
            children: [
              Expanded(
                child: Consumer<KenTextPasswordVisibilityNotifier>(
                  builder: (context, fieldmodel, child) {
                    return KenTextField(
                      id: widget.id,
                      label: widget.label,
                      autoFocus: widget.autoFocus,
                      backColor: widget.backColor,
                      fontSize: widget.fontSize,
                      fontBold: widget.fontBold,
                      fontColor: widget.fontColor,
                      captionBackColor: widget.captionBackColor,
                      captionFontBold: widget.captionFontBold,
                      captionFontColor: widget.captionFontColor,
                      captionFontSize: widget.captionFontSize,
                      borderColor: widget.borderColor,
                      borderRadius: widget.borderRadius,
                      borderWidth: widget.borderWidth,
                      submitLabel: widget.submitLabel,
                      height: widget.height,
                      inputFormatters: widget.inputFormatters,
                      padding: widget.padding,
                      showSubmit: widget.showSubmit ?? false,
                      showBorder: false,
                      width: widget.width,
                      underline: false,
                      data: _data,
                      clientValidator: widget.clientValidator,
                      keyboard: fieldmodel.passwordVisible
                          ? TextInputType.text
                          : TextInputType.visiblePassword,
                      readOnly: widget.readOnly,
                      formKey: widget.formKey,
                    );
                  },
                ),
              ),
              Container(
                color: widget.buttonBackColor,
                padding: EdgeInsets.all(iconTheme.size!.toDouble() - 10),
                child: GestureDetector(
                  child: Icon(
                    passwordFieldModel.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: iconTheme.color,
                    size: iconTheme.size,
                  ),
                  onTap: () {
                    setState(() {
                      passwordFieldModel.toggleVisible();
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                color: widget.buttonBackColor,
                padding: EdgeInsets.all(iconTheme.size!.toDouble() - 10),
                child: GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: iconTheme.color,
                    size: iconTheme.size,
                  ),
                  onTap: () {
                    setState(() {
                      _data = '';
                      passwordModel.reset();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            if (widget.underline!)
              Divider(
                thickness: dividerStyle.thickness,
                color: dividerStyle.color,
              ),
            if (widget.showRules!)
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: KenTextPasswordIndicators(
                  widget.showRulesIcon,
                  captionStyle,
                  iconTheme,
                  key: Key(
                      '${(widget.key as ValueKey).value}_password_indicators'),
                ),
              )
          ],
        )
      ],
    );

    return children;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData =
        IconThemeData(size: widget.iconSize, color: widget.iconColor);

    return themeData;
  }

  DividerThemeData _getDividerStyle() {
    DividerThemeData dividerData = DividerThemeData(color: widget.fontColor);

    return dividerData;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = TextStyle(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: widget.captionBackColor);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }
}
