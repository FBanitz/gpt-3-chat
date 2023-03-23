import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:gpt_3_chat/main.dart';
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

  Future<AiResponse> generateText(
    String prompt, [
    double? temperature,
    int? maxTokens,
    String? stop,
  ]) async {
    debugPrint(prompt);

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Authorization': 'Bearer $token',
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
      throw Exception(json.decode(response.body)['error']['message']);
    }

    debugPrint(response.body);

    AiResponse aiResponse = AiResponse.fromJson(response.body.fromJson);

    return aiResponse;
  }
}

class AiResponse {
  final String text;
  final bool isError;
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  AiResponse({
    this.isError = false,
    required this.text,
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory AiResponse.fromJson(Map<String, dynamic> json) {
    return AiResponse(
      text: (json['choices'][0]['text'] as String).cleanMessage,
      promptTokens: json['usage']['prompt_tokens'],
      completionTokens: json['usage']['completion_tokens'],
      totalTokens: json['usage']['total_tokens'],
    );
  }
}
