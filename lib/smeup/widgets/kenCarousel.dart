import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/models/notifiers/ken_carousel_indicator_notifier.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_carousel_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenCarouselIndicator.dart';
import 'package:ken/smeup/widgets/kenCarouselItem.dart';
import 'package:ken/smeup/widgets/kenWidgetInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetMixin.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class KenCarousel extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenCarouselModel? model;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;

  List<Map>? data;
  String? id;
  String? type;
  double? height;
  bool? autoPlay;
  String? title;

  KenCarousel.withController(
    KenCarouselModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenCarousel(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'CAU',
      this.height = KenCarouselModel.defaultHeight,
      this.autoPlay = false,
      this.title = ''})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(KenModel model) {
    KenCarouselModel m = model as KenCarouselModel;
    id = m.id;
    type = m.type;
    height = m.height;
    autoPlay = m.autoPlay;
    title = m.title;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenCarouselModel m = model as KenCarouselModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<Map>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add({
          'imageFile': element['imageFile'].toString(),
          'text': element['text'].toString()
        });
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _KenCarouselState createState() => _KenCarouselState();
}

class _KenCarouselState extends State<KenCarousel>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  int _initialIndex = 0;

  KenCarouselModel? _model;
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
    Widget carousel = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return carousel;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupCarouselDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    return _getButtonsComponent();
  }

  Future<KenWidgetBuilderResponse> _getButtonsComponent() async {
    final KenCarouselIndicatorNotifier notifier =
        Provider.of<KenCarouselIndicatorNotifier>(context, listen: false);
    //notifier.setIndex(_initialIndex);

    var carousel = CarouselSlider.builder(
      itemCount: _data.length,
      options: CarouselOptions(
          initialPage: _initialIndex,
          height: widget.height,
          autoPlay: widget.autoPlay!,
          onPageChanged: (index, reason) {
            notifier.setIndex(index);
          }),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return KenCarouselItem(_data[index]['imageFile'], _data[index]['text']);
      },
    );

    var column = Column(
        children: [carousel, KenCarouselIndicator(_initialIndex, _data)]);
    return KenWidgetBuilderResponse(_model, column);
  }
}
