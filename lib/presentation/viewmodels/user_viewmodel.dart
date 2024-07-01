import 'package:flutter/material.dart';
import 'package:taste_guide/data/database_helper.dart';

class UserViewModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _username = '';
  String _email = '';
  String get email => _email;

  UserViewModel() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Check if a user is logged in
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final user = await DatabaseHelper().getUser(email);
    if (user != null && user['password'] == password) {
      _isLoggedIn = true;
      _username = user['username'] ?? '';
      _email = email;
      _errorMessage = '';
    } else {
      _isLoggedIn = false;
      _errorMessage = 'Invalid username or password';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    _isLoggedIn = false;
    _username = '';
    _email = '';

    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(String username, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final existingUser = await DatabaseHelper().getUser(email);
    if (existingUser == null) {
      try {
        await DatabaseHelper().saveUser(username, email, password);
        _isLoggedIn = true;
        _username = username;
        _email = email;
        _errorMessage = '';
      } catch (e) {
        _isLoggedIn = false;
        _errorMessage = 'Failed to save user: $e';
      }
    } else {
      _isLoggedIn = false;
      _errorMessage = 'User already exists with this email';
    }

    _isLoading = false;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
