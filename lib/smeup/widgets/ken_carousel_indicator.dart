import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/notifiers/ken_carousel_indicator_notifier.dart';

class KenCarouselIndicator extends StatefulWidget {
  final int initialIndex;
  final List<Map>? data;
  const KenCarouselIndicator(this.initialIndex, this.data, {super.key});

  @override
  KenCarouselIndicatorState createState() => KenCarouselIndicatorState();
}

class KenCarouselIndicatorState extends State<KenCarouselIndicator> {
  @override
  Widget build(BuildContext context) {
    final KenCarouselIndicatorNotifier notifier =
        Provider.of<KenCarouselIndicatorNotifier>(context, listen: true);

    var list = List<Widget>.empty(growable: true);
    for (var element in widget.data!) {
      int i = widget.data!.indexOf(element);
      var cont = Container(
        width: 8.0,
        height: 8.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: notifier.index == i
                ? const Color.fromRGBO(63, 187, 211, 1)
                : const Color.fromRGBO(0, 96, 116, 1)),
      );

      list.add(cont);
    }

    var indicator = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );

    return indicator;
  }
}
