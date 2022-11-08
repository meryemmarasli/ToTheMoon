class User {
  final String name;
  final bool acceptAgreement;

  User({required this.name, required this.acceptAgreement});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json["Name"], acceptAgreement: json["AcceptAgreement"]);
  }

  // TODO: create a setter for the acceptAgreement flag
}
