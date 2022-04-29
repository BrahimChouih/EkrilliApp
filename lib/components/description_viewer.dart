import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescriptionViewer extends StatelessWidget {
  DescriptionViewer({Key? key, required this.text}) : super(key: key);
  final String text;
  RxBool showMore = true.obs;
  int letterNumber = 200;
  @override
  Widget build(BuildContext context) {
    if (showMore.value) showMore.value = text.length < letterNumber;
    if (text.length > 200) {
      letterNumber = 200;
    } else {
      letterNumber = text.length;
    }
    return Obx(
      () => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AnimatedCrossFade(
              firstChild: Text(
                text.substring(0, letterNumber) + '...',
                style: const TextStyle(fontSize: 16),
              ),
              secondChild: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
              crossFadeState: !showMore.value
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
          text.length > letterNumber
              ? Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      showMore.value = !showMore.value;
                      showMore.refresh();
                    },
                    child: Text(showMore.value ? 'Less'.tr : 'More'.tr),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
