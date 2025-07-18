// lib/models/api_error_model.dart

import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

/// Tương ứng với struct `ExceededQuota` trong Swift.
/// Dùng để phân tích cấu trúc JSON của lỗi.
@JsonSerializable(explicitToJson: true)
class ExceededQuotaModel {
  final ApiErrorDetailModel error;

  ExceededQuotaModel({required this.error});

  factory ExceededQuotaModel.fromJson(Map<String, dynamic> json) =>
      _$ExceededQuotaModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExceededQuotaModelToJson(this);
}

/// Tương ứng với struct `APIErrorDetail` trong Swift.
@JsonSerializable()
class ApiErrorDetailModel {
  final String message;
  final String type;

  ApiErrorDetailModel({
    required this.message,
    required this.type,
  });

  factory ApiErrorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorDetailModelToJson(this);
}
