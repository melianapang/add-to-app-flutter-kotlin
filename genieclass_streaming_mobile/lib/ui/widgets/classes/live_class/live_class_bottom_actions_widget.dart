import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_drag_drop_quiz_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_fitb_quiz_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_mcq_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:genieclass_streaming_mobile/core/models/live_class/live_class_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveCLassBottomActionsWidget extends StatefulWidget {
  const LiveCLassBottomActionsWidget._({
    required this.liveClassMode,
    this.enabledMic,
    this.onMicEnabled,
    this.onUpdateParticipantsView,
    this.onShowChat,
    this.onLeaveClass,
    required this.onSelectedMcqAnswer,
    required this.onSubmitAnswers,
  });

  final LiveClassMode liveClassMode;
  final bool? enabledMic;
  final VoidCallback? onMicEnabled;
  final VoidCallback? onUpdateParticipantsView;
  final VoidCallback? onShowChat;
  final VoidCallback? onLeaveClass;
  final void Function(String option, bool selected) onSelectedMcqAnswer;
  final void Function(
    LiveClassMode quizMode,
    String answers,
  ) onSubmitAnswers;

  factory LiveCLassBottomActionsWidget.bigClass({
    required LiveClassMode liveClassMode,
    required void Function(String option, bool selected) onSelectedMcqAnswer,
    required void Function(
      LiveClassMode quizMode,
      String answers,
    ) onSubmitAnswers,
  }) {
    return LiveCLassBottomActionsWidget._(
      liveClassMode: liveClassMode,
      onSelectedMcqAnswer: onSelectedMcqAnswer,
      onSubmitAnswers: onSubmitAnswers,
    );
  }

  factory LiveCLassBottomActionsWidget.smallClass({
    required LiveClassMode liveClassMode,
    required bool enabledMic,
    required VoidCallback onMicEnabled,
    required VoidCallback onUpdateParticipantsView,
    required VoidCallback onShowChat,
    required VoidCallback onLeaveClass,
    required void Function(String option, bool selected) onSelectedMcqAnswer,
    required void Function(
      LiveClassMode quizMode,
      String answers,
    ) onSubmitAnswers,
  }) {
    return LiveCLassBottomActionsWidget._(
      liveClassMode: liveClassMode,
      enabledMic: enabledMic,
      onMicEnabled: onMicEnabled,
      onUpdateParticipantsView: onUpdateParticipantsView,
      onShowChat: onShowChat,
      onLeaveClass: onLeaveClass,
      onSelectedMcqAnswer: onSelectedMcqAnswer,
      onSubmitAnswers: onSubmitAnswers,
    );
  }

  @override
  State<LiveCLassBottomActionsWidget> createState() =>
      _LiveCLassBottomActionsWidgetState();
}

class _LiveCLassBottomActionsWidgetState
    extends State<LiveCLassBottomActionsWidget> {
  late LiveClassMode _liveClassMode;
  bool _enabledSubmitQuiz = false;

  bool get _isSmallClass => widget.onUpdateParticipantsView != null;

  @override
  void initState() {
    super.initState();
    _liveClassMode = widget.liveClassMode;
    if (_liveClassMode != LiveClassMode.normal) {
      _enabledSubmitQuiz = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSmallClass && _liveClassMode == LiveClassMode.normal) {
      return SizedBox(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: _buildLiveClassName()),
              Expanded(child: _buildMainActions()),
              Expanded(child: _buildLeaveButton()),
            ],
          ),
        ),
      );
    }

    if (!_isSmallClass && _liveClassMode == LiveClassMode.normal) {
      return const SizedBox.shrink();
    }

    //quiz appears in big & small class
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Row(
          children: [
            if (_liveClassMode == LiveClassMode.fitbQuiz)
              Expanded(
                child: LiveClassFITBQuizWidget.controller(
                  onSubmitAnswer: _submitFITBAnswer,
                ),
              ),
            if (_liveClassMode == LiveClassMode.dragDropQuiz)
              Expanded(
                child: LiveClassDragDropQuizWidget.controller(
                  onSubmitAnswer: _submitDragDropAnswer,
                ),
              ),
            if (_liveClassMode == LiveClassMode.mcqQuiz)
              Expanded(
                child: LiveClassMcqWidget(
                  type: McqType.normal,
                  onSelected: widget.onSelectedMcqAnswer,
                  onSubmitAnswer: (selectedAnswers) {},
                ),
              ),
            if (_isSmallClass) ...[
              _buildMainActions(),
              Spacings.horSpace(24),
              _buildLeaveButton(),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildLiveClassName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          Images.icSmallGeniebook,
          width: 16,
          height: 16,
        ),
        Spacings.horSpace(8),
        Expanded(
          child: Text(
            'P3 Live Class Name Live Class Name Live Class Name',
            style: GCTextStyle.title2Emphasized(
              color: GCColors.whiteLilac,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMainActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacings.horSpace(8),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onMicEnabled,
          child: SvgPicture.asset(
            Images.icPlay,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              widget.enabledMic == true
                  ? GCColors.skyBlue
                  : GCColors.apricotOrange,
              BlendMode.srcIn,
            ),
          ),
        ),
        Spacings.horSpace(8),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onShowChat,
          child: SvgPicture.asset(
            Images.icPlay,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              GCColors.navyBlue,
              BlendMode.srcIn,
            ),
          ),
        ),
        Spacings.horSpace(8),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onUpdateParticipantsView,
          child: SvgPicture.asset(
            Images.icBell,
            width: 24,
            height: 24,
          ),
        ),
        Spacings.horSpace(8),
      ],
    );
  }

  Widget _buildLeaveButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onLeaveClass,
        child: SvgPicture.asset(
          Images.icPlay,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(
            GCColors.alertErrorChili,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  void _submitFITBAnswer(String answer) {
    if (!_enabledSubmitQuiz) return;
    if (_isSmallClass) return;
    widget.onSubmitAnswers(LiveClassMode.fitbQuiz, answer);
  }

  void _submitDragDropAnswer(String answer) {
    if (!_enabledSubmitQuiz) return;
    if (_isSmallClass) return;
    widget.onSubmitAnswers(LiveClassMode.dragDropQuiz, answer);
  }
}
