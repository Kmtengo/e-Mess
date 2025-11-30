import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAQs',
          style: TextStyle(
            fontFamily: 'BungeeSpice',
            color: Colors.deepOrange,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.deepOrange),
      ),
      body: ListView(
        children: [
          _buildSection(
            'General',
            [
              _buildFAQItem(
                'What is e-Mess?',
                'e-Mess is a digital cafeteria management system that allows students to order and pay for meals using fingerprint authentication.',
              ),
              _buildFAQItem(
                'How do I place an order?',
                'Select your desired meals from the menu, adjust quantities as needed, proceed to authentication using your fingerprint, and collect your receipt.',
              ),
              _buildFAQItem(
                'What payment methods are accepted?',
                'e-Mess uses a prepaid account system. You can top up your account using mobile money or at designated points.',
              ),
            ],
          ),
          _buildSection(
            'Account & Security',
            [
              _buildFAQItem(
                'How do I register my fingerprint?',
                'Visit the cafeteria administration office with your student ID to register your fingerprint in the system.',
              ),
              _buildFAQItem(
                'What if my fingerprint is not recognized?',
                'Try cleaning your finger and the scanner. If the problem persists, visit the administration office for assistance.',
              ),
              _buildFAQItem(
                'How do I check my account balance?',
                'Your current balance is displayed in your profile section. You can also view it during checkout.',
              ),
            ],
          ),
          _buildSection(
            'Orders & Menu',
            [
              _buildFAQItem(
                'What are the serving hours?',
                'Breakfast: 6:30 AM - 9:30 AM\nLunch: 11:30 AM - 2:30 PM\nTea: 4:00 PM - 5:30 PM\nDinner: 6:30 PM - 9:30 PM',
              ),
              _buildFAQItem(
                'Can I cancel my order?',
                'Orders can be cancelled within 5 minutes of placing them. Contact the cafeteria staff for assistance.',
              ),
              _buildFAQItem(
                'Are special dietary requirements accommodated?',
                'Yes, special dietary requirements can be registered with the cafeteria administration.',
              ),
            ],
          ),
          _buildSection(
            'Technical Support',
            [
              _buildFAQItem(
                'What if the app is not working?',
                'The system can work offline. If you encounter any issues, please contact technical support or visit the cafeteria office.',
              ),
              _buildFAQItem(
                'How do I update the app?',
                'The app will automatically notify you when updates are available. You can also check for updates in the settings menu.',
              ),
              _buildFAQItem(
                'Is my data secure?',
                'Yes, we use industry-standard encryption and security measures to protect your personal and payment information.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
