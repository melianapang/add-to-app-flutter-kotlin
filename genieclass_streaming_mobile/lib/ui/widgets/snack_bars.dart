import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';

enum MySnackBarType {
  attentive,
  negative,
  neutral,
  positive,
}

extension MySnackBarTypeExtension on MySnackBarType {
  static const Map<MySnackBarType, Color> mapTypeToBackgroundColor =
      <MySnackBarType, Color>{
    MySnackBarType.attentive: GCColors.alertBanana,
    MySnackBarType.negative: GCColors.alertErrorChili,
    MySnackBarType.neutral: GCColors.neutralDust,
    MySnackBarType.positive: GCColors.alertCelebratoryLeaf,
  };
  Color get backgroundColor =>
      mapTypeToBackgroundColor[this] ?? GCColors.navyDark;

  static const Map<MySnackBarType, Color> mapTypeToTextColor =
      <MySnackBarType, Color>{
    MySnackBarType.attentive: GCColors.textDefault,
    MySnackBarType.negative: GCColors.neutralChalk,
    MySnackBarType.neutral: GCColors.neutralChalk,
    MySnackBarType.positive: GCColors.neutralChalk,
  };
  Color get textColor => mapTypeToTextColor[this] ?? GCColors.neutralChalk;
}

class MySnackBar {
  static SnackBar buildSnackBar({
    required String message,
    required MySnackBarType type,
    Duration duration = const Duration(seconds: 3),
    Key? key,
    EdgeInsetsGeometry? margin = const EdgeInsets.only(
      bottom: 24,
      left: 16,
      right: 16,
    ),
    VoidCallback? onClose,
  }) {
    final Widget closeWidget = GestureDetector(
      onTap: onClose,
      child: const Icon(
        Icons.close,
        size: 16,
        color: GCColors.neutralDust,
      ),
    );

    return SnackBar(
      // backgroundColor: type.backgroundColor,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        // margin: margin ?? const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 10.0),
        decoration: BoxDecoration(
          color: type.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (type == MySnackBarType.negative) ...<Widget>[
                  const Icon(
                    Icons.warning,
                    color: GCColors.alertErrorChili,
                    size: 20,
                  ),
                  Spacings.horSpace(10),
                ],
                Expanded(
                  child: Text(
                    message,
                    style: GCTextStyle.callout(
                      color: type.textColor,
                    ),
                    strutStyle: const StrutStyle(
                      fontSize: 14,
                      height: 1.2,
                    ),
                  ),
                ),
                if (onClose != null) ...<Widget>[
                  Spacings.horSpace(16),
                  closeWidget,
                ],
              ],
            ),
          ],
        ),
      ),
      duration: duration,
      key: key,
      margin: EdgeInsets.zero,
      elevation: 0,
    );
  }
}
