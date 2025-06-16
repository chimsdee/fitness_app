// ignore_for_file: file_names

import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Settings_Notifications extends StatefulWidget {
  const Settings_Notifications({super.key});

  @override
  State<Settings_Notifications> createState() => _SettingsNotificationsState();
}

class _SettingsNotificationsState extends State<Settings_Notifications> {
  bool _workoutRemindersEnabled = true;
  bool _programNotificationsEnabled = false;

  void _toggleOptions(String selectedOption) {
    setState(() {
      if (selectedOption == 'workout') {
        _workoutRemindersEnabled = true;
        _programNotificationsEnabled = false;
      } else {
        _workoutRemindersEnabled = false;
        _programNotificationsEnabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification Settings',
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
            _buildNotificationOption(
              'Workout Reminders',
              isEnabled: _workoutRemindersEnabled,
              onTap: () => _toggleOptions('workout'),
            ),
            _buildDivider(),
            _buildNotificationOption(
              'Program Notifications',
              isEnabled: _programNotificationsEnabled,
              onTap: () => _toggleOptions('program'),
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationOption(
    String text, {
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: isEnabled ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Switch(
              value: isEnabled,
              onChanged: (value) => onTap(),
              activeColor: PrimaryColor,
              inactiveThumbColor: Colors.grey[600],
              inactiveTrackColor: Colors.grey[800],
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
