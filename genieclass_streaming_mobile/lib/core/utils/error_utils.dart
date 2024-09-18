import 'dart:developer';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/models/error.dart';
import 'package:genieclass_streaming_mobile/core/models/parsed_response.dart';
import 'package:retrofit/dio.dart';

class ErrorUtils<T> {
  Left<Failure, T> handleError(Object error) {
    if (error is TypeError) {
      debugPrint(error.stackTrace.toString());
      log('Failure: TypeError');
      return Left<Failure, T>(
        Failure(
          message: 'TypeError',
        ),
      );
    }
    log('Failure: Unexpected Error');
    debugPrint(error.toString());
    return Left<Failure, T>(
      Failure(
        message: 'Unexpected Error',
      ),
    );
  }

  Left<Failure, T> handleDomainError(HttpResponse<dynamic> response) {
    final ErrorResponse errorResponse = ErrorResponse.fromJson(
      response.data,
    );
    final Failure failure = Failure(
      errorCode: errorResponse.code,
      message: errorResponse.message ?? 'Unknown error',
    );
    log('Failure: ${failure.errorCode} | ${failure.message}');
    return Left<Failure, T>(failure);
  }
}
