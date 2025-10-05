import 'package:flutter/material.dart';
import 'package:real_commutrade/screens/login_page.dart';
import 'package:real_commutrade/theme/app_theme.dart';
import 'package:real_commutrade/theme/app_theme_notifier.dart'; // 1. Import the notifier

void main() {
  runApp(const MyApp());
}

// 2. Convert MyApp to a StatefulWidget to hold the theme state
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 3. This is the state variable that holds the current theme
  ThemeMode _themeMode = ThemeMode.light;

  // 4. This function will be passed down to change the theme
  void _changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 5. Wrap the MaterialApp in our AppThemeNotifier
    return AppThemeNotifier(
      changeTheme: _changeTheme, // Pass the function down the widget tree
      child: MaterialApp(
        title: 'CommuTrade',
        // Use the theme definitions from our AppTheme class
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        // The theme is now controlled by our state variable
        themeMode: _themeMode,
        home: const LoginPage(),
        debugShowCheckedModeBanner: false, // Optional: Hides the "debug" banner
      ),
    );
  }
}