// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';

class BodyFatCalculatorPage extends StatefulWidget {
  const BodyFatCalculatorPage({super.key});

  @override
  State<BodyFatCalculatorPage> createState() => _BodyFatCalculatorPageState();
}

class _BodyFatCalculatorPageState extends State<BodyFatCalculatorPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  String _gender = 'male';
  bool _isCalculating = false;
  bool _hasCalculated = false;

  double _bodyFatPercentage = 0;
  String _bodyFatCategory = '';

  void _calculateBodyFat() {
    if ((_gender == 'male' &&
            (_neckController.text.isEmpty || _waistController.text.isEmpty)) ||
        (_gender == 'female' &&
            (_neckController.text.isEmpty ||
                _waistController.text.isEmpty ||
                _hipController.text.isEmpty))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required measurements')),
      );
      return;
    }

    setState(() {
      _isCalculating = true;
      _hasCalculated = false;
    });

    Future.delayed(const Duration(seconds: 2), () {
      final double neck = double.parse(_neckController.text);
      final double waist = double.parse(_waistController.text);
      final double hip =
          _gender == 'female' ? double.parse(_hipController.text) : 0;

      // US Navy Body Fat Formula
      if (_gender == 'male') {
        _bodyFatPercentage = 495 /
                (1.0324 -
                    0.19077 * log10(waist - neck) +
                    0.15456 *
                        log10(_heightController.text.isEmpty
                            ? 170
                            : double.parse(_heightController.text))) -
            450;
      } else {
        _bodyFatPercentage = 495 /
                (1.29579 -
                    0.35004 * log10(waist + hip - neck) +
                    0.22100 *
                        log10(_heightController.text.isEmpty
                            ? 160
                            : double.parse(_heightController.text))) -
            450;
      }

      // Determine category
      if (_gender == 'male') {
        if (_bodyFatPercentage < 6)
          _bodyFatCategory = 'Essential fat';
        else if (_bodyFatPercentage < 14)
          _bodyFatCategory = 'Athletic';
        else if (_bodyFatPercentage < 18)
          _bodyFatCategory = 'Fitness';
        else if (_bodyFatPercentage < 25)
          _bodyFatCategory = 'Average';
        else
          _bodyFatCategory = 'Obese';
      } else {
        if (_bodyFatPercentage < 14)
          _bodyFatCategory = 'Essential fat';
        else if (_bodyFatPercentage < 21)
          _bodyFatCategory = 'Athletic';
        else if (_bodyFatPercentage < 25)
          _bodyFatCategory = 'Fitness';
        else if (_bodyFatPercentage < 32)
          _bodyFatCategory = 'Average';
        else
          _bodyFatCategory = 'Obese';
      }

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
        title: const Text('Body Fat Calculator'),
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

              // Height (optional)
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm) - optional',
                  labelStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Neck Measurement
              TextField(
                controller: _neckController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Neck circumference (cm)',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Waist Measurement
              TextField(
                controller: _waistController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Waist circumference (cm)',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Hip Measurement (only for female)
              if (_gender == 'female')
                TextField(
                  controller: _hipController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Hip circumference (cm)',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              if (_gender == 'female') const SizedBox(height: 20),

              // Calculate Button
              ElevatedButton(
                onPressed: _isCalculating ? null : _calculateBodyFat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor,
                  minimumSize: Size(size.width * 0.9, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: _isCalculating
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text('Calculate Body Fat',
                        style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 30),

              // Results
              if (_hasCalculated) _buildResults(),

              // Body Fat Chart
              const SizedBox(height: 20),
              _buildBodyFatChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    Color resultColor = Colors.green;
    if (_bodyFatCategory == 'Average') resultColor = Colors.orange;
    if (_bodyFatCategory == 'Obese') resultColor = Colors.red;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text('Your Body Fat Percentage',
              style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('${_bodyFatPercentage.toStringAsFixed(1)}%',
              style: TextStyle(
                  color: resultColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(_bodyFatCategory,
              style: TextStyle(color: resultColor, fontSize: 20)),
          const SizedBox(height: 10),
          const Text('Based on US Navy method',
              style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildBodyFatChart() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Body Fat Categories',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildChartRow('Essential fat', _gender == 'male' ? '2-5%' : '10-13%',
              Colors.blue),
          _buildChartRow(
              'Athletic', _gender == 'male' ? '6-13%' : '14-20%', Colors.green),
          _buildChartRow('Fitness', _gender == 'male' ? '14-17%' : '21-24%',
              Colors.lightGreen),
          _buildChartRow('Average', _gender == 'male' ? '18-24%' : '25-31%',
              Colors.orange),
          _buildChartRow(
              'Obese', _gender == 'male' ? '25%+' : '32%+', Colors.red),
        ],
      ),
    );
  }

  Widget _buildChartRow(String category, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Text(category, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          Text(range, style: const TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _neckController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    super.dispose();
  }
}

num log10(double d) {
  return log(d) / ln10;
}
