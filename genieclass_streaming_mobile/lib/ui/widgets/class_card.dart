import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({
    super.key,
    this.width,
    this.height,
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.padding = const EdgeInsets.all(12),
    this.bgColor = GCColors.neutralChalk,
    this.shadowBgColor = GCColors.neutralEraser,
    this.outerBorderRadius = const BorderRadius.only(
      bottomRight: Radius.circular(8),
      bottomLeft: Radius.circular(12),
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    ),
    this.innerBorderRadius = const BorderRadius.only(
      bottomRight: Radius.circular(10),
      bottomLeft: Radius.circular(8),
      topLeft: Radius.circular(10),
      topRight: Radius.circular(8),
    ),
    this.onTap,
    required this.child,
  });

  final double? width;
  final double? height;
  final Color bgColor, shadowBgColor;
  final BorderRadius innerBorderRadius, outerBorderRadius;
  final EdgeInsets? margin, padding;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: shadowBgColor,
          borderRadius: outerBorderRadius,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 4, left: 4),
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: innerBorderRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
