import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IntermediatePage extends StatefulWidget {
  const IntermediatePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IntermediatePageState createState() => _IntermediatePageState();
}

class _IntermediatePageState extends State<IntermediatePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isTimerRunning = false;
  int _timerSeconds = 3;
  late AnimationController _animationController;
  final List<bool> _completedExercises = List.filled(5, false);

  final List<String> _exercises = [
    "Standing Quadriceps Stretch",
    "Bodyweight Lunges",
    "One Arm Dumbbell Snatch",
    "Plank",
    "Pike Push-up"
  ];

  final Map<String, String> _exerciseInstructions = {
    "Standing Quadriceps Stretch":
        "1. Stand tall and balance on your left leg.\n2. Bend your right knee and grab your right ankle or foot behind you with your right hand.\n3. Keep both knees close together and push your hips slightly forward.\n4. Hold the stretch for 15-30 seconds, then switch legs.",
    "Bodyweight Lunges":
        "1. Stand with feet hip-width apart and hands on your hips or at your sides.\n2. Step forward with your right foot and lower your body until both knees are at 90 degrees.\n3. Keep your front knee aligned with your ankle and your back knee just above the floor.\n4. Push off the front foot to return to the starting position, then repeat with the left leg. ",
    "One Arm Dumbbell Snatch":
        "1. Place a dumbbell on the ground between your feet and stand with feet shoulder-width apart.\n2. Squat down and grab the dumbbell with one hand.\n3. In one explosive motion, lift the dumbbell straight up overhead while extending your hips, knees, and ankles.\n4. Lock the dumbbell overhead with a straight arm, then lower it back to the ground and repeat. ",
    "Plank":
        "1. Lie face down, then lift onto your forearms and toes.\n2. Keep your elbows under your shoulders and your body in a straight line from head to heels.\n3. Engage your core, glutes, and legs—avoid sagging or raising your hips.\n4. Hold the position for as long as you can maintain proper form.",
    "Pike Push-up":
        "1. Start in a push-up position, then raise your hips high to form an inverted V shape\n2. Look toward your feet and keep your legs and arms straight.\n3. Bend your elbows and lower your head toward the ground between your hands.\n4. Push back up to the starting position and repeat. ",
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
      appBar: AppBar(title: const Text("Intermediate Workout")),
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
            padding: const EdgeInsets.all(8.0),
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
      "Standing Quadriceps Stretch":
          "assets/exercises/Standing-Quadriceps-Stretch.gif",
      "Bodyweight Lunges": "assets/exercises/bodyweight-lunges.gif",
      "One Arm Dumbbell Snatch": "assets/exercises/One-Arm-Dumbbell-Snatch.gif",
      "Plank": "assets/exercises/plank.gif",
      "Pike Push-up": "assets/exercises/Pike-Push-up.gif",
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
