import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String baseUrl;
  final http.Client client;

  ApiClient({required this.baseUrl, http.Client? client})
    : client = client ?? http.Client();

  static const _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    return {
      ..._defaultHeaders,
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  bool _isSuccess(int code) => code == 200;

  dynamic _handleResponse(http.Response response, String endpoint) {
    // debugPrint('[$endpoint] ${response.statusCode}');
    // debugPrint(response.body);
    //
    // if (_isSuccess(response.statusCode)) {
    //   return response.body.isNotEmpty
    //       ? {
    //         'body': jsonDecode(response.body),
    //         'statusCode': response.statusCode,
    //       }
    //       : null;
    // } else {
    //   throw ApiException(
    //     statusCode: response.statusCode,
    //     message: response.body,
    //   );
    // }

    try {
      debugPrint('[$endpoint] ${response.statusCode}');
      debugPrint(response.body);
      return {
        'body': jsonDecode(response.body),
        'statusCode': response.statusCode,
      };

      if (_isSuccess(response.statusCode)) {
        return response.body.isNotEmpty
            ? {
          'body': jsonDecode(response.body),
          'statusCode': response.statusCode,
        }
            : null;
      } else {

      }
    } catch (e) {
      throw ApiException(
        statusCode: response.statusCode,
        message: response.body,
      );
    }
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '$baseUrl$endpoint',
    ).replace(queryParameters: queryParams);

    final response = await client.get(uri, headers: await _getHeaders());

    return _handleResponse(response, endpoint);
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? data}) async {
    final response = await client.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );

    return _handleResponse(response, endpoint);
  }

  Future<dynamic> patch(String endpoint, {Map<String, dynamic>? data}) async {
    final response = await client.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _getHeaders(),
      body: jsonEncode(data),
    );

    return _handleResponse(response, endpoint);
  }

  Future<dynamic> delete(String endpoint, {Map<String, dynamic>? data}) async {
    final response = await client.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: await _getHeaders(),
      body: data != null ? jsonEncode(data) : null,
    );

    return _handleResponse(response, endpoint);
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException ($statusCode): $message';
}
