/**
 * @file config.js
 * @description
 * This file contains configuration settings for your CommuTrade application,
 * specifically for connecting to AWS services like Cognito and API Gateway.
 * This is a JavaScript file that can be used by your web or mobile build scripts.
 */

// We use a global object 'window._config' to make these settings accessible
// throughout the frontend application.

window._config = {
  // --- AWS Cognito for User Authentication ---
  // These settings are required to connect your app to your AWS User Pool.
  // Replace the placeholder values with your actual AWS Cognito details.
  cognito: {
    userPoolId: 'REPLACE_WITH_YOUR_COGNITO_USER_POOL_ID', // e.g., 'us-east-1_xxxxxxxxx'
    userPoolClientId: 'REPLACE_WITH_YOUR_COGNITO_APP_CLIENT_ID', // e.g., 'xxxxxxxxxxxxxxxxxxxxxx'
    region: 'REPLACE_WITH_YOUR_AWS_REGION', // e.g., 'us-east-1'
  },

  // --- AWS API Gateway for Backend API ---
  // This is the URL your app will use to make API calls to your backend services.
  // Replace the placeholder with the invoke URL of your API Gateway.
  api: {
    invokeUrl: 'REPLACE_WITH_YOUR_API_GATEWAY_INVOKE_URL', // e.g., 'https://xxxxxxxxx.execute-api.us-east-1.amazonaws.com/prod'
  },
};