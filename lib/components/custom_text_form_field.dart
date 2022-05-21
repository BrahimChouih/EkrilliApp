import 'package:ekrilli_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.textInputType,
    this.expanded = false,
    this.maxLines = 1,
    this.validator,
    this.textInputAction,
    this.color,
    this.textColor,
    this.hint,
    this.maxChars,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool expanded;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Color? color;
  final Color? textColor;
  final String? hint;
  final int? maxChars;
  final bool readOnly;
  final Function()? onTap;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      expands: widget.expanded,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      maxLines: widget.maxLines,
      cursorColor: deepPrimaryColor,
      readOnly: widget.readOnly,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide:
              BorderSide(color: widget.color ?? deepPrimaryColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide:
              BorderSide(color: widget.color ?? deepPrimaryColor, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        hintText: widget.hint,
        contentPadding: const EdgeInsets.all(8.0),
        counterStyle: Get.textTheme.bodyText2?.copyWith(
          color: deepPrimaryColor,
          fontSize: 10,
        ),
        counterText: widget.maxChars == null
            ? ''
            : (widget.maxChars! <= widget.controller!.text.length
                    ? 0
                    : widget.maxChars! - widget.controller!.text.length)
                .toString(),
      ),
    );
  }
}
