import 'dart:convert';

import 'package:gym_application/models/user_type.dart';

class User {
  final int id;
  final int? age;
  final String? avatar;
  final String? email;
  final String name;
  final String? phone;
  final UserType type;

  User(
      {required this.id,
      this.age,
      this.avatar,
      this.email,
      required this.name,
      this.phone,
      required this.type});

  factory User.fromJson(dynamic json) => User(
      id: json['id'] ?? 0,
      age: json['age'] ?? 0,
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      type: typeResolver(json['type']));

  factory User.empty() => User(
        id: -1,
        name: '',
        type: UserType.customer,
        age: -1,
        avatar: '',
        email: '',
        phone: '',
      );

  String toJson() {
    Map<String, dynamic> values = {
      'id': id,
      'name': name,
      'type': type.name,
      'age': age,
      'email': email,
      'phone': phone,
    };
    return json.encode(values);
  }
}
