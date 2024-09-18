import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:genieclass_streaming_mobile/core/constants/env.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/shared_pref/authentication_shared_pref_service.dart';
import 'package:genieclass_streaming_mobile/core/data_store/general/dto/auth_token_dto.dart';
import 'package:genieclass_streaming_mobile/core/services/shared_pref_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthorizationTokenInterceptor extends InterceptorsWrapper {
  AuthorizationTokenInterceptor({
    required Dio dio,
    required AuthenticationSharedPrefService authenticationService,
  })  : _dio = dio,
        _authenticationService = authenticationService;

  final Dio _dio;
  final AuthenticationSharedPrefService _authenticationService;
  String? accessToken;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _authenticationService.get(
      key: SharedPrefKeys.mcsToken,
    );
    options.headers.addAll(<String, dynamic>{
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    });
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.type == DioExceptionType.badResponse || tokenInvalidResponse(err)) {
      await refreshAndRedoRequest(err, handler);
    } else {
      return handler.reject(err);
    }
  }

  /// Refreshes access token, sets it to header, and resolves cloned request of the original.
  Future<void> refreshAndRedoRequest(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final bool succeed = await getAndSetAccessTokenVariable();
    if (!succeed) {
      handler.reject(error);
      return;
    }

    /// Redo hit endpoint and resolve
    handler.resolve(
      await _dio.request(
        error.requestOptions.path,
        data: error.requestOptions.data,
        options: Options(
          method: error.requestOptions.method,
          headers: <String, dynamic>{
            HttpHeaders.authorizationHeader: 'Bearer $accessToken',
          },
        ),
      ),
    );
  }

  /// Gets new access token using the device's refresh token and sets it to [accessToken] class field.
  ///
  /// If the refresh token from the device's storage is null or empty, an [EmptyTokenException] is thrown.
  /// This should be handled with care. This means the user has somehow been logged out!
  Future<bool> getAndSetAccessTokenVariable() async {
    try {
      final refreshToken = await _authenticationService.get(
        key: SharedPrefKeys.mcsToken,
      );
      final apiKey = await _authenticationService.get(
        key: SharedPrefKeys.apiKey,
      );
      final uid = await _authenticationService.get(
        key: SharedPrefKeys.uid,
      );

      print(
          "HIIII getAndSetAccessTokenVariable ; $refreshToken ; $apiKey ; $uid");

      final RefreshAuthTokenRequest payload = RefreshAuthTokenRequest(
        refreshToken: refreshToken,
      );

      // New DIO instance so it doesn't get blocked by QueuedInterceptorsWrapper.
      // Refreshes token from endpoint.
      Dio retryDio = Dio(
        BaseOptions(
          baseUrl: EnvConstants.baseURL,
        ),
      )
        ..options.headers.addAll(<String, dynamic>{
          HttpHeaders.contentTypeHeader: 'application/json',
          // 'api-key': apiKey,
          // 'UID': uid,
          'api-key': 'dcE6iUtu4b80ENV50Mje80B3Ze2jq8',
          'UID': '15C17EE504BBA7A561CFEDB873DC0216',
        })
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            error: true,
            request: true,
            responseHeader: true,
          ),
        );

      final Response<dynamic> response = await retryDio.post(
        'user/refresh_token/json',
        data: payload,
        options: Options(
          headers: {"Content-Type": 'application/json'},
        ),
      );

      if (!validStatusCode(response)) {
        return false;
      }

      final responseData = jsonDecode(response.data);
      if (responseData['error'] || responseData['data'] == null) {
        return false;
      }

      final tokenModel = responseData['data'];
      final String token = tokenModel['access_token'] ?? "";

      if (token.isNotEmpty == true) {
        accessToken = token;
        await _authenticationService.saveUsingSharedPrefKey(
          key: SharedPrefKeys.mcsToken,
          data: token,
        );
        return true;
      }

      return false;
    } on DioException catch (_) {
      return false;
    }
  }

  bool tokenInvalidResponse(DioException error) =>
      error.response?.statusCode == 403 || error.response?.statusCode == 401;

  bool validStatusCode(Response response) =>
      response.statusCode == 200 || response.statusCode == 201;
}
