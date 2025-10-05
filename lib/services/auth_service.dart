import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

Future<String> getAccessToken(String username, String password) async {
  try {
    final result = await Amplify.Auth.signIn(
      username: username,
      password: password,
    );

    if (result.isSignedIn) {
      final session = await Amplify.Auth.fetchAuthSession();
      final cognitoSession = session as CognitoAuthSession;

      if (cognitoSession.isSignedIn) {
        final accessToken = cognitoSession.userPoolTokens.accessToken.raw;
        print('Access Token: $accessToken');
        return accessToken;
      }
    }
  } on AuthException catch (e) {
    print('Sign in failed: ${e.message}');
    // Handle specific errors like invalid username or password
  }
  return null;
}