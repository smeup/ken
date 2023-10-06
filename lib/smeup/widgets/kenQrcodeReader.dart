import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_qrcode_reader_model.dart';
import '../services/ken_configuration_service.dart';
import '../services/ken_utilities.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class KenQRCodeReader extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  // Graphics properties
  double? padding;
  double? size;
  Function? onDataRead;
  int? maxReads;
  int? delayInMillis;
  bool? showLoader;

  KenQRCodeReaderModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;
  String? id;
  String? type;

  String? data;

  KenQRCodeReader.withController(
    KenQRCodeReaderModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenQRCodeReader(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'QRC',
      this.data,
      this.padding = KenQRCodeReaderModel.defaultPadding,
      this.size = KenQRCodeReaderModel.defaultSize,
      this.maxReads = KenQRCodeReaderModel.defaultMaxReads,
      this.delayInMillis = KenQRCodeReaderModel.defaultDealyInMillis,
      title = ''})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    //todo
    // SmeupDataService.incrementDataFetch(id);
  }

  @override
  runControllerActivities(KenModel model) {
    KenQRCodeReaderModel m = model as KenQRCodeReaderModel;
    id = m.id;
    type = m.type;
    padding = m.padding;
    maxReads = m.maxReads;
    delayInMillis = m.delayInMillis;
    size = m.size;
    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenQRCodeReaderModel m = model as KenQRCodeReaderModel;

    // change data format
    var workData = formatDataFields(m);

    return workData['rows'][0]['QRC'];
  }

  @override
  _KenQRCodeReaderState createState() => _KenQRCodeReaderState();
}

class _KenQRCodeReaderState extends State<KenQRCodeReader>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenQRCodeReaderModel? _model;
  dynamic _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;

    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget qrcode = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.immediate;
        setDataLoad(widget.id, false);
      });
    });

    return qrcode;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.delay) {
      if (_model != null) {
        // await SmeupQRCodeReaderDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }
    return _getQRCodeComponent();
  }

  Future<KenWidgetBuilderResponse> _getQRCodeComponent() async {
    Widget children;

    children = Center(
      child: Container(
        padding: EdgeInsets.all(widget.padding!),
        child: QrImageView(
          data: _data,
          size: widget.size,
          errorCorrectionLevel: QrErrorCorrectLevel.Q,
          gapless: false,
          version: 9,
          foregroundColor:
              KenConfigurationService.getTheme()!.textTheme.bodyText2!.color,
        ),
      ),
    );

    return KenWidgetBuilderResponse(_model, children);
  }
}
