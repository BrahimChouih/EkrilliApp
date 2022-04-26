import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    Key? key,
    this.leading,
    this.padding = 15.0,
    this.title = '',
    this.trailing,
    this.backButton = false,
    this.height,
    this.width,
  }) : super(key: key);

  Widget? leading;
  Widget? trailing;
  String title;
  final bool backButton;
  double padding;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
            left: padding,
            child: leading ??
                (backButton
                    ? InkWell(
                        child: const Icon(Icons.arrow_back_ios),
                        onTap: () => Get.back(),
                      )
                    : const SizedBox()),
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "SFProRounded",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: padding,
            child: trailing ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
