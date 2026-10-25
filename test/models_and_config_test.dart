import 'package:flutter_test/flutter_test.dart';
import 'package:ai_offline_app/data/models/chat_model.dart';
import 'package:ai_offline_app/data/models/image_model.dart';
import 'package:ai_offline_app/core/config/api_config.dart';

void main() {
  group('ChatMessage Model Tests', () {
    test('serialization to and from Map preserves all fields', () {
      final now = DateTime.utc(2026, 10, 25, 12, 0, 0);
      final message = ChatMessage(
        id: 'msg-101',
        message: 'Explain transformer architectures',
        response: 'Transformers rely on self-attention mechanisms.',
        timestamp: now,
        isUserMessage: false,
        confidence: 0.96,
      );

      final map = message.toMap();
      expect(map['id'], 'msg-101');
      expect(map['message'], 'Explain transformer architectures');
      expect(map['response'], 'Transformers rely on self-attention mechanisms.');
      expect(map['isUserMessage'], false);
      expect(map['confidence'], 0.96);

      final reconstructed = ChatMessage.fromMap(map);
      expect(reconstructed.id, message.id);
      expect(reconstructed.message, message.message);
      expect(reconstructed.response, message.response);
      expect(reconstructed.isUserMessage, message.isUserMessage);
      expect(reconstructed.confidence, message.confidence);
    });

    test('copyWith updates specified fields only', () {
      final message = ChatMessage(
        id: 'msg-001',
        message: 'Original message',
        response: 'Original response',
        timestamp: DateTime.now(),
        isUserMessage: true,
      );

      final updated = message.copyWith(response: 'New response', isUserMessage: false);
      expect(updated.id, 'msg-001');
      expect(updated.message, 'Original message');
      expect(updated.response, 'New response');
      expect(updated.isUserMessage, false);
    });
  });

  group('GeneratedImage Model Tests', () {
    test('GeneratedImage fromMap parses correctly', () {
      final now = DateTime.utc(2026, 10, 25, 14, 30, 0);
      final img = GeneratedImage(
        id: 'img-505',
        prompt: 'Futuristic solar observatory in desert',
        imagePath: '/data/user/0/com.ai.offline/images/img-505.png',
        timestamp: now,
        style: 'artistic',
        qualityScore: 0.92,
      );

      final map = img.toMap();
      expect(map['id'], 'img-505');
      expect(map['style'], 'artistic');
      expect(map['qualityScore'], 0.92);

      final restored = GeneratedImage.fromMap(map);
      expect(restored.prompt, img.prompt);
      expect(restored.imagePath, img.imagePath);
      expect(restored.style, 'artistic');
    });
  });

  group('ApiConfig Tests', () {
    test('getEndpoint builds valid URL', () {
      final endpoint = ApiConfig.getEndpoint('chat/completions');
      expect(endpoint, 'https://api.openai.com/v1/chat/completions');
    });

    test('setApiKey updates runtime key', () {
      const testKey = 'sk-test-custom-key-12345';
      ApiConfig.setApiKey(testKey);
      expect(ApiConfig.apiKey, testKey);
    });
  });
}
