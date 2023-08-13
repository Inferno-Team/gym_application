import 'package:gym_application/models/gym.dart';
import 'package:gym_application/models/subscription_model.dart';

class MySubModel {
  final Gym gym;
  final Subscription sub;
  final DateTime endAt;
  final DateTime startAt;
  final  isApproved;
  final  isValid;
  final  price;

  MySubModel({
    required this.gym,
    required this.sub,
    required this.endAt,
    required this.startAt,
    required this.isApproved,
    required this.isValid,
    required this.price,
  });

  factory MySubModel.fromJson(Map<String, dynamic> json) => MySubModel(
        gym: Gym.fromJson(json['club']),
        sub: Subscription.fromJson(json['sub_type']),
        isApproved: json['approved'] ?? false,
        isValid: json['is_valid'] ?? false,
        price: json['price'],
        endAt: DateTime.parse(json['end_at']),
        startAt: DateTime.parse(json['start_at']),
      );
}
