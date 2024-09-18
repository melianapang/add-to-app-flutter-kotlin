import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveClassDragDropQuizWidget extends StatefulWidget {
  const LiveClassDragDropQuizWidget._({
    required this.drawQuadrant,
    this.boardWidth,
    this.boardHeight,
    this.onSubmitAnswer,
  });

  final bool drawQuadrant;
  final double? boardWidth;
  final double? boardHeight;
  final void Function(String)? onSubmitAnswer;

  factory LiveClassDragDropQuizWidget.controller({
    required void Function(String)? onSubmitAnswer,
  }) {
    return LiveClassDragDropQuizWidget._(
      drawQuadrant: false,
      onSubmitAnswer: onSubmitAnswer,
    );
  }

  factory LiveClassDragDropQuizWidget.board({
    required double boardWidth,
    required double boardHeight,
  }) {
    return LiveClassDragDropQuizWidget._(
      drawQuadrant: true,
      boardHeight: boardHeight,
      boardWidth: boardWidth,
    );
  }

  @override
  State<LiveClassDragDropQuizWidget> createState() =>
      _LiveClassDragDropQuizWidgetState();
}

class _LiveClassDragDropQuizWidgetState
    extends State<LiveClassDragDropQuizWidget> {
  final List<DragTargetDetails<int>> _draggedShapes = [];

  @override
  Widget build(BuildContext context) {
    if (!widget.drawQuadrant) {
      return _buildDragDropControllerWidget();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildQuadrant(),
        _buildQuadrant(),
      ],
    );
  }

  Widget _buildQuadrant() {
    final double? boardW = widget.boardWidth;
    final double? boardH = widget.boardHeight;
    if (boardW == null || boardH == null) return const SizedBox.shrink();

    final double width = (boardW / 2) - 16;
    final double height = boardH * 0.6;

    return DragTarget(
      onAcceptWithDetails: (DragTargetDetails<int> details) {
        _draggedShapes.add(details);
        setState(() {});
      },
      builder: (context, accepted, rejected) {
        RenderBox? renderBox = context.findRenderObject() as RenderBox;

        return Padding(
          padding: const EdgeInsets.all(6),
          child: DottedBorder(
            color: GCColors.navyBlue,
            strokeWidth: 3.0,
            borderType: BorderType.RRect,
            radius: const Radius.circular(20),
            dashPattern: const [5, 2],
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: GCColors.navyBlue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: _buildDroppedShapes(renderBox),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDroppedShapes(RenderBox? renderBox) {
    RenderBox? newRenderBox = renderBox;
    if (newRenderBox == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: _draggedShapes
          .map(
            (e) => _buildDroppedShapeInQuadrant(e, newRenderBox),
          )
          .toList(),
    );
  }

  Widget _buildDroppedShapeInQuadrant(
    DragTargetDetails<int> item,
    RenderBox renderBox,
  ) {
    Offset offset = renderBox.globalToLocal(item.offset);
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: SvgPicture.asset(
        Images.icSmallGeniebook,
        width: 24,
      ),
    );
  }

  Widget _buildDragDropControllerWidget() {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Spacings.horSpace(8),
          _buildTimerWidget(),
          Spacings.horSpace(24),
          Draggable(
            data: 0,
            feedback: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 36,
            ),
            childWhenDragging: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 24,
            ),
            child: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 24,
            ),
          ),
          Spacings.horSpace(12),
          Draggable(
            data: 1,
            feedback: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 36,
            ),
            childWhenDragging: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 24,
            ),
            child: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 24,
            ),
          ),
          Spacings.horSpace(12),
          Draggable(
            data: 2,
            feedback: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 36,
            ),
            childWhenDragging: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 24,
            ),
            child: SvgPicture.asset(
              Images.icSmallGeniebook,
              width: 24,
            ),
          ),
          Spacings.horSpace(24),
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
