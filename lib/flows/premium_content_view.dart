// lib/flows/premium_content_view.dart

import 'package:flutter/material.dart';
import '../config/app_config.dart';

class PremiumContentView extends StatelessWidget {
  const PremiumContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Nền Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppConfig.actionLightColor, AppConfig.actionDarkColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Nội dung chính
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Icon Vương miện
                    const Icon(Icons.workspace_premium, size: 100, color: Colors.white),
                    const SizedBox(height: 20),
                    // Tiêu đề
                    const Text(
                      "Premium Version",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Unlock All Features",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Danh sách các tính năng
                    ...AppConfig.premiumFeaturesList.map((feature) => _buildFeatureRow(feature)),
                    const SizedBox(height: 50),
                    // Nút Mua hàng
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Xử lý logic mua hàng
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppConfig.actionDarkColor,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        "Upgrade Now", // Giá sẽ được thêm vào sau
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Nút Khôi phục giao dịch
                    TextButton(
                      onPressed: () {
                        // TODO: Xử lý logic khôi phục giao dịch
                      },
                      child: const Text(
                        "Restore Purchases",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          // Nút Đóng
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper để hiển thị mỗi dòng tính năng
  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
