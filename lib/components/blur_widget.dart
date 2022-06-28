import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class BlurWidget extends StatelessWidget {
  const BlurWidget({
    Key? key,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.isBlur = true,
  }) : super(key: key);
  final Widget child;
  final bool isBlur;
  final BorderRadius borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: isBlur ? blurEffect : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: child,
      ),
    );
  }
}
