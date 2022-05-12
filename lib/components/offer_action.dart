import 'dart:ui';

import 'package:ekrilli_app/components/submit_button.dart';
import 'package:ekrilli_app/components/text_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class OfferAction extends StatelessWidget {
  OfferAction({Key? key}) : super(key: key);
  RxBool expanded = false.obs;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: Get.width,
            color: deepPrimaryColor.withOpacity(0.1),
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.03,
            ).copyWith(
              top: Get.height * 0.01,
            ),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Make a deal with this person',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  expanded.value
                      ? TextFielWithTitle(
                          controller: TextEditingController(),
                          title: 'Start Date',
                          validator: (_) => null,
                        )
                      : const SizedBox(),
                  SizedBox(height: Get.height * 0.02),
                  expanded.value
                      ? TextFielWithTitle(
                          controller: TextEditingController(),
                          title: 'End Date',
                          validator: (_) => null,
                        )
                      : const SizedBox(),
                  expanded.value
                      ? SubmitButton(
                          text: 'Send Offer',
                          color: primaryColor.withOpacity(0.8),
                          textColor: Colors.white.withOpacity(0.9),
                          margin: EdgeInsets.symmetric(
                            vertical: Get.height * 0.02,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                        )
                      : const SizedBox(),
                  InkWell(
                    onTap: () {
                      expanded.value = !expanded.value;
                    },
                    child: SizedBox(
                      height: Get.height * 0.04,
                      width: Get.width * 0.5,
                      child: Center(
                        child: FaIcon(
                          expanded.value
                              ? FontAwesomeIcons.caretUp
                              : FontAwesomeIcons.caretDown,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
