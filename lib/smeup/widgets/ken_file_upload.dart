import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../helpers/ken_utilities.dart';
import '../services/ken_defaults.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_button.dart';
import 'ken_list_box.dart';

class KenFileUpload extends StatefulWidget {
  final GlobalKey<ScaffoldState> formKey;

  final Color? backColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;

  final double? width;
  final double? height;
  final Axis? orientation;
  final EdgeInsetsGeometry? padding;
  final KenListType? listType;
  final String? layout;
  final String? title;
  final int? portraitColumns;
  final int? landscapeColumns;
  final String? id;
  final String? type;
  final bool dismissEnabled;
  final dynamic data;
  final bool? showLoader;
  final String? defaultSort;
  final String? backgroundColName;
  final bool? showSelection;
  final int? selectedRow;
  final double? listHeight;
  final String? storageSelectedRow;
  final double? realBoxHeight;

  final double? availableSpace;
  final Function? onRefresh;

  final bool? isFirestore;
  final Function? onGetBoxImage;
  final Function? onGetBoxText;
  final Function? onGetButtons;
  final Function? onGetButtonsColumns;

  const KenFileUpload(this.formKey, this.data,
      {super.key,
      this.id = '',
      this.type = 'FUP',
      this.borderColor = KenListBoxDefaults.defaultBorderColor,
      this.borderWidth = KenListBoxDefaults.defaultBorderRadius,
      this.borderRadius = KenListBoxDefaults.defaultBorderRadius,
      this.backColor = KenListBoxDefaults.defaultBackColor,
      this.fontSize = KenListBoxDefaults.defaultFontSize,
      this.fontColor = KenListBoxDefaults.defaultFontColor,
      this.fontBold = KenListBoxDefaults.defaultFontBold,
      this.captionFontBold = KenListBoxDefaults.defaultCaptionFontBold,
      this.captionFontSize = KenListBoxDefaults.defaultCaptionFontSize,
      this.captionFontColor = KenListBoxDefaults.defaultCaptionFontColor,
      this.layout = KenListBoxDefaults.defaultLayout,
      this.width = KenListBoxDefaults.defaultWidth,
      this.height = KenListBoxDefaults.defaultHeight,
      this.orientation = KenListBoxDefaults.defaultOrientation,
      this.padding = KenListBoxDefaults.defaultPadding,
      this.listType = KenListBoxDefaults.defaultListType,
      this.portraitColumns = KenListBoxDefaults.defaultPortraitColumns,
      this.landscapeColumns = KenListBoxDefaults.defaultLandscapeColumns,
      this.backgroundColName = KenListBoxDefaults.defaultBackgroundColName,
      this.listHeight = KenListBoxDefaults.defaultListHeight,
      this.showSelection = KenListBoxDefaults.defaultShowSelection,
      this.selectedRow = KenListBoxDefaults.defaultSelectedRow,
      this.storageSelectedRow,
      this.realBoxHeight = KenListBoxDefaults.defaultRealBoxHeight,
      this.dismissEnabled = false,
      this.defaultSort = KenListBoxDefaults.defaultDefaultSort,
      this.availableSpace,
      this.onRefresh,
      this.isFirestore,
      this.onGetBoxImage,
      this.onGetBoxText,
      this.onGetButtons,
      this.onGetButtonsColumns,
      this.title,
      this.showLoader});

  @override
  KenFileUploadState createState() => KenFileUploadState();
}

class KenFileUploadState extends State<KenFileUpload> {
  dynamic _data;
  String _chooseButtonId = '';
  String _uploadButtonId = '';
  String _cancelButtonId = '';
  String _listId = '';
  late KenListBox _list;

  @override
  void initState() {
    _data = widget.data;

    _chooseButtonId = '${widget.id}_chooseButton';

    _listId = '${widget.id}_list';
    KenMessageBus.instance
        .event<ButtonOnPressedEvent>(
            KenUtilities.getMessageBusId(_chooseButtonId, widget.formKey))
        .takeWhile((element) => context.mounted)
        .listen(
      (event) {
        FilePicker.platform
            .pickFiles(allowMultiple: true)
            .then((FilePickerResult? result) {
          if (result != null) {
            List<File> files = result.paths.map((path) => File(path!)).toList();

            for (var file in files) {
              (_data["rows"] as List).add({
                "code": file.path,
                "description": p.basename(file.path),
                "imageType": "file"
              });
            }

            KenMessageBus.instance.fireEvent(
              ListboxOnRefreshListEvent(
                  messageBusId:
                      KenUtilities.getMessageBusId(_listId, widget.formKey)),
            );
          }
        });
      },
    );

    _uploadButtonId = '${widget.id}_uploadButton';
    KenMessageBus.instance
        .event<ButtonOnPressedEvent>(
            KenUtilities.getMessageBusId(_uploadButtonId, widget.formKey))
        .takeWhile((element) => context.mounted)
        .listen(
      (event) {
        KenMessageBus.instance.fireEvent(
          FileUploadExecuteUploadEvent(
              messageBusId:
                  KenUtilities.getMessageBusId(widget.id, widget.formKey),
              files: _data["rows"] as List),
        );
      },
    );

    _cancelButtonId = '${widget.id}_cancelButton';
    KenMessageBus.instance
        .event<ButtonOnPressedEvent>(
            KenUtilities.getMessageBusId(_cancelButtonId, widget.formKey))
        .takeWhile((element) => context.mounted)
        .listen(
      (event) {
        var rows = _data["rows"] as List;
        rows.clear();

        KenMessageBus.instance.fireEvent(
          ListboxOnRefreshListEvent(
              messageBusId:
                  KenUtilities.getMessageBusId(_listId, widget.formKey)),
        );
      },
    );

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
    _list = _getList();

    var children = Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KenButton(
            id: _chooseButtonId,
            data: "Choose",
            key: Key(_chooseButtonId),
            formKey: widget.formKey,
          ),
          KenButton(
            id: _uploadButtonId,
            data: "Upload",
            key: Key(_uploadButtonId),
            formKey: widget.formKey,
          ),
          KenButton(
            id: _cancelButtonId,
            data: "Cancel",
            key: Key(_cancelButtonId),
            formKey: widget.formKey,
          ),
        ],
      ),
      _list
    ]);

    return SingleChildScrollView(
      child: children,
    );
  }

  KenListBox _getList() {
    return KenListBox(
      widget.formKey,
      _data,
      backColor: widget.backColor,
      backgroundColName: KenListBoxDefaults.defaultBackgroundColName,
      borderColor: widget.borderColor,
      borderRadius: widget.borderRadius,
      borderWidth: widget.borderWidth,
      captionFontBold: widget.captionFontBold,
      captionFontColor: widget.captionFontColor,
      captionFontSize: widget.captionFontSize,
      defaultSort: KenListBoxDefaults.defaultBackgroundColName,
      dismissEnabled: widget.dismissEnabled,
      fontBold: widget.fontBold,
      fontColor: widget.fontColor,
      fontSize: widget.fontSize,
      height: widget.height,
      id: _listId,
      key: Key(widget.id!),
      landscapeColumns: widget.landscapeColumns,
      layout: widget.layout,
      listHeight: widget.listHeight,
      listType: KenListType.oriented,
      storageSelectedRow: null,
      orientation: widget.orientation,
      padding: widget.padding,
      portraitColumns: widget.landscapeColumns,
      realBoxHeight: widget.height,
      selectedRow: widget.selectedRow,
      showLoader: widget.showLoader,
      showSelection: false,
      title: widget.title,
      type: widget.type,
      width: widget.width,
      availableSpace: widget.availableSpace,
      onRefresh: widget.onRefresh,
      isFirestore: widget.isFirestore,
      onGetBoxImage: widget.onGetBoxImage,
    );
  }

  // String imageToBase64(String? imagePath) {
  //   final extension = p.extension(
  //       imagePath!.substring(imagePath.lastIndexOf("/")).replaceAll("/", ""));
  //   final bytes = File(imagePath).readAsBytesSync();
  //   String base64 =
  //       "data:image/${extension.replaceAll(".", "")};base64,${base64Encode(bytes)}";
  //   return base64;
  // }
}
