import 'package:flutter/material.dart';
import 'package:real_commutrade/screens/register_page.dart';
import 'package:real_commutrade/screens/main_nav_page.dart';
import 'package:real_commutrade/theme/app_theme.dart'; // Import the AppTheme

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _matrixNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _errorMessage;
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Clear error on new attempt
    });

    await Future.delayed(const Duration(seconds: 2));

    String matrixNumber = _matrixNumberController.text;
    String password = _passwordController.text;

    if (matrixNumber.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Please fill in all fields.";
      });
    } else if (password.length < 6) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Password must be at least 6 characters long.";
      });
    } else {
      // On success, navigate to MainNavPage
      if (mounted) { // Check if the widget is still in the tree
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create a specific input decoration for this page that works on a gradient
    final inputDecoration = InputDecoration(
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIconColor: Colors.white,
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
      ),
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: const BoxDecoration(
          // Using the accent color from our theme for consistency
          gradient: LinearGradient(
            colors: [
              AppTheme.accentColor, // Darker orange from theme
              Color(0xFFFEC48C),   // Lighter soft orange
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/commutrade.png',
                  height: 120,
                ),
                const SizedBox(height: 16),
                Text(
                  'CommuTrade',
                  // Using text style from the theme and overriding the color
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48.0),
                TextField(
                  controller: _matrixNumberController,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Matrix Number',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 32.0),
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    // Styling the button with theme colors for a consistent look
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.lightSurfaceColor, // White button
                      foregroundColor: AppTheme.accentColor, // Orange text
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                    )
                        : Text('Login', style: Theme.of(context).textTheme.labelLarge),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48.0),
                const Text(
                  '© 2025 CommuTrade. All Rights Reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}