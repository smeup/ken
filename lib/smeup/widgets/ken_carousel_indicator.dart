import 'package:flutter/cupertino.dart';
import 'package:ken/smeup/models/notifiers/ken_carousel_indicator_notifier.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class KenCarouselIndicator extends StatefulWidget {
  final int initialIndex;
  List<Map>? data;
  KenCarouselIndicator(this.initialIndex, this.data);

  @override
  _KenCarouselIndicatorState createState() => _KenCarouselIndicatorState();
}

class _KenCarouselIndicatorState extends State<KenCarouselIndicator> {
  @override
  Widget build(BuildContext context) {
    final KenCarouselIndicatorNotifier notifier =
        Provider.of<KenCarouselIndicatorNotifier>(context, listen: true);

    var list = List<Widget>.empty(growable: true);
    widget.data!.forEach((element) {
      int i = widget.data!.indexOf(element);
      var cont = Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: notifier.index == i
                ? Color.fromRGBO(63, 187, 211, 1)
                : Color.fromRGBO(0, 96, 116, 1)),
      );

      list.add(cont);
    });

    var indicator = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );

    return indicator;
  }
}
