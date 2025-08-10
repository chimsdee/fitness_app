// ignore_for_file: prefer_final_fields, curly_braces_in_flow_control_structures, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class MultiCalculatorFlowPage extends StatefulWidget {
  const MultiCalculatorFlowPage({super.key});

  @override
  State<MultiCalculatorFlowPage> createState() =>
      _MultiCalculatorFlowPageState();
}

class _MultiCalculatorFlowPageState extends State<MultiCalculatorFlowPage> {
  final Map<String, bool> _selectedCalculators = {
    'BMI': false,
    'BMR': false,
    'Body Fat': false,
    'Hydration': false,
    'Ideal Weight': false,
    'TDEE': false,
  };

  List<String> _activeCalculators = [];
  int _currentStep = 0;
  Map<String, Map<String, dynamic>> _results = {};
  bool _isCalculating = false;

  // Controllers for shared inputs
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _gender = 'male';
  String _activityLevel = 'normal'; // Used for Hydration, BMR, TDEE
  bool _showResults = false;

  void _startCalculations() {
    _activeCalculators = _selectedCalculators.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (_activeCalculators.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one calculator')),
      );
      return;
    }

    setState(() {
      _currentStep = 0;
      _results.clear();
      _showResults = false;
    });
  }

  void _calculateCurrentStep() {
    if (_isCalculating) return;

    setState(() {
      _isCalculating = true;
      _showResults = false;
    });

    Future.delayed(const Duration(seconds: 2), () {
      String currentCalculator = _activeCalculators[_currentStep];
      Map<String, dynamic> result = {};

      try {
        if (currentCalculator == 'BMI') {
          if (_heightController.text.isEmpty ||
              _weightController.text.isEmpty) {
            throw 'Please enter height and weight';
          }
          double height = double.parse(_heightController.text) / 100;
          double weight = double.parse(_weightController.text);
          double bmi = weight / (height * height);
          String category = bmi < 18.5
              ? 'Underweight'
              : bmi < 25
                  ? 'Normal weight'
                  : bmi < 30
                      ? 'Overweight'
                      : 'Obese';
          result = {'BMI': bmi.toStringAsFixed(1), 'Category': category};
        } else if (currentCalculator == 'BMR') {
          if (_ageController.text.isEmpty ||
              _heightController.text.isEmpty ||
              _weightController.text.isEmpty) {
            throw 'Please fill all fields';
          }
          int age = int.parse(_ageController.text);
          double height = double.parse(_heightController.text);
          double weight = double.parse(_weightController.text);
          double bmr = _gender == 'male'
              ? (10 * weight) + (6.25 * height) - (5 * age) + 5
              : (10 * weight) + (6.25 * height) - (5 * age) - 161;
          Map<String, double> activityLevels = {
            'sedentary': 1.2,
            'light': 1.375,
            'moderate': 1.55,
            'active': 1.725,
            'very active': 1.9,
          };
          double dailyCalories = bmr * activityLevels[_activityLevel]!;
          result = {
            'BMR': bmr.toStringAsFixed(0),
            'Daily Calories': dailyCalories.toStringAsFixed(0)
          };
        } else if (currentCalculator == 'Body Fat') {
          if (_neckController.text.isEmpty ||
              _waistController.text.isEmpty ||
              (_gender == 'female' && _hipController.text.isEmpty)) {
            throw 'Please fill all required measurements';
          }
          double neck = double.parse(_neckController.text);
          double waist = double.parse(_waistController.text);
          double hip =
              _gender == 'female' ? double.parse(_hipController.text) : 0;
          double height = _heightController.text.isEmpty
              ? (_gender == 'male' ? 170 : 160)
              : double.parse(_heightController.text);
          double bodyFatPercentage;
          if (_gender == 'male') {
            bodyFatPercentage = 495 /
                    (1.0324 -
                        0.19077 * log(waist - neck) / log(10) +
                        0.15456 * log(height) / log(10)) -
                450;
          } else {
            bodyFatPercentage = 495 /
                    (1.29579 -
                        0.35004 * log(waist + hip - neck) / log(10) +
                        0.22100 * log(height) / log(10)) -
                450;
          }
          String category = _gender == 'male'
              ? (bodyFatPercentage < 6
                  ? 'Essential fat'
                  : bodyFatPercentage < 14
                      ? 'Athletic'
                      : bodyFatPercentage < 18
                          ? 'Fitness'
                          : bodyFatPercentage < 25
                              ? 'Average'
                              : 'Obese')
              : (bodyFatPercentage < 14
                  ? 'Essential fat'
                  : bodyFatPercentage < 21
                      ? 'Athletic'
                      : bodyFatPercentage < 25
                          ? 'Fitness'
                          : bodyFatPercentage < 32
                              ? 'Average'
                              : 'Obese');
          result = {
            'Body Fat %': bodyFatPercentage.toStringAsFixed(1),
            'Category': category
          };
        } else if (currentCalculator == 'Hydration') {
          if (_weightController.text.isEmpty) {
            throw 'Please enter your weight';
          }
          double weight = double.parse(_weightController.text);
          Map<String, double> activityFactors = {
            'sedentary': 30,
            'normal': 35,
            'active': 40,
            'very active': 45,
          };
          double waterIntake = weight * activityFactors[_activityLevel]!;
          result = {
            'Water Intake': '${waterIntake.toStringAsFixed(0)} ml',
            'Liters': (waterIntake / 1000).toStringAsFixed(1)
          };
        } else if (currentCalculator == 'Ideal Weight') {
          if (_heightController.text.isEmpty) {
            throw 'Please enter your height';
          }
          double height = double.parse(_heightController.text);
          Map<String, double> idealWeights = _gender == 'male'
              ? {
                  'Hamwi': 48 + 2.7 * (height - 152.4) / 2.54,
                  'Devine': 50 + 2.3 * (height - 152.4) / 2.54,
                  'Robinson': 52 + 1.9 * (height - 152.4) / 2.54,
                  'Miller': 56.2 + 1.41 * (height - 152.4) / 2.54,
                }
              : {
                  'Hamwi': 45.5 + 2.2 * (height - 152.4) / 2.54,
                  'Devine': 45.5 + 2.3 * (height - 152.4) / 2.54,
                  'Robinson': 49 + 1.7 * (height - 152.4) / 2.54,
                  'Miller': 53.1 + 1.36 * (height - 152.4) / 2.54,
                };
          double average =
              idealWeights.values.reduce((a, b) => a + b) / idealWeights.length;
          result = {
            'Hamwi': idealWeights['Hamwi']!.toStringAsFixed(1),
            'Devine': idealWeights['Devine']!.toStringAsFixed(1),
            'Robinson': idealWeights['Robinson']!.toStringAsFixed(1),
            'Miller': idealWeights['Miller']!.toStringAsFixed(1),
            'Average': average.toStringAsFixed(1)
          };
        } else if (currentCalculator == 'TDEE') {
          if (_ageController.text.isEmpty ||
              _heightController.text.isEmpty ||
              _weightController.text.isEmpty) {
            throw 'Please fill all fields';
          }
          int age = int.parse(_ageController.text);
          double height = double.parse(_heightController.text);
          double weight = double.parse(_weightController.text);
          double bmr = _gender == 'male'
              ? (10 * weight) + (6.25 * height) - (5 * age) + 5
              : (10 * weight) + (6.25 * height) - (5 * age) - 161;
          Map<String, double> activityLevels = {
            'rookie': 1.3,
            'beginner': 1.45,
            'intermediate': 1.6,
            'advanced': 1.8,
            'true beast': 2.0,
          };
          double tdee = bmr * activityLevels[_activityLevel]!;
          result = {
            'TDEE': tdee.toStringAsFixed(0),
            'Maintenance': tdee.toStringAsFixed(0),
            'Cutting': (tdee - 300).toStringAsFixed(0),
            'Aggressive Cut': (tdee - 600).toStringAsFixed(0),
            'Bulking': (tdee + 300).toStringAsFixed(0),
            'Aggressive Bulk': (tdee + 600).toStringAsFixed(0),
          };
        }

        setState(() {
          _results[currentCalculator] = result;
          _isCalculating = false;
          _showResults = true;
        });
      } catch (e) {
        setState(() {
          _isCalculating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    });
  }

  void _nextStep() {
    if (_currentStep < _activeCalculators.length - 1) {
      setState(() {
        _currentStep++;
        _showResults = false;
        _clearInputs();
      });
    } else {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _clearInputs() {
    if (_currentStep >= _activeCalculators.length) return;
    String nextCalculator = _activeCalculators[_currentStep];
    if (!nextCalculator.contains('BMI')) _heightController.clear();
    if (!nextCalculator.contains('BMI') &&
        !nextCalculator.contains('Hydration')) _weightController.clear();
    if (!nextCalculator.contains('BMR') && !nextCalculator.contains('TDEE'))
      _ageController.clear();
    if (!nextCalculator.contains('Body Fat')) {
      _neckController.clear();
      _waistController.clear();
      _hipController.clear();
    }
  }

  void _sendEmail() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    String subject = 'Your Fitness Calculator Results';
    String body = 'Here are your fitness calculator results:\n\n';
    _results.forEach((calculator, result) {
      body += '$calculator:\n';
      result.forEach((key, value) {
        body += '  $key: $value\n';
      });
      body += '\n';
    });

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _emailController.text,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email client')),
      );
    }

    // Reset and return to selection screen
    setState(() {
      _currentStep = 0;
      _activeCalculators.clear();
      _results.clear();
      _selectedCalculators.updateAll((key, value) => false);
      _emailController.clear();
      _clearInputs();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Multi-Calculator Flow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _currentStep == 0
            ? _buildSelectionScreen(size)
            : _currentStep < _activeCalculators.length
                ? _buildCalculatorStep(size)
                : _buildEmailStep(size),
      ),
    );
  }

  Widget _buildSelectionScreen(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Calculators',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ..._selectedCalculators.keys.map((calculator) => CheckboxListTile(
              title:
                  Text(calculator, style: const TextStyle(color: Colors.white)),
              value: _selectedCalculators[calculator],
              onChanged: (value) =>
                  setState(() => _selectedCalculators[calculator] = value!),
              activeColor: PrimaryColor,
              checkColor: Colors.black,
            )),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _startCalculations,
          style: ElevatedButton.styleFrom(
            backgroundColor: PrimaryColor,
            minimumSize: Size(size.width * 0.9, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Go', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildCalculatorStep(Size size) {
    String currentCalculator = _activeCalculators[_currentStep];
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            '$currentCalculator Calculator',
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          if (['BMR', 'Body Fat', 'TDEE'].contains(currentCalculator))
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: const Text('Male',
                        style: TextStyle(color: Colors.white)),
                    value: 'male',
                    groupValue: _gender,
                    onChanged: (value) =>
                        setState(() => _gender = value.toString()),
                    activeColor: PrimaryColor,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: const Text('Female',
                        style: TextStyle(color: Colors.white)),
                    value: 'female',
                    groupValue: _gender,
                    onChanged: (value) =>
                        setState(() => _gender = value.toString()),
                    activeColor: PrimaryColor,
                  ),
                ),
              ],
            ),
          if (['BMI', 'BMR', 'Body Fat', 'Ideal Weight', 'TDEE']
              .contains(currentCalculator))
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                    'Height (cm)${currentCalculator == 'Body Fat' ? ' - optional' : ''}',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          const SizedBox(height: 20),
          if (['BMI', 'BMR', 'Body Fat', 'Hydration', 'TDEE']
              .contains(currentCalculator))
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          const SizedBox(height: 20),
          if (['BMR', 'TDEE'].contains(currentCalculator))
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age (years)',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          const SizedBox(height: 20),
          if (currentCalculator == 'Body Fat') ...[
            TextField(
              controller: _neckController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Neck circumference (cm)',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _waistController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Waist circumference (cm)',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            if (_gender == 'female')
              TextField(
                controller: _hipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Hip circumference (cm)',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            const SizedBox(height: 20),
          ],
          if (['BMR', 'Hydration', 'TDEE'].contains(currentCalculator))
            DropdownButtonFormField(
              value: _activityLevel,
              dropdownColor: Colors.grey[900],
              decoration: InputDecoration(
                labelText: currentCalculator == 'TDEE'
                    ? 'Training Level'
                    : 'Activity Level',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              items: currentCalculator == 'TDEE'
                  ? const [
                      DropdownMenuItem(
                          value: 'rookie',
                          child: Text('Rookie (1-2 workouts/week)')),
                      DropdownMenuItem(
                          value: 'beginner',
                          child: Text('Beginner (3-4 workouts/week)')),
                      DropdownMenuItem(
                          value: 'intermediate',
                          child: Text('Intermediate (5-6 workouts/week)')),
                      DropdownMenuItem(
                          value: 'advanced',
                          child: Text('Advanced (daily workouts)')),
                      DropdownMenuItem(
                          value: 'true beast',
                          child: Text('True Beast (2x/day training)')),
                    ]
                  : const [
                      DropdownMenuItem(
                          value: 'sedentary',
                          child: Text('Sedentary (little exercise)')),
                      DropdownMenuItem(
                          value: 'normal', child: Text('Normal activity')),
                      DropdownMenuItem(
                          value: 'active',
                          child: Text('Active (exercise 3-5 days/week)')),
                      DropdownMenuItem(
                          value: 'very active',
                          child: Text('Very Active (daily intense exercise)')),
                    ],
              onChanged: (value) =>
                  setState(() => _activityLevel = value.toString()),
            ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _isCalculating ? null : _calculateCurrentStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColor,
              minimumSize: Size(size.width * 0.9, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: _isCalculating
                ? const CircularProgressIndicator(color: Colors.black)
                : Text('Calculate $currentCalculator',
                    style: const TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: 30),
          if (_showResults && _results[currentCalculator] != null)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    '$currentCalculator Results',
                    style: const TextStyle(
                        color: PrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ..._results[currentCalculator]!.entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key,
                                  style: const TextStyle(color: Colors.white)),
                              Text(
                                  entry.key.contains('TDEE') &&
                                          entry.key != 'TDEE'
                                      ? '${entry.value} cal'
                                      : entry.value,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColor,
                      minimumSize: Size(size.width * 0.9, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Next',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmailStep(Size size) {
    return Column(
      children: [
        const Text(
          'Complete and Email Results',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Enter your email',
            labelStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _sendEmail,
          style: ElevatedButton.styleFrom(
            backgroundColor: PrimaryColor,
            minimumSize: Size(size.width * 0.9, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Complete', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    _neckController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
