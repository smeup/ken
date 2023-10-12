import 'dart:async';

import 'package:flutter/material.dart';
import '../models/widgets/ken_image_list_model.dart';
import '../services/ken_utilities.dart';
import 'ken_list_box.dart';

// ignore: must_be_immutable
class KenImageList extends StatefulWidget {
  KenImageListModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? backColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;

  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? title;
  int? columns;
  int? rows;
  String? id;
  String? type;
  bool dismissEnabled = false;
  dynamic data;
  bool? showLoader = false;
  Axis? orientation;
  double? listHeight;

  // dynamisms functions
  Function? onItemTap;

  dynamic parentForm;

  Function? onGetChildren;

  KenImageList(
    this.scaffoldKey,
    this.formKey,
    this.data,
    this.columns,
    this.rows, {
    this.id = '',
    this.type = 'IML',
    this.backColor = KenImageListModel.defaultBackColor,
    this.borderColor = KenImageListModel.defaultBorderColor,
    this.borderWidth = KenImageListModel.defaultBorderWidth,
    this.borderRadius = KenImageListModel.defaultBorderRadius,
    this.fontSize = KenImageListModel.defaultFontSize,
    this.fontColor = KenImageListModel.defaultFontColor,
    this.fontBold = KenImageListModel.defaultFontBold,
    this.captionFontBold = KenImageListModel.defaultCaptionFontBold,
    this.captionFontSize = KenImageListModel.defaultCaptionFontSize,
    this.captionFontColor = KenImageListModel.defaultCaptionFontColor,
    this.width = KenImageListModel.defaultWidth,
    this.height = KenImageListModel.defaultHeight,
    this.padding = KenImageListModel.defaultPadding,
    this.orientation = KenImageListModel.defaultOrientation,
    this.listHeight = KenImageListModel.defaultListHeight,
    this.title = '',
    showLoader = false,
    this.onItemTap,
    this.dismissEnabled = false,
  });

  @override
  KenImageListState createState() => KenImageListState();
}

class KenImageListState extends State<KenImageList> {
  List<Widget>? cells;
  dynamic _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    int? noColl = widget.columns;
    if (noColl == 0) {
      noColl = widget.rows;
    }

    return KenListBox(
      widget.scaffoldKey,
      widget.formKey,
      _data,
      onItemTap: widget.onItemTap,
      dismissEnabled: widget.dismissEnabled,
      borderColor: widget.borderColor,
      borderWidth: widget.borderWidth,
      borderRadius: widget.borderRadius,
      backColor: widget.backColor,
      fontSize: widget.captionFontSize,
      fontColor: widget.captionFontColor,
      fontBold: widget.fontBold,
      captionFontBold: widget.captionFontBold,
      captionFontSize: widget.captionFontSize,
      captionFontColor: widget.captionFontColor,
      height: widget.height,
      listHeight: widget.listHeight,
      layout: 'imageList',
      listType: KenListType.oriented,
      orientation: widget.orientation,
      padding: widget.padding,
      portraitColumns: noColl,
      landscapeColumns: noColl,
      width: widget.width,
      showLoader: widget.showLoader,
      title: widget.title,
    );
  }

  // } else {
  //   final _modelListBox = KenListBoxModel(
  //       borderColor: widget.borderColor,
  //       borderWidth: widget.borderWidth,
  //       borderRadius: widget.borderRadius,
  //       backColor: widget.backColor,
  //       fontSize: widget.captionFontSize,
  //       fontColor: widget.captionFontColor,
  //       fontBold: widget.fontBold,
  //       captionFontBold: widget.captionFontBold,
  //       captionFontSize: widget.captionFontSize,
  //       captionFontColor: widget.captionFontColor,
  //       height: widget.height,
  //       listHeight: listboxHeight,
  //       layout: 'imageList',
  //       listType: KenListType.oriented,
  //       orientation: widget.orientation,
  //       padding: widget.padding,
  //       portraitColumns: noColl,
  //       landscapeColumns: noColl,
  //       width: widget.width,
  //       title: widget.title,
  //       formKey: widget.formKey);
  //   _modelListBox.dynamisms = _model!.dynamisms;
  //   _modelListBox.data = _data;

  //   if (widget.onGetChildren != null) {
  //     widget.onGetChildren!(_data);
  //   }

  //   final response = await KenMessageBus.instance.publishRequestAndAwait(
  //     widget.globallyUniqueId,
  //     KenTopic.kenImageListGetChildren,
  //     KenMessageBusEventData(
  //         context: context,
  //         widget: widget,
  //         model: _modelListBox,
  //         data: _data),
  //   );

  //   children = response.data.data;
  // }
}
