// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogMediaModel _$BlogMediaModelFromJson(Map<String, dynamic> json) =>
    BlogMediaModel(
      id: (json['id'] as num).toInt(),
      mediaType: $enumDecode(_$BlogMediaTypeEnumMap, json['media_type']),
      mediaDetails: BlogMediaDetails.fromJson(
          json['media_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogMediaModelToJson(BlogMediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'media_type': _$BlogMediaTypeEnumMap[instance.mediaType]!,
      'media_details': instance.mediaDetails,
    };

const _$BlogMediaTypeEnumMap = {
  BlogMediaType.image: 'image',
  BlogMediaType.video: 'video',
  BlogMediaType.text: 'text',
  BlogMediaType.application: 'application',
  BlogMediaType.audio: 'audio',
};

BlogMediaDetails _$BlogMediaDetailsFromJson(Map<String, dynamic> json) =>
    BlogMediaDetails(
      sizes: BlogMediaSizes.fromJson(json['sizes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogMediaDetailsToJson(BlogMediaDetails instance) =>
    <String, dynamic>{
      'sizes': instance.sizes,
    };

BlogMediaSizes _$BlogMediaSizesFromJson(Map<String, dynamic> json) =>
    BlogMediaSizes(
      medium: json['medium'] == null
          ? null
          : BlogMediaSize.fromJson(json['medium'] as Map<String, dynamic>),
      large: json['large'] == null
          ? null
          : BlogMediaSize.fromJson(json['large'] as Map<String, dynamic>),
      thumbnail: json['thumbnail'] == null
          ? null
          : BlogMediaSize.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogMediaSizesToJson(BlogMediaSizes instance) =>
    <String, dynamic>{
      'medium': instance.medium,
      'large': instance.large,
      'thumbnail': instance.thumbnail,
    };

BlogMediaSize _$BlogMediaSizeFromJson(Map<String, dynamic> json) =>
    BlogMediaSize(
      source: json['source_url'] as String,
    );

Map<String, dynamic> _$BlogMediaSizeToJson(BlogMediaSize instance) =>
    <String, dynamic>{
      'source_url': instance.source,
    };
