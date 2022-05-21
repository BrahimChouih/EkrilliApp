import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text_form_field.dart';

class TextFielWithTitle extends StatelessWidget {
  TextFielWithTitle({
    Key? key,
    required this.controller,
    required this.title,
    this.last = false,
    this.textInputType,
    this.expanded = false,
    this.maxLines = 1,
    this.maxChars,
    this.validator,
    this.formKey,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final bool last;
  final TextInputType? textInputType;
  final bool expanded;
  final int maxLines;
  final int? maxChars;
  final bool readOnly;
  final GlobalKey? formKey;
  String? Function(String?)? validator;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(title),
          SizedBox(height: Get.height * 0.01),
          CustomTextFormField(
            controller: controller,
            textInputType: textInputType,
            expanded: expanded,
            onTap: onTap,
            maxLines: maxLines,
            maxChars: maxChars,
            readOnly: readOnly,
            validator: validator ??
                (value) {
                  if (controller.text.isEmpty) {
                    return 'You must fill in this field';
                  }
                  if (maxChars != null && (value?.length ?? 0) > maxChars!) {
                    return 'You have exceeded the burn limit' +
                        '(' +
                        maxChars.toString() +
                        ' ' +
                        'Letter' +
                        ')';
                  }
                  return null;
                },
            textInputAction: last ? TextInputAction.done : TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
