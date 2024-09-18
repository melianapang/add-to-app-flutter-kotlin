import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/dio.dart';

part 'parsed_response.g.dart';

extension ParsedResponse<T> on HttpResponse<T> {
  bool get isSuccess => <int>[
        HttpStatus.ok,
        HttpStatus.created,
        HttpStatus.accepted,
      ].contains(response.statusCode);

  Failure? get failure => Failure.fromJson(response.data);

  bool get hasError => failure?.errorCode != null;

  bool? get isPostSuccess =>
      <int>[
        HttpStatus.ok,
        HttpStatus.created,
        HttpStatus.accepted,
      ].contains(response.statusCode) &&
      response.data['message'] == 'Success';
}

@JsonSerializable()
class Failure {
  Failure({
    this.errorCode,
    required this.message,
  });

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);

  Map<String, dynamic> toJson() => _$FailureToJson(this);

  final int? errorCode;
  final String message;
}
