import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taste_guide/presentation/viewmodels/user_viewmodel.dart';
import 'package:taste_guide/presentation/viewmodels/theme_viewmodel.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Dark Theme'),
              trailing: Consumer<ThemeViewModel>(
                builder: (context, themeViewModel, child) {
                  return Switch(
                    value: themeViewModel.isDarkMode,
                    onChanged: (value) {
                      themeViewModel.toggleTheme(value);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Consumer<UserViewModel>(
              builder: (context, userViewModel, child) {
                return ListTile(
                  title: Text('Account'),
                  subtitle: Text(userViewModel.email),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<UserViewModel>(context, listen: false).logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
