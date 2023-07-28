class DietItem {
  final int id;
  final String ingredient;
  final String quantity;

  DietItem({
    required this.id,
    required this.ingredient,
    required this.quantity,
  });

  factory DietItem.fromJson(Map<String, dynamic> json) => DietItem(
        id: json['id'],
        ingredient: json['ingredient'],
        quantity: json['quantity'],
      );

  factory DietItem.empty() => DietItem(
        id: 0,
        ingredient: '',
        quantity: '',
      );
}
