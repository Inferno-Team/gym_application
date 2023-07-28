class UserSubscription {
  final int customerId;
  final int subscriptionId;
  final DateTime startAt;
  final DateTime endAt;
  final double price;
  final String approved;
  final bool isValid;

  UserSubscription({
    required this.customerId,
    required this.subscriptionId,
    required this.startAt,
    required this.endAt,
    required this.price,
    required this.approved,
    required this.isValid,
  });

  factory UserSubscription.fromJson(Map<String, dynamic> json) =>
      UserSubscription(
        customerId: json['customer_id'] ?? 0,
        subscriptionId: int.tryParse(json['subscription_id'].toString()) ?? 0,
        startAt: DateTime.parse(json['start_at']),
        endAt: DateTime.parse(json['end_at']),
        price: double.tryParse((json['price']).toString()) ?? 0.0,
        approved: json['approved'] ?? 'no',
        isValid: json['is_valid'] ?? false,
      );
}
