// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Failure _$FailureFromJson(Map<String, dynamic> json) => Failure(
      errorCode: (json['errorCode'] as num?)?.toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$FailureToJson(Failure instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
