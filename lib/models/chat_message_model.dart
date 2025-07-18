// lib/models/chat_message_model.dart

// Enum để xác định người gửi tin nhắn, tương tự như trong Swift.
enum ChatMessageSender {
  human,
  bot,
}

/// Model để biểu diễn một tin nhắn trong giao diện.
/// Class này không cần json_serializable vì nó được tạo ra
/// bên trong logic của ứng dụng, không phải phân tích trực tiếp từ API.
class ChatMessageModel {
  final String id;
  final DateTime date;
  final String text;
  final ChatMessageSender sender;

  ChatMessageModel({
    required this.id,
    required this.date,
    required this.text,
    required this.sender,
  });
}