import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Using the same ngrok URL as your web application
  static const String baseUrl = 'https://pup-improved-labrador.ngrok-free.app';
  static const String mlBaseUrl = 'https://pup-improved-labrador.ngrok-free.app';

  // Chat endpoint
  Future<Map<String, dynamic>> chat(String question) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/external/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'question': question}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get chat response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in chat API: $e');
    }
  }

  // ML Process endpoint
  Future<Map<String, dynamic>> processML({
    required String url,
    required String dataType,
    required String model,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$mlBaseUrl/api/external/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'url': url,
          'data_type': dataType,
          'model': model,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to process ML: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in ML process API: $e');
    }
  }

  // Workflow Process endpoint
  Future<Map<String, dynamic>> processWorkflow({
    required String model,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$mlBaseUrl/api/external/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'model': model,
          'data': data,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to process workflow: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in workflow process API: $e');
    }
  }

  // Combined (skin query) endpoint
  Future<Map<String, dynamic>> processCombined({
    required String question,
    String? image,
    String? audio,
    List<Map<String, dynamic>>? keystrokes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/external/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'question': question,
          if (image != null && image.isNotEmpty) 'image': image,
          if (audio != null && audio.isNotEmpty) 'audio': audio,
          if (keystrokes != null) 'typing': {'keystrokes': keystrokes},
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to process combined: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error in combined process API: $e');
    }
  }
} 