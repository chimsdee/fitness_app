// ignore_for_file: library_private_types_in_public_api

import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CorePowerPage extends StatefulWidget {
  const CorePowerPage({super.key});

  @override
  _CorePowerPageState createState() => _CorePowerPageState();
}

class _CorePowerPageState extends State<CorePowerPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isTimerRunning = false;
  int _timerSeconds = 3;
  late AnimationController _animationController;
  final List<bool> _completedExercises = List.filled(5, false);

  final List<String> _exercises = [
    "Heel Touch",
    "Bicycle Crunch",
    "JackKnife Sit Ups",
    "Lying Scissor Kick",
    "Russian Twists"
  ];

  final Map<String, String> _exerciseInstructions = {
    "Heel Touch":
        "1. Lie on your back; knees bent, feet flat on the floor, arms at your sides.\n2. Crunch up slightly and reach your right hand to tap your right heel, then your left hand to tap your left heel.\n3. Keep your core engaged and your lower back pressed into the mat. Perform reps in a slow, controlled touch–tap rhythm.",
    "Bicycle Crunch":
        "1. Lie on your back with hands behind your head, knees bent at 90°.\n2. Bring your left elbow toward your right knee while straightening your left leg.\n3. Switch sides, bringing right elbow to left knee, like pedaling a bicycle.\n4. Keep your lower back pressed down and rotate through your core, not your neck. ",
    "JackKnife Sit Ups":
        "1. Lie flat with arms extended overhead and legs straight.\n2. Simultaneously lift your upper body and legs to meet in the middle, reaching your hands toward your toes—hinge from your core.\n3. Lower back down slowly, keeping the movement smooth and controlled. ",
    "Lying Scissor Kick":
        "1. Lie on your back with legs straight up toward the ceiling, hands under your glutes for support.\n2. Lower your right leg toward the floor while the left leg remains up; then switch.\n3. Keep your lower back pressed into the mat throughout—avoid arching or jerking.",
    "Russian Twists":
        "1.Sit on the floor with your knees bent and feet slightly lifted.\n2. Lean back slightly, keeping your back straight and core engaged.\n3. Hold your hands together or a weight, and twist your torso to the right.\n4. Twist back to the left, touching the floor lightly on each side. ",
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
            child: Text(_currentTabIndex == 4 ? "Done" : "Next Exercise"),
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
      appBar: AppBar(title: const Text("Core Workout")),
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
      "Heel Touch": "assets/exercises/Heel-Touch.gif",
      "Bicycle Crunch": "assets/exercises/Bicycle-Crunch.gif",
      "JackKnife Sit Ups": "assets/exercises/Jackknife-Sit-ups.gif",
      "Lying Scissor Kick": "assets/exercises/Lying-Scissor-Kick.gif",
      "Russian Twists": "assets/exercises/Russian-Twist.gif",
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
