import 'package:flutter/cupertino.dart';
import 'package:ken/smeup/models/notifiers/smeup_carousel_indicator_notifier.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SmeupCarouselIndicator extends StatefulWidget {
  final int initialIndex;
  List<Map> data;
  SmeupCarouselIndicator(this.initialIndex, this.data);

  @override
  _SmeupCarouselIndicatorState createState() => _SmeupCarouselIndicatorState();
}

class _SmeupCarouselIndicatorState extends State<SmeupCarouselIndicator> {
  @override
  Widget build(BuildContext context) {
    final SmeupCarouselIndicatorNotifier notifier =
        Provider.of<SmeupCarouselIndicatorNotifier>(context, listen: true);

    var list = List<Widget>.empty(growable: true);
    (widget.data).forEach((element) {
      int i = widget.data.indexOf(element);
      var cont = Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: notifier.index == i
                ? Color.fromRGBO(0, 0, 0, 0.9)
                : Color.fromRGBO(0, 0, 0, 0.4)),
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
