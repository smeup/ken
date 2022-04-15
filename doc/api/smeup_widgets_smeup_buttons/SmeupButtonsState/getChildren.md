


# getChildren method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupWidgetBuilderResponse](../../smeup_models_smeupWidgetBuilderResponse/SmeupWidgetBuilderResponse-class.md)> getChildren
()

_override_



<p>Buttons' structure:</p>



## Implementation

```dart
Future<SmeupWidgetBuilderResponse> getChildren() async {
  if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
    if (_model != null) {
      await SmeupButtonsDao.getData(_model!);
      _data = widget.treatData(_model!);
    }

    setDataLoad(widget.id, true);
  }

  var buttons = List<SmeupButton>.empty(growable: true);

  int buttonIndex = 0;
  List array = _model == null ? _data : _data['rows'];
  array.forEach((buttonData) {
    buttonIndex += 1;
    String? buttonText = _model == null ? buttonData : buttonData['value'];
    final button = SmeupButton(
      id: '${SmeupUtilities.getWidgetId(widget.type, widget.id)}_${buttonIndex.toString()}',
      type: widget.type,
      buttonIndex: buttonIndex,
      title: widget.title,
      data: buttonText,
      backColor: widget.backColor,
      borderColor: widget.borderColor,
      width: widget.width,
      height: widget.height,
      position: widget.position,
      align: widget.align,
      fontColor: widget.fontColor,
      fontSize: widget.fontSize,
      padding: widget.padding,
      valueField: widget.valueField,
      borderRadius: widget.borderRadius,
      borderWidth: widget.borderWidth,
      elevation: widget.elevation,
      fontBold: widget.fontBold,
      iconData: widget.iconData,
      iconSize: widget.iconSize,
      iconColor: widget.iconColor,
      icon: null,
      isBusy: _isBusy,
      clientOnPressed: () {
        if (widget.clientOnPressed != null) {
          widget.clientOnPressed!(buttonIndex, buttonText);
        }
        runDynamism(context, buttonData);
      },
      isLink: widget.isLink!,
      model: _model,
    );

    buttons.add(button);
  });

  if (buttons.length > 0) {
    var widgets;
    if (widget.orientation == WidgetOrientation.Vertical)
      widgets = SingleChildScrollView(
          scrollDirection: Axis.vertical, child: Column(children: buttons));
    else
      widgets = SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: Row(children: buttons));

    return SmeupWidgetBuilderResponse(_model, widgets);
  } else {
    SmeupLogService.writeDebugMessage(
        'Error SmeupButtons no children \'button\' created',
        logType: LogType.warning);
    final column = Column(children: [Container()]);
    return SmeupWidgetBuilderResponse(_model, column);
  }
}
```







