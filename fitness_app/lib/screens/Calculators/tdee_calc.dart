// import 'package:flutter/material.dart';
// import 'package:fitness_app/constants/color.dart';

// class TDEECalculatorPage extends StatefulWidget {
//   const TDEECalculatorPage({super.key});

//   @override
//   State<TDEECalculatorPage> createState() => _TDEECalculatorPageState();
// }

// class _TDEECalculatorPageState extends State<TDEECalculatorPage> {
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _heightController = TextEditingController();
//   final TextEditingController _weightController = TextEditingController();

//   String _gender = 'male';
//   String _activityLevel = 'rookie';
//   bool _isCalculating = false;
//   bool _hasCalculated = false;

//   double _tdee = 0;
//   Map<String, double> _goalCalories = {
//     'Maintenance': 0,
//     'Cutting': 0,
//     'Aggressive Cut': 0,
//     'Bulking': 0,
//     'Aggressive Bulk': 0,
//   };

//   // Custom activity levels with your terminology
//   final Map<String, double> _activityLevels = {
//     'rookie': 1.3, // Light exercise 1-2x/week
//     'beginner': 1.45, // Exercise 3-4x/week
//     'intermediate': 1.6, // Exercise 5-6x/week
//     'advanced': 1.8, // Daily intense exercise
//     'true beast': 2.0, // Professional athlete level
//   };

//   void _calculateTDEE() {
//     if (_ageController.text.isEmpty ||
//         _heightController.text.isEmpty ||
//         _weightController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields')),
//       );
//       return;
//     }

//     setState(() {
//       _isCalculating = true;
//       _hasCalculated = false;
//     });

//     Future.delayed(const Duration(seconds: 2), () {
//       final int age = int.parse(_ageController.text);
//       final double height = double.parse(_heightController.text);
//       final double weight = double.parse(_weightController.text);

//       // Mifflin-St Jeor Equation
//       double bmr = _gender == 'male'
//           ? (10 * weight) + (6.25 * height) - (5 * age) + 5
//           : (10 * weight) + (6.25 * height) - (5 * age) - 161;

//       _tdee = bmr * _activityLevels[_activityLevel]!;

//       // Calculate goal calories
//       _goalCalories = {
//         'Maintenance': _tdee,
//         'Cutting': _tdee - 300,
//         'Aggressive Cut': _tdee - 600,
//         'Bulking': _tdee + 300,
//         'Aggressive Bulk': _tdee + 600,
//       };

//       setState(() {
//         _isCalculating = false;
//         _hasCalculated = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('TDEE Calculator'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               // Gender Selection
//               Row(
//                 children: [
//                   Expanded(
//                     child: RadioListTile(
//                       title: const Text('Male',
//                           style: TextStyle(color: Colors.white)),
//                       value: 'male',
//                       groupValue: _gender,
//                       onChanged: (value) =>
//                           setState(() => _gender = value.toString()),
//                       activeColor: PrimaryColor,
//                     ),
//                   ),
//                   Expanded(
//                     child: RadioListTile(
//                       title: const Text('Female',
//                           style: TextStyle(color: Colors.white)),
//                       value: 'female',
//                       groupValue: _gender,
//                       onChanged: (value) =>
//                           setState(() => _gender = value.toString()),
//                       activeColor: PrimaryColor,
//                     ),
//                   ),
//                 ],
//               ),

//               // Input Fields
//               _buildInputField(_ageController, 'Age (years)'),
//               const SizedBox(height: 20),
//               _buildInputField(_heightController, 'Height (cm)'),
//               const SizedBox(height: 20),
//               _buildInputField(_weightController, 'Weight (kg)'),
//               const SizedBox(height: 20),

//               // Custom Activity Level Dropdown
//               DropdownButtonFormField(
//                 value: _activityLevel,
//                 dropdownColor: Colors.grey[900],
//                 decoration: InputDecoration(
//                   labelText: 'Training Level',
//                   labelStyle: const TextStyle(color: Colors.white),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 style: const TextStyle(color: Colors.white),
//                 items: const [
//                   DropdownMenuItem(
//                     value: 'rookie',
//                     child: Text('Rookie (1-2 workouts/week)'),
//                   ),
//                   DropdownMenuItem(
//                     value: 'beginner',
//                     child: Text('Beginner (3-4 workouts/week)'),
//                   ),
//                   DropdownMenuItem(
//                     value: 'intermediate',
//                     child: Text('Intermediate (5-6 workouts/week)'),
//                   ),
//                   DropdownMenuItem(
//                     value: 'advanced',
//                     child: Text('Advanced (daily workouts)'),
//                   ),
//                   DropdownMenuItem(
//                     value: 'true beast',
//                     child: Text('True Beast (2x/day training)'),
//                   ),
//                 ],
//                 onChanged: (value) =>
//                     setState(() => _activityLevel = value.toString()),
//               ),
//               const SizedBox(height: 30),

//               // Calculate Button
//               ElevatedButton(
//                 onPressed: _isCalculating ? null : _calculateTDEE,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: PrimaryColor,
//                   minimumSize: Size(size.width * 0.9, 50),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: _isCalculating
//                     ? const CircularProgressIndicator(color: Colors.black)
//                     : const Text('Calculate TDEE',
//                         style: TextStyle(color: Colors.black)),
//               ),
//               const SizedBox(height: 30),

//               // Results
//               if (_hasCalculated) _buildResults(),

//               // Training Level Guide
//               const SizedBox(height: 20),
//               _buildTrainingLevelGuide(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputField(TextEditingController controller, String label) {
//     return TextField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       style: const TextStyle(color: Colors.white),
//     );
//   }

//   Widget _buildResults() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         children: [
//           const Text('Your TDEE',
//               style: TextStyle(
//                   color: PrimaryColor,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           Text('${_tdee.toStringAsFixed(0)} calories/day',
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold)),
//           const SizedBox(height: 20),
//           const Text('Calorie Goals',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           _buildGoalRow('Maintenance', _goalCalories['Maintenance']!),
//           _buildGoalRow('Cutting (-300)', _goalCalories['Cutting']!),
//           _buildGoalRow(
//               'Aggressive Cut (-600)', _goalCalories['Aggressive Cut']!),
//           _buildGoalRow('Bulking (+300)', _goalCalories['Bulking']!),
//           _buildGoalRow(
//               'Aggressive Bulk (+600)', _goalCalories['Aggressive Bulk']!),
//         ],
//       ),
//     );
//   }

//   Widget _buildGoalRow(String label, double calories) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(color: Colors.white)),
//           Text('${calories.toStringAsFixed(0)} cal',
//               style: TextStyle(
//                   color: label.contains('Cut')
//                       ? Colors.red[300]
//                       : label.contains('Bulk')
//                           ? Colors.green[300]
//                           : Colors.white,
//                   fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _buildTrainingLevelGuide() {
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Training Level Guide',
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           SizedBox(height: 10),
//           Text('🏆 Rookie: Just starting out (1-2 workouts/week)',
//               style: TextStyle(color: Colors.white54)),
//           Text('🥉 Beginner: Consistent 3-4 workouts/week',
//               style: TextStyle(color: Colors.white54)),
//           Text('🥈 Intermediate: Serious training (5-6 workouts/week)',
//               style: TextStyle(color: Colors.white54)),
//           Text('🥇 Advanced: Daily intense workouts',
//               style: TextStyle(color: Colors.white54)),
//           Text('💪 True Beast: Professional athlete level (2x/day)',
//               style: TextStyle(color: Colors.white54)),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _ageController.dispose();
//     _heightController.dispose();
//     _weightController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:fitness_app/constants/color.dart';

class TDEECalculatorPage extends StatefulWidget {
  final Function(Map<String, dynamic>)? onComplete;
  final bool isInFlow;

  const TDEECalculatorPage({
    super.key,
    this.onComplete,
    this.isInFlow = false,
  });

  @override
  State<TDEECalculatorPage> createState() => _TDEECalculatorPageState();
}

class _TDEECalculatorPageState extends State<TDEECalculatorPage> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _gender = 'male';
  String _activityLevel = 'rookie';
  bool _isCalculating = false;
  bool _hasCalculated = false;

  double _tdee = 0;
  Map<String, double> _goalCalories = {
    'Maintenance': 0,
    'Cutting': 0,
    'Aggressive Cut': 0,
    'Bulking': 0,
    'Aggressive Bulk': 0,
  };

  final Map<String, double> _activityLevels = {
    'rookie': 1.3,
    'beginner': 1.45,
    'intermediate': 1.6,
    'advanced': 1.8,
    'true beast': 2.0,
  };

  void _calculateTDEE() {
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

    Future.delayed(const Duration(seconds: 2), () {
      final int age = int.parse(_ageController.text);
      final double height = double.parse(_heightController.text);
      final double weight = double.parse(_weightController.text);

      double bmr = _gender == 'male'
          ? (10 * weight) + (6.25 * height) - (5 * age) + 5
          : (10 * weight) + (6.25 * height) - (5 * age) - 161;

      _tdee = bmr * _activityLevels[_activityLevel]!;

      _goalCalories = {
        'Maintenance': _tdee,
        'Cutting': _tdee - 300,
        'Aggressive Cut': _tdee - 600,
        'Bulking': _tdee + 300,
        'Aggressive Bulk': _tdee + 600,
      };

      setState(() {
        _isCalculating = false;
        _hasCalculated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (widget.isInFlow) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('TDEE Calculator'),
              centerTitle: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
                      _buildInputField(_ageController, 'Age (years)'),
                      const SizedBox(height: 20),
                      _buildInputField(_heightController, 'Height (cm)'),
                      const SizedBox(height: 20),
                      _buildInputField(_weightController, 'Weight (kg)'),
                      const SizedBox(height: 20),
                      _buildActivityDropdown(),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _isCalculating ? null : _calculateTDEE,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimaryColor,
                          minimumSize: Size(size.width * 0.9, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isCalculating
                            ? const CircularProgressIndicator(
                                color: Colors.black)
                            : const Text('Calculate TDEE',
                                style: TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(height: 30),
                      if (_hasCalculated) _buildResults(),
                      const SizedBox(height: 20),
                      _buildTrainingLevelGuide(),
                    ],
                  ),
                ),
              ),
            ),
            if (_hasCalculated)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.onComplete != null) {
                      widget.onComplete!({
                        'TDEE': '${_tdee.toStringAsFixed(0)} calories/day',
                        'Maintenance':
                            '${_goalCalories['Maintenance']!.toStringAsFixed(0)} cal',
                        'Cutting (-300)':
                            '${_goalCalories['Cutting']!.toStringAsFixed(0)} cal',
                        'Aggressive Cut (-600)':
                            '${_goalCalories['Aggressive Cut']!.toStringAsFixed(0)} cal',
                        'Bulking (+300)':
                            '${_goalCalories['Bulking']!.toStringAsFixed(0)} cal',
                        'Aggressive Bulk (+600)':
                            '${_goalCalories['Aggressive Bulk']!.toStringAsFixed(0)} cal',
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      const Text('Next', style: TextStyle(color: Colors.black)),
                ),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('TDEE Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
              _buildInputField(_ageController, 'Age (years)'),
              const SizedBox(height: 20),
              _buildInputField(_heightController, 'Height (cm)'),
              const SizedBox(height: 20),
              _buildInputField(_weightController, 'Weight (kg)'),
              const SizedBox(height: 20),
              _buildActivityDropdown(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isCalculating ? null : _calculateTDEE,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor,
                  minimumSize: Size(size.width * 0.9, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isCalculating
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text('Calculate TDEE',
                        style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 30),
              if (_hasCalculated) _buildResults(),
              const SizedBox(height: 20),
              _buildTrainingLevelGuide(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildActivityDropdown() {
    return DropdownButtonFormField(
      value: _activityLevel,
      dropdownColor: Colors.grey[900],
      decoration: InputDecoration(
        labelText: 'Training Level',
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      style: const TextStyle(color: Colors.white),
      items: const [
        DropdownMenuItem(
          value: 'rookie',
          child: Text('Rookie (1-2 workouts/week)'),
        ),
        DropdownMenuItem(
          value: 'beginner',
          child: Text('Beginner (3-4 workouts/week)'),
        ),
        DropdownMenuItem(
          value: 'intermediate',
          child: Text('Intermediate (5-6 workouts/week)'),
        ),
        DropdownMenuItem(
          value: 'advanced',
          child: Text('Advanced (daily workouts)'),
        ),
        DropdownMenuItem(
          value: 'true beast',
          child: Text('True Beast (2x/day training)'),
        ),
      ],
      onChanged: (value) => setState(() => _activityLevel = value.toString()),
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
          const Text('Your TDEE',
              style: TextStyle(
                  color: PrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('${_tdee.toStringAsFixed(0)} calories/day',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('Calorie Goals',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildGoalRow('Maintenance', _goalCalories['Maintenance']!),
          _buildGoalRow('Cutting (-300)', _goalCalories['Cutting']!),
          _buildGoalRow(
              'Aggressive Cut (-600)', _goalCalories['Aggressive Cut']!),
          _buildGoalRow('Bulking (+300)', _goalCalories['Bulking']!),
          _buildGoalRow(
              'Aggressive Bulk (+600)', _goalCalories['Aggressive Bulk']!),
        ],
      ),
    );
  }

  Widget _buildGoalRow(String label, double calories) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text('${calories.toStringAsFixed(0)} cal',
              style: TextStyle(
                  color: label.contains('Cut')
                      ? Colors.red[300]
                      : label.contains('Bulk')
                          ? Colors.green[300]
                          : Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTrainingLevelGuide() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Training Level Guide',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('🏆 Rookie: Just starting out (1-2 workouts/week)',
              style: TextStyle(color: Colors.white54)),
          Text('🥉 Beginner: Consistent 3-4 workouts/week',
              style: TextStyle(color: Colors.white54)),
          Text('🥈 Intermediate: Serious training (5-6 workouts/week)',
              style: TextStyle(color: Colors.white54)),
          Text('🥇 Advanced: Daily intense workouts',
              style: TextStyle(color: Colors.white54)),
          Text('💪 True Beast: Professional athlete level (2x/day)',
              style: TextStyle(color: Colors.white54)),
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
