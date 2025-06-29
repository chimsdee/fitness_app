// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AdvancedPage extends StatefulWidget {
  const AdvancedPage({super.key});

  @override
  _AdvancedPageState createState() => _AdvancedPageState();
}

class _AdvancedPageState extends State<AdvancedPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isTimerRunning = false;
  int _timerSeconds = 3;
  late AnimationController _animationController;
  List<bool> _completedExercises = List.filled(5, false);

  final List<String> _exercises = [
    "Pec Deck Fly",
    "Dumbbell-Fly",
    "Pull-up",
    "Dumbbell Straight Leg Deadlift",
    "Lying-High-Bench Barbell Curl"
  ];

  final Map<String, String> _exerciseInstructions = {
    "Pec Deck Fly":
        "1. Lie flat on a bench holding dumbbells above your chest, palms facing each other.\n2. With a slight bend in your elbows, slowly lower the dumbbells in a wide arc until your arms are level with your chest.\n3. Pause briefly, then raise the dumbbells back up using the same arc.\n4. Keep the motion smooth—don’t let the weights drop quickly.",
    "Dumbbell-Fly":
        "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand at your sides.\n2. Raise the dumbbells out to the sides in a wide arc until they are level with your shoulders.\n3. Keep a slight bend in your elbows and avoid swinging the weights.\n4. Lower the dumbbells back to the starting position in a controlled manner.",
    "Pull-up":
        "1. Hang from a pull-up bar with an overhand grip, hands slightly wider than shoulder-width.\n2. Engage your back and core, then pull your body up until your chin is above the bar.\n3. Lower yourself back down in a controlled manner until your arms are fully extended.\n4. Avoid swinging or using momentum—focus on using your muscles.",
    "Dumbbell Straight Leg Deadlift":
        "1. Stand with feet hip-width apart, holding a dumbbell in each hand in front of your thighs.\n2. Keeping your back straight, hinge at the hips and lower the dumbbells down along your legs while keeping them close to your body.\n3. Lower until you feel a stretch in your hamstrings, then return to standing by engaging your glutes and hamstrings.\n4. Keep a slight bend in your knees throughout the movement.",
    "Lying-High-Bench Barbell Curl":
        "1. Lie back on a high bench with your arms hanging down, holding a barbell with an underhand grip.\n2. Curl the barbell up towards your shoulders while keeping your elbows close to your body.\n3. Squeeze at the top of the movement, then lower the barbell back down in a controlled manner.\n4. Avoid swinging or using momentum—focus on isolating your biceps.",
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
      appBar: AppBar(title: const Text("Advanced Workout")),
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
      "Pec Deck Fly": "assets/exercises/Pec-Deck-Fly.gif",
      "Dumbbell-Fly": "assets/exercises/Dumbbell-Fly.gif",
      "Pull-up": "assets/exercises/Pull-up.gif",
      "Dumbbell Straight Leg Deadlift":
          "assets/exercises/Dumbbell-Straight-Leg-Deadlift.gif",
      "Lying-High-Bench Barbell Curl":
          "assets/exercises/Lying-High-Bench-Barbell-Curl.gif",
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
