import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@e-mess.com',
      queryParameters: {
        'subject': 'E-Mess Support Request',
      },
    );
    
    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch email');
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '+254123456789',
    );
    
    if (!await launchUrl(phoneLaunchUri)) {
      throw Exception('Could not launch phone');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Support',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How can we help you?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Choose your preferred way to get in touch with us',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildContactOption(
              icon: Icons.email,
              title: 'Email Us',
              subtitle: 'support@e-mess.com',
              onTap: _launchEmail,
            ),
            _buildContactOption(
              icon: Icons.phone,
              title: 'Call Us',
              subtitle: '+254 123 456 789',
              onTap: _launchPhone,
            ),
            _buildContactOption(
              icon: Icons.chat,
              title: 'Live Chat',
              subtitle: 'Available 24/7',
              onTap: () {
                // TODO: Implement live chat
              },
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Common Issues',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCommonIssue(
                      'Payment not going through?',
                      'Make sure you have sufficient balance and try again.',
                    ),
                    _buildCommonIssue(
                      'Can\'t place an order?',
                      'Check your internet connection and try again.',
                    ),
                    _buildCommonIssue(
                      'Fingerprint not working?',
                      'Try re-registering your fingerprint in settings.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Operating Hours',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildOperatingHours('Monday - Friday', '6:00 AM - 10:00 PM'),
                    _buildOperatingHours('Saturday', '7:00 AM - 9:00 PM'),
                    _buildOperatingHours('Sunday', '8:00 AM - 8:00 PM'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildCommonIssue(String title, String solution) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(solution),
        ),
      ],
    );
  }

  Widget _buildOperatingHours(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(hours),
        ],
      ),
    );
  }
}
