import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/error_response.dart';
import 'package:gym_application/models/gym.dart';
import 'package:gym_application/models/login_type.dart';
import 'package:gym_application/models/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  static final DataService _singleton = DataService._internal();
  final String apiUrl = "http://192.168.1.8:8000";
  final String route = "/api";

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<Response> _createGetRequest<Type>({
    required url,
    headers,
    params,
    required Type Function(dynamic j) fromJson,
    required String key,
  }) async {
    try {
      final uri = Uri.parse(_createUrl(url, params));
      http.Response response = await http.get(uri, headers: headers);
      var jsonData = await json.decode(response.body);
      var initResponse = Response.fromJson(jsonData);

      if (initResponse.code == 200) {
        return DataResponse.fromJson(
            json: jsonData, fromJson: fromJson, key: key);
        // return LoginResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong $key :  $initResponse');
        return ErrorResponse.fromJson(jsonData);
        // return LoginResponse.fromJson(await json.decode(response.body));
      }
    } catch (e) {
      print('something wrong $key :  $e');
    }
    return Response.empty();
  }

  Future<Response> _createPostRequest<Type>(
      {uri,
      body,
      headers,
      required Type Function(dynamic j) fromJson,
      required String key}) async {
    try {
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      var jsonData = await json.decode(response.body);
      var initResponse = Response.fromJson(jsonData);

      if (initResponse.code == 200) {
        return DataResponse.fromJson(
            json: jsonData, fromJson: fromJson, key: key);
        // return LoginResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong $key :  $initResponse');
        return ErrorResponse.fromJson(jsonData);
        // return LoginResponse.fromJson(await json.decode(response.body));
      }
    } catch (e) {
      print('something wrong $key :  $e');
    }
    return Response.empty();
  }

  Future<Response> login(String email, String password) async {
    var loginRoute = '/login';

    final Uri uri = Uri.parse(apiUrl + route + loginRoute);
    return await _createPostRequest(
      uri: uri,
      body: {'email': email, 'password': password},
      key: 'login',
      fromJson: (j) => LoginType.fromJson(j),
    );
    // try {
    //   http.Response response =
    //       await http.post(uri, body: {'email': email, 'password': password});
    //   var jsonData = await json.decode(response.body);
    //   var initResponse = Response.fromJson(jsonData);
    //   print(jsonData);
    //   if (initResponse.code == 200) {
    //     return DataResponse.fromJson(
    //         jsonData, (j) => LoginType.fromJson(j), 'login');
    //     // return LoginResponse.fromJson(await json.decode(response.body));
    //   } else {
    //     print('something wrong $initResponse');
    //     return ErrorResponse.fromJson(jsonData);
    //     // return LoginResponse.fromJson(await json.decode(response.body));
    //   }
    // } catch (e) {
    //   print('something wrong $e');
    // return LoginResponse(
    //     status: false, parent: Parent.empty(), message: "Login Error");
  }

  Future<Response> getAllGyms(String token) async {
    var loginRoute = '/clubs';
    var prefix = '/club';
    final url = apiUrl + prefix + route + loginRoute;
    return await _createGetRequest(
      url: url,
      headers: {
        "Authorization": "Bearer $token",
      },
      key: 'clubs',
      fromJson: (j) => (j as List).map((e) => Gym.fromJson(e)).toList(),
    );
    /*  try {

      var jsonData = await json.decode(response.body);
      var initResponse = Response.fromJson(jsonData);
      print(jsonData);
      if (initResponse.code == 200) {
        return DataResponse.fromJson(
            json: jsonData,
            fromJson: (j) => (j as List)
                .map(
                  (element) => Gym.fromJson(element),
                )
                .toList(),
            key: 'clubs');
        // return LoginResponse.fromJson(await json.decode(response.body));
      } else {
        print('something wrong $initResponse');
        return ErrorResponse.fromJson(jsonData);
        // return LoginResponse.fromJson(await json.decode(response.body));
      }
    } catch (e) {
      print('something wrong $e');
    }
    return Response.empty();*/
  }

  _createUrl(url, Map? params) {
    if (params == null) {
      return url;
    } else {
      var newURL = '';
      var keys = params.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        if (i == 0) {
          newURL = '?${keys[i]}=${params[keys[i]]}';
        } else {
          newURL += '&${keys[i]}=${params[keys[i]]}';
        }
      }
      return newURL;
    }
  }
}
