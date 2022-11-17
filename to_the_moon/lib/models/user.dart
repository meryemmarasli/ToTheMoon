import 'dart:ffi';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/services.dart';

class User {
  bool acceptAgreement;

  User({required this.acceptAgreement});

  factory User.fromJson(Map<String, dynamic> json) {
    return User( acceptAgreement: json["AcceptAgreement"]);
  }

  // TODO: create a setter for the acceptAgreement flag

}
