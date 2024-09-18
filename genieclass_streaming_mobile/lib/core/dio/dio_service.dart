import 'dart:async';
import 'package:alice_lightweight/core/alice_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:genieclass_streaming_mobile/core/constants/env.dart';
import 'package:genieclass_streaming_mobile/core/services/alice_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class DioService {
  DioService({
    required AliceService aliceService,
    required DioServiceErrorHandler dioServiceErrorHandler,
  })  : _dioServiceErrorHandler = dioServiceErrorHandler,
        _aliceService = aliceService;

  static CancelToken _cancelToken = CancelToken();
  static const int _timeOut = 20000;

  Map<String, int> retryCounter = <String, int>{};

  final AliceService _aliceService;
  final DioServiceErrorHandler _dioServiceErrorHandler;

  Dio makeBaseDio() {
    return Dio()
      ..options.baseUrl = EnvConstants.baseURL
      ..options.responseType = ResponseType.json
      ..options.connectTimeout = const Duration(
        milliseconds: _timeOut,
      )
      ..options.sendTimeout = const Duration(
        milliseconds: _timeOut,
      )
      ..options.receiveTimeout = const Duration(
        milliseconds: _timeOut,
      )
      ..interceptors.addAll(
        <Interceptor>[
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            error: true,
            request: true,
            responseHeader: true,
          ),
          AliceDioInterceptor(
            _aliceService.aliceCore,
          ),
        ],
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (
            RequestOptions option,
            RequestInterceptorHandler handler,
          ) async {
            option.cancelToken = _cancelToken;

            return handler.next(option);
          },
          onError: (
            DioException error,
            ErrorInterceptorHandler handler,
          ) {
            // if (error.type == DioExceptionType.badResponse) {
            // return handler.resolve(error.response!);
            // }
            return handler.next(error);
          },
        ),
      );
  }

  dynamic _onDioError(
    DioException e,
    ErrorInterceptorHandler h,
  ) async {
    _dioServiceErrorHandler.dioError = e;

    if (e.response != null) {
      return h.resolve(e.response!);
    }

    return h.next(e);
  }

  void cancelAllRequest() {
    _cancelToken.cancel('MANUAL CANCEL');
    _cancelToken = CancelToken();
  }

  dynamic _onDioWithStaticTokenError(
    DioException e,
    ErrorInterceptorHandler h, {
    void Function()? logout,
  }) async {
    _dioServiceErrorHandler.dioError = e;

    if (e.response != null) {
      if (e.response?.statusCode == 401) {
        logout?.call();
      }

      return h.resolve(e.response!);
    }

    return h.next(e);
  }
}

final Provider<DioServiceErrorHandler> dioServiceErrorHandlerProvider =
    Provider<DioServiceErrorHandler>((ProviderRef<DioServiceErrorHandler> ref) {
  return DioServiceErrorHandler();
});

class DioServiceErrorHandler {
  final StreamController<DioException> _onChangedDioException =
      StreamController<DioException>.broadcast();

  Stream<DioException> get _dioErrorStream => _onChangedDioException.stream;

  StreamSubscription<DioException>? _dioErrorSubscription;

  void close() {
    if (_counterLimitListener.length > _limitListener) {
      _counterLimitListener.removeLast();
      _dioErrorSubscription!.cancel();
    }
  }

  static const _limitListener = 1;
  final List<int> _counterLimitListener = [];

  void listen(Function(DioException dioError) callback) {
    if (_counterLimitListener.length < _limitListener) {
      _dioErrorSubscription = _dioErrorStream.listen(
        (DioException event) {
          callback(event);
        },
      );
      _counterLimitListener.add(1);
    }
  }

  set dioError(DioException dioError) {
    _onChangedDioException.add(dioError);
  }
}
