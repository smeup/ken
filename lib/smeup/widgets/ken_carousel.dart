import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import '../models/notifiers/ken_carousel_indicator_notifier.dart';
import 'ken_carousel_indicator.dart';
import 'ken_carousel_item.dart';
import 'package:provider/provider.dart';

class KenCarousel extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;

  final List<Map>? data;
  final String? id;
  final String? type;
  final double? height;
  final bool? autoPlay;
  final String? title;
  final Color? fontColor; // Add fontColor parameter

  const KenCarousel(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'CAU',
      this.height = KenCarouselDefaults.defaultHeight,
      this.autoPlay = false,
      this.title = '',
      this.fontColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return _getButtonsComponent(context);
  }

  Widget _getButtonsComponent(BuildContext context) {
    final KenCarouselIndicatorNotifier notifier =
        Provider.of<KenCarouselIndicatorNotifier>(context, listen: false);
    //notifier.setIndex(_initialIndex);

    int? initialIndex = 0;

    var carousel = CarouselSlider.builder(
      itemCount: data!.length,
      options: CarouselOptions(
          initialPage: initialIndex,
          height: height,
          autoPlay: autoPlay!,
          onPageChanged: (index, reason) {
            notifier.setIndex(index);
          }),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return KenCarouselItem(
          data![index]['imageFile'],
          data![index]['text'],
          fontColor: fontColor, // Pass the fontColor parameter
        );
      },
    );

    var column =
        Column(children: [carousel, KenCarouselIndicator(initialIndex, data)]);
    return column;
  }
}
