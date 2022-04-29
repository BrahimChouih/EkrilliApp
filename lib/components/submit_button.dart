import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/primary_theme.dart';
import '../utils/constants.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    this.onTap,
    required this.text,
    Key? key,
    this.padding,
    this.margin,
    this.color,
    this.textColor,
  }) : super(key: key);

  final Function()? onTap;
  final String text;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: margin ?? EdgeInsets.all(Get.height * 0.015),
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 15,
            ),
        decoration: BoxDecoration(
          color: color ?? primaryColor,
          borderRadius: borderRadius,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
