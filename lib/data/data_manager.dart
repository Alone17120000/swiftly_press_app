// lib/data/data_manager.dart

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';
import '../models/blog_post_model.dart';
import '../services/openai_service.dart';
import '../services/wordpress_service.dart';

// Keys for SharedPreferences
const String _kFavoriteItemsKey = "favoriteItems";
const String _kPremiumUserKey = "isPremiumUser";
const String _kCreditsBalanceKey = "creditsBalance";

class DataManager extends ChangeNotifier {
  final WordpressService _wordpressService = WordpressService();
  final OpenAiService _openAiService = OpenAiService();

  // --- Trạng thái ---
  bool _isLoading = false, _isSearching = false, _isLoadingFavorites = false, _isSummarizing = false;
  List<BlogPostModel> _homePosts = [], _searchResults = [], _favoritePosts = [];
  CustomTabBarItem _selectedTab = CustomTabBarItem.discover;
  List<String> _favoritePostIds = [];
  bool _isPremiumUser = false;
  int _creditsBalance = AppConfig.defaultCreditsAmount;
  final Map<int, String> _summaries = {};
  String? _errorMessage;

  // --- Getters ---
  bool get isLoading => _isLoading;
  List<BlogPostModel> get homePosts => _homePosts;
  CustomTabBarItem get selectedTab => _selectedTab;
  bool get isSearching => _isSearching;
  List<BlogPostModel> get searchResults => _searchResults;
  List<String> get favoritePostIds => _favoritePostIds;
  List<BlogPostModel> get favoritePosts => _favoritePosts;
  bool get isLoadingFavorites => _isLoadingFavorites;
  bool get isPremiumUser => _isPremiumUser;
  int get creditsBalance => _creditsBalance;
  bool get isSummarizing => _isSummarizing;
  Map<int, String> get summaries => _summaries;
  String? get errorMessage => _errorMessage;

  DataManager() {
    _loadInitialData();
  }

  void _loadInitialData() async {
    await _loadPersistedData();
    fetchHomePosts();
  }

  Future<void> _loadPersistedData() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteString = prefs.getString(_kFavoriteItemsKey) ?? '';
    _favoritePostIds = favoriteString.split(',').where((id) => id.isNotEmpty).toList();
    _isPremiumUser = prefs.getBool(_kPremiumUserKey) ?? false;
    _creditsBalance = prefs.getInt(_kCreditsBalanceKey) ?? AppConfig.defaultCreditsAmount;
    notifyListeners();
  }

  set selectedTab(CustomTabBarItem tab) {
    if (_selectedTab != tab) {
      _selectedTab = tab;
      notifyListeners();
      if (tab == CustomTabBarItem.favorites) {
        fetchFavoritePosts();
      }
    }
  }

  Future<void> toggleFavorite(int postId) async {
    final prefs = await SharedPreferences.getInstance();
    final id = postId.toString();

    if (_favoritePostIds.contains(id)) {
      _favoritePostIds.remove(id);
    } else {
      _favoritePostIds.add(id);
    }

    await prefs.setString(_kFavoriteItemsKey, _favoritePostIds.join(','));
    notifyListeners();
    await fetchFavoritePosts();
  }

  Future<void> fetchHomePosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _homePosts = await _wordpressService.fetchHomePosts();
    } catch (e) {
      _errorMessage = "Could not load posts. Please check your connection.";
      _homePosts = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFavoritePosts() async {
    if (_favoritePostIds.isEmpty) {
      _favoritePosts = [];
      notifyListeners();
      return;
    }
    _isLoadingFavorites = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final detailedPosts = await Future.wait(
        _favoritePostIds.map((id) => _wordpressService.fetchPostDetails(int.parse(id))),
      );
      _favoritePosts = detailedPosts;
    } catch (e) {
      _errorMessage = "Could not load favorites. Please try again.";
      _favoritePosts = [];
    }
    _isLoadingFavorites = false;
    notifyListeners();
  }

  Future<void> summarizePost(BlogPostModel post) async {
    if (_creditsBalance <= 0) {
      throw Exception("You are out of credits. Please buy more in Settings.");
    }
    _isSummarizing = true;
    notifyListeners();
    try {
      final contentToSummarize = post.content.rendered.replaceAll(RegExp(r'<[^>]*>'), '');
      final summary = await _openAiService.summarizeText(contentToSummarize);
      _summaries[post.id] = summary;
      _creditsBalance--;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_kCreditsBalanceKey, _creditsBalance);
    } catch (e) {
      throw Exception("Failed to summarize. Please try again.");
    } finally {
      _isSummarizing = false;
      notifyListeners();
    }
  }

  Future<void> searchPosts(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }
    _isSearching = true;
    _errorMessage = null;
    _searchResults = [];
    notifyListeners();

    try {
      debugPrint("Bắt đầu tìm kiếm với từ khóa: '$query'");
      final searchIdResults = await _wordpressService.searchPosts(query);
      debugPrint("Tìm thấy ${searchIdResults.length} ID kết quả.");

      if (searchIdResults.isNotEmpty) {
        List<BlogPostModel> validPosts = [];
        for (var result in searchIdResults) {
          try {
            final post = await _wordpressService.fetchPostDetails(result.id);
            validPosts.add(post);
          } catch (e) {
            debugPrint("Bỏ qua bài viết bị lỗi với ID: ${result.id}. Lỗi: $e");
          }
        }
        _searchResults = validPosts;
        debugPrint("Đã tải thành công chi tiết cho ${_searchResults.length} bài viết.");
      } else {
        _searchResults = [];
      }
    } catch (e) {
      debugPrint("--- LỖI KHI TÌM KIẾM ---");
      debugPrint(e.toString());
      debugPrint("-------------------------");
      _errorMessage = "Could not perform search. Please try again.";
      _searchResults = [];
    }

    _isSearching = false;
    notifyListeners();
  }
}
