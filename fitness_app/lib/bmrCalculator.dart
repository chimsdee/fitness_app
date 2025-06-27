// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';

class BMRCalculatorPage extends StatefulWidget {
  const BMRCalculatorPage({super.key});

  @override
  State<BMRCalculatorPage> createState() => _BMRCalculatorPageState();
}

class _BMRCalculatorPageState extends State<BMRCalculatorPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _gender = 'male';
  String _activityLevel = 'sedentary';
  bool _isCalculating = false;
  bool _hasCalculated = false;

  double _bmr = 0;
  double _dailyCalories = 0;

  final Map<String, double> _activityLevels = {
    'sedentary': 1.2,
    'light': 1.375,
    'moderate': 1.55,
    'active': 1.725,
    'very active': 1.9,
  };

  void _calculateBMR() {
    if (_ageController.text.isEmpty ||
        _heightController.text.isEmpty ||
        _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      _isCalculating = true;
      _hasCalculated = false;
    });

    // Simulate calculation delay
    Future.delayed(const Duration(seconds: 2), () {
      final int age = int.parse(_ageController.text);
      final double height = double.parse(_heightController.text);
      final double weight = double.parse(_weightController.text);

      // Mifflin-St Jeor Equation
      if (_gender == 'male') {
        _bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
      } else {
        _bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
      }

      _dailyCalories = _bmr * _activityLevels[_activityLevel]!;

      setState(() {
        _isCalculating = false;
        _hasCalculated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('BMR Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Gender Selection
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Male',
                          style: TextStyle(color: Colors.white)),
                      value: 'male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                      activeColor: PrimaryColor,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text('Female',
                          style: TextStyle(color: Colors.white)),
                      value: 'female',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value.toString();
                        });
                      },
                      activeColor: PrimaryColor,
                    ),
                  ),
                ],
              ),

              // Age Input
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

              // Height Input
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Weight Input
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

              // Activity Level Dropdown
              DropdownButtonFormField(
                value: _activityLevel,
                dropdownColor: Colors.grey[900],
                decoration: InputDecoration(
                  labelText: 'Activity Level',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                items: const [
                  DropdownMenuItem(
                    value: 'sedentary',
                    child: Text('Sedentary (little or no exercise)'),
                  ),
                  DropdownMenuItem(
                    value: 'light',
                    child: Text('Light (exercise 1-3 days/week)'),
                  ),
                  DropdownMenuItem(
                    value: 'moderate',
                    child: Text('Moderate (exercise 3-5 days/week)'),
                  ),
                  DropdownMenuItem(
                    value: 'active',
                    child: Text('Active (exercise 6-7 days/week)'),
                  ),
                  DropdownMenuItem(
                    value: 'very active',
                    child: Text('Very Active (hard exercise 6-7 days/week)'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _activityLevel = value.toString();
                  });
                },
              ),
              const SizedBox(height: 30),

              // Calculate Button
              ElevatedButton(
                onPressed: _isCalculating ? null : _calculateBMR,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor,
                  minimumSize: Size(size.width * 0.9, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isCalculating
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'Calculate BMR',
                        style: TextStyle(color: Colors.black),
                      ),
              ),
              const SizedBox(height: 30),

              // Results
              if (_hasCalculated)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Your Basal Metabolic Rate',
                        style: TextStyle(
                          color: PrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${_bmr.toStringAsFixed(0)} calories/day',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Daily Calorie Needs',
                        style: TextStyle(
                          color: PrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${_dailyCalories.toStringAsFixed(0)} calories/day',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildActivityLevelInfo(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityLevelInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Activity Level Multipliers:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildActivityLevelRow('Sedentary', '1.2', 'little or no exercise'),
        _buildActivityLevelRow('Light', '1.375', '1-3 days/week'),
        _buildActivityLevelRow('Moderate', '1.55', '3-5 days/week'),
        _buildActivityLevelRow('Active', '1.725', '6-7 days/week'),
        _buildActivityLevelRow(
            'Very Active', '1.9', 'hard exercise 6-7 days/week'),
      ],
    );
  }

  Widget _buildActivityLevelRow(
      String level, String multiplier, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              level,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              multiplier,
              style: const TextStyle(
                  color: PrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
