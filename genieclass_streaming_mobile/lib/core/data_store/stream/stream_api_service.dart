import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/dto/chat_dto.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/dto/livekit_stream_dto.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/dto/traffic_light_dto.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/stream_api.dart';
import 'package:genieclass_streaming_mobile/core/dio/stream_dio_service.dart';
import 'package:genieclass_streaming_mobile/core/models/parsed_response.dart';
import 'package:genieclass_streaming_mobile/core/utils/error_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/dio.dart';

final streamApiProvider = Provider<StreamApiService>((ref) {
  return StreamApiService(
    dio: ref.watch(streamDioProvider).getDio(),
  );
});

class StreamApiService {
  StreamApiService({
    required this.dio,
  }) : _api = StreamApi(dio);

  final Dio dio;
  final StreamApi _api;

  //LiveKit
  Future<Either<Failure, String>> requestLiveKitToken({
    required String meetingId,
    required String name,
    required int duration,
    required bool isSmallClass,
    required bool isAdmitted,
  }) async {
    try {
      final LiveKitTokenRequest payload = LiveKitTokenRequest(
        meetingId: meetingId,
        name: name,
        userType: "1",
        duration: duration,
        isSmallClass: isSmallClass,
        admitted: isAdmitted,
      );

      final HttpResponse<dynamic> response = await _api.requestLiveKitToken(
        payload,
      );

      if (response.isSuccess) {
        return Right<Failure, String>(
          LiveKitTokenResponse.fromJson(
            response.data,
          ).token,
        );
      }
      return ErrorUtils<String>().handleDomainError(response);
    } catch (e) {
      return ErrorUtils<String>().handleError(e);
    }
  }

  Future<Either<Failure, bool>> triggerLiveKitEvent({
    required String onlineLessonId,
    required String meetingId,
    required String eventName,
    required String metadata,
  }) async {
    try {
      final LiveKitEventRequest payload = LiveKitEventRequest(
        onlineLessonId: onlineLessonId,
        meetingId: meetingId,
        eventName: eventName,
        metadata: metadata,
      );

      final HttpResponse<dynamic> response = await _api.triggerLiveKitEvent(
        payload,
      );

      if (response.isSuccess) {
        return const Right<Failure, bool>(true);
      }
      return ErrorUtils<bool>().handleDomainError(response);
    } catch (e) {
      return ErrorUtils<bool>().handleError(e);
    }
  }
  //LiveKit

  //Chat
  Future<Either<Failure, List<HistoryChat>>> fetchHistoryChat({
    required String onlineLessonId,
  }) async {
    try {
      final HttpResponse<dynamic> response = await _api.fetchHistoryChat(
        onlineLessonId,
      );

      if (response.isSuccess) {
        return Right<Failure, List<HistoryChat>>(
          HistoryChatResponse.fromJson(
            response.data,
          ).chats,
        );
      }
      return ErrorUtils<List<HistoryChat>>().handleDomainError(response);
    } catch (e) {
      return ErrorUtils<List<HistoryChat>>().handleError(e);
    }
  }

  Future<Either<Failure, bool>> sendChat({
    required String onlineLessonId,
    required String roomId,
    required String content,
  }) async {
    try {
      final SendChatRequest payload = SendChatRequest(
        onlineLessonId: onlineLessonId,
        roomId: roomId,
        content: content,
        contentType: "text",
        type: "STUDENT_TO_ADMIN",
      );

      final HttpResponse<dynamic> response = await _api.sendChat(
        payload,
      );

      if (response.isSuccess) {
        return const Right<Failure, bool>(true);
      }
      return ErrorUtils<bool>().handleDomainError(response);
    } catch (e) {
      return ErrorUtils<bool>().handleError(e);
    }
  }
  //Chat

  //Traffic Light
  Future<Either<Failure, bool>> setTrafficLightAttempt({
    required String onlineLessonId,
    required String meetingId,
    required String studentId,
    required String teacherId,
    required String sessionId,
    required String rating,
  }) async {
    try {
      final SetTrafficLightRequest payload = SetTrafficLightRequest(
        onlineLessonId: onlineLessonId,
        roomId: meetingId,
        studentId: studentId,
        teacherId: teacherId,
        sessionId: sessionId,
        rating: rating,
      );

      final HttpResponse<dynamic> response = await _api.setTrafficLightAttempt(
        payload,
      );

      if (response.isSuccess) {
        return const Right<Failure, bool>(true);
      }
      return ErrorUtils<bool>().handleDomainError(response);
    } catch (e) {
      return ErrorUtils<bool>().handleError(e);
    }
  }

  Future<Either<Failure, TrafficLightResponse>> fetchTrafficLight({
    required String onlineLessonId,
    required String sessionId,
  }) async {
    try {
      final HttpResponse<dynamic> response = await _api.fetchTrafficLight(
        onlineLessonId,
        sessionId,
      );

      if (response.isSuccess) {
        return Right<Failure, TrafficLightResponse>(
          TrafficLightResponse.fromJson(
            response.data,
          ),
        );
      }
      return ErrorUtils<TrafficLightResponse>().handleDomainError(response);
    } catch (e) {
      return ErrorUtils<TrafficLightResponse>().handleError(e);
    }
  }
  //Traffic Light
}
