import 'package:gym_application/models/user.dart';

class LoginType {
  final String token;
  final User user;

  LoginType({required this.token, required this.user});

  factory LoginType.fromJson(dynamic json) => LoginType(
        token: json['token'] ?? '',
        user: User.fromJson(
          json['user'],
        ),
      );
}
