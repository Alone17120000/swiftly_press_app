// lib/models/blog_post_model.dart

import 'package:json_annotation/json_annotation.dart';
import 'blog_category_model.dart';
import 'blog_media_model.dart';
import 'rendered_content.dart';

// Dòng này báo cho build_runner biết nó cần tạo file .g.dart cho file này
part 'blog_post_model.g.dart';

// --- Lớp EmbeddedModel ---
// Được định nghĩa ở đây để giữ cấu trúc tương tự file Swift gốc.
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class EmbeddedModel {
  // Map trường 'wp:featuredmedia' từ JSON sang 'media'
  @JsonKey(name: 'wp:featuredmedia')
  final List<BlogMediaModel>? media;

  // Map trường 'wp:term' từ JSON sang 'categories'
  @JsonKey(name: 'wp:term')
  final List<List<BlogCategoryModel>> categories;

  EmbeddedModel({
    this.media,
    required this.categories,
  });

  factory EmbeddedModel.fromJson(Map<String, dynamic> json) => _$EmbeddedModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmbeddedModelToJson(this);
}


// --- Lớp BlogPostModel ---
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BlogPostModel {
  final int id;

  // Map trường 'date_gmt' từ JSON
  @JsonKey(name: 'date_gmt')
  final String dateGmt;

  // Map trường 'modified_gmt' từ JSON
  @JsonKey(name: 'modified_gmt')
  final String modifiedGmt;

  final String link;
  final RenderedContent title;
  final RenderedContent content;
  final RenderedContent excerpt;

  // Map trường 'featured_media' từ JSON
  @JsonKey(name: 'featured_media')
  final int featuredMedia;

  // Map trường '_embedded' từ JSON
  @JsonKey(name: '_embedded')
  final EmbeddedModel embedded;

  BlogPostModel({
    required this.id,
    required this.dateGmt,
    required this.modifiedGmt,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.featuredMedia,
    required this.embedded,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json) => _$BlogPostModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlogPostModelToJson(this);

  // Getter để lấy tags, tương tự như trong Swift
  String get tags {
    final allCategories = embedded.categories.expand((element) => element).toList();
    final tagItems = allCategories.where((e) => e.taxonomy == "post_tag").toList();
    if (tagItems.isEmpty) return "Generic";
    return tagItems.map((e) => e.name).whereType<String>().join(", ");
  }

  // Getter để lấy category, tương tự như trong Swift
  String get category {
    final allCategories = embedded.categories.expand((element) => element).toList();
    final categoryItem = allCategories.firstWhere(
          (e) => e.taxonomy == "category" && e.name?.toLowerCase() != "uncategorized",
      orElse: () => BlogCategoryModel(id: -1, name: "", taxonomy: ""),
    );
    return categoryItem.name ?? "";
  }
}
