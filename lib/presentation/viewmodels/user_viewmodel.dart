import 'package:flutter/material.dart';
import 'package:taste_guide/data/local_storage.dart';

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
    _isLoggedIn = await LocalStorage.isUserLoggedIn();
    if (_isLoggedIn) {
      final user = await LocalStorage.getUser();
      _email = user['email'] ?? '';
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final user = await LocalStorage.getUser();
    if (user['email'] == email && user['password'] == password) {
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
    await LocalStorage.logout();
    _isLoggedIn = false;
    _email = '';
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await LocalStorage.saveUser(email, password);
    _isLoggedIn = true;
    _email = email;
    _errorMessage = '';

    _isLoading = false;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
