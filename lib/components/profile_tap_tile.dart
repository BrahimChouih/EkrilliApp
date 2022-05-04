import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class ProfielTapTile extends StatelessWidget {
  const ProfielTapTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: deepPrimaryColor.withOpacity(0.3),
                ),
                color: deepPrimaryColor.withOpacity(0.2),
              ),
              child: Row(
                children: [
                  Icon(
                    icon, size: 30,
                    color: Colors.black.withOpacity(0.75),
                    // color: Colors.white,
                  ),
                  SizedBox(width: Get.width * 0.07),
                  Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.75),
                          // color: Colors.white,
                        ),
                      ),
                      subtitle != null
                          ? Text(
                              subtitle ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )
                          : const SizedBox(),
                    ],
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
