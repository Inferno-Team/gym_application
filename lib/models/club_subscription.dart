import 'package:gym_application/models/subscription_model.dart';

class ClubSubScription {
  final int id;
  final double price;
  final Subscription subscription;

  ClubSubScription({
    required this.id,
    required this.price,
    required this.subscription,
  });

  factory ClubSubScription.fromJson(Map<String, dynamic> json) =>
      ClubSubScription(
        id: json['id'] ?? -1,
        price: double.tryParse(json['price'].toString()) ?? 0.0,
        subscription: Subscription.fromJson(json['subscription']),
      );

  factory ClubSubScription.empty() => ClubSubScription(
        id: -1,
        price: 0.0,
        subscription: Subscription.empty(),
      );
}
