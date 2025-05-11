import 'dart:convert' show jsonDecode;

import 'package:flutter/rendering.dart' show debugPrint;
import 'package:http/http.dart' show Response;

class ResponseModel {
  const ResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.body,
  });

  final bool success;
  final int statusCode;
  final String message;
  final dynamic body;

  bool get hasData => body != null;

  // In ResponseModel class
  factory ResponseModel.fomMap(Response response) {
    dynamic decodedBody;
    String message =
        'Oops 😓\nSome thing went wrong 🙁!'; // Default error message
    bool success = false;
    final int statusCode = response.statusCode;

    try {
      // Only decode if there's a body and it's likely JSON
      if (response.body.isNotEmpty) {
        decodedBody = jsonDecode(response.body);
        debugPrint(
            'Decoded response body => $decodedBody'); // See what you actually get

        // Check if the decoded body is a Map to potentially extract a message
        if (decodedBody is Map<String, dynamic>) {
          // Example: Your API might wrap errors in a map like {'message': 'Error details'}
          // Or successful single-item responses might be maps.
          // Adjust this logic based on how your API returns messages/errors.
          message = decodedBody['message']?.toString() ??
              (statusCode == 200 || statusCode == 201 ? 'Success' : message);
        } else if (decodedBody is List) {
          // If it's a list, assume success if status code is OK, use default message
          message = (statusCode == 200 || statusCode == 201)
              ? 'Data retrieved successfully'
              : message;
        }
      } else {
        // Handle empty body - depends on your API contract
        message = (statusCode == 200 || statusCode == 201 || statusCode == 204)
            ? 'Operation successful (no content)'
            : message;
      }

      success = statusCode == 200 || statusCode == 201;
    } catch (e) {
      // Handle JSON decoding errors
      debugPrint('Error decoding JSON: $e');
      message = 'Error processing response data.';
      decodedBody = null; // Ensure body is null on error
      success = false; // Ensure success is false on error
    }

    return ResponseModel(
      // Use the determined success status based on statusCode primarily
      success: success,
      statusCode: statusCode,
      // body now holds the actual decoded data (List or Map or null)
      body: decodedBody,
      message: message, // Use the extracted or default message
    );
  }
}
