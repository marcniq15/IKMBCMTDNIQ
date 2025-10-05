import 'package:flutter/material.dart';
import 'package:real_commutrade/theme/app_theme.dart'; // Import the AppTheme

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _matrixNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  void _register() {
    // Placeholder registration logic
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        _errorMessage = "Registration is not yet implemented.";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // We use the same custom input decoration as the LoginPage
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
      // This makes the body's gradient extend up behind the transparent AppBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // A transparent AppBar gives us a perfectly placed back button
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Ensure the back arrow is white
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: const BoxDecoration(
          // Using the same gradient as the LoginPage
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
                // Adding the logo for brand consistency
                Image.asset(
                  'assets/commutrade.png',
                  height: 100,
                ),
                const SizedBox(height: 16),
                Text(
                  'Create an Account',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48.0),

                // Text fields using the custom decoration
                TextField(
                  controller: _fullNameController,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _matrixNumberController,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Matrix Number',
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
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

                // Button styled to match the LoginPage
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.accentColor, // Orange text
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
                    )
                        : Text('Register', style: Theme.of(context).textTheme.labelLarge),
                  ),
                ),

                // We no longer need the "Already have an account?" text link,
                // as the back button in the AppBar serves this purpose.
              ],
            ),
          ),
        ),
      ),
    );
  }
}