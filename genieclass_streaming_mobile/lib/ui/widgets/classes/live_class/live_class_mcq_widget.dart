import 'dart:async';
import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_mcq_button_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum McqType {
  normal,
  combined,
  sequential,
}

class LiveClassMcqWidget extends StatefulWidget {
  const LiveClassMcqWidget({
    super.key,
    this.time = 30,
    required this.type,
    required this.onSelected,
    required this.onSubmitAnswer,
  });

  final McqType type;
  final int time;
  final Function(String, bool) onSelected;
  final Function(Set<String>) onSubmitAnswer;

  @override
  State<LiveClassMcqWidget> createState() => _LiveClassMcqWidgetState();
}

class _LiveClassMcqWidgetState extends State<LiveClassMcqWidget> {
  final Set<String> _selectedAnswers = {};
  bool enabledSubmit = true;

  late Timer _timer;
  int _localTime = 0;

  @override
  void initState() {
    super.initState();

    _localTime = widget.time;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_localTime == 0) {
          timer.cancel();
          enabledSubmit = false;

          setState(() {});
        } else {
          _localTime--;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTimerWidget(),
        Spacings.horSpace(4),
        LiveClassMcqButtonWidget(
          option: "A",
          state: _getButtonState("A"),
          onSelected: _selectNewOption,
        ),
        Spacings.horSpace(8),
        LiveClassMcqButtonWidget(
          option: "B",
          state: _getButtonState("B"),
          onSelected: _selectNewOption,
        ),
        Spacings.horSpace(8),
        LiveClassMcqButtonWidget(
          option: "C",
          state: _getButtonState("C"),
          onSelected: _selectNewOption,
        ),
        Spacings.horSpace(8),
        LiveClassMcqButtonWidget(
          option: "D",
          state: _getButtonState("D"),
          onSelected: _selectNewOption,
        ),
        Spacings.horSpace(4),
        Expanded(child: _buildSubmitButton()),
      ],
    );
  }

  Widget _buildTimerWidget() {
    return Row(
      children: [
        SvgPicture.asset(
          Images.icSmallGeniebook,
          width: 22,
        ),
        Spacings.horSpace(4),
        Text(
          timeRemaining,
          style: GCTextStyle.title2Emphasized(
            color: GCColors.neutralChalk,
          ),
        ),
        Spacings.horSpace(4),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          if (!enabledSubmit) return;
          widget.onSubmitAnswer(_selectedAnswers);
        },
        child: Container(
          height: 32,
          width: 108,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              24,
            ),
            color:
                enabledSubmit ? GCColors.apricotOrange : GCColors.neutralDust,
          ),
          child: Text(
            "Submit",
            textAlign: TextAlign.center,
            style: GCTextStyle.title2Emphasized(
              color: GCColors.neutralChalk,
            ),
          ),
        ),
      ),
    );
  }

  void _selectNewOption(String option) {
    switch (widget.type) {
      case McqType.normal:
        if ((_selectedAnswers.isNotEmpty && _selectedAnswers.first != option) ||
            _selectedAnswers.isEmpty) {
          widget.onSelected(option, true);
          _selectedAnswers.clear();
          _selectedAnswers.add(option);
        }

      case McqType.combined:
        if (_selectedAnswers.contains(option)) {
          widget.onSelected(option, false);
          _selectedAnswers.remove(option);
        } else {
          widget.onSelected(option, true);
          _selectedAnswers.add(option);
        }

      case McqType.sequential:
    }

    setState(() {});
  }

  //MCQ Button
  McqButtonState _getButtonState(String option) {
    switch (widget.type) {
      case McqType.normal:
      case McqType.combined:
        return _getNormalCombinedMcqButtonState(option);

      case McqType.sequential:
        return _getSequentialMcqButtonState(option);
    }
  }

  McqButtonState _getNormalCombinedMcqButtonState(option) {
    if (!enabledSubmit) {
      return McqButtonState.disabled;
    }

    if (_selectedAnswers.contains(option)) {
      return McqButtonState.selected;
    }

    return McqButtonState.normal;
  }

  McqButtonState _getSequentialMcqButtonState(option) {
    if (!enabledSubmit) {
      return McqButtonState.disabled;
    }

    return McqButtonState.normal;
  }
  //MCQ Button

  //Timer
  String get timeRemaining {
    int convertedMinute = ((_localTime / 1000) / 60).round();
    int convertedSeconds = (_localTime / 1000 % 60).round();

    return "$convertedMinute:${convertedSeconds < 10 ? "0$convertedSeconds" : "$convertedSeconds"}";
  }
  //Timer
}
