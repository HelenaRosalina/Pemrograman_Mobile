import 'package:flutter/material.dart';
import 'package:taste_guide/data/database_helper.dart';

class UserViewModel extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _email = '';
  String get email => _email;

  UserViewModel() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final user = await DatabaseHelper().getUser();
    if (user != null) {
      _isLoggedIn = true;
      _email = user['email'] ?? '';
    } else {
      _isLoggedIn = false;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final user = await DatabaseHelper().getUser();
    if (user != null && user['email'] == email && user['password'] == password) {
      _isLoggedIn = true;
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

    // Just change the login status, don't delete the user
    _isLoggedIn = false;
    _email = '';

    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await DatabaseHelper().saveUser(email, password);
    final user = await DatabaseHelper().getUser();
    if (user != null && user['email'] == email && user['password'] == password) {
      _isLoggedIn = true;
      _email = email;
      _errorMessage = '';
    } else {
      _isLoggedIn = false;
      _errorMessage = 'Registration failed';
    }

    _isLoading = false;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
