import 'dart:convert';

import 'package:gpt_3_chat/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:gpt_3_chat/extensions/string.dart';

class AIController {
  final String model;
  final double defautTemperature;
  final int defaultMaxTokens;
  // final String defaultStop;

  AIController({
    this.model = "text-davinci-003", 
    this.defautTemperature = 0.5, 
    this.defaultMaxTokens = 256, 
    // this.defaultStop = "\n",
  });

  Future<String> generateText(String prompt, [double? temperature, int? maxTokens, String? stop]) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Authorization': 'Bearer ${Secrets.token}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'prompt': prompt,
        'model': model,
        'temperature': temperature ?? defautTemperature,
        'max_tokens': maxTokens ?? defaultMaxTokens,
        // 'stop': stop ?? defaultStop,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load response, Error ${response.statusCode}: ${response.body}');
    }

    String aiResponse = response.body.fromJson['choices'][0]['text'];
    
    while (
      aiResponse.startsWith('\n') 
      || aiResponse.startsWith(' ')
    ) {
      aiResponse = aiResponse.substring(1);
    }

    while (
      aiResponse.endsWith('\n') 
      || aiResponse.endsWith(' ')
    ) {
      aiResponse = aiResponse.substring(0, aiResponse.length - 1);
    }

    return aiResponse;
  }
}