import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/password_model.dart';
import '../services/api_service.dart';

class PasswordProvider with ChangeNotifier {
  List<Password> _passwords = [];
  bool _isLoading = false;

  List<Password> get passwords => _passwords;
  bool get isLoading => _isLoading;

  Future<void> fetchPasswords(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.getPasswords(token);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _passwords = data.map((json) => Password.fromJson(json)).toList();
      }
    } catch (e) {
      print('Fetch passwords error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addPassword(String token, Password password) async {
    try {
      final response = await ApiService.createPassword(token, password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchPasswords(token);
        return true;
      }
    } catch (e) {
      print('Add password error: $e');
    }
    return false;
  }

  Future<bool> updatePassword(String token, String id, Password password) async {
    try {
      final response = await ApiService.updatePassword(token, id, password);
      if (response.statusCode == 200) {
        await fetchPasswords(token);
        return true;
      }
    } catch (e) {
      print('Update password error: $e');
    }
    return false;
  }

  Future<bool> deletePassword(String token, String id) async {
    try {
      final response = await ApiService.deletePassword(token, id);
      if (response.statusCode == 200 || response.statusCode == 204) {
        _passwords.removeWhere((p) => p.id == id);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('Delete password error: $e');
    }
    return false;
  }
}
