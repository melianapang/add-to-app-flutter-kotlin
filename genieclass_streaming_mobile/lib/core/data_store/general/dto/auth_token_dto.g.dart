// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshAuthTokenRequest _$RefreshAuthTokenRequestFromJson(
        Map<String, dynamic> json) =>
    RefreshAuthTokenRequest(
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$RefreshAuthTokenRequestToJson(
        RefreshAuthTokenRequest instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
    };
