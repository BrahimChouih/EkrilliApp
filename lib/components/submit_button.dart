import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/primary_theme.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    this.onTap,
    this.text = '',
    Key? key,
  }) : super(key: key);

  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(Get.height * 0.015),
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
