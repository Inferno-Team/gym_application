class Errors {
  final List<String>? email;
  final List<String>? password;

  Errors({this.email, this.password});

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json['email']?.cast<String>(),
        password: json['password']?.cast<String>(),
      );

  factory Errors.empty() => Errors();
}
