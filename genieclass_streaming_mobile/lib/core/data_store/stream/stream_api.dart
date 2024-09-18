import 'package:dio/dio.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/dto/chat_dto.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/dto/livekit_stream_dto.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/dto/traffic_light_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'stream_api.g.dart';

@RestApi()
abstract class StreamApi {
  factory StreamApi(Dio dio, {String baseUrl}) = _StreamApi;

  //LiveKit
  @POST('stream/generate-token')
  Future<HttpResponse<dynamic>> requestLiveKitToken(
    @Body() LiveKitTokenRequest payload,
  );

  @POST('stream/{online_lesson_id}')
  Future<HttpResponse<dynamic>> fetchLatestMetaData(
    @Path("online_lesson_id") String onlineLessonId,
  );

  @POST("event/trigger")
  Future<HttpResponse<dynamic>> triggerLiveKitEvent(
    @Body() LiveKitEventRequest payload,
  );
  //LiveKit

  //Chat
  @GET("chat/student")
  Future<HttpResponse<dynamic>> fetchHistoryChat(
    @Query("online_class_id") String onlineLessonId,
  );

  @POST("chat/send")
  Future<HttpResponse<dynamic>> sendChat(
    @Body() SendChatRequest payload,
  );
  //Chat

  //Traffic-Light
  @POST("feedback/traffic-light")
  Future<HttpResponse<dynamic>> setTrafficLightAttempt(
    @Body() SetTrafficLightRequest payload,
  );

  @GET("feedback/traffic-light/student/{online_lesson_id}/{session_id}")
  Future<HttpResponse<dynamic>> fetchTrafficLight(
    @Path("online_lesson_id") String onlineLessonId,
    @Path("session_id") String sessionId,
  );
  //Traffic-Light
}
