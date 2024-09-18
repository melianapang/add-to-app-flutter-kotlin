import 'package:alice_lightweight/core/alice_core.dart';
import 'package:alice_lightweight/ui/page/alice_calls_list_screen.dart';
import 'package:alice_lightweight/utils/alice_custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/constants/env.dart';
import 'package:genieclass_streaming_mobile/core/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aliceCoreProvider = Provider<AliceService>((ref) {
  // final navigationService = ref.watch(navigationProvider);
  return AliceService(
      // navigationService.navigatorKey,
      );
});

class AliceService {
  AliceService() {
    bool enableAlice = false;

    switch (EnvConstants.env) {
      case EnvironmentEnum.staging:
        enableAlice = true;
        break;
      case EnvironmentEnum.production:
        enableAlice = false;
        break;
      default:
    }

    _aliceCore = AliceCore(
      navigatorKey,
      const AliceCustomColors(),
    );

    if (enableAlice) {
      // ShakeDetector.autoStart(
      //   onPhoneShake: _aliceCore.navigateToCallListScreen,
      // );
    }
  }
  late AliceCore _aliceCore;
  AliceCore get aliceCore => _aliceCore;

  bool _isInspectorOpened = false;

  void navigateToCallListScreen() {
    final BuildContext? context = _aliceCore.getContext();
    if (context != null && !_isInspectorOpened) {
      _isInspectorOpened = true;
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AliceCallsListScreen(
            _aliceCore,
            const AliceCustomColors(),
          ),
        ),
      ).then((_) => _isInspectorOpened = false);
    }
  }
}
