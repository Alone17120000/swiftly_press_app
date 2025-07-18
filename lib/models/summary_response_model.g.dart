// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryResponseModel _$SummaryResponseModelFromJson(
        Map<String, dynamic> json) =>
    SummaryResponseModel(
      id: json['id'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SummaryResponseModelToJson(
        SummaryResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'choices': instance.choices.map((e) => e.toJson()).toList(),
    };

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
      message: ChoiceMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'message': instance.message.toJson(),
    };

ChoiceMessage _$ChoiceMessageFromJson(Map<String, dynamic> json) =>
    ChoiceMessage(
      content: json['content'] as String,
    );

Map<String, dynamic> _$ChoiceMessageToJson(ChoiceMessage instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
