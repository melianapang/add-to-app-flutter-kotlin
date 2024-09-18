import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveClassFITBQuizWidget extends StatefulWidget {
  const LiveClassFITBQuizWidget._({
    this.boardWidth,
    this.onAnswerChanged,
    this.onSubmitAnswer,
  });

  final double? boardWidth;
  final void Function(String)? onAnswerChanged;
  final void Function(String)? onSubmitAnswer;

  factory LiveClassFITBQuizWidget.controller({
    required void Function(String)? onSubmitAnswer,
  }) {
    return LiveClassFITBQuizWidget._(
      onSubmitAnswer: onSubmitAnswer,
    );
  }

  factory LiveClassFITBQuizWidget.board({
    required double boardWidth,
    required void Function(String) onAnswerChanged,
  }) {
    return LiveClassFITBQuizWidget._(
      onAnswerChanged: onAnswerChanged,
      boardWidth: boardWidth,
    );
  }

  @override
  State<LiveClassFITBQuizWidget> createState() =>
      _LiveClassFITBQuizWidgetState();
}

class _LiveClassFITBQuizWidgetState extends State<LiveClassFITBQuizWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.onSubmitAnswer != null) {
      return _buildFITBControllerWidget();
    }

    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DottedBorder(
          color: GCColors.navyBlue,
          strokeWidth: 3.0,
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          dashPattern: const [5, 2],
          child: Container(
            width: widget.boardWidth,
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: GCColors.navyBlue.withOpacity(0.5),
            ),
            child: TextFormField(
              controller: _controller,
              onChanged: widget.onAnswerChanged,
              focusNode: FocusNode(),
              maxLines: 1,
              style: GCTextStyle.callout(
                boldness: GCFontBoldness.regular,
                color: GCColors.neutralChalk,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Fill this box with your answer',
                hintStyle: GCTextStyle.callout(
                  boldness: GCFontBoldness.regular,
                  color: GCColors.navyLight,
                  style: FontStyle.italic,
                ),
              ),
              cursorColor: GCColors.apricotOrange,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFITBControllerWidget() {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Spacings.horSpace(8),
          _buildTimerWidget(),
          Spacings.horSpace(8),
          _buildSubmitButton(),
        ],
      ),
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
          "00:00",
          style: GCTextStyle.title2Emphasized(
            color: GCColors.neutralChalk,
          ),
        ),
        Spacings.horSpace(4),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        // if (!_enabledSubmitQuiz) return;
        // widget.onSubmitAnswers(_liveClassMode, []);
        // // widget.onSubmitAnswer(_selectedAnswers);
      },
      child: Container(
        height: 32,
        width: 108,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            24,
          ),
          color: GCColors.apricotOrange,
          // color:
          //     enabledSubmit ? GCColors.apricotorange : GCColors.neutralDust,
        ),
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: GCTextStyle.title2Emphasized(
            color: GCColors.neutralChalk,
          ),
        ),
      ),
    );
  }
}
