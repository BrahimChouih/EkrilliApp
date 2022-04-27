import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RatingWidget extends StatelessWidget {
  RatingWidget({
    Key? key,
    this.stars = 0,
    this.numReviews = 0,
  }) : super(key: key);
  final double stars;
  final int numReviews;

  List<Widget> rateWidgets = [];

  @override
  Widget build(BuildContext context) {
    double rate = 0;
    if (stars != 0 && numReviews != 0) {
      rate = stars / numReviews;
    }
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
  }
}
