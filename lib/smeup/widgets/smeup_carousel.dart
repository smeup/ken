import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_carousel_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_carousel_indicator.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_carousel_item.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';

class SmeupCarousel extends StatefulWidget {
  final SmeupCaurouselModel smeupCaurouselModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupCarousel(
    this.smeupCaurouselModel,
    this.scaffoldKey,
    this.formKey,
  );

  @override
  _SmeupCarouselState createState() => _SmeupCarouselState();
}

class _SmeupCarouselState extends State<SmeupCarousel> {
  int _initialIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttons = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getButtonsComponent(widget.smeupCaurouselModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupCaurouselModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupCarousel: ${snapshot.error}',
                logType: LogType.error);
            widget.smeupCaurouselModel.notifyError(context, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    return buttons;
  }

  Future<SmeupWidgetBuilderResponse> _getButtonsComponent(
      SmeupCaurouselModel smeupCaurouselModel) async {
    await smeupCaurouselModel.setData();

    if (!smeupCaurouselModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupCaurouselModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupCaurouselModel, SmeupNotAvailable());
    }

    final SmeupCaurouselModelIndicator notifier =
        Provider.of<SmeupCaurouselModelIndicator>(context, listen: false);
    notifier.setIndex(_initialIndex);

    var carousel = CarouselSlider.builder(
      itemCount: smeupCaurouselModel.data.length,
      options: CarouselOptions(
          initialPage: _initialIndex,
          height: smeupCaurouselModel.height,
          autoPlay: smeupCaurouselModel.autoPlay,
          onPageChanged: (index, reason) {
            notifier.setIndex(index);
          }),
      itemBuilder: (context, index) {
        return SmeupCarouselItem(smeupCaurouselModel.data[index]['imageFile'],
            smeupCaurouselModel.data[index]['text']);
      },
    );

    var column = Column(children: [
      carousel,
      SmeupCarouselIndicator(_initialIndex, smeupCaurouselModel)
    ]);
    return SmeupWidgetBuilderResponse(smeupCaurouselModel, column);
  }
}
