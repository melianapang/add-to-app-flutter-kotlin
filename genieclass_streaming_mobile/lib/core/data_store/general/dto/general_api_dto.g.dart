// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_api_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralApiResponse _$GeneralApiResponseFromJson(Map<String, dynamic> json) =>
    GeneralApiResponse(
      isError: json['error'] as bool? ?? false,
      errorCode: json['error_code'] as String?,
      errorCategory: json['error_category'] as String?,
      errorMessage: json['error_msg'] as String?,
    );

Map<String, dynamic> _$GeneralApiResponseToJson(GeneralApiResponse instance) =>
    <String, dynamic>{
      'error': instance.isError,
      'error_code': instance.errorCode,
      'error_category': instance.errorCategory,
      'error_msg': instance.errorMessage,
    };
