import 'dart:io';

import 'package:dio/dio.dart';
import 'package:genieclass_streaming_mobile/core/constants/env.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/shared_pref/authentication_shared_pref_service.dart';
import 'package:genieclass_streaming_mobile/core/dio/interceptors/token_interceptor.dart';
import 'package:genieclass_streaming_mobile/core/services/alice_service.dart';
import 'package:genieclass_streaming_mobile/core/dio/dio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersDioProvider =
    Provider<UsersDioService>((ProviderRef<UsersDioService> ref) {
  final AuthenticationSharedPrefService authenticationService =
      ref.watch(authenticationSharedPrefProvider);
  final AliceService aliceService = ref.watch(aliceCoreProvider);
  final DioServiceErrorHandler dioServiceErrorHandler = ref.watch(
    dioServiceErrorHandlerProvider,
  );

  return UsersDioService(
    authenticationService: authenticationService,
    aliceService: aliceService,
    dioServiceErrorHandler: dioServiceErrorHandler,
  );
});

class UsersDioService extends DioService {
  UsersDioService({
    required AuthenticationSharedPrefService authenticationService,
    required AliceService aliceService,
    required DioServiceErrorHandler dioServiceErrorHandler,
  })  : _authenticationService = authenticationService,
        super(
          aliceService: aliceService,
          dioServiceErrorHandler: dioServiceErrorHandler,
        );

  final AuthenticationSharedPrefService _authenticationService;

  Dio getDio() {
    final Dio baseDio = makeBaseDio();

    return baseDio
      ..options.baseUrl = EnvConstants.streamBaseURL
      ..options.headers.addAll(<String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
      })
      ..interceptors.add(
        AuthorizationTokenInterceptor(
          dio: baseDio,
          authenticationService: _authenticationService,
        ),
      );
  }
}
