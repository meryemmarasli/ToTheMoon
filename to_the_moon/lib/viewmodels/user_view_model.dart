import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:to_the_moon/models/user.dart';
class UserViewModel extends ChangeNotifier{
  final User _user;
  UserViewModel(this._user);

  bool get agreement {
    return this._user.acceptAgreement;
  }

  void setAgreement(){
    _user.acceptAgreement = true;
    notifyListeners();
  }
}