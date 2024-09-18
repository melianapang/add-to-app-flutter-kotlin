import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/live_class_channel_service.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/dto/chat_dto.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/stream_api_service.dart';
import 'package:genieclass_streaming_mobile/core/models/live_class/live_class_model.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/camera_preview_view.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/small_live_class_livekit_view.dart';
import 'package:genieclass_streaming_mobile/view_models/view_model.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:livekit_client/src/types/other.dart' as LivekitOtherUtils;
import 'package:rxdart/rxdart.dart';

class SmallLiveClassLiveKitViewModel extends BaseViewModel {
  SmallLiveClassLiveKitViewModel({
    required LiveClassChannelService liveClassChannelService,
    required StreamApiService streamApiService,
  })  : _liveClassChannelService = liveClassChannelService,
        _streamApiService = streamApiService;

  final LiveClassChannelService _liveClassChannelService;
  final StreamApiService _streamApiService;

  late SmallLiveClassLivekitViewParam _param;
  SmallLiveClassLivekitViewParam get param => _param;

  final TextEditingController controller = TextEditingController();

  //UI
  LiveClassMode liveClassMode = LiveClassMode.normal;
  //UI

  //LiveKit
  Room? _room;
  Room? get room => _room;
  EventsListener<RoomEvent>? _roomListener;
  EventsListener<RoomEvent>? get roomListener => _roomListener;
  //LiveKit

  //Chat
  List<HistoryChat> _chats = [];
  List<HistoryChat> get chats => _chats;
  //Chat

  //Method Channel
  BehaviorSubject<CameraPreviewViewParam> get _behaviorSubject =>
      _liveClassChannelService.smallLiveClassSubject;
  //Method Channel

  @override
  Future<void> disposeModel() async {
    _roomListener?.dispose();
    _room?.disconnect();
  }

  void init(
    SmallLiveClassLivekitViewParam? param,
  ) async {
    _behaviorSubject.stream.listen((data) async {
      _param = SmallLiveClassLivekitViewParam(
        onlineLessonId: '22648',
        meetingId: '32881000022648',
        levelId: data.levelId,
        subjectId: data.subjectId,
        wsUrl: data.wsUrl,
      );
      await requestToken();
      initChat();
    });

    // _param = SmallLiveClassLivekitViewParam(
    //   onlineLessonId: '22648',
    //   meetingId: '32881000022648',
    //   levelId: '9',
    //   subjectId: '19',
    //   wsUrl: "wss://livekit-01.dev.geniebook.dev",
    // );
    // await requestToken();
    // initChat();
  }

  //LiveKit
  Future<void> requestToken() async {
    final response = await _streamApiService.requestLiveKitToken(
      name: "Meliana",
      duration: 400,
      isAdmitted: true,
      isSmallClass: true,
      meetingId: _param.meetingId,
    );

    if (response.isRight) {
      _setupRoom(token: response.right);
    }
  }

  void _setupRoom({
    required String token,
  }) {
    if (_room != null &&
        (_room?.connectionState ==
                LivekitOtherUtils.ConnectionState.connected ||
            _room?.connectionState ==
                LivekitOtherUtils.ConnectionState.connecting)) {
      return;
    }

    _room = Room(
      roomOptions: const RoomOptions(
        adaptiveStream: false,
        dynacast: true,
        defaultAudioOutputOptions: AudioOutputOptions(speakerOn: true),
        defaultAudioCaptureOptions: AudioCaptureOptions(),
        defaultAudioPublishOptions: AudioPublishOptions(),
        defaultVideoPublishOptions: VideoPublishOptions(),
      ),
    );

    try {
      _room?.connect(
        _param.wsUrl,
        token,
        connectOptions: const ConnectOptions(
          autoSubscribe: true,
        ),
      );

      _room?.localParticipant?.setCameraEnabled(true);
      _room?.localParticipant?.setMicrophoneEnabled(false);

      _observeToRoomEvents();
    } catch (error) {}
  }

  void _observeToRoomEvents() {
    Room? room = _room;
    if (room == null) return;

    _roomListener = room.createListener();

    EventsListener<RoomEvent>? roomListener = _roomListener;
    if (roomListener == null) return;

    roomListener
      ..on<RoomConnectedEvent>((e) => notify())
      ..on<ParticipantConnectedEvent>(_onRemoteParticipantConnected)
      ..on<DataReceivedEvent>(
        (e) => classifyTopicData(roomEvent: e),
      );
  }

  void _onRemoteParticipantConnected(ParticipantConnectedEvent event) {
    notify();
  }

  void classifyTopicData({
    required DataReceivedEvent roomEvent,
  }) {
    String? data = roomEvent.topic;
    if (data == null || data.isEmpty) return;

    print("object:::: ${roomEvent.data}");

    // switch (data) {
    //   case "class-state":
    //   case "chat":
    //   case "quiz-event":
    //   case "traffic-light":
    //   case "spotlight":
    //   default:
    //     return;
    // }
  }

  bool isMicrophoneEnabled() {
    return _room?.localParticipant?.isMicrophoneEnabled() == true;
  }

  void enableMicrophone() {
    bool isEnabled = _room?.localParticipant?.isMicrophoneEnabled() == true;
    _room?.localParticipant?.setMicrophoneEnabled(!isEnabled);
  }
  //LiveKit

  //Chat
  Future<void> initChat() async {
    final response = await _streamApiService.fetchHistoryChat(
      onlineLessonId: _param.onlineLessonId,
    );

    if (response.isRight) {
      _chats = response.right;
      notify();
    }
  }
  //Chat

  //DataChannel
  void updateClassState() {}

  void addNewChat() {}

  void triggerInClassQuiz() {}

  void triggerTrafficLight() {}

  void triggerSpotlight() {}
  //Data Channel
}
