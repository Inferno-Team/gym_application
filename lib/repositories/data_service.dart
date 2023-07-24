import 'package:gym_application/models/check_if_user_subscribed_model.dart';
import 'package:gym_application/models/club_subscription.dart';
import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/diet_model.dart';
import 'package:gym_application/models/error_response.dart';
import 'package:gym_application/models/gym.dart';
import 'package:gym_application/models/login_type.dart';
import 'package:gym_application/models/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  static final DataService _singleton = DataService._internal();

  // final String apiUrl = "http://192.168.1.8:8000";
  final String baseUrl = "https://gym.inferno-team.cloud";
  final String apiURL = "/api";

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
      String finalUrl = _createUrl(url, params);
      final uri = Uri.parse(finalUrl);
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
    var string_body = '';
    try {
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      string_body = response.body;
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
      print(string_body);
    }
    return Response.empty();
  }

  Future<Response> login(String email, String password) async {
    var loginRoute = '/login';

    final Uri uri = Uri.parse(baseUrl + apiURL + loginRoute);
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

  Future<Response> register(
    String email,
    String password,
    String name,
    String? phone,
  ) async {
    var registerRoute = '/register';

    final Uri uri = Uri.parse(baseUrl + apiURL + registerRoute);
    return await _createPostRequest(
      uri: uri,
      body: {
        'email': email,
        'password': password,
        'phone': phone ?? '',
        'name': name
      },
      key: 'login',
      fromJson: (j) => LoginType.fromJson(j),
    );
  }

  Future<Response> getAllGyms(String token) async {
    var route = '/clubs';
    var prefix = '/club';
    final url = baseUrl + prefix + apiURL + route;

    return await _createGetRequest(
      url: url,
      headers: {
        "Authorization": "Bearer $token",
      },
      key: 'clubs',
      fromJson: (j) => (j as List).map((e) => Gym.fromJson(e)).toList(),
    );
  }

  Future<Response> getAllDiets(String token) async {
    var route = '/get-all-table';
    var prefix = '/customer';
    final url = baseUrl + prefix + apiURL + route;
    print(url);
    return await _createGetRequest(
      url: url,
      headers: {
        "Authorization": "Bearer $token",
      },
      key: 'tables',
      fromJson: (j) => (j as List).map((e) => DietModel.fromJson(e)).toList(),
    );
  }

  String _createUrl(url, Map? params) {

    if (params == null) {
      return url;
    } else {
      var newURL = url;
      var keys = params.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        if (i == 0) {
          newURL += '?${keys[i]}=${params[keys[i]]}';
        } else {
          newURL += '&${keys[i]}=${params[keys[i]]}';
        }
      }
      return newURL;
    }
  }

  Future<Response> checkIfUserSubscribed(String token, int id) async {
    var checkRoute = '/check-if-subscribed';
    var prefix = '/customer';
    var fullRoute = baseUrl + prefix + apiURL + checkRoute;
    final Uri uri = Uri.parse(fullRoute);
    return await _createPostRequest(
      uri: uri,
      body: {
        'club_id': "$id",
      },
      key: 'subscribed',
      fromJson: (j) => CheckIfSub.fromJson(j),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }

  Future<Response> getClubSubscription(String token, int id) async {
    var route = '/get-single-club-subscription';
    var prefix = '/customer';
    final url = baseUrl + prefix + apiURL + route;
    return await _createGetRequest(
      url: url,
      headers: {
        "Authorization": "Bearer $token",
      },
      params: {'id': "$id"},
      key: 'subs',
      fromJson: (j) => (j as List)
          .map(
            (e) => ClubSubScription.fromJson(e),
          )
          .toList(),
    );
  }
}
