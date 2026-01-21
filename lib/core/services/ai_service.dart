import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String _baseUrl = 'https://whisperrconnect.vercel.app/api/ai';

  Future<String> generateResponse({
    required String prompt,
    List<Map<String, String>>? history,
    String? systemInstruction,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'prompt': prompt,
          'history': history,
          'systemInstruction':
              systemInstruction ??
              'You are a professional assistant in the WhisperrConnect app.',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['text'];
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data['error'] ?? 'AI generation failed');
      }
    } catch (e) {
      throw Exception('AI Service Error: $e');
    }
  }

  Future<Map<String, dynamic>> analyzeTone(String content) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/analyze'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'content': content}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Tone analysis failed');
      }
    } catch (e) {
      throw Exception('AI Service Error: $e');
    }
  }
}
