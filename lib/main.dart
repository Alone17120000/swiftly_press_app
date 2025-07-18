// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_config.dart';
import 'data/data_manager.dart';
import 'flows/dashboard_content_view.dart';

void main() {
  runApp(
    /// Sử dụng ChangeNotifierProvider để cung cấp một instance của DataManager
    /// cho tất cả các widget con trong cây widget.
    ChangeNotifierProvider(
      create: (context) => DataManager(),
      child: const SwiftlyPressApp(),
    ),
  );
}

/// Lớp tùy chỉnh để tắt hiệu ứng "glow" khi cuộn tới cuối danh sách.
class NoGlowScrollBehavior extends ScrollBehavior {
  const NoGlowScrollBehavior();
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class SwiftlyPressApp extends StatelessWidget {
  const SwiftlyPressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swiftly Press',
      theme: ThemeData(
        // Đặt màu nền chung cho ứng dụng
        scaffoldBackgroundColor: AppConfig.backgroundColor,
        primarySwatch: Colors.blue,
      ),
      // Sử dụng scrollBehavior để tùy chỉnh hiệu ứng cuộn
      scrollBehavior: const NoGlowScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: const DashboardContentView(), // Màn hình chính của ứng dụng
    );
  }
}
