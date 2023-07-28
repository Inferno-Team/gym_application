import 'dart:convert';

import 'package:gym_application/models/user.dart';

class Gym {
  final int id;
  final String name;
  final String location;
  final pos;
  final User manager;
  final String? image;

  Gym({
    required this.id,
    required this.name,
    required this.location,
    required this.pos,
    this.image,
    required this.manager,
  });

  factory Gym.fromJson(dynamic json) => Gym(
        id: json['id'] ?? -1,
        name: json['name'] ?? '',
        location: json['location'] ?? '',
        pos: json['pos'],
        manager: User.fromJson(json['manager']),
        image: json['image'],
      );

  factory Gym.empty() => Gym(
        id: -1,
        name: '',
        location: '',
        pos: [],
        manager: User.empty(),
      );

  String toJson() {
    Map<String, dynamic> values = {
      'id': id,
      'name': name,
      'pos': pos.toString(),
      'manager': manager.toJson(),
      'location': location,
    };
    return json.encode(values);
  }
}
