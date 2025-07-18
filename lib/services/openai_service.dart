// lib/services/openai_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/summary_response_model.dart';
import '../models/api_error_model.dart';

/// Lớp dịch vụ chịu trách nhiệm cho các cuộc gọi API đến OpenAI.
class OpenAiService {
  /// Gửi yêu cầu tóm tắt một đoạn văn bản.
  /// Tương ứng với hàm `summarizePost` và `startAPIRequest` trong DataManager.
  Future<String> summarizeText(String textToSummarize) async {
    final url = Uri.parse(AppConfig.openAIApiUrl);

    // Chuẩn bị header cho yêu cầu
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppConfig.openAIApiKey}',
    };

    // Chuẩn bị phần thân (body) của yêu cầu
    final body = jsonEncode({
      ...AppConfig.apiDefaultSettings, // Sử dụng các cài đặt mặc định
      'messages': [
        {'role': 'system', 'content': AppConfig.systemInstructions},
        {'role': 'user', 'content': '${AppConfig.summaryPrompt}$textToSummarize'},
      ],
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Phân tích phản hồi thành công
        final responseBody = jsonDecode(response.body);
        final summaryResponse = SummaryResponseModel.fromJson(responseBody);

        // Lấy nội dung tóm tắt từ lựa chọn đầu tiên
        final summaryText = summaryResponse.choices.first.message.content;
        return summaryText.trim();
      } else {
        // Xử lý các lỗi HTTP khác
        // Cố gắng phân tích lỗi quota trước
        try {
          final errorBody = jsonDecode(response.body);
          final quotaError = ExceededQuotaModel.fromJson(errorBody);
          if (quotaError.error.type == 'insufficient_quota') {
            throw Exception('Lỗi: Hết hạn ngạch (quota). ${quotaError.error.message}');
          }
        } catch (e) {
          // Nếu không phải lỗi quota, ném lỗi chung
          throw Exception('Lỗi máy chủ với mã trạng thái: ${response.statusCode}');
        }
        throw Exception('Lỗi không xác định với mã trạng thái: ${response.statusCode}');
      }
    } catch (e) {
      // Ném lại lỗi để lớp gọi có thể xử lý
      rethrow;
    }
  }
}
