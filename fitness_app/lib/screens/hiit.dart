// ignore_for_file: library_private_types_in_public_api

import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HighIntensityPage extends StatefulWidget {
  const HighIntensityPage({super.key});

  @override
  _HighIntensityPageState createState() => _HighIntensityPageState();
}

class _HighIntensityPageState extends State<HighIntensityPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isTimerRunning = false;
  int _timerSeconds = 3;
  late AnimationController _animationController;
  final List<bool> _completedExercises = List.filled(5, false);

  final List<String> _exercises = [
    "Bodyweight Squat",
    "Push Ups",
    "Glutes Bridges",
    "Mountain Climbers",
    "Plank"
  ];

  final Map<String, String> _exerciseInstructions = {
    "Bodyweigt Squats":
        "1. Stand with feet shoulder-width apart\n2. Lower hips back and down as if sitting in a chair\n3. Keep chest up and knees behind toes\n4. Return to standing position",
    "Push-Ups":
        "1. Start in plank position with hands shoulder-width apart\n2. Lower body until chest nearly touches floor\n3. Push back up to starting position",
    "Glutes Bridges":
        "1. Lie on your back with your knees bent, feet flat on the floor hip-width apart, and arms by your sides.\n2. Tighten your core and squeeze your glutes.\n3. Lift your hips off the ground until your body forms a straight line from shoulders to knees.\n4. Hold for 1-2 seconds, then slowly lower your hips back down. Repeat. ",
    "Mountain Climbers":
        "1. Start in a plank position with your hands directly under your shoulders and your body in a straight line.\n2. Engage your core to keep your hips level.\n3. Drive one knee toward your chest quickly.\n4. Switch legs rapidly, as if you’re \"running\" in place. Continue alternating. ",
    "Plank":
        "1. Lie face down, then lift onto your forearms and toes.\n2. Keep your elbows under your shoulders and your body in a straight line from head to heels.\n3. Engage your core, glutes, and legs—avoid sagging or raising your hips.\n4. Hold the position for as long as you can maintain proper form.",
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
      appBar: AppBar(title: const Text("HIIT Workout")),
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
      "Bodyweight Squat": "assets/exercises/bodyweight-squat.gif",
      "Push Ups": "assets/exercises/push_up.gif",
      "Glutes Bridges": "assets/exercises/Glute-Bridge-.gif",
      "Mountain Climbers": "assets/exercises/Mountain-climber.gif",
      "Plank": "assets/exercises/plank.gif",
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
