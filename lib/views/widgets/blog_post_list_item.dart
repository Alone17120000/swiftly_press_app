// lib/views/widgets/blog_post_list_item.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import gói intl
import '../../config/app_config.dart';
import '../../models/blog_post_model.dart';
import '../../flows/details_content_view.dart';

class BlogPostListItem extends StatelessWidget {
  final BlogPostModel model;

  const BlogPostListItem({super.key, required this.model});

  // Hàm helper để định dạng ngày tháng
  String _getFormattedDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('MMMM d, yyyy').format(dateTime); // Ví dụ: July 9, 2025
    } catch (e) {
      return dateString; // Trả về chuỗi gốc nếu không phân tích được
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = model.embedded.media?.first.medium;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsContentView(post: model),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: imageUrl != null
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2.0, color: AppConfig.actionDarkColor));
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: AppConfig.primaryLightColor),
                    );
                  },
                )
                    : Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.photo, color: AppConfig.primaryLightColor),
                ),
              ),
            ),
            const SizedBox(width: 15),
            // Post Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.tags.toUpperCase(),
                    style: const TextStyle(
                      color: AppConfig.actionLightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    model.title.rendered.replaceAll(RegExp(r'<[^>]*>'), ''),
                    style: const TextStyle(
                      color: AppConfig.primaryDarkColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Hiển thị ngày đã định dạng
                  Text(
                    _getFormattedDate(model.dateGmt),
                    style: TextStyle(
                      color: AppConfig.primaryDarkColor.withOpacity(0.6),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
