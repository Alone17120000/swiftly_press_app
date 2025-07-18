// lib/models/blog_search_result_model.dart

import 'package:json_annotation/json_annotation.dart';

part 'blog_search_result_model.g.dart';

/// Model này dùng để chứa kết quả khi tìm kiếm bài viết.
/// Tương ứng với BlogSearchResultModel.swift
@JsonSerializable()
class BlogSearchResultModel {
  final int id;

  BlogSearchResultModel({required this.id});

  factory BlogSearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$BlogSearchResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogSearchResultModelToJson(this);
}
