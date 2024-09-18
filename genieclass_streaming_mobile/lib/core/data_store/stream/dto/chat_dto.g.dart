// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryChatResponse _$HistoryChatResponseFromJson(Map<String, dynamic> json) =>
    HistoryChatResponse(
      chats: (json['chats'] as List<dynamic>)
          .map((e) => HistoryChat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryChatResponseToJson(
        HistoryChatResponse instance) =>
    <String, dynamic>{
      'chats': instance.chats,
    };

HistoryChat _$HistoryChatFromJson(Map<String, dynamic> json) => HistoryChat(
      id: json['id'] as String,
      onlineLessonId: json['online_class_id'] as String,
      content: json['content'] as String,
      status: (json['status'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? "",
      recipientId: json['recipient_id'] as String?,
      senderId: json['sender_id'] as String? ?? "",
      createdAt: json['created_at'] as String? ?? "",
      createdBy: json['created_by'] as String? ?? "",
      updatedAt: json['updated_at'] as String? ?? "",
      updatedBy: json['updated_by'] as String? ?? "",
      timestamp: json['timestamp'] as String? ?? "",
    );

Map<String, dynamic> _$HistoryChatToJson(HistoryChat instance) =>
    <String, dynamic>{
      'id': instance.id,
      'online_class_id': instance.onlineLessonId,
      'content': instance.content,
      'status': instance.status,
      'type': instance.type,
      'recipient_id': instance.recipientId,
      'sender_id': instance.senderId,
      'created_at': instance.createdAt,
      'created_by': instance.createdBy,
      'updated_at': instance.updatedAt,
      'updated_by': instance.updatedBy,
      'timestamp': instance.timestamp,
    };

SendChatRequest _$SendChatRequestFromJson(Map<String, dynamic> json) =>
    SendChatRequest(
      onlineLessonId: json['online_class_id'] as String,
      roomId: json['room_id'] as String,
      content: json['content'] as String,
      contentType: json['content_type'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$SendChatRequestToJson(SendChatRequest instance) =>
    <String, dynamic>{
      'online_class_id': instance.onlineLessonId,
      'room_id': instance.roomId,
      'content': instance.content,
      'content_type': instance.contentType,
      'type': instance.type,
    };
