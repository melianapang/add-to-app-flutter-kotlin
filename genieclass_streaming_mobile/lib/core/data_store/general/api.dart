import 'package:dio/dio.dart';
import 'package:genieclass_streaming_mobile/core/data_store/general/dto/auth_token_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @POST('user/refresh_token/json')
  Future<HttpResponse<dynamic>> requestAuthToken(
    @Body() RefreshAuthTokenRequest payload,
  );
}
