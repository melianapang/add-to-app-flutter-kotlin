import 'dart:io';
import 'package:dio/dio.dart';
import 'package:genieclass_streaming_mobile/core/constants/env.dart';
import 'package:genieclass_streaming_mobile/core/cross_platform_service.dart/shared_pref/authentication_shared_pref_service.dart';
import 'package:genieclass_streaming_mobile/core/dio/interceptors/validation_interceptor.dart';
import 'package:genieclass_streaming_mobile/core/services/alice_service.dart';
import 'package:genieclass_streaming_mobile/core/dio/dio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final generalDioProvider =
    Provider<GeneralDioService>((ProviderRef<GeneralDioService> ref) {
  final DioServiceErrorHandler dioServiceErrorHandler = ref.watch(
    dioServiceErrorHandlerProvider,
  );

  return GeneralDioService(
    aliceService: ref.watch(aliceCoreProvider),
    dioServiceErrorHandler: dioServiceErrorHandler,
    authenticationService: ref.watch(authenticationSharedPrefProvider),
  );
});

class GeneralDioService extends DioService {
  GeneralDioService({
    required AliceService aliceService,
    required DioServiceErrorHandler dioServiceErrorHandler,
    required AuthenticationSharedPrefService authenticationService,
  })  : _authenticationService = authenticationService,
        super(
          aliceService: aliceService,
          dioServiceErrorHandler: dioServiceErrorHandler,
        );

  final AuthenticationSharedPrefService _authenticationService;

  Dio getDio() {
    final Dio baseDio = makeBaseDio();

    return baseDio
      ..options.baseUrl = EnvConstants.baseURL
      ..options.headers.addAll(<String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json',
      })
      ..interceptors.add(
        GeneralValidationInterceptor(
          authenticationService: _authenticationService,
        ),
      );
  }
}
