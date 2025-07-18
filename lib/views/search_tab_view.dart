// lib/views/search_tab_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_config.dart';
import '../data/data_manager.dart';
import 'widgets/blog_post_list_item.dart';
import 'widgets/error_display_widget.dart';

class SearchTabView extends StatefulWidget {
  const SearchTabView({super.key});

  @override
  State<SearchTabView> createState() => _SearchTabViewState();
}

class _SearchTabViewState extends State<SearchTabView> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search Blogs',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                Provider.of<DataManager>(context, listen: false).searchPosts(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<DataManager>(
              builder: (context, manager, child) {
                return _buildSearchResults(context, manager);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, DataManager manager) {
    if (manager.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (manager.errorMessage != null && manager.searchResults.isEmpty) {
      return ErrorDisplayWidget(
        message: manager.errorMessage!,
        onRetry: () {
          if (_textController.text.isNotEmpty) {
            manager.searchPosts(_textController.text);
          }
        },
      );
    }

    if (manager.searchResults.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60, color: AppConfig.primaryLightColor),
            SizedBox(height: 16),
            Text('Explore Posts', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppConfig.primaryDarkColor)),
            Text('Discover stories, ideas, and more', style: TextStyle(fontSize: 16, color: AppConfig.primaryLightColor)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: manager.searchResults.length,
      itemBuilder: (context, index) {
        final post = manager.searchResults[index];
        return BlogPostListItem(model: post);
      },
    );
  }
}
