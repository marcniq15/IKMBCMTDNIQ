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
                            "PoolId": "us-east-1_DKGPQeiej", // OPTIONAL: Only if you have an Identity Pool
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_DKGPQeiej",
                        "AppClientId": "26gs8tfvu3c1v8711d4mqkgkas",
                        "Region": "us-east-1"
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
