class CheckIfSub {
  final bool value;

  CheckIfSub({required this.value});

  factory CheckIfSub.fromJson(Map<String, dynamic> json) =>
      CheckIfSub(value: json['value'] ?? false);

  factory CheckIfSub.empty() => CheckIfSub(value: false);
}
