class User {
  bool acceptAgreement;

  User({required this.acceptAgreement});

  factory User.fromJson(Map<String, dynamic> json) {
    return User( acceptAgreement: json["AcceptAgreement"]);
  }

  void updateAgreement(){
      this.acceptAgreement = true;
  }

  // TODO: create a setter for the acceptAgreement flag
}

