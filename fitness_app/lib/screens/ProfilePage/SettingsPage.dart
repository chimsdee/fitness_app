import 'package:fitness_app/screens/ProfilePage/Languages.dart';
import 'package:fitness_app/screens/ProfilePage/UnitsOfMeasure.dart';
import 'package:fitness_app/screens/ProfilePage/contactUs.dart';
// ignore: unused_import
import 'package:fitness_app/screens/ProfilePage/profilePage.dart';
import 'package:fitness_app/screens/ProfilePage/settings_Notifications.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingRow(
              context,
              title: 'Units of Measure',
              destination: const UnitsOfMeasure(),
            ),
            _buildDivider(),
            _buildSettingRow(
              context,
              title: 'Notifications',
              destination: const Settings_Notifications(),
            ),
            _buildDivider(),
            _buildSettingRow(
              context,
              title: 'Language',
              destination: const LanguageSettings(),
            ),
            _buildDivider(),
            _buildSettingRow(
              context,
              title: 'Contact Us',
              destination: const ContactUsPage(),
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(BuildContext context,
      {required String title, required Widget destination}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.15),
      thickness: 2,
      height: 16,
    );
  }
}
