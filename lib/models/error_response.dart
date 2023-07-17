import 'package:gym_application/models/errors_type.dart';
import 'package:gym_application/models/response.dart';

class ErrorResponse extends Response {
  final Errors errors;

  ErrorResponse({
    required this.errors,
    required super.code,
    required super.msg,
  });

  factory ErrorResponse.fromJson(dynamic json) => ErrorResponse(
        code: json['code'],
        msg: json['msg'],
        errors: Errors.fromJson(json['errors']),
      );
}
