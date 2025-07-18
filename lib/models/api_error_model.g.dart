// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExceededQuotaModel _$ExceededQuotaModelFromJson(Map<String, dynamic> json) =>
    ExceededQuotaModel(
      error:
          ApiErrorDetailModel.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExceededQuotaModelToJson(ExceededQuotaModel instance) =>
    <String, dynamic>{
      'error': instance.error.toJson(),
    };

ApiErrorDetailModel _$ApiErrorDetailModelFromJson(Map<String, dynamic> json) =>
    ApiErrorDetailModel(
      message: json['message'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ApiErrorDetailModelToJson(
        ApiErrorDetailModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': instance.type,
    };
