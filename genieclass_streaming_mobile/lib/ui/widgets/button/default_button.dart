import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';

class DefaultButton extends StatelessWidget {
  final String? text;
  final double? height;
  final Function()? onPressed;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Color? color;
  final double radius;
  final TextStyle? style;
  final bool isEnable;
  final bool hasShadow;
  final double? width;
  final Widget? child;

  const DefaultButton(
      {super.key,
      this.text,
      this.onPressed,
      this.height,
      this.margin,
      this.backgroundColor,
      this.radius = 8,
      this.color,
      this.style,
      this.isEnable = true,
      this.hasShadow = false,
      this.width = double.infinity,
      this.child});

  Color? get _bgColor => isEnable ? backgroundColor : GCColors.neutralEraser;
  Color? get _textColor => isEnable ? color : GCColors.neutralChalk;
  TextStyle get _style =>
      style ??
      GCTextStyle.cardTitle(
        color: GCColors.neutralChalk,
        fontSize: 16,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 48,
      margin: margin,
      decoration: hasShadow
          ? BoxDecoration(
              color: Colors.black.withAlpha(56),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            )
          : null,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          )),
          backgroundColor: WidgetStateProperty.all(_bgColor),
        ),
        onPressed: isEnable ? onPressed : null,
        child: child ??
            Text(
              text ?? "",
              style: _style.copyWith(color: _textColor),
            ),
      ),
    );
  }
}
