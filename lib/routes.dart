import 'package:flutter/material.dart';
import 'screens/authentication_screen.dart';
import 'checkout.dart';
import 'screens/confirmation_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/history_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/support_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'main.dart';

class AppRoutes {
  static const String home = '/';
  static const String authentication = '/authentication';
  static const String checkout = '/checkout';
  static const String confirmation = '/confirmation';
  static const String faq = '/faq';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String statistics = '/statistics';
  static const String support = '/support';
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      authentication: (context) => const AuthenticationScreen(),
      checkout: (context) =>
          const CheckoutPage(selectedMeals: [], totalAmount: 0.0),
      confirmation: (context) => const ConfirmationScreen(),
      faq: (context) => const FAQScreen(),
      history: (context) => const HistoryScreen(),
      profile: (context) => const ProfileScreen(),
      settings: (context) => const SettingsScreen(),
      statistics: (context) => const StatisticsScreen(),
      support: (context) => const SupportScreen(),
      splash: (context) => const SplashScreen(),
      onboarding: (context) => const OnboardingScreen(),
      login: (context) => const LoginScreen(),
      signup: (context) => const SignupScreen(),
    };
  }
}
