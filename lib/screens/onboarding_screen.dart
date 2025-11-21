import 'package:flutter/material.dart';
import 'package:e_mess/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Skip the Queue",
      "description": "Experience lightning-fast service with our responsive touchscreens. Say goodbye to long lines.",
      "icon": "access_time_filled_rounded", // Using icon names to map to Icons later
    },
    {
      "title": "Secure Transactions",
      "description": "Top up easily and pay securely using biometric scanners. Your funds are safe.",
      "icon": "fingerprint_rounded",
    },
    {
      "title": "Always Available",
      "description": "Enjoy seamless service delivery that works even when offline. e-Mess is always ready.",
      "icon": "wifi_off_rounded",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  title: _onboardingData[index]["title"]!,
                  description: _onboardingData[index]["description"]!,
                  iconData: _getIconData(_onboardingData[index]["icon"]!),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  if (_currentPage != _onboardingData.length - 1)
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                          fontFamily: 'NunitoSans',
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60), // Spacer to balance layout

                  // Page Indicators
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => buildDot(index: index),
                    ),
                  ),

                  // Next/Get Started Button
                  if (_currentPage == _onboardingData.length - 1)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(12),
                      ),
                      child: const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'access_time_filled_rounded':
        return Icons.access_time_filled_rounded;
      case 'fingerprint_rounded':
        return Icons.fingerprint_rounded;
      case 'wifi_off_rounded':
        return Icons.wifi_off_rounded;
      default:
        return Icons.info;
    }
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.deepOrange : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 150,
            color: Colors.teal,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'BungeeSpice',
              fontSize: 30,
              color: Colors.deepOrange,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'NunitoSans',
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
