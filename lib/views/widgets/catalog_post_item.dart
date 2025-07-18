// lib/views/widgets/catalog_post_item.dart

import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../models/blog_post_model.dart';
import '../../flows/details_content_view.dart';

class CatalogPostItem extends StatelessWidget {
  final BlogPostModel model;

  const CatalogPostItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final imageUrl = model.embedded.media?.first.medium;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsContentView(post: model)),
        );
      },
      child: Container(
        width: 150, // Chiều rộng nhỏ hơn
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: AspectRatio(
                aspectRatio: 1, // Hình vuông
                child: imageUrl != null
                    ? Image.network(imageUrl, fit: BoxFit.cover)
                    : Container(color: AppConfig.primaryLightColor),
              ),
            ),
            const SizedBox(height: 8),
            // Tiêu đề
            Text(
              model.title.rendered.replaceAll(RegExp(r'<[^>]*>'), ''),
              style: const TextStyle(
                color: AppConfig.primaryDarkColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}