// lib/views/settings_tab_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart'; // Thêm gói để đánh giá
import 'package:share_plus/share_plus.dart'; // Thêm gói để chia sẻ
import '../config/app_config.dart';
import '../data/data_manager.dart';
import '../flows/premium_content_view.dart'; // Import màn hình Premium

class SettingsTabView extends StatelessWidget {
  const SettingsTabView({super.key});

  // Hàm helper để mở URL
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Hiển thị thông báo nếu không mở được URL
    }
  }

  // Hàm helper để hiển thị SnackBar thông báo tính năng chưa hoàn thiện
  void _showFeatureNotImplemented(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName feature is not yet implemented.'),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final InAppReview inAppReview = InAppReview.instance;

    return Consumer<DataManager>(
      builder: (context, manager, child) {
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // --- Phần In-App Purchases ---
            _buildSectionHeader("In-App Purchases"),
            _buildSectionContainer(
              child: Column(
                children: [
                  if (!manager.isPremiumUser)
                    _SettingsItem(
                      title: "Upgrade Premium",
                      icon: Icons.workspace_premium,
                      onTap: () {
                        // Mở màn hình Premium
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PremiumContentView(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                    ),
                  if (!manager.isPremiumUser) const Divider(height: 1),
                  _SettingsItem(
                    title: "Restore Purchases",
                    icon: Icons.restore,
                    onTap: () {
                      _showFeatureNotImplemented(context, "Restore Purchases");
                    },
                  ),
                  const Divider(height: 1),
                  _SettingsItem(
                    title: "Buy More Credits",
                    icon: Icons.add_circle_outline,
                    trailing: Text("Balance: ${manager.creditsBalance}"),
                    onTap: () {
                      _showFeatureNotImplemented(context, "Buy More Credits");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- Phần Spread the Word ---
            _buildSectionHeader("Spread the Word"),
            _buildSectionContainer(
              child: Column(
                children: [
                  _SettingsItem(
                    title: "Rate App",
                    icon: Icons.star,
                    onTap: () async {
                      // Yêu cầu đánh giá trong ứng dụng
                      if (await inAppReview.isAvailable()) {
                        inAppReview.requestReview();
                      } else {
                        // Nếu không được, mở trang cửa hàng ứng dụng
                        _launchUrl(AppConfig.yourAppURL);
                      }
                    },
                  ),
                  const Divider(height: 1),
                  _SettingsItem(
                    title: "Share App",
                    icon: Icons.share,
                    onTap: () {
                      // Mở dialog chia sẻ của hệ thống
                      Share.share('Check out this amazing app! ${AppConfig.yourAppURL.toString()}');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- Phần Support & Privacy ---
            _buildSectionHeader("Support & Privacy"),
            _buildSectionContainer(
              child: Column(
                children: [
                  _SettingsItem(
                    title: "E-Mail us",
                    icon: Icons.email,
                    onTap: () => _launchUrl(Uri.parse('mailto:${AppConfig.emailSupport}')),
                  ),
                  const Divider(height: 1),
                  _SettingsItem(
                    title: "Privacy Policy",
                    icon: Icons.shield,
                    onTap: () => _launchUrl(AppConfig.privacyURL),
                  ),
                  const Divider(height: 1),
                  _SettingsItem(
                    title: "Terms of Use",
                    icon: Icons.description,
                    onTap: () => _launchUrl(AppConfig.termsAndConditionsURL),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget helper để tạo tiêu đề cho mỗi phần
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // Widget helper để tạo khung chứa cho mỗi phần
  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}

// Widget helper cho mỗi mục trong cài đặt
class _SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.title,
    required this.icon,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppConfig.primaryDarkColor),
      title: Text(title, style: const TextStyle(color: AppConfig.primaryDarkColor)),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
