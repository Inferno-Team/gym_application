class UserEatTable {
  final int id;
  final int userId;
  final int dietId;

  UserEatTable({
    required this.id,
    required this.userId,
    required this.dietId,
  });

  factory UserEatTable.fromJson(Map<String, dynamic> json) => UserEatTable(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? 0,
        dietId: json['table_id'] ?? 0,
      );

  factory UserEatTable.empty() => UserEatTable(
        id: 0,
        userId: 0,
        dietId: 0,
      );
}
