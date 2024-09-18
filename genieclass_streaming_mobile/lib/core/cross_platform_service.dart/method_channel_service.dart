import 'package:flutter/services.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/live_class_channel_service.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/shared_pref/authentication_shared_pref_service.dart';

abstract class MethodChannelService {
  MethodChannelService();

  static const String engineId = 'genieclass_stream_engine';

  late MethodChannel _methodChannel;
  MethodChannel get methodChannel => _methodChannel;

  void initMethodChannel({
    required MethodChannelUsage usage,
    required Future<void> Function(MethodCall) handler,
  }) {
    _methodChannel = MethodChannel(usage.channelName);
    _methodChannel.setMethodCallHandler(handler);
  }

  void invokeMethod({
    required String label,
    dynamic data,
  }) {
    _methodChannel.invokeMethod(label, data);
  }

  void disposeMethodChannel() {
    _methodChannel.setMethodCallHandler(null);
  }
}

enum MethodChannelUsage {
  liveClass('genieclass_live_class_channel'),
  authentication('genieclass_authentication_channel');

  const MethodChannelUsage(
    this.channelName,
  );
  final String channelName;
}

extension MethodCallExtension on MethodCall {
  static const Map<String, LiveClassMethodChannelLabels> _liveClassEnums =
      <String, LiveClassMethodChannelLabels>{
    'liveClassParam': LiveClassMethodChannelLabels.liveClassParam,
    'smallLiveClassParam': LiveClassMethodChannelLabels.smallLiveClassParam,
  };

  LiveClassMethodChannelLabels get liveClassMethodEnum =>
      _liveClassEnums[method] ?? LiveClassMethodChannelLabels.none;

  static const Map<String, AuthenticationSharedPrefLabel> _authMethodEnums =
      <String, AuthenticationSharedPrefLabel>{
    'authenticationKeys': AuthenticationSharedPrefLabel.authenticationKeys,
    'apiKey': AuthenticationSharedPrefLabel.apiKey,
    'uid': AuthenticationSharedPrefLabel.uid,
    'mcsToken': AuthenticationSharedPrefLabel.mcsToken,
  };

  AuthenticationSharedPrefLabel get authMethodEnum =>
      _authMethodEnums[method] ?? AuthenticationSharedPrefLabel.none;
}
