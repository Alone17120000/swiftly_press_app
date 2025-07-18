// lib/config/app_config.dart

import 'package:flutter/material.dart';

/// Enum cho các mục trên thanh điều hướng, tương tự CustomTabBarItem trong Swift
enum CustomTabBarItem {
  discover,
  search,
  favorites,
  settings;

  /// Cung cấp tên hiển thị cho mỗi tab
  String get rawValue {
    switch (this) {
      case CustomTabBarItem.discover:
        return 'Discover';
      case CustomTabBarItem.search:
        return 'Search';
      case CustomTabBarItem.favorites:
        return 'Favorites';
      case CustomTabBarItem.settings:
        return 'Settings';
    }
  }

  /// Cung cấp icon cho mỗi tab
  IconData get icon {
    switch (this) {
      case CustomTabBarItem.discover:
        return Icons.house_rounded;
      case CustomTabBarItem.search:
        return Icons.search;
      case CustomTabBarItem.favorites:
        return Icons.favorite_rounded;
      case CustomTabBarItem.settings:
        return Icons.settings_rounded;
    }
  }
}

/// Lớp chứa các cấu hình chung cho ứng dụng, tương tự AppConfig.swift
class AppConfig {
  // MARK: - Main App Colors
  static const Color backgroundColor = Color(0xFFF4F2F9);
  static const Color primaryLightColor = Color(0xFFCBC9D2);
  static const Color primaryDarkColor = Color(0xFF151A31);
  static const Color actionLightColor = Color(0xFF5D90F7);
  static const Color actionDarkColor = Color(0xFF4773E1);

  // MARK: - Settings flow items
  static const String emailSupport = "support@apps4world.com";
  static final Uri privacyURL = Uri.parse("https://www.google.com/");
  static final Uri termsAndConditionsURL = Uri.parse("https://www.google.com/");
  static final Uri yourAppURL = Uri.parse("https://apps.apple.com/app/idXXXXXXXXX");

  // MARK: - In App Purchases
  static const String premiumVersion = "SwiftlyPress.Premium";
  static const String creditsProductId = "SwiftlyPress.moreCredits";
  static const int defaultCreditsAmount = 2;
  static const int creditsPurchaseAmount = 10;
  static const List<String> premiumFeaturesList = [
    "Unlock Search Feature",
    "Remove All Ads"
  ];

  // MARK: - API Configurations
  static const String apiHost = "https://techcrunch.com";
  static const String _postsEndpoint = "/wp-json/wp/v2/posts?_embed&orderby=date&per_page=<count>";
  static const String _searchEndpoint = "/wp-json/wp/v2/search?_embed&per_page=<count>&search=<query>";

  // MARK: - Generic Configurations
  static const int homePostsLimit = 5;
  static const int searchResultsLimit = 40;

  /// Xây dựng URL để lấy danh sách bài viết
  static String getPostsUrl(int count) {
    return "$apiHost$_postsEndpoint".replaceAll('<count>', count.toString());
  }

  /// Xây dựng URL để tìm kiếm bài viết
  static String getSearchUrl(String query, int count) {
    return "$apiHost$_searchEndpoint"
        .replaceAll('<count>', count.toString())
        .replaceAll('<query>', Uri.encodeComponent(query));
  }

  /// Xây dựng URL để lấy chi tiết một bài viết theo ID
  static String getPostDetailsUrl(int postId) {
    return "$apiHost/wp-json/wp/v2/posts/$postId?_embed";
  }

  // MARK: - Open AI Configurations
  static const String openAIApiKey = "sk-xxxxxxxx";
  static const String openAIApiUrl = "https://api.openai.com/v1/chat/completions";
  static const String systemInstructions = "You are a helpful assistant.";
  static const Map<String, dynamic> apiDefaultSettings = {"model": "gpt-4"};
  static const String summaryPrompt = "Summarize this:\n\n";
}
