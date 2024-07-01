import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // Save user email and password
  static Future<void> saveUser(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    print('User saved: email=$email');
  }

  // Get user email and password
  static Future<Map<String, String>> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');
    print('User fetched: email=$email, password=$password');
    return {
      'email': email ?? '',
      'password': password ?? '',
    };
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.containsKey('email') && prefs.containsKey('password');
    print('Is user logged in: $isLoggedIn');
    return isLoggedIn;
  }

  // Remove user login status
  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email'); // Optionally remove only login status, not email and password
    await prefs.remove('password'); // Optionally remove only login status, not email and password
    print('User logged out');
  }
}
