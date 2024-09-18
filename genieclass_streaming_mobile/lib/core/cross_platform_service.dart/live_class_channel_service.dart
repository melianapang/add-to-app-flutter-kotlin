import 'package:flutter/services.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/method_channel_service.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/camera_preview_view.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/live_class_livekit_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

final liveClassChannelService = Provider<LiveClassChannelService>(
  (_) => LiveClassChannelService(),
);

class LiveClassChannelService extends MethodChannelService {
  LiveClassChannelService() {
    _initMethodChannel();
  }

  //Stream Data
  BehaviorSubject<LiveClassLiveKitViewParam> liveClassSubject =
      BehaviorSubject();
  BehaviorSubject<CameraPreviewViewParam> smallLiveClassSubject =
      BehaviorSubject();
  //Stream Data

  void _initMethodChannel() {
    initMethodChannel(
      usage: MethodChannelUsage.liveClass,
      handler: _handler,
    );
  }

  Future<void> _handler(MethodCall call) async {
    print("HIIII LiveClassChannelService ${call.method} ${call.arguments}");
    switch (call.liveClassMethodEnum) {
      case LiveClassMethodChannelLabels.liveClassParam:
        _handleLiveClassParam(call);
      case LiveClassMethodChannelLabels.smallLiveClassParam:
        _handleSmallLiveClassParam(call);
      case LiveClassMethodChannelLabels.none:
      default:
    }
  }

  void _handleLiveClassParam(MethodCall call) {
    LiveClassLiveKitViewParam param = LiveClassLiveKitViewParam(
      onlineLessonId: call.arguments["onlineLessonId"] ?? "",
      meetingId: call.arguments["meetingId"] ?? "",
      subjectId: call.arguments["subjectId"] ?? "",
      levelId: call.arguments["levelId"] ?? "",
      wsUrl: call.arguments["wsUrl"] ?? "",
    );

    liveClassSubject.sink.add(param);
  }

  void _handleSmallLiveClassParam(MethodCall call) {
    CameraPreviewViewParam param = CameraPreviewViewParam(
      className: call.arguments["className"],
      onlineLessonId: call.arguments["onlineLessonId"] ?? "",
      meetingId: call.arguments["meetingId"] ?? "",
      subjectId: call.arguments["subjectId"] ?? "",
      levelId: call.arguments["levelId"] ?? "",
      wsUrl: call.arguments["wsUrl"] ?? "",
    );

    smallLiveClassSubject.sink.add(param);
  }
}

enum LiveClassMethodChannelLabels {
  liveClassParam,
  smallLiveClassParam,
  none,
}
