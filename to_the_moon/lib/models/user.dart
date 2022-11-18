import 'dart:ffi';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/services.dart';

class User {
  bool acceptAgreement;
  int userId;

  User({required this.acceptAgreement, required this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        acceptAgreement: json["AcceptAgreement"],
        userId: json["AcceptAgreement"]
        );

  }

  // TODO: create a setter for the acceptAgreement flag

}
