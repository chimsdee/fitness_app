import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Privacy policy',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildPolicySection(
                '1. Introduction',
                'This policy explains how our app collects, uses '
                    'and protects your personal information.',
              ),
              _buildPolicySection(
                '2. Information We Collect',
                'We may collect personal information such as name, email '
                    'and location to provide a better user experience.',
              ),
              _buildPolicySection(
                '3. How We Use Your Personal Information',
                'Your information is used to personalize your personal experience, improve '
                    'our app and send you relevant updates.',
              ),
              _buildPolicySection(
                '4. Security',
                'We tke appropriate measures to secure your prersonal information '
                    'but no method of transmission over the internet is 100% secure.',
              ),
              _buildPolicySection(
                '5. Contact Us',
                'If you have any questions about our privacy policy, please contact '
                    'us at chimsom09@gmail.com.',
              ),
              _buildPolicySection(
                '6. Consent',
                'By using our app, you hereby consent to the policy and '
                    "agree to it's terms and conditions.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 17,
          )
        ],
      ),
    );
  }
}
