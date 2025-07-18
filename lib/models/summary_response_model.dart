// lib/models/summary_response_model.dart

import 'package:json_annotation/json_annotation.dart';

part 'summary_response_model.g.dart';

/// Model này ánh xạ với cấu trúc JSON trả về từ API tóm tắt.
/// Tương ứng với `SummaryResponseModel` và `ChatMessageResponse` trong Swift.
@JsonSerializable(explicitToJson: true)
class SummaryResponseModel {
  final String id;
  final List<Choice> choices;

  SummaryResponseModel({
    required this.id,
    required this.choices,
  });

  factory SummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$SummaryResponseModelToJson(this);
}

/// Tương ứng với struct `Choice` trong Swift.
@JsonSerializable(explicitToJson: true)
class Choice {
  final ChoiceMessage message;

  Choice({required this.message});

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}

/// Tương ứng với struct `ChoiceMessage` trong Swift.
@JsonSerializable(explicitToJson: true)
class ChoiceMessage {
  final String content;

  ChoiceMessage({required this.content});

  factory ChoiceMessage.fromJson(Map<String, dynamic> json) =>
      _$ChoiceMessageFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceMessageToJson(this);
}
