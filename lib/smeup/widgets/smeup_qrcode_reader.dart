import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_qrcode_reader_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_qrcode_reader_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class SmeupQRCodeReader extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  // Graphics properties
  double padding;
  double size;
  Function onDataRead;
  int maxReads;
  int delayInMillis;
  bool showLoader;

  SmeupQRCodeReaderModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  String id;
  String type;

  String data;

  SmeupQRCodeReader.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupQRCodeReader(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'QRC',
      this.data,
      this.padding = SmeupQRCodeReaderModel.defaultPadding,
      this.size = SmeupQRCodeReaderModel.defaultSize,
      this.maxReads = SmeupQRCodeReaderModel.defaultMaxReads,
      this.delayInMillis = SmeupQRCodeReaderModel.defaultDealyInMillis,
      title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    SmeupDataService.incrementDataFetch(id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupQRCodeReaderModel m = model;
    id = m.id;
    type = m.type;
    padding = m.padding;
    maxReads = m.maxReads;
    delayInMillis = m.delayInMillis;
    size = m.size;
    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupQRCodeReaderModel m = model;

    // change data format
    var workData = formatDataFields(m);

    return workData['rows'][0]['QRC'];
  }

  @override
  _SmeupQRCodeReaderState createState() => _SmeupQRCodeReaderState();
}

class _SmeupQRCodeReaderState extends State<SmeupQRCodeReader>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupQRCodeReaderModel _model;
  dynamic _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;

    if (_model != null) widgetLoadType = _model.widgetLoadType;
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
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return qrcode;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupQRCodeReaderDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }
    return _getQRCodeComponent();
  }

  Future<SmeupWidgetBuilderResponse> _getQRCodeComponent() async {
    Widget children;

    children = Center(
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        child: QrImage(
          data: _data,
          size: widget.size,
          errorCorrectionLevel: QrErrorCorrectLevel.Q,
          gapless: false,
          version: 9,
        ),
      ),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
