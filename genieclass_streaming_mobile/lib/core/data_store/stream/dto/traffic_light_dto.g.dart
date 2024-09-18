// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traffic_light_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetTrafficLightRequest _$SetTrafficLightRequestFromJson(
        Map<String, dynamic> json) =>
    SetTrafficLightRequest(
      onlineLessonId: json['online_class_id'] as String,
      roomId: json['room_id'] as String,
      studentId: json['student_id'] as String,
      teacherId: json['teacher_id'] as String,
      sessionId: json['session_id'] as String,
      rating: json['rating'] as String,
      deviceType: json['device_type'] as String?,
    );

Map<String, dynamic> _$SetTrafficLightRequestToJson(
        SetTrafficLightRequest instance) =>
    <String, dynamic>{
      'online_class_id': instance.onlineLessonId,
      'room_id': instance.roomId,
      'student_id': instance.studentId,
      'teacher_id': instance.teacherId,
      'session_id': instance.sessionId,
      'rating': instance.rating,
      'device_type': instance.deviceType,
    };

TrafficLightResponse _$TrafficLightResponseFromJson(
        Map<String, dynamic> json) =>
    TrafficLightResponse(
      currentTime: json['current_time'] as String? ?? "",
      rating: (json['rating'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$TrafficLightResponseToJson(
        TrafficLightResponse instance) =>
    <String, dynamic>{
      'current_time': instance.currentTime,
      'rating': instance.rating,
    };
