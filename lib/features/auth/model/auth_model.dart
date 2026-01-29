import 'dart:convert';
import 'package:fresh_market_app/features/services/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_client.dart';


class AuthModel {
  final ApiClient _client;

  AuthModel(this._client);

  Future<bool> login(String email, String password) async {
    try {
      final response = await _client.post(
        Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return await _saveUserData(decoded);
      } else {
        final decoded = jsonDecode(response.body);
        throw decoded['message'] ?? 'Login failed';
      }
    } catch (e) {
      throw Exception("Login error: $e");
    }
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
      throw Exception('${e.toString()}');
    }
  }


  Future<bool> _saveUserData(Map<String, dynamic> decoded) async {

    final token =
        decoded['data']?['token'] ??
            decoded['token'];

    if (token is String && token.isNotEmpty) {

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('auth_token', token);
      await prefs.setString(
          'user_name',
          decoded['data']?['name'] ??
              decoded['name'] ??
              '');

      await prefs.setString(
          'user_email',
          decoded['data']?['email'] ??
              decoded['email'] ??
              '');

      return true;
    }

    throw Exception("Token missing from response: $decoded");
  }



  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }


  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }


  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
