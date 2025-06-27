// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:fitness_app/screens/ProfilePage/PrivacyPolicy.dart';
import 'package:fitness_app/screens/ProfilePage/SettingsPage.dart';
import 'package:fitness_app/screens/ProfilePage/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const FitnessApp());

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Pro',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => const ProfilePage(),
        '/edit': (context) => const EditProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/privacyPolicy': (context) => const PrivacyPolicyPage(),
        '/proUpgrade': (context) => const ProUpgradePage(),
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = "Chimsom Divine Elue";
  final DateTime joinDate = DateTime(2025, 6, 15);
  final String userImage = 'assets/images/profile.jpg';
  final Map<String, String> healthStats = {
    'BMI': '22.3',
    'BMR': '1,650',
    'H2O': '2.1L',
  };

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 400;
    final formattedDate = DateFormat('MMMM yyyy').format(joinDate);
    final nameInitials = userName.split(' ').map((e) => e[0]).join();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: 20,
          ),
          child: Column(
            children: [
              // Profile Header
              _buildProfileHeader(nameInitials, formattedDate, isSmallScreen),

              // Centered Name
              Center(
                child: Text(
                  userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 22 : 25,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Health Stats Preview
              _buildHealthStatsRow(context, isSmallScreen),

              const Divider(color: Colors.grey, thickness: 0.5),

              // Menu Items
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context: context,
                        text: 'Edit Profile',
                        route: '/edit',
                        icon: Icons.edit_attributes,
                        subtitle: 'Name, photo, metrics',
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        context: context,
                        text: 'Privacy Policy',
                        route: '/privacyPolicy',
                        icon: Icons.privacy_tip,
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        context: context,
                        text: 'Settings',
                        route: '/settings',
                        icon: Icons.settings,
                        subtitle: 'Notifications, theme',
                      ),
                      _buildDivider(),
                      _buildMenuItem(
                        context: context,
                        text: 'Health Stats',
                        route: '/healthStats',
                        icon: Icons.monitor_heart,
                        subtitle: 'BMI, BMR, Hydration',
                      ),
                      _buildDivider(),
                    ],
                  ),
                ),
              ),

              // Pro Upgrade Card
              _buildProUpgradeSection(isSmallScreen),

              const SizedBox(height: 12),
              const Divider(color: Colors.grey, thickness: 0.5),

              // Sign Out
              TextButton(
                onPressed: _confirmSignOut,
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: isSmallScreen ? 16 : 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Keep all other existing methods unchanged) ...
  Widget _buildProfileHeader(String initials, String date, bool isSmallScreen) {
    return Column(
      children: [
        Container(
          width: isSmallScreen ? 80 : 100,
          height: isSmallScreen ? 80 : 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[800]!,
              width: 2.0,
            ),
          ),
          child: ClipOval(
            child: userImage.isNotEmpty
                ? Image.asset(
                    userImage,
                    fit: BoxFit.cover, // This ensures the image fills the space
                    width: isSmallScreen ? 80 : 100,
                    height: isSmallScreen ? 80 : 100,
                  )
                : Center(
                    child: Text(
                      initials,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today, color: Colors.grey, size: 16),
            const SizedBox(width: 8),
            Text(
              'Joined $date',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildHealthStatsRow(BuildContext context, bool isSmallScreen) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/healthStats'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: healthStats.entries.map((entry) {
            return Column(
              children: [
                Text(
                  entry.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.key,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String text,
    required String route,
    required IconData icon,
    String? subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: Colors.grey))
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }

  Widget _buildProUpgradeSection(bool isSmallScreen) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: const Icon(Icons.star, color: Colors.yellow, size: 32),
        title: const Text(
          "UPGRADE TO PRO",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: const Text(
          "Unlock all premium features",
          style: TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.arrow_forward, color: Colors.white),
        onTap: () => Navigator.pushNamed(context, '/proUpgrade'),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.grey,
      height: 1,
      thickness: 0.5,
    );
  }

  void _confirmSignOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// Minimal implementation for ProUpgradePage to resolve the error.
class ProUpgradePage extends StatelessWidget {
  const ProUpgradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Go Pro")),
      body: const Center(child: Text("Pro Upgrade Page")),
    );
  }
}
