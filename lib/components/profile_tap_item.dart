import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class ProfileTapItem extends StatelessWidget {
  const ProfileTapItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: Get.width * 0.25,
        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: deepPrimaryColor.withOpacity(0.3),
          ),
          color: deepPrimaryColor.withOpacity(0.2),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
              // color: Colors.white,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                // color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
