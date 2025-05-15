import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch \$url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.tealAccent,
            ),            currentAccountPicture: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            accountName: Text(
              'John Doe', // TODO: Replace with actual user name
              style: TextStyle(
                color: Colors.deepOrange,
                fontFamily: 'BungeeSpice',
                fontSize: 18,
              ),
            ),
            accountEmail: Text(
              'johndoe@student.ac.ke', // TODO: Replace with actual email
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.teal),
                  title: Text('Settings'),
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                ),
                ListTile(
                  leading: Icon(Icons.bar_chart, color: Colors.teal),
                  title: Text('Statistics'),
                  onTap: () => Navigator.pushNamed(context, '/statistics'),
                ),
                ListTile(
                  leading: Icon(Icons.history, color: Colors.teal),
                  title: Text('History'),
                  onTap: () => Navigator.pushNamed(context, '/history'),
                ),
                ListTile(
                  leading: Icon(Icons.support_agent, color: Colors.teal),
                  title: Text('Support'),
                  onTap: () => Navigator.pushNamed(context, '/support'),
                ),
                ListTile(
                  leading: Icon(Icons.question_answer, color: Colors.teal),
                  title: Text('FAQs'),
                  onTap: () => Navigator.pushNamed(context, '/faqs'),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Socials',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [                    IconButton(
                      icon: Icon(Icons.business, color: Colors.blue),
                      onPressed: () => _launchUrl('https://linkedin.com/company/e-mess'),
                    ),
                    IconButton(
                      icon: Icon(Icons.webhook, color: Colors.black), // X (Twitter) icon
                      onPressed: () => _launchUrl('https://x.com/e_mess'),
                    ),
                    IconButton(
                      icon: Icon(Icons.youtube_searched_for, color: Colors.red),
                      onPressed: () => _launchUrl('https://youtube.com/@e_mess'),
                    ),
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'About',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.star, color: Colors.amber),
                  title: Text('Rate us'),
                  onTap: () => _launchUrl('https://play.google.com/store/apps/details?id=com.example.e_mess'),
                ),
                ListTile(
                  leading: Icon(Icons.description, color: Colors.teal),
                  title: Text('Terms & Conditions'),
                  onTap: () => Navigator.pushNamed(context, '/terms'),
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip, color: Colors.teal),
                  title: Text('Privacy Policy'),
                  onTap: () => Navigator.pushNamed(context, '/privacy'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
