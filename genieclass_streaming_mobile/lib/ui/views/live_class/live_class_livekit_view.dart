import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/live_class_channel_service.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/stream_api_service.dart';
import 'package:genieclass_streaming_mobile/core/models/live_class/live_class_model.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_bottom_actions_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_chat_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_drag_drop_quiz_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_fitb_quiz_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/participant_video_view.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/dialogs.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:genieclass_streaming_mobile/view_models/live_class/live_class_livekit_view_model.dart';
import 'package:genieclass_streaming_mobile/view_models/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_client/src/types/other.dart' as LivekitOtherUtils;

class LiveClassLiveKitViewParam {
  LiveClassLiveKitViewParam({
    this.onlineLessonId = "",
    this.meetingId = "",
    this.subjectId = "",
    this.levelId = "",
    this.wsUrl = "",
  });

  final String onlineLessonId;
  final String meetingId;
  final String subjectId;
  final String levelId;
  final String wsUrl;
}

class LiveClassLiveKitView extends ConsumerStatefulWidget {
  const LiveClassLiveKitView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LiveClassLiveKitViewState();
}

class _LiveClassLiveKitViewState extends ConsumerState<LiveClassLiveKitView> {
  // Room? _room;
  // late EventsListener<RoomEvent> _roomListener;

  bool _showChat = true;
  bool _showQuizControllerBar = false;
  bool _showActionsOverlay = true;
  final OverlayPortalController _overlayController = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    print("HIIII dispose CALLEDDD");
    // _roomListener.dispose();
    // _room?.disconnect();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<LiveClassLiveKitViewModel>(
      model: LiveClassLiveKitViewModel(
        liveClassChannelService: ref.read(liveClassChannelService),
        streamApiService: ref.read(streamApiProvider),
      ),
      onModelReady: (viewModel) {
        viewModel.init();
      },
      builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: GCColors.navyBlue,
          body: OverlayPortal(
            controller: _overlayController,
            overlayChildBuilder: _buildActionsOverlay,
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Spacings.verSpace(8),
                      _buildMainVideoView(
                        viewModel: viewModel,
                      ),
                      _buildQuizControllerBottomBar(
                        viewModel: viewModel,
                      ),
                    ],
                  ),
                ),
                _buildChatWidget(
                  viewModel,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainVideoView({
    required LiveClassLiveKitViewModel viewModel,
  }) {
    Room? room = viewModel.room;
    if (room == null ||
        room.connectionState != LivekitOtherUtils.ConnectionState.connected) {
      return _buildLoadingState();
    }

    RemoteParticipant? teacher = room.remoteParticipants.values.firstOrNull;

    if (teacher == null) {
      return Expanded(
        child: Container(
          color: GCColors.alertCelebratoryLeaf,
        ),
      );
    }

    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width;
          double height;

          if (_showChat) {
            width = constraints.maxWidth;
            height = ((9 / 16) * width);
          } else {
            height = constraints.maxHeight;
            width = ((16 / 9) * height);
          }

          return GestureDetector(
            onTap: _toggleActionsOverlayView,
            child: InteractiveViewer(
              panEnabled: !_showChat && !_showQuizControllerBar,
              scaleEnabled: !_showChat && !_showQuizControllerBar,
              child: Center(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ParticipantVideoView.main(
                        participant: teacher,
                      ),
                      if (viewModel.liveClassMode == LiveClassMode.fitbQuiz)
                        LiveClassFITBQuizWidget.board(
                          boardWidth: width,
                          onAnswerChanged: (text) {},
                        ),
                      if (viewModel.liveClassMode == LiveClassMode.dragDropQuiz)
                        LiveClassDragDropQuizWidget.board(
                          boardWidth: width,
                          boardHeight: height,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuizControllerBottomBar({
    required LiveClassLiveKitViewModel viewModel,
  }) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: _showQuizControllerBar
            ? LiveCLassBottomActionsWidget.bigClass(
                liveClassMode: viewModel.liveClassMode,
                onSelectedMcqAnswer: _onSelectedMcqButton,
                onSubmitAnswers: _submitQuizAnswers,
              )
            : const SizedBox(height: 8));
  }

  Widget _buildChatWidget(LiveClassLiveKitViewModel viewModel) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
      child: _showChat
          ? LiveClassChatWidget(
              theme: ChatTheme.dark,
              chats: viewModel.chats,
              widthType: ChatWidthType.percentage,
              connected: true,
              isRestricted: false,
              inputController: viewModel.controller,
              onSendChat: (content) {},
              onClose: _toggleChatWidget,
            )
          : const SizedBox(width: 8),
    );
  }

  Widget _buildActionsOverlay(BuildContext context) {
    return GestureDetector(
      onTap: _toggleActionsOverlayView,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        color: Colors.black.withOpacity(0.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildLiveClassName()),
            Spacings.horSpace(16),
            _buildMainActions(),
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
          width: 32,
          height: 32,
        ),
        Spacings.horSpace(8),
        Expanded(
          child: Text(
            'P3 Live Class Name Live Class Name Live Class Name Live Class Name',
            style: GCTextStyle.largeTitle2(
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
          onTap: () {},
          child: SvgPicture.asset(
            Images.icPlay,
            width: 32,
            height: 32,
          ),
        ),
        Spacings.horSpace(8),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            Images.icPlay,
            width: 32,
            height: 32,
          ),
        ),
        Spacings.horSpace(8),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            Images.icPlay,
            width: 32,
            height: 32,
          ),
        ),
        Spacings.horSpace(8),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            Images.icPlay,
            width: 32,
            height: 32,
            colorFilter: const ColorFilter.mode(
              GCColors.navyBlue,
              BlendMode.srcIn,
            ),
          ),
        ),
        Spacings.horSpace(8),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            GCColors.apricotOrange,
          ),
        ),
      ),
    );
  }

  //General UI
  void _toggleQuizControllerBarWidget() {
    _showQuizControllerBar = !_showQuizControllerBar;
    setState(() {});
  }

  void _toggleChatWidget() {
    _showChat = !_showChat;
    setState(() {});
  }

  void _toggleActionsOverlayView() {
    _showActionsOverlay = !_showActionsOverlay;
    if (_showActionsOverlay) {
      _overlayController.show();
    } else {
      _overlayController.hide();
    }
  }
  //General UI

  //Dialog
  void _showWelcomeDialog() {
    showCustomDialog(
      context: context,
      barrierDismissible: true,
      child: CustomDialog.confirmation(
        context,
        label: 'Welcome to GenieClass',
        positiveLabel: 'Continue',
        negativeLabel: 'Leave Class',
        positiveCallback: () {
          Navigator.pop(context);
        },
        negativeCallback: () => Navigator.pop(context),
      ),
    );
  }
  //Dialog

  //In-Class Quiz
  void _onSelectedMcqButton(String option, bool selected) {}

  void _submitQuizAnswers(LiveClassMode quizMode, String answers) {
    if (quizMode == LiveClassMode.normal) return;
  }
  //In-Class Quiz
}
