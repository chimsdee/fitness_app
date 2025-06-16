// ignore_for_file: file_names

import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Description Section
            const Text(
              'About FitnessTrack Pro',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'FitnessTrack Pro is your ultimate workout companion designed to help you achieve your fitness goals. '
              'Track workouts, monitor progress, and stay motivated with our comprehensive fitness tracking features. '
              'Suitable for all fitness levels from beginners to professional athletes.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),

            // Contact Information Section
            const Text(
              'Contact Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Developer Card
            _buildInfoCard(
              icon: Icons.person,
              title: 'Software Developer',
              content: 'Chimsom Divine Elue',
            ),
            const SizedBox(height: 20),

            // Phone Number
            _buildInfoRow(
              icon: Icons.phone,
              text: '+44 7449 270921',
            ),
            const SizedBox(height: 15),

            // Email
            _buildInfoRow(
              icon: Icons.email,
              text: 'chimsom09@gmail.com',
            ),
            const SizedBox(height: 30),

            // Business Hours
            const Text(
              'Business Hours',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Monday - Friday: 9am - 5pm GMT\n'
              'Saturday: 10am - 2pm GMT\n'
              'Sunday: Closed',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required IconData icon,
      required String title,
      required String content}) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: PrimaryColor, size: 30),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: PrimaryColor),
        const SizedBox(width: 15),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
