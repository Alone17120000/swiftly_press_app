// lib/views/home_tab_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_config.dart';
import '../data/data_manager.dart';
import 'widgets/blog_post_list_item.dart';
import 'widgets/carousel_post_item.dart';
import 'widgets/catalog_post_item.dart'; // MỚI: Import widget catalog
import 'widgets/error_display_widget.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        if (manager.isLoading && manager.homePosts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (manager.errorMessage != null && manager.homePosts.isEmpty) {
          return ErrorDisplayWidget(
            message: manager.errorMessage!,
            onRetry: () => manager.fetchHomePosts(),
          );
        }

        if (manager.homePosts.isEmpty) {
          return const Center(child: Text('Không có bài viết nào.'));
        }

        final featuredPost = manager.homePosts.first;
        final carouselPosts = manager.homePosts.skip(1).toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. PHẦN BÀI VIẾT NỔI BẬT (GIỮ NGUYÊN)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: BlogPostListItem(model: featuredPost),
              ),

              // 2. PHẦN CAROUSEL BAN ĐẦU (GIỮ NGUYÊN)
              SizedBox(
                height: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: carouselPosts.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemBuilder: (context, index) {
                    final post = carouselPosts[index];
                    return CarouselPostItem(model: post);
                  },
                ),
              ),
              const SizedBox(height: 24),

              // 3. MỚI: PHẦN TRENDING
              _buildSectionHeader("Trending"),
              SizedBox(
                height: 220, // Chiều cao nhỏ hơn cho phần này
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: manager.trendingPosts.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemBuilder: (context, index) {
                    final post = manager.trendingPosts[index];
                    // Tái sử dụng CarouselPostItem với kích thước khác
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: CarouselPostItem(model: post));
                  },
                ),
              ),
              const SizedBox(height: 24),

              // 4. MỚI: PHẦN CATALOG
              _buildSectionHeader("All Catalogs"),
              SizedBox(
                height: 220, // Chiều cao cho các item catalog
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: manager.catalogPosts.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemBuilder: (context, index) {
                    final post = manager.catalogPosts[index];
                    // Sử dụng widget mới CatalogPostItem
                    return CatalogPostItem(model: post);
                  },
                ),
              ),
              const SizedBox(height: 20), // Khoảng trống ở cuối
            ],
          ),
        );
      },
    );
  }

  // Widget helper để tạo tiêu đề cho mỗi phần
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 16, 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppConfig.primaryDarkColor,
        ),
      ),
    );
  }
}