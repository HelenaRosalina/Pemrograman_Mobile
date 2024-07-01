import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/registration_page.dart';
import 'presentation/pages/data_list_page.dart';
import 'presentation/pages/data_detail_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/viewmodels/user_viewmodel.dart';
import 'presentation/viewmodels/theme_viewmodel.dart';

void main() {
  runApp(TasteGuideApp());
}

class TasteGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(
            title: 'Taste Guide',
            theme: themeViewModel.currentTheme,
            home: LoginPage(),
            routes: {
              '/login': (context) => LoginPage(),
              '/register': (context) => RegistrationPage(),
              '/list': (context) => DataListPage(),
              '/settings': (context) => SettingsPage(),
            },
          );
        },
      ),
    );
  }
}
