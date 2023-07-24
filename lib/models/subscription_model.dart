class Subscription {
  final int id;
  final String name;
  final String duration;

  Subscription({required this.name, required this.id, required this.duration});

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json['id'] ?? -1,
        name: json['name'] ?? '',
        duration: json['duration'] ?? '',
      );

  factory Subscription.empty() => Subscription(
        id: -1,
        name: '',
        duration: '',
      );
}
