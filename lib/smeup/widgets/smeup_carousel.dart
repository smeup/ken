import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_carousel_dao.dart';
import 'package:ken/smeup/models/notifiers/smeup_carousel_indicator_notifier.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_carousel_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_carousel_indicator.dart';
import 'package:ken/smeup/widgets/smeup_carousel_item.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SmeupCarousel extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupCarouselModel? model;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;

  List<Map>? data;
  String? id;
  String? type;
  double? height;
  bool? autoPlay;
  String? title;

  SmeupCarousel.withController(
    SmeupCarouselModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  SmeupCarousel(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'CAU',
      this.height = SmeupCarouselModel.defaultHeight,
      this.autoPlay = false,
      this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupCarouselModel m = model as SmeupCarouselModel;
    id = m.id;
    type = m.type;
    height = m.height;
    autoPlay = m.autoPlay;
    title = m.title;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupCarouselModel m = model as SmeupCarouselModel;

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
  _SmeupCarouselState createState() => _SmeupCarouselState();
}

class _SmeupCarouselState extends State<SmeupCarousel>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  int _initialIndex = 0;

  SmeupCarouselModel? _model;
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
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupCarouselDao.getData(_model!);
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    return _getButtonsComponent();
  }

  Future<SmeupWidgetBuilderResponse> _getButtonsComponent() async {
    final SmeupCarouselIndicatorNotifier notifier =
        Provider.of<SmeupCarouselIndicatorNotifier>(context, listen: false);
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
        return SmeupCarouselItem(
            _data[index]['imageFile'], _data[index]['text']);
      },
    );

    var column = Column(
        children: [carousel, SmeupCarouselIndicator(_initialIndex, _data)]);
    return SmeupWidgetBuilderResponse(_model, column);
  }
}
