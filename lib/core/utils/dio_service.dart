import 'dart:convert';

import 'package:http/http.dart' as http;

import 'const_strings.dart';

class HttpService {
  static final HttpService _instance = HttpService._internal();
  factory HttpService() => _instance;

  final String baseUrl = appEndpoint;
  HttpService._internal();

  Map<String, String> _defaultHeaders({String? token}) => {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  Future<http.Response> get(
    String endpoint, {
    String? token,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(
      url,
      headers: headers ?? _defaultHeaders(token: token),
    );
    _handleResponse(response);
    return response;
  }

  Future<http.Response> post(
    String endpoint, {
    String? token,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: headers ?? _defaultHeaders(token: token),
      body: jsonEncode(body),
    );
    _handleResponse(response);
    return response;
  }

  Future<http.Response> put(
    String endpoint, {
    String? token,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.put(
      url,
      headers: headers ?? _defaultHeaders(token: token),
      body: jsonEncode(body),
    );
    _handleResponse(response);
    return response;
  }

  Future<http.Response> delete(
    String endpoint, {
    String? token,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(
      url,
      headers: headers ?? _defaultHeaders(token: token),
    );
    _handleResponse(response);
    return response;
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode >= 400) {
      print('❌ Error ${response.statusCode}: ${response.body}');
    } else {
      print('✅ ${response.request?.method} ${response.request?.url}');
    }
  }
}
