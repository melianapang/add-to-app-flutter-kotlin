import 'package:dio/dio.dart';
import 'package:genieclass_streaming_mobile/core/data_store/general/api.dart';
import 'package:genieclass_streaming_mobile/core/dio/api_dio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider<ApiService>((ProviderRef<ApiService> ref) {
  return ApiService(
    dio: ref.read(generalDioProvider).getDio(),
  );
});

class ApiService {
  ApiService({
    required this.dio,
  }) : _api = Api(
          dio,
        );
  final Dio dio;
  final Api _api;
}
