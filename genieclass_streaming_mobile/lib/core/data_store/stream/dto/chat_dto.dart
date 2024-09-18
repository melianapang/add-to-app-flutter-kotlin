import 'package:json_annotation/json_annotation.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
class HistoryChatResponse {
  HistoryChatResponse({
    required this.chats,
  });

  factory HistoryChatResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryChatResponseToJson(this);

  final List<HistoryChat> chats;
}

@JsonSerializable()
class HistoryChat {
  HistoryChat({
    required this.id,
    required this.onlineLessonId,
    required this.content,
    this.status = 0,
    this.type = "",
    this.recipientId,
    this.senderId = "",
    this.createdAt = "",
    this.createdBy = "",
    this.updatedAt = "",
    this.updatedBy = "",
    this.timestamp = "",
  });

  factory HistoryChat.fromJson(Map<String, dynamic> json) =>
      _$HistoryChatFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryChatToJson(this);

  final String id;

  @JsonKey(name: "online_class_id")
  final String onlineLessonId;

  final String content;

  final int status;

  final String type;

  @JsonKey(name: "recipient_id")
  final String? recipientId;

  @JsonKey(name: "sender_id")
  final String senderId;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "created_by")
  final String createdBy;

  @JsonKey(name: "updated_at")
  final String updatedAt;

  @JsonKey(name: "updated_by")
  final String updatedBy;

  final String timestamp;
}

@JsonSerializable()
class SendChatRequest {
  SendChatRequest({
    required this.onlineLessonId,
    required this.roomId,
    required this.content,
    required this.contentType,
    required this.type,
  });

  factory SendChatRequest.fromJson(Map<String, dynamic> json) =>
      _$SendChatRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendChatRequestToJson(this);

  @JsonKey(name: "online_class_id")
  final String onlineLessonId;

  @JsonKey(name: "room_id")
  final String roomId;

  final String content;

  @JsonKey(name: "content_type")
  final String contentType;

  final String type;
}
