// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teachers_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherDetailResponse _$TeacherDetailResponseFromJson(
        Map<String, dynamic> json) =>
    TeacherDetailResponse(
      details: json['data'] == null
          ? null
          : TeacherDetail.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeacherDetailResponseToJson(
        TeacherDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.details,
    };

TeacherDetail _$TeacherDetailFromJson(Map<String, dynamic> json) =>
    TeacherDetail(
      username: json['username'] as String,
      displayName: json['display_name'] as String,
      isModerator: (json['is_moderator'] as num).toInt(),
    );

Map<String, dynamic> _$TeacherDetailToJson(TeacherDetail instance) =>
    <String, dynamic>{
      'username': instance.username,
      'display_name': instance.displayName,
      'is_moderator': instance.isModerator,
    };
