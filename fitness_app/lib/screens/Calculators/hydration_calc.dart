import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';

class HydrationCalculatorPage extends StatefulWidget {
  const HydrationCalculatorPage({super.key});

  @override
  State<HydrationCalculatorPage> createState() =>
      _HydrationCalculatorPageState();
}

class _HydrationCalculatorPageState extends State<HydrationCalculatorPage> {
  final TextEditingController _weightController = TextEditingController();

  String _activityLevel = 'normal';
  bool _isCalculating = false;
  bool _hasCalculated = false;

  double _waterIntake = 0;
  final Map<String, double> _activityFactors = {
    'sedentary': 30,
    'normal': 35,
    'active': 40,
    'very active': 45,
  };

  void _calculateHydration() {
    if (_weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your weight')),
      );
      return;
    }

    setState(() {
      _isCalculating = true;
      _hasCalculated = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      final double weight = double.parse(_weightController.text);
      _waterIntake = weight * _activityFactors[_activityLevel]!;

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
        title: const Text('Hydration Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Weight Input
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Activity Level
              DropdownButtonFormField(
                value: _activityLevel,
                dropdownColor: Colors.grey[900],
                decoration: InputDecoration(
                  labelText: 'Activity Level',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                style: const TextStyle(color: Colors.white),
                items: const [
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

              // Calculate Button
              ElevatedButton(
                onPressed: _isCalculating ? null : _calculateHydration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor,
                  minimumSize: Size(size.width * 0.9, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: _isCalculating
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text('Calculate Water Intake',
                        style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 30),

              // Results
              if (_hasCalculated) _buildResults(),

              // Water Intake Tips
              const SizedBox(height: 20),
              _buildWaterTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text('Recommended Daily Water Intake',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text('${_waterIntake.toStringAsFixed(0)} ml',
              style: const TextStyle(
                  color: PrimaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('(~${(_waterIntake / 1000).toStringAsFixed(1)} liters)',
              style: const TextStyle(color: Colors.white54)),
          const SizedBox(height: 15),
          const Text('Based on your weight and activity level',
              style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildWaterTips() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hydration Tips',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('• Drink water consistently throughout the day',
              style: TextStyle(color: Colors.white54)),
          Text('• Increase intake during exercise or hot weather',
              style: TextStyle(color: Colors.white54)),
          Text('• Monitor urine color (pale yellow is ideal)',
              style: TextStyle(color: Colors.white54)),
          Text('• Foods like fruits and vegetables also contribute',
              style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }
}
