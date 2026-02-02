import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_model.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthModel _authModel;
// Dependency injection
  AuthViewModel(this._authModel);

  bool isLoading = false;
  String? error;


  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final success = await _authModel.login(email, password);
      isLoading = false;
      notifyListeners();

      return success;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      rethrow;
    }
  }




Future<bool> register(
      String name,
      String email,
      String password,
      String phone,

      ) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final success =
      await _authModel.register(
          name: name,
          email: email,
          password: password,
          phone: phone,

      );

      return success;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }


  Future<void> logout() async {
    await _authModel.logout();
    notifyListeners();
  }
}
