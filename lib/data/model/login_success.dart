import 'package:flutter/cupertino.dart';

class LoginStatus extends ChangeNotifier {
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  void updateLoginStatus(bool isLogin) {
    _isLogin = isLogin;
    notifyListeners();
  }
}