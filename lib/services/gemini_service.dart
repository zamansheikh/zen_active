import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static final GeminiService _instance = GeminiService._internal();

  factory GeminiService() {
    return _instance;
  }

  GeminiService._internal();

  /// Initialize Gemini API with API Key
  static void init({required String apiKey}) {
    Gemini.init(apiKey: apiKey);
  }

  /// Single Prompt Request
  Future<String?> prompt(String text) async {
    try {
      final response = await Gemini.instance.prompt(parts: [
        Part.text(text),
      ]);
      print('Response: ${response?.output}');
      return response?.output;
    } catch (e) {
      print('Error in prompt: $e');
      return null;
    }
  }

  /// Streaming Prompt Request
  Stream<String?> promptStream(String text) {
    return Gemini.instance.promptStream(parts: [
      Part.text(text),
    ]).map((value) => value?.output);
  }

  /// Chat Request with Context
  Future<String?> chat(List<Content> contents) async {
    try {
      final response = await Gemini.instance.chat(contents);
      return response?.output;
    } catch (e) {
      print('Error in chat: $e');
      return null;
    }
  }

  /// Count Tokens for Input Text
  Future<int?> countTokens(String text) async {
    try {
      final response = await Gemini.instance.countTokens(text);
      return response;
    } catch (e) {
      print('Error in countTokens: $e');
      return null;
    }
  }

  /// Get Model Info (FIXED)
  Future<ModelInfo?> getModelInfo(String model) async {
    try {
      final response = await Gemini.instance.info(model: model);
      return ModelInfo(
        id: response.name ?? '',
        displayName: response.displayName ?? '',
        description: response.description ?? '',
        inputTokenLimit: response.inputTokenLimit ?? 0,
        version: response.version ?? '',
      );
    } catch (e) {
      print('Error in getModelInfo: $e');
      return null;
    }
  }

  /// List All Available Models
  Future<List<ModelInfo>?> listModels() async {
    try {
      final response = await Gemini.instance.listModels();
      return response
          .map((model) => ModelInfo(
                id: model.name ?? '',
                displayName: model.displayName ?? '',
                description: model.description ?? '',
                inputTokenLimit: model.inputTokenLimit ?? 0,
                version: model.version ?? '',
              ))
          .toList();
    } catch (e) {
      print('Error in listModels: $e');
      return null;
    }
  }

  /// Get Embedding for Single Text
  Future<List<num>?> embedContent(String text) async {
    try {
      final response = await Gemini.instance.embedContent(text);
      return response;
    } catch (e) {
      print('Error in embedContent: $e');
      return null;
    }
  }

  /// Get Embeddings for Batch of Texts
  Future<List<List<num>>?> batchEmbedContents(List<String> texts) async {
    try {
      final response = await Gemini.instance.batchEmbedContents(texts);
      return response?.map((e) => e).whereType<List<num>>().toList();
    } catch (e) {
      print('Error in batchEmbedContents: $e');
      return null;
    }
  }
}

/// Model Information Class
class ModelInfo {
  final String id;
  final String displayName;
  final String description;
  final int inputTokenLimit;
  final String version;

  ModelInfo({
    required this.id,
    required this.displayName,
    required this.description,
    required this.inputTokenLimit,
    required this.version,
  });

  factory ModelInfo.fromJson(Map<String, dynamic> json) {
    return ModelInfo(
      id: json['id'],
      displayName: json['displayName'] ?? '',
      description: json['description'] ?? '',
      inputTokenLimit: json['inputTokenLimit'] ?? 0,
      version: json['version'] ?? '',
    );
  }
}
