// ignore_for_file: library_private_types_in_public_api

import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WarmUpsPage extends StatefulWidget {
  const WarmUpsPage({super.key});

  @override
  _WarmUpsPageState createState() => _WarmUpsPageState();
}

class _WarmUpsPageState extends State<WarmUpsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isTimerRunning = false;
  int _timerSeconds = 3;
  late AnimationController _animationController;
  final List<bool> _completedExercises = List.filled(5, false);

  final List<String> _exercises = [
    "Arm Circles",
    "High Knee Run",
    "Cossack Squat",
    "Dynamic Chest Stretch",
    "Elbow to Knee Twists"
  ];

  final Map<String, String> _exerciseInstructions = {
    "Arm Circles":
        "Stand tall with feet shoulder-width apart and extend your arms out to the sides at shoulder height.\n2.Start making small circles with your arms going forward.\n3. Gradually increase the size of the circles for 10–15 seconds.\n4. Reverse direction and repeat backward for the same duration.",
    "High Knee Run":
        "1. Stand straight with arms at your sides.\n2. Begin running in place, lifting your knees as high as possible towards your chest.\n3. Pump your arms as if sprinting to stay balanced.\n4. Maintain a quick pace for 20–30 seconds. ",
    "Cossack Squat":
        "1. Stand with feet wider than shoulder-width apart and point toes slightly out.\n2. Shift your weight to one leg and squat down on that side while keeping the other leg straight.\n3. Keep your chest up and reach your arms forward for balance.\n4. Push through your bent leg to return to the center, then repeat on the other side. ",
    "Dynamic Chest Stretch":
        "1. Stand upright with feet shoulder-width apart.\n2. Extend both arms straight out to the sides.\n3. Swing your arms in front of your chest and cross them, alternating which arm is on top.\n4. Open your arms back out and repeat continuously for 10–15 reps. ",
    "Elbow to Knee Twists":
        "1. Stand with feet hip-width apart and place your hands behind your head.\n2. Lift your right knee while twisting your torso to bring your left elbow toward it.\n3. Return to the starting position.\n4. Repeat with the opposite elbow and knee, alternating sides. ",
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _animationController = AnimationController(vsync: this);
  }

  void _startTimer() {
    setState(() => _isTimerRunning = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
        _startTimer(); // Recursive call for countdown
      } else {
        _exerciseCompleted();
      }
    });
  }

  void _exerciseCompleted() {
    setState(() {
      _isTimerRunning = false;
      _completedExercises[_currentTabIndex] = true;
      _timerSeconds = 3; // Reset timer
    });
    _showCompletionDialog();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/congrats.json', height: 150),
            Text(
                "Congratulations!\nYou finished ${_exercises[_currentTabIndex]}!"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (_currentTabIndex < 4) {
                setState(() {
                  // <-- Add this
                  _currentTabIndex++; // Update the index first
                });
                _tabController.animateTo(_currentTabIndex); // Then move the tab
              } else {
                _showWorkoutComplete();
              }
            },
            child: Text(_currentTabIndex == 4 ? "Done" : "Next Warm-Up"),
          ),
        ],
      ),
    );
  }

  void _showInstructions(String exercise) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$exercise Instructions"),
        content: SingleChildScrollView(
          child: Text(
              _exerciseInstructions[exercise] ?? "No instructions available"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showWorkoutComplete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/celebrate.json', height: 200),
            const Text("Workout Complete! 🎉"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("Back to Home"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Warm-Ups")),
      body: Column(
        children: [
          // Tab Bar
          TabBar(
            controller: _tabController,
            tabs: _exercises.map((e) => Tab(text: e)).toList(),
            isScrollable: true,
            onTap: (index) => setState(() => _currentTabIndex = index),
          ),

          // Exercise Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _exercises
                  .map((exercise) => _buildExerciseTab(exercise))
                  .toList(),
            ),
          ),

          // Progress Tracker
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Progress: ${_completedExercises.where((e) => e).length}/5",
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseTab(String exercise) {
    // Map exercise names to GIF filenames
    final gifPaths = {
      "Arm Circles": "assets/exercises/Arm-Circles_Shoulders.gif",
      "High Knee Run": "assets/exercises/High-Knee-Run.gif",
      "Cossack Squat": "assets/exercises/Cossack-Squat.gif",
      "Dynamic Chest Stretch": "assets/exercises/Dynamic-Chest-Stretch.gif",
      "Elbow to Knee Twists": "assets/exercises/Elbow-To-Knee-Twists.gif",
    };

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Exercise GIF
          Stack(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    gifPaths[exercise] ?? 'assets/exercises/default.gif',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Text(
                        "GIF not found",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => _showInstructions(exercise),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: PrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Timer and Start Button (keep existing code below)
          const SizedBox(height: 20),
          CircularPercentIndicator(
            radius: 100,
            lineWidth: 15,
            percent: _timerSeconds / 3,
            center:
                Text("$_timerSeconds", style: const TextStyle(fontSize: 40)),
            progressColor: PrimaryColor,
          ),
          const SizedBox(height: 20),

          // Start Button
          ElevatedButton(
            onPressed: _isTimerRunning ? null : _startTimer,
            child: Text(_isTimerRunning ? "Running..." : "Start Exercise"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
