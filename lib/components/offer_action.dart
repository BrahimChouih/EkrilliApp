import 'dart:ui';

import 'package:ekrilli_app/components/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class OfferAction extends StatelessWidget {
  const OfferAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Container(
          color: deepPrimaryColor.withOpacity(0.1),
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.03,
          ),
          child: Row(
            children: [
              Text(
                'Make a deal with this person',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              const Spacer(),
              SubmitButton(
                text: 'Send Offer',
                color: primaryColor.withOpacity(0.8),
                textColor: deepPrimaryColor,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
