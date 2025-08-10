// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, use_build_context_synchronously, unnecessary_to_list_in_spreads, file_names
import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:fitness_app/screens/calculators/bmiCalculator.dart';
import 'package:fitness_app/screens/calculators/bmrCalculator.dart';
import 'package:fitness_app/screens/calculators/bodyfat_Calc.dart';
import 'package:fitness_app/screens/calculators/hydration_calc.dart';
import 'package:fitness_app/screens/calculators/idealweight_calc.dart';
import 'package:fitness_app/screens/calculators/tdee_calc.dart';

class MultiCalculatorFlow extends StatefulWidget {
  const MultiCalculatorFlow({super.key});

  @override
  State<MultiCalculatorFlow> createState() => _MultiCalculatorFlowState();
}

class _MultiCalculatorFlowState extends State<MultiCalculatorFlow> {
  final Map<String, bool> _selectedCalculators = {
    'BMI Calculator': false,
    'BMR Calculator': false,
    'Body Fat Calculator': false,
    'Hydration Calculator': false,
    'Ideal Weight Calculator': false,
    'TDEE Calculator': false,
  };

  final Map<String, dynamic> _results = {};
  int _currentStep = 0;
  List<String> _selectedCalculatorNames = [];

  @override
  Widget build(BuildContext context) {
    if (_currentStep == 0) {
      return _buildSelectionPage();
    } else if (_currentStep <= _selectedCalculatorNames.length) {
      return _buildCalculatorPage();
    } else {
      return _buildEmailSubmissionPage();
    }
  }

  Widget _buildSelectionPage() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Multi-Calculator Flow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Calculators to Use:',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _selectedCalculators.keys.map((String key) {
                  return CheckboxListTile(
                    title:
                        Text(key, style: const TextStyle(color: Colors.white)),
                    value: _selectedCalculators[key],
                    activeColor: PrimaryColor,
                    checkColor: Colors.black,
                    onChanged: (bool? value) {
                      setState(() {
                        _selectedCalculators[key] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _selectedCalculatorNames = _selectedCalculators.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();

                if (_selectedCalculatorNames.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please select at least one calculator')),
                  );
                  return;
                }

                setState(() {
                  _currentStep = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:
                  const Text('Continue', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorPage() {
    final currentCalculator = _selectedCalculatorNames[_currentStep - 1];

    void onCalculatorComplete(Map<String, dynamic> result) {
      // Changed from dynamic to Map
      _results[currentCalculator] = result;

      if (_currentStep == _selectedCalculatorNames.length) {
        setState(() => _currentStep++);
      } else {
        setState(() => _currentStep++);
      }
    }

    switch (currentCalculator) {
      case 'BMI Calculator':
        return BMICalculatorPage(
          onComplete: onCalculatorComplete,
          isInFlow: true,
        );
      case 'BMR Calculator':
        return BMRCalculatorPage(
          onComplete: onCalculatorComplete,
          isInFlow: true,
        );
      case 'Body Fat Calculator':
        return BodyFatCalculatorPage(
          onComplete: onCalculatorComplete,
          isInFlow: true,
        );
      case 'Hydration Calculator':
        return HydrationCalculatorPage(
          onComplete: onCalculatorComplete,
          isInFlow: true,
        );
      case 'Ideal Weight Calculator':
        return IdealWeightCalculatorPage(
          onComplete: onCalculatorComplete,
          isInFlow: true,
        );
      case 'TDEE Calculator':
        return TDEECalculatorPage(
          onComplete: onCalculatorComplete,
          isInFlow: true,
        );
      default:
        return Container();
    }
  }

  Widget _buildEmailSubmissionPage() {
    final TextEditingController _emailController = TextEditingController();
    bool _isSending = false;
    String? _errorMessage;

    String _buildEmailText() {
      String text = 'Your Fitness Calculator Results:\n\n';
      _results.forEach((calculator, result) {
        text += '$calculator:\n';
        if (result is Map) {
          result.forEach((key, value) {
            text += '  $key: $value\n';
          });
        } else {
          text += '  $result\n';
        }
        text += '\n';
      });
      return text;
    }

    String _buildEmailHtml() {
      String html = '''
      <html>
        <head>
          <style>
            body { font-family: Arial, sans-serif; }
            h1 { color: #2E7D32; }
            table { width: 100%; border-collapse: collapse; margin: 20px 0; }
            th { background-color: #2E7D32; color: white; padding: 10px; }
            td { padding: 8px; border-bottom: 1px solid #ddd; }
            tr:nth-child(even) { background-color: #f2f2f2; }
          </style>
        </head>
        <body>
          <h1>Your Fitness Calculator Results</h1>
          <table>
      ''';

      _results.forEach((calculator, result) {
        html += '''
            <tr>
              <th colspan="2">$calculator</th>
            </tr>
        ''';

        if (result is Map) {
          result.forEach((key, value) {
            html += '''
            <tr>
              <td><strong>$key</strong></td>
              <td>$value</td>
            </tr>
            ''';
          });
        } else {
          html += '''
            <tr>
              <td colspan="2">$result</td>
            </tr>
            ''';
        }
      });

      html += '''
          </table>
          <p>Thank you for using our Fitness App!</p>
        </body>
      </html>
      ''';

      return html;
    }

    Future<void> _sendEmail() async {
      if (_emailController.text.isEmpty ||
          !_emailController.text.contains('@')) {
        setState(() => _errorMessage = 'Please enter a valid email');
        return;
      }

      setState(() {
        _isSending = true;
        _errorMessage = null;
      });

      try {
        // 1. Configure SMTP server (replace with your credentials)
        final smtpServer = gmail(
          'chimsom09@gmail.com', // Your Gmail
          'mlvj snae jzjj clbb', // Your password or App Password
        );

        // 2. Create email message
        final message = Message()
          ..from = Address('chimsom09@gmail.com', 'Fitness App')
          ..recipients.add(_emailController.text)
          ..subject = 'Your Fitness Calculator Results'
          ..text = _buildEmailText()
          ..html = _buildEmailHtml();

        // 3. Send the email
        await send(message, smtpServer);

        // 4. Show success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Results sent successfully!')),
        );

        // Close the flow
        if (mounted) Navigator.pop(context);
      } catch (e) {
        setState(
            () => _errorMessage = 'Failed to send email. Please try again.');
        debugPrint('Email sending error: $e');
      } finally {
        if (mounted) {
          setState(() => _isSending = false);
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Email Results'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Results Summary:',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ..._results.entries.map((entry) {
                      return _buildResultCard(entry.key, entry.value);
                    }).toList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText: _errorMessage,
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSending ? null : _sendEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isSending
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Text(
                      'Send Results',
                      style: TextStyle(color: Colors.black),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(String calculatorName, dynamic result) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            calculatorName,
            style: const TextStyle(
                color: PrimaryColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          if (result is Map)
            ...result.entries.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(e.key,
                          style: const TextStyle(color: Colors.white54)),
                      const Spacer(),
                      Text(e.value.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ))
          else
            Text(result.toString(),
                style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
