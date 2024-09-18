import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/live_class_channel_service.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/stream_api_service.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_bottom_actions_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/live_class/live_class_chat_widget.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/classes/participant_video_view.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/dialogs.dart';
import 'package:genieclass_streaming_mobile/view_models/live_class/small_class_livekit_view_model.dart';
import 'package:genieclass_streaming_mobile/view_models/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:genieclass_streaming_mobile/core/models/live_class/live_class_model.dart';
import 'package:livekit_client/src/types/other.dart' as LivekitOtherUtils;

class SmallLiveClassLivekitViewParam {
  SmallLiveClassLivekitViewParam({
    required this.onlineLessonId,
    required this.meetingId,
    required this.levelId,
    required this.subjectId,
    required this.wsUrl,
  });

  final String onlineLessonId;
  final String meetingId;
  final String levelId;
  final String subjectId;
  final String wsUrl;
}

class SmallLiveClassLiveKitView extends ConsumerStatefulWidget {
  const SmallLiveClassLiveKitView({
    super.key,
    this.param,
  });

  final SmallLiveClassLivekitViewParam? param;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SmallLiveClassLiveKitViewState();
}

class _SmallLiveClassLiveKitViewState
    extends ConsumerState<SmallLiveClassLiveKitView> {
  bool _showParticipants = true;
  bool _showActionsBottomBar = true;

  final TextEditingController _chatInputController = TextEditingController();

  LiveClassMode liveClassMode = LiveClassMode.normal;
  LiveClassMode get _liveClassMode {
    if (liveClassMode == LiveClassMode.fitbQuiz ||
        liveClassMode == LiveClassMode.dragDropQuiz) {
      return LiveClassMode.mcqQuiz;
    }
    return liveClassMode;
  }

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
    // _listener.dispose();
    // _room.removeListener(_onRoomStateChanged);
    // _room.disconnect();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModel<SmallLiveClassLiveKitViewModel>(
        model: SmallLiveClassLiveKitViewModel(
          liveClassChannelService: ref.read(liveClassChannelService),
          streamApiService: ref.read(streamApiProvider),
        ),
        onModelReady: (viewModel) {
          viewModel.init(
            widget.param,
          );
        },
        builder: (context, viewModel, _) {
          return GestureDetector(
            onTap: _toggleBottomActionsWidget,
            child: Scaffold(
              backgroundColor: GCColors.navyDark,
              body: Column(
                children: [
                  ...viewModel.room == null ||
                          viewModel.room?.connectionState ==
                              LivekitOtherUtils.ConnectionState.connected
                      ? _buildVideoTracks(viewModel)
                      : _buildLoadingState(),
                  _buildActionsBottomBarWidget(viewModel),
                ],
              ),
            ),
          );
        });
  }

  List<Widget> _buildLoadingState() {
    return [
      const Expanded(
        child: Center(
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              GCColors.apricotOrange,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildVideoTracks(SmallLiveClassLiveKitViewModel viewModel) {
    return [
      _buildParticipantsView(viewModel),
      _buildMainVideoView(viewModel),
    ];
  }

  Widget _buildParticipantsView(SmallLiveClassLiveKitViewModel viewModel) {
    double videoWidth = 120 * 16 / 9;
    final LocalParticipant? localParticipant = viewModel.room?.localParticipant;
    final List<RemoteParticipant>? remoteParticipants =
        viewModel.room?.remoteParticipants.values.toList();
    final int totalParticipants = (remoteParticipants?.length ?? 0) + 1;

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      child: _showParticipants
          ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 4,
              ),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: totalParticipants,
                  itemBuilder: (context, index) {
                    Participant? participant = index == 0
                        ? localParticipant as Participant?
                        : remoteParticipants?[index - 1] as Participant?;

                    if (participant == null) {
                      return const SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        height: 120,
                        width: videoWidth,
                        child: ParticipantVideoView.participant(
                          participant: participant,
                          isLocalParticipant: index == 0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : const SizedBox(
              height: 8,
            ),
    );
  }

  Widget _buildMainVideoView(SmallLiveClassLiveKitViewModel viewModel) {
    List<RemoteParticipant>? participants =
        viewModel.room?.remoteParticipants.values.toList();

    RemoteParticipant? teacher =
        participants?.firstWhere((e) => e.metadata?.contains('2') == true); //?

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
          final double maxHeight = constraints.maxHeight;
          final double width = ((16 / 9) * maxHeight);

          return InteractiveViewer(
            panEnabled: !_showParticipants && !_showActionsBottomBar,
            scaleEnabled: !_showParticipants && !_showActionsBottomBar,
            child: Center(
              child: SizedBox(
                height: maxHeight,
                width: width,
                child: ParticipantVideoView.main(
                  participant: teacher,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionsBottomBarWidget(
    SmallLiveClassLiveKitViewModel viewModel,
  ) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: _showActionsBottomBar
            ? LiveCLassBottomActionsWidget.smallClass(
                liveClassMode: _liveClassMode,
                enabledMic: viewModel.isMicrophoneEnabled() == true,
                onMicEnabled: viewModel.enableMicrophone,
                onUpdateParticipantsView: _toggleParticipantsView,
                onShowChat: _showChatDialog,
                onSelectedMcqAnswer: _onSelectedMcqButton,
                onSubmitAnswers: _submitQuizAnswers,
                onLeaveClass: () => Navigator.pop(context),
              )
            : const SizedBox(height: 8));
  }

  void _toggleBottomActionsWidget() {
    _showActionsBottomBar = !_showActionsBottomBar;
    setState(() {});
  }

  void _toggleParticipantsView() {
    _showParticipants = !_showParticipants;
    setState(() {});
  }

  void _onSelectedMcqButton(String option, bool selected) {}

  void _submitQuizAnswers(LiveClassMode quizMode, String answers) {
    if (quizMode == LiveClassMode.normal) return;
  }

  void _showChatDialog() {
    _chatInputController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog.bottomSheet(
          context,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: LiveClassChatWidget(
            theme: ChatTheme.light,
            chats: const [],
            widthType: ChatWidthType.fullScreen,
            connected: false,
            isRestricted: false,
            inputController: _chatInputController,
            onSendChat: (content) {},
            onClose: () => Navigator.pop(context),
          ),
        );
      },
    );
  }
}
