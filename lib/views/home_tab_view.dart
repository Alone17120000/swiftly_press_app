// lib/views/home_tab_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_manager.dart';
import 'widgets/blog_post_list_item.dart';
import 'widgets/carousel_post_item.dart';
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: BlogPostListItem(model: featuredPost),
              ),
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
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
