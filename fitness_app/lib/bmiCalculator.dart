// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';

class BMICalculatorPage extends StatefulWidget {
  const BMICalculatorPage({super.key});

  @override
  State<BMICalculatorPage> createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmi = 0;
  String _result = '';
  bool _isCalculating = false;
  bool _hasCalculated = false;

  void _calculateBMI() {
    if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both height and weight')),
      );
      return;
    }

    setState(() {
      _isCalculating = true;
      _hasCalculated = false;
    });

    final double height = double.parse(_heightController.text) / 100;
    final double weight = double.parse(_weightController.text);

    // Simulate calculation delay
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _bmi = weight / (height * height);
        _determineResult();
        _isCalculating = false;
        _hasCalculated = true;
      });
    });
  }

  void _determineResult() {
    if (_bmi < 18.5) {
      _result = 'Underweight';
    } else if (_bmi >= 18.5 && _bmi < 25) {
      _result = 'Normal weight';
    } else if (_bmi >= 25 && _bmi < 30) {
      _result = 'Overweight';
    } else {
      _result = 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height in cm',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight in kg',
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isCalculating ? null : _calculateBMI,
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
                      'Calculate BMI',
                      style: TextStyle(color: Colors.black),
                    ),
            ),
            const SizedBox(height: 30),
            if (_hasCalculated)
              Column(
                children: [
                  Text(
                    'Your BMI: ${_bmi.toStringAsFixed(1)}',
                    style: TextStyle(
                      color:
                          _getResultColor(), // This will dynamically set the color
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(
                      color: _getResultColor(), // Same dynamic color here
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildBMIScale(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIScale() {
    return Column(
      children: [
        const Text(
          'BMI Scale:',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildScaleItem('Underweight', '<18.5', Colors.blue),
            _buildScaleItem('Normal', '18.5-24.9', Colors.green),
            _buildScaleItem('Overweight', '25-29.9', Colors.orange),
            _buildScaleItem('Obese', '30+', Colors.red),
          ],
        ),
      ],
    );
  }

  Widget _buildScaleItem(String label, String range, Color color) {
    return Column(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        Text(
          range,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }

  Color _getResultColor() {
    if (_bmi < 18.5) {
      return Colors.blue;
    } else if (_bmi >= 18.5 && _bmi < 25) {
      return Colors.green;
    } else if (_bmi >= 25 && _bmi < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}
