    import 'package:flutter/material.dart';
    import 'package:amplify_flutter/amplify_flutter.dart';
    import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
    // You'll also need to generate a file for amplify configuration
    import 'amplifyconfiguration.dart'; // This file will be generated

    void main() {
      WidgetsFlutterBinding.ensureInitialized();
      _configureAmplify();
      runApp(MyApp());
    }

    Future<void> _configureAmplify() async {
      try {
        await Amplify.addPlugins([AmplifyAuthCognito()]);
        // Replace with your actual configuration
        // You'd typically get this from `amplify init` or manual config.
        final amplifyConfig = '''{
            "UserAgent": "aws-amplify-cli/2.0",
            "Version": "1.0",
            "auth": {
                "plugins": {
                    "awsCognitoAuthPlugin": {
                        "UserAgent": "aws-amplify-cli/0.1.0",
                        "Version": "0.1.0",
                        "IdentityManager": {
                            "Default": {}
                        },
                        "CredentialsProvider": {
                            "CognitoIdentity": {
                                "Default": {
                                    "PoolId": "YOUR_COGNITO_IDENTITY_POOL_ID", // Optional, if using federated identities
                                    "Region": "YOUR_AWS_REGION"
                                }
                            }
                        },
                        "CognitoUserPool": {
                            "Default": {
                                "PoolId": "YOUR_COGNITO_USER_POOL_ID", // e.g., us-east-1_XXXXX
                                "AppClientId": "YOUR_COGNITO_APP_CLIENT_ID", // e.g., XXXXXXXX
                                "Region": "YOUR_AWS_REGION" // e.g., us-east-1
                            }
                        },
                        "Auth": {
                            "Default": {
                                "authenticationFlowType": "USER_SRP_AUTH",
                                "socialProviders": [], // If you add Google/Facebook sign-in
                                "usernameAttributes": [],
                                "signupAttributes": ["EMAIL"],
                                "passwordPolicy": {
                                    "minLength": 8,
                                    "requireLowercase": true,
                                    "requireUppercase": true,
                                    "requireNumbers": true,
                                    "requireSymbols": true
                                },
                                "mfaConfiguration": "OFF", // Or "ON", "OPTIONAL"
                                "mfaTypes": [],
                                "verificationMechanisms": ["EMAIL"]
                            }
                        }
                    }
                }
            }
        }''';

        await Amplify.configure(amplifyConfig);
        safePrint('Amplify configured.');
      } on AmplifyException catch (e) {
        safePrint('Error configuring Amplify: $e');
      }
    }
