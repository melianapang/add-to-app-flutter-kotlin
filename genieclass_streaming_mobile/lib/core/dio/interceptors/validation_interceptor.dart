import 'package:dio/dio.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/shared_pref/authentication_shared_pref_service.dart';
import 'package:genieclass_streaming_mobile/core/services/shared_pref_service.dart';

class GeneralValidationInterceptor extends InterceptorsWrapper {
  GeneralValidationInterceptor({
    required AuthenticationSharedPrefService authenticationService,
  }) : _authenticationService = authenticationService;

  final AuthenticationSharedPrefService _authenticationService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final apiKey = await _authenticationService.get(key: SharedPrefKeys.apiKey);
    final uid = await _authenticationService.get(key: SharedPrefKeys.uid);

    options.headers.addAll(<String, dynamic>{
      // 'api-key': apiKey,
      // 'UID': uid,
      'api-key': 'dcE6iUtu4b80ENV50Mje80B3Ze2jq8',
      'UID': '15C17EE504BBA7A561CFEDB873DC0216',
    });

    handler.next(options);
  }
}
