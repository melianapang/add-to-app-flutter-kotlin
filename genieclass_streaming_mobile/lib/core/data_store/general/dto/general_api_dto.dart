import 'package:json_annotation/json_annotation.dart';

part 'general_api_dto.g.dart';

@JsonSerializable()
class GeneralApiResponse {
  GeneralApiResponse({
    this.isError = false,
    this.errorCode,
    this.errorCategory,
    this.errorMessage,
  });

  factory GeneralApiResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralApiResponseToJson(this);

  @JsonKey(name: "error")
  final bool isError;

  @JsonKey(name: "error_code")
  final String? errorCode;

  @JsonKey(name: "error_category")
  final String? errorCategory;

  @JsonKey(name: "error_msg")
  final String? errorMessage;
}
