import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';

enum McqButtonState {
  normal,
  selected,
  correct,
  incorrect,
  disabled,
}

class LiveClassMcqButtonWidget extends StatelessWidget {
  const LiveClassMcqButtonWidget({
    super.key,
    required this.option,
    this.state = McqButtonState.normal,
    required this.onSelected,
  });

  final String option;
  final McqButtonState state;
  final Function(String) onSelected;

  Color get textColor {
    switch (state) {
      case McqButtonState.normal:
        return GCColors.navyDark;
      case McqButtonState.selected:
      case McqButtonState.correct:
      case McqButtonState.incorrect:
      case McqButtonState.disabled:
      default:
        return GCColors.neutralChalk;
    }
  }

  Color get backgroundColor {
    switch (state) {
      case McqButtonState.normal:
        return GCColors.neutralChalk;
      case McqButtonState.selected:
        return GCColors.apricotOrange;
      case McqButtonState.correct:
        return GCColors.alertCelebratoryLeaf;
      case McqButtonState.incorrect:
        return GCColors.alertErrorChili;
      case McqButtonState.disabled:
      default:
        return GCColors.neutralDust;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onSelected(option),
      child: Container(
        height: 32,
        width: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            24,
          ),
          color: backgroundColor,
        ),
        child: Text(
          option,
          textAlign: TextAlign.center,
          style: GCTextStyle.title2Emphasized(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
