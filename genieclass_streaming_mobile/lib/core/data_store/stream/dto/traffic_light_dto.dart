import 'package:json_annotation/json_annotation.dart';

part 'traffic_light_dto.g.dart';

@JsonSerializable()
class SetTrafficLightRequest {
  SetTrafficLightRequest({
    required this.onlineLessonId,
    required this.roomId,
    required this.studentId,
    required this.teacherId,
    required this.sessionId,
    required this.rating,
    this.deviceType,
  });

  factory SetTrafficLightRequest.fromJson(Map<String, dynamic> json) =>
      _$SetTrafficLightRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetTrafficLightRequestToJson(this);

  @JsonKey(name: "online_class_id")
  final String onlineLessonId;

  @JsonKey(name: "room_id")
  final String roomId;

  @JsonKey(name: "student_id")
  final String studentId;

  @JsonKey(name: "teacher_id")
  final String teacherId;

  @JsonKey(name: "session_id")
  final String sessionId;

  final String rating;

  @JsonKey(name: "device_type")
  final String? deviceType;
}

@JsonSerializable()
class TrafficLightResponse {
  TrafficLightResponse({
    this.currentTime = "",
    this.rating = -1,
  });

  factory TrafficLightResponse.fromJson(Map<String, dynamic> json) =>
      _$TrafficLightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrafficLightResponseToJson(this);

  @JsonKey(name: "current_time")
  final String? currentTime;

  @JsonKey(name: "rating")
  final int? rating;
}
