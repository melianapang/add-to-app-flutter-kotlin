import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/live_class_channel_service.dart';
import 'package:genieclass_streaming_mobile/ui/views/live_class/camera_preview_view.dart';
import 'package:genieclass_streaming_mobile/view_models/view_model.dart';
import 'package:rxdart/rxdart.dart';

class CameraPreviewViewModel extends BaseViewModel {
  CameraPreviewViewModel({
    required LiveClassChannelService liveClassChannelService,
  }) : _liveClassChannelService = liveClassChannelService;

  final LiveClassChannelService _liveClassChannelService;

  late CameraPreviewViewParam _param;
  CameraPreviewViewParam get param => _param;

  bool _arePremissionsGranted = false;
  bool get arePremissionsGranted => _arePremissionsGranted;

  bool _isLoadingData = true;
  bool get isLoadingData => _isLoadingData;

  //Method Channel
  BehaviorSubject<CameraPreviewViewParam> get _behaviorSubject =>
      _liveClassChannelService.smallLiveClassSubject;
  //Method Channel

  void init() async {
    // _behaviorSubject.stream.listen((data) async {
    //   _param = data;
    //   _isLoadingData = false;
    //  notify();
    // });

    _param = CameraPreviewViewParam(
      className: 'NAMA KELAS',
      onlineLessonId: '22648',
      meetingId: '32881000022648',
      levelId: '2',
      subjectId: '19',
      wsUrl: 'wss://livekit-01.dev.geniebook.dev',
    );
    _isLoadingData = false;
    notify();
  }

  void setPermissionsStatus({
    required bool granted,
  }) {
    _arePremissionsGranted = granted;
    notify();
  }
}
