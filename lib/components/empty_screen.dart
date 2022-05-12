import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    Key? key,
    required this.title,
    required this.icon,
    this.isExpanded = true,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(
            child: child(),
          )
        : child();
  }

  Widget child() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            color: Colors.grey.withOpacity(0.2),
            size: Get.width * 0.4,
          ),
          SizedBox(height: Get.height * 0.01),
          Text(
            title,
            style: Get.theme.textTheme.bodyText1?.copyWith(
              fontSize: 21,
            ),
          ),
        ],
      );
}
