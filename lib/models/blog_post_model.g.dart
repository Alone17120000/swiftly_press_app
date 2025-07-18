// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmbeddedModel _$EmbeddedModelFromJson(Map<String, dynamic> json) =>
    EmbeddedModel(
      media: (json['wp:featuredmedia'] as List<dynamic>?)
          ?.map((e) => BlogMediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['wp:term'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => BlogCategoryModel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$EmbeddedModelToJson(EmbeddedModel instance) =>
    <String, dynamic>{
      'wp:featuredmedia': instance.media?.map((e) => e.toJson()).toList(),
      'wp:term': instance.categories
          .map((e) => e.map((e) => e.toJson()).toList())
          .toList(),
    };

BlogPostModel _$BlogPostModelFromJson(Map<String, dynamic> json) =>
    BlogPostModel(
      id: (json['id'] as num).toInt(),
      dateGmt: json['date_gmt'] as String,
      modifiedGmt: json['modified_gmt'] as String,
      link: json['link'] as String,
      title: RenderedContent.fromJson(json['title'] as Map<String, dynamic>),
      content:
          RenderedContent.fromJson(json['content'] as Map<String, dynamic>),
      excerpt:
          RenderedContent.fromJson(json['excerpt'] as Map<String, dynamic>),
      featuredMedia: (json['featured_media'] as num).toInt(),
      embedded:
          EmbeddedModel.fromJson(json['_embedded'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogPostModelToJson(BlogPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date_gmt': instance.dateGmt,
      'modified_gmt': instance.modifiedGmt,
      'link': instance.link,
      'title': instance.title.toJson(),
      'content': instance.content.toJson(),
      'excerpt': instance.excerpt.toJson(),
      'featured_media': instance.featuredMedia,
      '_embedded': instance.embedded.toJson(),
    };
