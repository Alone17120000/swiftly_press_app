// lib/views/widgets/carousel_post_item.dart

import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../models/blog_post_model.dart';
import '../../flows/details_content_view.dart';

class CarouselPostItem extends StatelessWidget {
  final BlogPostModel model;

  const CarouselPostItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final imageUrl = model.embedded.media?.first.large;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsContentView(post: model)),
        );
      },
      child: Container(
        width: screenWidth - 100,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Hình ảnh nền
              Positioned.fill(
                child: imageUrl != null
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: AppConfig.primaryLightColor),
                )
                    : Container(color: AppConfig.primaryLightColor),
              ),
              // Lớp phủ mờ ở dưới
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
              ),
              // Nội dung text
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.tags.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.title.rendered.replaceAll(RegExp(r'<[^>]*>'), ''),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
