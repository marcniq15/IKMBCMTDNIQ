import 'package:flutter/material.dart';
// ** 1. ADDED Amplify import for Cognito functionality **
import 'package:amplify_flutter/amplify_flutter.dart'; 
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

  // Changed to an asynchronous function
  Future<void> _register() async {
    // Basic validation
    if (_fullNameController.text.isEmpty || 
        _matrixNumberController.text.isEmpty || 
        _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = "All fields are required.";
      });
      return;
    }
    
    // Matrix Number is used as the unique username/identifier
    final username = _matrixNumberController.text.trim();
    final password = _passwordController.text.trim();
    final fullName = _fullNameController.text.trim();

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // 2. AWS COGNITO REGISTRATION LOGIC
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: {
            // NOTE: Cognito requires an email or phone for sign up by default.
            // If you are using Matrix Number as the username and have NOT enabled
            // email/phone verification, you can skip the email line.
            // If email is required, you must use a real or placeholder email:
            AuthUserAttributeKey.email: '$username@university.edu', 
            
            // Custom attributes must exactly match the names in your Cognito User Pool
            AuthUserAttributeKey.custom('custom:full_name'): fullName,
            AuthUserAttributeKey.custom('custom:matrix_number'): username,
          },
        ),
      );

      safePrint('Sign up result: ${result.nextStep.signUpStep}');
      
      // Handle the result: Cognito usually requires confirmation (step: confirmSignUp)
      if (result.nextStep.signUpStep == AuthSignUpStep.confirmSignUp) {
        if (mounted) {
          // You should now navigate the user to a ConfirmationPage
          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ConfirmationPage(username: username)));
          
          setState(() {
             _errorMessage = "Success! A confirmation code has been sent. Please confirm your account.";
          });
        }
      } else {
        setState(() {
            _errorMessage = "Registration completed successfully. You may now log in.";
        });
      }

    } on AuthException catch (e) {
      safePrint('Error signing up: ${e.message}');
      setState(() {
          _errorMessage = e.message;
      });
    } catch (e) {
      safePrint('An unknown error occurred: $e');
      setState(() {
          _errorMessage = "An unexpected error occurred.";
      });
    }

    setState(() {
      _isLoading = false;
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
              Color(0xFFFEC48C),    // Lighter soft orange
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
