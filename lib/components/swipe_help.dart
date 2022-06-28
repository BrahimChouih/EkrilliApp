import 'package:ekrilli_app/components/blur_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/constants.dart';

class SwipeHelp extends StatelessWidget {
  const SwipeHelp({Key? key, this.text = ''}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return BlurWidget(
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: borderRadius,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/swipe.svg',
              color: deepPrimaryColor,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(
                color: deepPrimaryColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
