import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:genieclass_streaming_mobile/core/data_store/users/dto/teachers_dto.dart';
import 'package:genieclass_streaming_mobile/core/data_store/users/users_api.dart';
import 'package:genieclass_streaming_mobile/core/dio/users_dio_service.dart';
import 'package:genieclass_streaming_mobile/core/models/parsed_response.dart';
import 'package:genieclass_streaming_mobile/core/utils/error_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';

final usersApiProvider = Provider<UsersApiService>((ref) {
  return UsersApiService(
    dio: ref.watch(usersDioProvider).getDio(),
  );
});

class UsersApiService {
  UsersApiService({
    required this.dio,
  }) : _api = UsersApi(dio);

  final Dio dio;
  final UsersApi _api;

  Future<Either<Failure, TeacherDetailResponse>> fetchTeacherDetailsById({
    required String userId,
  }) async {
    try {
      final HttpResponse<dynamic> response = await _api.fetchTeacherDetailsById(
        userId,
      );

      if (response.isSuccess) {
        return Right<Failure, TeacherDetailResponse>(
          TeacherDetailResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<TeacherDetailResponse>().handleDomainError(response);
    } catch (e) {
      return ErrorUtils<TeacherDetailResponse>().handleError(e);
    }
  }
}
