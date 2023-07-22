class DietModel {
  final int id;
  final String name;
  final int itemsCount;
  final int customerCount;
  final String gym;

  DietModel({
    required this.id,
    required this.name,
    required this.itemsCount,
    required this.customerCount,
    required this.gym,
  });

  factory DietModel.fromJson(Map<String, dynamic> json) => DietModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        itemsCount: json['itemsCount'] ?? 0,
        customerCount: json['customerCount'] ?? 0,
        gym: json['gym'] ?? '',
      );
}
