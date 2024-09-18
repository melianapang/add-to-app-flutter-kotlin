import 'package:json_annotation/json_annotation.dart';

part 'auth_token_dto.g.dart';

@JsonSerializable()
class RefreshAuthTokenRequest {
  RefreshAuthTokenRequest({
    required this.refreshToken,
  });

  factory RefreshAuthTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshAuthTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshAuthTokenRequestToJson(this);

  final String refreshToken;
}
