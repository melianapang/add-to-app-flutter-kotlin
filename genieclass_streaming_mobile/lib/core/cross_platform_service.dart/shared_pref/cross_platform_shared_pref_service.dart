import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/method_channel_service.dart';
import 'package:genieclass_streaming_mobile/core/services/shared_pref_service.dart';

abstract class CrossPlatformSharedPrefService extends MethodChannelService {
  CrossPlatformSharedPrefService({
    required SharedPreferencesService sharedPreferencesService,
  }) : _sharedPreferencesService = sharedPreferencesService;

  final SharedPreferencesService _sharedPreferencesService;

  ///Get the data to Flutter's shared-preference
  Future<String> get({
    required SharedPrefKeys key,
  }) async {
    return await _sharedPreferencesService.get(key) ?? '';
  }

  ///To set the data to Flutter's shared-preference
  ///Use [SharedPrefKeys] as the label
  Future<void> saveUsingSharedPrefKey({
    required SharedPrefKeys key,
    required String data,
  }) async {
    await _sharedPreferencesService.set(key, data);
  }

  ///To set the data to Flutter's shared-preference
  ///Use string as the label
  Future<void> saveUsingStringKey({
    required String key,
    required String data,
  }) async {
    await _sharedPreferencesService.set(_sharedPrefKey(key), data);
  }

  ///To set the data to other platform (Kotlin/Swift)
  void send({
    required String label,
    dynamic data,
  }) {
    methodChannel.invokeMethod(label, data);
  }

  ///To set the data to Flutter's shared-preference, then send to other platform (Kotlin/Swift)
  ///Use [SharedPrefKeys] as the label
  Future<void> saveAndSend({
    required String label,
    dynamic data,
  }) async {
    await saveUsingStringKey(key: label, data: data);
    send(label: label, data: data);
  }

  //Mapping
  final Map<String, SharedPrefKeys> _sharedPrefKeys = <String, SharedPrefKeys>{
    SharedPrefKeys.apiKey.label: SharedPrefKeys.apiKey,
    SharedPrefKeys.uid.label: SharedPrefKeys.uid,
    SharedPrefKeys.userId.label: SharedPrefKeys.userId,
    SharedPrefKeys.mcsToken.label: SharedPrefKeys.mcsToken,
    SharedPrefKeys.mcsUserId.label: SharedPrefKeys.mcsUserId,
  };

  SharedPrefKeys _sharedPrefKey(String value) =>
      _sharedPrefKeys[value] ?? SharedPrefKeys.none;
  //Mapping
}
