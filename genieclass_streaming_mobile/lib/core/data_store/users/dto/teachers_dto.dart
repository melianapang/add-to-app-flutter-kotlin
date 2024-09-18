import 'package:json_annotation/json_annotation.dart';

part 'teachers_dto.g.dart';

@JsonSerializable()
class TeacherDetailResponse {
  TeacherDetailResponse({
    this.details,
  });

  factory TeacherDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TeacherDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherDetailResponseToJson(this);

  @JsonKey(name: "data")
  final TeacherDetail? details;
}

@JsonSerializable()
class TeacherDetail {
  TeacherDetail({
    required this.username,
    required this.displayName,
    required this.isModerator,
  });

  factory TeacherDetail.fromJson(Map<String, dynamic> json) =>
      _$TeacherDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherDetailToJson(this);
  final String username;

  @JsonKey(name: "display_name")
  final String displayName;

  @JsonKey(name: "is_moderator")
  final int isModerator;
}
