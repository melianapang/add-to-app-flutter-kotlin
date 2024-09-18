import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'users_api.g.dart';

@RestApi()
abstract class UsersApi {
  factory UsersApi(Dio dio, {String baseUrl}) = _UsersApi;

  @GET("teachers/{user_id}")
  Future<HttpResponse<dynamic>> fetchTeacherDetailsById(
    @Path("user_id") String userId,
  );
}
