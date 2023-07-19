class Errors {
  final List<String>? email;
  final List<String>? password;
  final List<String>? name;
  final List<String>? phone;
  final int id;

  Errors({this.email, this.password, this.name, this.phone,required this.id});

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json['email']?.cast<String>(),
        password: json['password']?.cast<String>(),
        name: json['name']?.cast<String>(),
        phone: json['phone']?.cast<String>(),
        id: 0,
      );

  factory Errors.empty() => Errors(id: -1);
}
