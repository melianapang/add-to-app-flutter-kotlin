import 'package:flutter/services.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/method_channel_service.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/shared_pref/cross_platform_shared_pref_service.dart';
import 'package:genieclass_streaming_mobile/core/services/shared_pref_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final authenticationSharedPrefProvider =
    Provider<AuthenticationSharedPrefService>(
  (ref) => AuthenticationSharedPrefService(
    sharedPreferencesService: ref.read(sharedPrefProvider),
  ),
);

class AuthenticationSharedPrefService extends CrossPlatformSharedPrefService {
  AuthenticationSharedPrefService({
    required SharedPreferencesService sharedPreferencesService,
  }) : super(
          sharedPreferencesService: sharedPreferencesService,
        ) {
    _initMethodChannel();
  }

  //Stream Data
  BehaviorSubject<String> apiKeySubject = BehaviorSubject();
  BehaviorSubject<String> uidSubject = BehaviorSubject();
  BehaviorSubject<String> userIdSubject = BehaviorSubject();
  BehaviorSubject<String> mcsTokenSubject = BehaviorSubject();
  BehaviorSubject<String> mcsUidSubject = BehaviorSubject();
  BehaviorSubject<String> mcsUserIdSubject = BehaviorSubject();
  //Stream Data

  void _initMethodChannel() {
    initMethodChannel(
      usage: MethodChannelUsage.authentication,
      handler: _handler,
    );
  }

  Future<void> _handler(MethodCall call) async {
    switch (call.authMethodEnum) {
      case AuthenticationSharedPrefLabel.authenticationKeys:
        _handleAuthorizationKeys(call);

      case AuthenticationSharedPrefLabel.apiKey:
        _handleApiKeyParam(call);

      case AuthenticationSharedPrefLabel.uid:
        _handleUidParam(call);

      case AuthenticationSharedPrefLabel.mcsToken:
        _handleMcsTokenParam(call);

      case AuthenticationSharedPrefLabel.none:
      default:
    }
  }

  Future<void> _handleAuthorizationKeys(MethodCall call) async {
    final apiKey = call.arguments['apiKey'];
    final mcsToken = call.arguments['mcsToken'];
    final uid = call.arguments['uid'];

    if (apiKey != null) {
      await saveUsingStringKey(
        key: AuthenticationSharedPrefLabel.apiKey.name,
        data: apiKey,
      );
      apiKeySubject.sink.add(apiKey);
    }

    if (mcsToken != null) {
      await saveUsingStringKey(
        key: AuthenticationSharedPrefLabel.mcsToken.name,
        data: mcsToken,
      );
      mcsTokenSubject.sink.add(mcsToken);
    }

    if (uid != null) {
      await saveUsingStringKey(
        key: AuthenticationSharedPrefLabel.uid.name,
        data: uid,
      );
      uidSubject.sink.add(uid);
    }
  }

  Future<void> _handleApiKeyParam(MethodCall call) async {
    final apiKey = call.arguments['apiKey'];
    await saveUsingStringKey(
      key: AuthenticationSharedPrefLabel.apiKey.name,
      data: apiKey,
    );
    apiKeySubject.sink.add(apiKey);
  }

  Future<void> _handleUidParam(MethodCall call) async {
    final uid = call.arguments['uid'];

    await saveUsingStringKey(
      key: AuthenticationSharedPrefLabel.uid.name,
      data: uid,
    );
    apiKeySubject.sink.add(uid);
  }

  Future<void> _handleMcsTokenParam(MethodCall call) async {
    final String? mcsToken = call.arguments['mcsToken'];
    if (mcsToken == null || mcsToken.isEmpty) return;

    await saveUsingStringKey(
      key: AuthenticationSharedPrefLabel.mcsToken.name,
      data: mcsToken,
    );
    apiKeySubject.sink.add(mcsToken);
  }
}

enum AuthenticationSharedPrefLabel {
  authenticationKeys,
  apiKey,
  uid,
  mcsToken,
  none;
}
