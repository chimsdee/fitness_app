// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ProUpgradePage extends StatefulWidget {
  const ProUpgradePage({super.key});

  @override
  State<ProUpgradePage> createState() => _ProUpgradePageState();
}

class _ProUpgradePageState extends State<ProUpgradePage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _upgradeSuccess = false;

  Future<void> _sendUpgradeEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final smtpServer = gmail(
        'chimsom09@gmail.com',
        'wxsd esoi rqxe kkse', // my 16-character app password
      );

      final message = Message()
        ..from = const Address('chimsom09@gmail.com', 'Fitness App Pro')
        ..recipients.add(email)
        ..subject = 'Your Pro Upgrade Confirmation'
        ..html = """
          <h1 style="color: #2575FC;">Welcome to Fitness App Pro!</h1>
          <p>Thank you for upgrading to our Pro version. Here's what you get:</p>
          <ul>
            <li>Advanced Analytics</li>
            <li>Personalized Workouts</li>
            <li>Nutrition Plans</li>
            <li>Ad-Free Experience</li>
            <li>Priority Support</li>
          </ul>
          <p>Start enjoying these features now in the app!</p>
          <p>Best regards,<br/>The Fitness App Team</p>
        """;

      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent: ${sendReport.toString()}');

      setState(() => _upgradeSuccess = true);
    } on MailerException catch (e) {
      debugPrint('Mailer error: ${e.toString()}');
      for (var p in e.problems) {
        debugPrint('Problem: ${p.code}: ${p.msg}');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send email: ${e.message}')),
        );
      }
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Go Pro"),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_upgradeSuccess) ...[
              const Text(
                "Unlock Premium Features",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildFeatureItem("Advanced Analytics", Icons.analytics),
              _buildFeatureItem("Personalized Workouts", Icons.fitness_center),
              _buildFeatureItem("Nutrition Plans", Icons.restaurant),
              _buildFeatureItem("No Ads", Icons.block),
              _buildFeatureItem("Priority Support", Icons.support_agent),
              const SizedBox(height: 30),
              const Text(
                "Only £9.99/month",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: PrimaryColor,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email for confirmation',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[900],
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendUpgradeEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2575FC),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "UPGRADE NOW",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ] else ...[
              const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Upgrade Successful!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "A confirmation has been sent to your email",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "START USING PRO FEATURES",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: PrimaryColor, size: 30),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
