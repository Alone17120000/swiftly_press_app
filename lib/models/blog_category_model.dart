import 'package:json_annotation/json_annotation.dart';

part 'blog_category_model.g.dart'; // Dòng này báo cho build_runner biết nó cần tạo file .g.dart cho lớp này

@JsonSerializable(fieldRename: FieldRename.snake) // Tự động chuyển đổi tên trường từ snake_case (ví dụ: category_id thành categoryId)
class BlogCategoryModel {
  final int id;
  final String? name;
  final String? taxonomy; // Loại phân loại (ví dụ: 'category' hoặc 'post_tag')

  BlogCategoryModel({required this.id, this.name, this.taxonomy});

  // Factory constructor để tạo instance từ JSON
  factory BlogCategoryModel.fromJson(Map<String, dynamic> json) => _$BlogCategoryModelFromJson(json);

  // Phương thức để chuyển đổi sang JSON
  Map<String, dynamic> toJson() => _$BlogCategoryModelToJson(this);

  // Preview/Demo model (tương tự như trong iOS)
  static BlogCategoryModel preview = BlogCategoryModel(id: 1, name: "Health", taxonomy: "category");
}