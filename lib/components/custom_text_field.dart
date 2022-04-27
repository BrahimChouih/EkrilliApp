import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/primary_theme.dart';
import '../utils/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
    this.obscureText = false,
    this.keyboardType,
    this.onChange,
    this.prefixIcon,
  }) : super(key: key);

  final String? hintText;
  TextEditingController? controller;
  final bool obscureText;
  final EdgeInsetsGeometry? margin;
  final TextInputType? keyboardType;
  Function(String)? onChange;
  Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        onChanged: onChange,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: primaryColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
