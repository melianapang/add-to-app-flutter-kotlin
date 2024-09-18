import 'package:json_annotation/json_annotation.dart';

part 'livekit_stream_dto.g.dart';

//Token
@JsonSerializable()
class LiveKitTokenRequest {
  LiveKitTokenRequest({
    required this.meetingId,
    required this.name,
    required this.userType,
    required this.duration,
    required this.isSmallClass,
    required this.admitted,
  });

  factory LiveKitTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$LiveKitTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LiveKitTokenRequestToJson(this);

  @JsonKey(name: "room_id")
  final String meetingId;

  final String name;

  @JsonKey(name: "user_type")
  final String userType;

  final int duration;

  @JsonKey(name: "is_small_class")
  final bool isSmallClass;

  final bool admitted;
}

@JsonSerializable()
class LiveKitTokenResponse {
  LiveKitTokenResponse({
    required this.token,
  });

  factory LiveKitTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$LiveKitTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LiveKitTokenResponseToJson(this);

  final String token;
}
//Token

//Event Trigger
@JsonSerializable()
class LiveKitEventRequest {
  LiveKitEventRequest({
    required this.onlineLessonId,
    required this.meetingId,
    required this.eventName,
    required this.metadata,
  });

  factory LiveKitEventRequest.fromJson(Map<String, dynamic> json) =>
      _$LiveKitEventRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LiveKitEventRequestToJson(this);

  @JsonKey(name: "online_class_id")
  final String onlineLessonId;

  @JsonKey(name: "stream_id")
  final String meetingId;

  @JsonKey(name: "event_name")
  final String eventName;

  final String metadata;
}
//Event Trigger
