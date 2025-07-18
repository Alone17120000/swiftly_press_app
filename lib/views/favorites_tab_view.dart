// lib/views/favorites_tab_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_config.dart';
import '../data/data_manager.dart';
import 'widgets/blog_post_list_item.dart';

class FavoritesTabView extends StatelessWidget {
  const FavoritesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        // Khi đang tải, hiển thị vòng quay
        if (manager.isLoadingFavorites) {
          return const Center(child: CircularProgressIndicator());
        }

        // Nếu không có mục yêu thích nào, hiển thị thông báo
        if (manager.favoritePosts.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bookmark_border, size: 60, color: AppConfig.primaryLightColor),
                SizedBox(height: 16),
                Text(
                  'Nothing Here Yet!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppConfig.primaryDarkColor),
                ),
                Text(
                  'Find and favorite posts to see them here',
                  style: TextStyle(fontSize: 16, color: AppConfig.primaryLightColor),
                ),
              ],
            ),
          );
        }

        // Nếu có, hiển thị danh sách
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: manager.favoritePosts.length,
          itemBuilder: (context, index) {
            final post = manager.favoritePosts[index];
            return BlogPostListItem(model: post);
          },
        );
      },
    );
  }
}
