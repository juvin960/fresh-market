import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fresh_market_app/features/services/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_client.dart';


class AuthModel {
  final ApiClient _client;

  AuthModel(this._client);

  Future<bool> login(String email, String password) async {
    try {
      final decoded = await _client.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );


      if (decoded['errorOccurred'] == true) {
        print('Login failed: ${decoded['message']}');
        return false;
      }
      final saved = await _saveUserData(decoded);
      return saved;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }
  Future<bool> _saveUserData(Map<String, dynamic> response) async {
    try {
      final token = response['data']?['token'];

      if (token == null || token.trim().isEmpty) {
        debugPrint(' Token missing in response: $response');
        return false;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('user_name', response['data']?['name'] ?? '');
      await prefs.setString('user_email', response['data']?['email'] ?? '');

      debugPrint(' Token saved successfully');
      return true;
    } catch (e) {
      debugPrint('Error saving user data: $e');
      return false;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.trim().isNotEmpty;
  }



  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {

    if ([name, email, phone, password].any((s) => s.trim().isEmpty)) {
      throw Exception('All registration fields are required.');
    }

    try {
      final Map<String, dynamic> response = await _client.post(
        Endpoints.register,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );

      final status = response["statusCode"] ?? 0;
      final body = response["body"] ?? '';

      print('Register response - status: $status, body: $body');

      Map<String, dynamic> decoded = {};
      if (body.isNotEmpty) {
        try {
          if (body is Map<String, dynamic>) {
            decoded = body;
          } else {

            decoded = {'data': body};
          }
        } on FormatException catch (fe) {
          throw Exception('Invalid JSON response from server: ${fe.message}');
        }
      }

      if (status == 200 || status == 201) {
        return await _saveUserData(decoded);
      } else {
        String message = (decoded['message'] ?? decoded['error'] ?? 'Registration failed').toString();


        if (decoded.containsKey("validation_error")) {
          Map<String,dynamic> validationErrors = decoded["validation_error"];

          if (validationErrors.containsKey("email")) {
            message += "\n${validationErrors["email"][0] ?? ""}";
          }

          if (validationErrors.containsKey("phone")) {
            message += "\n${validationErrors["phone"][0] ?? ""}";
          }
        }

        throw Exception(message);
      }
    } catch (e, st) {

      print('Register error: $e\n$st');
      throw Exception(e.toString());
    }
  }




  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
