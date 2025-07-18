// lib/services/wordpress_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/blog_post_model.dart';
import '../models/blog_search_result_model.dart';

/// Lớp dịch vụ chịu trách nhiệm cho tất cả các cuộc gọi API đến WordPress.
class WordpressService {
  /// Lấy danh sách các bài viết mới nhất cho trang chủ.
  /// Tương ứng với hàm `fetchHomePosts` trong DataManager.
  Future<List<BlogPostModel>> fetchHomePosts() async {
    final url = AppConfig.getPostsUrl(AppConfig.homePostsLimit);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Nếu máy chủ trả về phản hồi OK, phân tích JSON.
      List<dynamic> body = jsonDecode(response.body);
      List<BlogPostModel> posts = body
          .map(
            (dynamic item) => BlogPostModel.fromJson(item as Map<String, dynamic>),
      )
          .toList();
      return posts;
    } else {
      // Nếu phản hồi không OK, ném ra một ngoại lệ.
      throw Exception('Failed to load posts');
    }
  }

  /// Tìm kiếm bài viết dựa trên một truy vấn.
  /// Tương ứng với hàm `searchBlogPosts` trong DataManager.
  Future<List<BlogSearchResultModel>> searchPosts(String query) async {
    final url = AppConfig.getSearchUrl(query, AppConfig.searchResultsLimit);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<BlogSearchResultModel> results = body
          .map(
            (dynamic item) => BlogSearchResultModel.fromJson(item as Map<String, dynamic>),
      )
          .toList();
      return results;
    } else {
      throw Exception('Failed to search posts');
    }
  }

  /// Lấy chi tiết của một bài viết dựa trên ID của nó.
  /// Tương ứng với hàm `fetchBlogPostDetails` trong DataManager.
  Future<BlogPostModel> fetchPostDetails(int postId) async {
    final url = AppConfig.getPostDetailsUrl(postId);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // API chi tiết bài viết của WordPress đôi khi trả về một đối tượng trực tiếp
      // thay vì một danh sách. Chúng ta cần xử lý cả hai trường hợp.
      dynamic body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) {
        return BlogPostModel.fromJson(body);
      } else {
        throw Exception('Unexpected format for post details');
      }
    } else {
      throw Exception('Failed to load post details for id: $postId');
    }
  }
}
