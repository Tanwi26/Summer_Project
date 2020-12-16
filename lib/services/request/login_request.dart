import 'dart:async';

import 'package:exam_arrangement/models/user.dart';
import 'package:exam_arrangement/data/CtrQuery/login_ctr.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();

  Future<User> getLogin(String username, String password) {
    var result = con.getLogin(username, password);
    return result;
  }
}
