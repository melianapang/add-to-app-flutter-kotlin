// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livekit_stream_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveKitTokenRequest _$LiveKitTokenRequestFromJson(Map<String, dynamic> json) =>
    LiveKitTokenRequest(
      meetingId: json['room_id'] as String,
      name: json['name'] as String,
      userType: json['user_type'] as String,
      duration: (json['duration'] as num).toInt(),
      isSmallClass: json['is_small_class'] as bool,
      admitted: json['admitted'] as bool,
    );

Map<String, dynamic> _$LiveKitTokenRequestToJson(
        LiveKitTokenRequest instance) =>
    <String, dynamic>{
      'room_id': instance.meetingId,
      'name': instance.name,
      'user_type': instance.userType,
      'duration': instance.duration,
      'is_small_class': instance.isSmallClass,
      'admitted': instance.admitted,
    };

LiveKitTokenResponse _$LiveKitTokenResponseFromJson(
        Map<String, dynamic> json) =>
    LiveKitTokenResponse(
      token: json['token'] as String,
    );

Map<String, dynamic> _$LiveKitTokenResponseToJson(
        LiveKitTokenResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

LiveKitEventRequest _$LiveKitEventRequestFromJson(Map<String, dynamic> json) =>
    LiveKitEventRequest(
      onlineLessonId: json['online_class_id'] as String,
      meetingId: json['stream_id'] as String,
      eventName: json['event_name'] as String,
      metadata: json['metadata'] as String,
    );

Map<String, dynamic> _$LiveKitEventRequestToJson(
        LiveKitEventRequest instance) =>
    <String, dynamic>{
      'online_class_id': instance.onlineLessonId,
      'stream_id': instance.meetingId,
      'event_name': instance.eventName,
      'metadata': instance.metadata,
    };
