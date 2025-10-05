// lib/amplify_config.dart (or directly in main.dart)

const String amplifyconfig = '''{
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/2.0",
                "Version": "1.0",
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "YOUR_IDENTITY_POOL_ID", // OPTIONAL: Only if you have an Identity Pool
                            "Region": "YOUR_AWS_REGION"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "YOUR_COGNITO_USER_POOL_ID",
                        "AppClientId": "YOUR_COGNITO_APP_CLIENT_ID",
                        "Region": "YOUR_AWS_REGION"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH" // Or "USER_PASSWORD_AUTH" if you're using simple username/password flow
                    }
                }
            }
        }
    }
}''';
