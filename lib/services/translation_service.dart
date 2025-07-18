// lib/services/translation_service.dart

import 'package:translator/translator.dart';

/// Lớp dịch vụ này sử dụng gói 'translator' miễn phí.
class TranslationService {
  final _translator = GoogleTranslator();

  /// Dịch văn bản sang tiếng Việt (mặc định)
  Future<String> translateText(String text, {String toLanguage = 'vi'}) async {
    try {
      // Gói này không cần API key
      final translation = await _translator.translate(text, to: toLanguage);
      return translation.text;
    } catch (e) {
      print("Lỗi dịch thuật: $e");
      throw Exception('Không thể dịch văn bản.');
    }
  }
}