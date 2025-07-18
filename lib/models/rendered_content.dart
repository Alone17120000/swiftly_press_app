import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart'; // Để có thể sử dụng các loại widget Flutter sau này (nếu cần)

part 'rendered_content.g.dart'; // Dòng này báo cho build_runner biết nó cần tạo file .g.dart cho lớp này

@JsonSerializable() // Annotation này đánh dấu lớp này sẽ được tự động tạo mã JSON
class RenderedContent {
  final String rendered;

  RenderedContent({required this.rendered});

  // Factory constructor để tạo một instance của RenderedContent từ một Map (JSON)
  // Đây là phương thức quan trọng để phân tích JSON
  factory RenderedContent.fromJson(Map<String, dynamic> json) => _$RenderedContentFromJson(json);

  // Phương thức để chuyển đổi một instance của RenderedContent thành một Map (JSON)
  Map<String, dynamic> toJson() => _$RenderedContentToJson(this);

  // Tương tự như 'formattedString' trong Swift
  // Trong Flutter, chúng ta thường xử lý HTML bằng các gói như flutter_html
  // Tạm thời, nó chỉ trả về chuỗi gốc.
  String get formattedString => rendered;
}