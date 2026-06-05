import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/password_model.dart';

class ApiService {
  // Use 10.0.2.2 for Android Emulator to access localhost of host machine
  // Use localhost for iOS simulator or web
  static const String baseUrl = 'http://127.0.0.1:3000';

  // Auth Endpoints
  static Future<http.Response> signup(String email, String password) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  static Future<http.Response> login(String email, String password) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  // Password Endpoints
  static Future<http.Response> getPasswords(String token) async {
    return await http.get(
      Uri.parse('$baseUrl/passwords'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<http.Response> createPassword(String token, Password password) async {
    return await http.post(
      Uri.parse('$baseUrl/passwords'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(password.toJson()),
    );
  }

  static Future<http.Response> updatePassword(String token, String id, Password password) async {
    return await http.put(
      Uri.parse('$baseUrl/passwords/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(password.toJson()),
    );
  }

  static Future<http.Response> deletePassword(String token, String id) async {
    return await http.delete(
      Uri.parse('$baseUrl/passwords/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
