import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class StarsWidget extends StatelessWidget {
  StarsWidget({
    Key? key,
    this.stars = 0,
    this.numReviews = 0,
    this.type = StarsWidgetType.icons,
    this.calculate = true,
  }) : super(key: key);
  final double stars;
  final int numReviews;
  final bool calculate;
  final StarsWidgetType type;
  List<Widget> rateWidgets = [];

  @override
  Widget build(BuildContext context) {
    double rate = stars;
    if (stars != 0 && numReviews != 0 && calculate) {
      rate = stars / numReviews;
    }
    if (type == StarsWidgetType.icons) {
      for (int i = 1; i <= 5; i++) {
        IconData icon = Icons.star_rounded;
        if (rate < i) {
          if (rate < (i - 0.5)) {
            icon = Icons.star_border_rounded;
          } else {
            icon = Icons.star_half_rounded;
          }
        }

        rateWidgets.add(
          Icon(
            icon,
            color: Colors.amberAccent,
            // color: Color(0xffFFA303),
          ),
        );
      }
      String numR = '';
      if (numReviews >= 1000) {
        double number = numReviews / 1000;
        numR = '(${number.toStringAsFixed(1)}k)';
      } else {
        numR = '($numReviews)';
      }

      rateWidgets.add(
        Text(
          numR,
          style: const TextStyle(
            color: Color(0xffDBDBDB),
            fontSize: 18,
          ),
        ),
      );

      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: rateWidgets,
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '(' + rate.toStringAsFixed(1) + ')',
          ),
          const FaIcon(
            Icons.star_rounded,
            color: Colors.amber,
          ),
        ],
      );
    }
  }
}

enum StarsWidgetType {
  icons,
  digital,
}
