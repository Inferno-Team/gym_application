import 'package:gym_application/models/response.dart';

class DataResponse<Type> extends Response {
  Type? data;

  DataResponse({required super.code, required this.data, required super.msg});

  factory DataResponse.fromJson({
    dynamic json,
    required Type Function(dynamic j) fromJson,
    required String key,
  }) {
    print(json);
    return DataResponse(
      code: json['code'],
      data: fromJson(json[key]),
      msg: json['msg'],
    );
  }

  factory DataResponse.empty({data}) => DataResponse(
        code: -1,
        data: data,
        msg: '',
      );
}
