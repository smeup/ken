import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_carousel_model.dart';

class SmeupCarouselIndicator extends StatefulWidget {
  final int initialIndex;
  final SmeupCaurouselModel smeupCaurouselModel;
  SmeupCarouselIndicator(this.initialIndex, this.smeupCaurouselModel);

  @override
  _SmeupCarouselIndicatorState createState() => _SmeupCarouselIndicatorState();
}

class _SmeupCarouselIndicatorState extends State<SmeupCarouselIndicator> {
  @override
  Widget build(BuildContext context) {
    final SmeupCaurouselModelIndicator notifier =
        Provider.of<SmeupCaurouselModelIndicator>(context, listen: true);

    var list = List<Widget>.empty(growable: true);
    (widget.smeupCaurouselModel.data).forEach((element) {
      int i = widget.smeupCaurouselModel.data.indexOf(element);
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
