import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = true;
  String _selectedLanguage = 'English';
  String _selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
          const SizedBox(height: 16),
          _buildSection(
            'Account',
            [
              ListTile(
                leading: const Icon(Icons.person, color: Colors.teal),
                title: const Text('Profile Settings'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.pushNamed(context, '/profile'),
              ),
              ListTile(
                leading: const Icon(Icons.security, color: Colors.teal),
                title: const Text('Security'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {}, // TODO: Implement security settings
              ),
            ],
          ),
          _buildSection(
            'Preferences',
            [
              SwitchListTile(
                secondary: const Icon(Icons.notifications, color: Colors.teal),
                title: const Text('Notifications'),
                value: _notificationsEnabled,
                activeColor: Colors.teal,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.fingerprint, color: Colors.teal),
                title: const Text('Biometric Authentication'),
                value: _biometricEnabled,
                activeColor: Colors.teal,
                onChanged: (value) {
                  setState(() {
                    _biometricEnabled = value;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.teal),
                title: const Text('Language'),
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                    }
                  },
                  items: ['English', 'Swahili']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6, color: Colors.teal),
                title: const Text('Theme'),
                trailing: DropdownButton<String>(
                  value: _selectedTheme,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedTheme = newValue;
                      });
                    }
                  },
                  items: ['Light', 'Dark', 'System']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          _buildSection(
            'Data Management',
            [
              ListTile(
                leading: const Icon(Icons.storage, color: Colors.teal),
                title: const Text('Clear Cache'),
                onTap: () {
                  // TODO: Implement clear cache
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cache cleared'),
                      backgroundColor: Colors.teal,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.download, color: Colors.teal),
                title: const Text('Download History'),
                onTap: () {}, // TODO: Implement download history
              ),
            ],
          ),
          _buildSection(
            'About',
            [
              ListTile(
                leading: const Icon(Icons.info, color: Colors.teal),
                title: const Text('App Version'),
                trailing: const Text('1.0.0'),
              ),
              ListTile(
                leading: const Icon(Icons.update, color: Colors.teal),
                title: const Text('Check for Updates'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your app is up to date'),
                      backgroundColor: Colors.teal,
                    ),
                  );
                },
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
          padding: const EdgeInsets.all(16.0),
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
        const Divider(),
      ],
    );
  }
}
