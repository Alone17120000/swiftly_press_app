// lib/flows/dashboard_content_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_config.dart';
import '../data/data_manager.dart';
import '../views/home_tab_view.dart';
import '../views/search_tab_view.dart';
import '../views/favorites_tab_view.dart';
import '../views/settings_tab_view.dart';
import 'premium_content_view.dart'; // Import màn hình Premium

/// Widget chính chứa thanh điều hướng và các trang (tabs).
/// Tương ứng với DashboardContentView.swift
class DashboardContentView extends StatefulWidget {
  const DashboardContentView({super.key});

  @override
  State<DashboardContentView> createState() => _DashboardContentViewState();
}

class _DashboardContentViewState extends State<DashboardContentView> {
  // PageController để điều khiển việc chuyển trang bằng cách vuốt hoặc nhấn tab.
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng Consumer để lắng nghe và xây dựng lại UI khi DataManager thay đổi.
    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConfig.backgroundColor,
            elevation: 0,
            title: Text(
              manager.selectedTab.rawValue, // Lấy tên tab từ DataManager
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: AppConfig.primaryDarkColor,
              ),
            ),
            actions: [
              // Hiển thị nút vương miện chỉ ở tab "Discover"
              if (manager.selectedTab == CustomTabBarItem.discover)
                IconButton(
                  icon: const Icon(
                    Icons.workspace_premium, // Icon tương tự "crown.fill"
                    color: AppConfig.primaryDarkColor,
                    size: 28,
                  ),
                  onPressed: () {
                    // Mở màn hình Premium khi nhấn nút
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumContentView(),
                        fullscreenDialog: true, // Hiển thị màn hình từ dưới lên
                      ),
                    );
                  },
                ),
              const SizedBox(width: 8),
            ],
          ),
          // PageView chứa nội dung của các tab
          body: PageView(
            controller: _pageController,
            // Cập nhật trạng thái trong DataManager khi người dùng vuốt qua lại
            onPageChanged: (index) {
              manager.selectedTab = CustomTabBarItem.values[index];
            },
            children: const [
              // Các màn hình cho từng tab
              HomeTabView(),
              SearchTabView(),
              FavoritesTabView(),
              SettingsTabView(),
            ],
          ),
          // Thanh điều hướng dưới cùng
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: manager.selectedTab.index,
            onTap: (index) {
              // Chuyển trang khi người dùng nhấn vào một tab
              _pageController.jumpToPage(index);
            },
            selectedItemColor: AppConfig.actionDarkColor,
            unselectedItemColor: AppConfig.primaryLightColor,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed, // Giữ các item cố định
            showSelectedLabels: false, // Ẩn chữ của tab được chọn
            showUnselectedLabels: false, // Ẩn chữ của tab không được chọn
            items: CustomTabBarItem.values.map((tab) {
              return BottomNavigationBarItem(
                icon: Icon(tab.icon),
                label: tab.rawValue,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
