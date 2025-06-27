import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';

class IdealWeightCalculatorPage extends StatefulWidget {
  const IdealWeightCalculatorPage({super.key});

  @override
  State<IdealWeightCalculatorPage> createState() =>
      _IdealWeightCalculatorPageState();
}

class _IdealWeightCalculatorPageState extends State<IdealWeightCalculatorPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  String _gender = 'male';
  bool _isCalculating = false;
  bool _hasCalculated = false;

  Map<String, double> _idealWeights = {
    'Hamwi': 0,
    'Devine': 0,
    'Robinson': 0,
    'Miller': 0,
  };

  void _calculateIdealWeight() {
    if (_heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your height')),
      );
      return;
    }

    setState(() {
      _isCalculating = true;
      _hasCalculated = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      final double height = double.parse(_heightController.text);

      // Calculate using different formulas
      if (_gender == 'male') {
        _idealWeights = {
          'Hamwi': 48 + 2.7 * (height - 152.4) / 2.54,
          'Devine': 50 + 2.3 * (height - 152.4) / 2.54,
          'Robinson': 52 + 1.9 * (height - 152.4) / 2.54,
          'Miller': 56.2 + 1.41 * (height - 152.4) / 2.54,
        };
      } else {
        _idealWeights = {
          'Hamwi': 45.5 + 2.2 * (height - 152.4) / 2.54,
          'Devine': 45.5 + 2.3 * (height - 152.4) / 2.54,
          'Robinson': 49 + 1.7 * (height - 152.4) / 2.54,
          'Miller': 53.1 + 1.36 * (height - 152.4) / 2.54,
        };
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
        title: const Text('Ideal Weight Calculator'),
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

              // Height Input
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30),

              // Calculate Button
              ElevatedButton(
                onPressed: _isCalculating ? null : _calculateIdealWeight,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor,
                  minimumSize: Size(size.width * 0.9, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: _isCalculating
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text('Calculate Ideal Weight',
                        style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 30),

              // Results
              if (_hasCalculated) _buildResults(),

              // Information
              const SizedBox(height: 20),
              _buildInfoCard(),
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
          const Text('Your Ideal Weight Range',
              style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildWeightRow('Hamwi Method', _idealWeights['Hamwi']!),
          _buildWeightRow('Devine Method', _idealWeights['Devine']!),
          _buildWeightRow('Robinson Method', _idealWeights['Robinson']!),
          _buildWeightRow('Miller Method', _idealWeights['Miller']!),
          const SizedBox(height: 15),
          Text(
            'Average: ${(_idealWeights.values.reduce((a, b) => a + b) / _idealWeights.length).toStringAsFixed(1)} kg',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightRow(String method, double weight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(method, style: const TextStyle(color: Colors.white)),
          Text('${weight.toStringAsFixed(1)} kg',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Ideal Weight',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            'Ideal weight calculations provide estimates based on height and gender using various formulas. '
            'These are general guidelines and individual factors like muscle mass and body composition should be considered.',
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _genderController.dispose();
    super.dispose();
  }
}
