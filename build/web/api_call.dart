import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart'; // To get ID token

// Your API Gateway Invoke URL
const String apiBaseUrl = 'https://xxxxxxxxx.execute-api.YOUR_AWS_REGION.amazonaws.com/prod';

Future<void> createListingInBackend({
  required String title,
  required String description,
  required double price,
  required String category,
  String? imageUrl,
}) async {
  final idToken = await getIdToken(); // Function from Cognito setup
  if (idToken == null) {
    safePrint('User not authenticated.');
    return;
  }

  final url = Uri.parse('$apiBaseUrl/listings');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': idToken, // Send the Cognito ID token here
  };
  final body = jsonEncode({
    'title': title,
    'description': description,
    'price': price,
    'category': category,
    'imageUrl': imageUrl,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      safePrint('Listing created successfully: ${response.body}');
      // Handle success
    } else {
      safePrint('Failed to create listing. Status: ${response.statusCode}, Body: ${response.body}');
      // Handle error
    }
  } catch (e) {
    safePrint('Error creating listing: $e');
    // Handle network error
  }
}
