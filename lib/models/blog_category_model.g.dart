// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogCategoryModel _$BlogCategoryModelFromJson(Map<String, dynamic> json) =>
    BlogCategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      taxonomy: json['taxonomy'] as String?,
    );

Map<String, dynamic> _$BlogCategoryModelToJson(BlogCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taxonomy': instance.taxonomy,
    };
