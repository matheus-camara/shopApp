import 'package:flutter/cupertino.dart';
import 'package:shop_app/appSettings.dart';
import 'package:shop_app/domain/user.dart';
import 'package:shop_app/services/services.dart';

class Auth with ChangeNotifier {
  User _user;

  bool get isLoggedIn => _user != null;

  String get token {
    if (_user?.expiration != null &&
        (_user?.expiration?.isAfter(DateTime.now()) ?? false) &&
        _user?.token != null) {
      return _user.token;
    }
    return null;
  }

  Future<bool> signUp(String email, String password) async {
    AuthService _service = AuthService(AppSettings.signUpAdress);
    return await _service.signUp(email, password);
  }

  Future<void> login(String email, String password) async {
    AuthService _service = AuthService(AppSettings.signInAdress);
    var result = await _service.login(email, password);
    if (result != null) _user = result;
    notifyListeners();
  }

  User get user => _user;
}
