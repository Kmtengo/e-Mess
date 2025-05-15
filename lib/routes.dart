import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/history_screen.dart';
import 'screens/support_screen.dart';
import 'screens/faq_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/profile': (context) => const ProfileScreen(),
      '/settings': (context) => const SettingsScreen(),
      '/statistics': (context) => const StatisticsScreen(),
      '/history': (context) => const HistoryScreen(),
      '/support': (context) => const SupportScreen(),
      '/faqs': (context) => const FAQScreen(),
    };
  }
}
