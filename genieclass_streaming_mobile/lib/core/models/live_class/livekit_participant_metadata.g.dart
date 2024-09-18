// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livekit_participant_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveKitParticipantMetadata _$LiveKitParticipantMetadataFromJson(
        Map<String, dynamic> json) =>
    LiveKitParticipantMetadata(
      userType: json['user_type'] as String?,
      isModerator: json['is_moderator'] as bool? ?? false,
      admitted: json['admitted'] as bool? ?? false,
    );

Map<String, dynamic> _$LiveKitParticipantMetadataToJson(
        LiveKitParticipantMetadata instance) =>
    <String, dynamic>{
      'user_type': instance.userType,
      'is_moderator': instance.isModerator,
      'admitted': instance.admitted,
    };
