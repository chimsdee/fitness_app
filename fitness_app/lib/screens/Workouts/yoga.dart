import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class YogaPage extends StatefulWidget {
  const YogaPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YogaPageState createState() => _YogaPageState();
}

class _YogaPageState extends State<YogaPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isTimerRunning = false;
  int _timerSeconds = 3;
  late AnimationController _animationController;
  final List<bool> _completedExercises = List.filled(5, false);

  final List<String> _exercises = [
    "Ultrasana",
    "Cow Pose",
    "Cobra Stretch",
    "Butterfly Pose",
    "Half Pigeon Pose"
  ];

  final Map<String, String> _exerciseInstructions = {
    "Ultrasana":
        "1. Kneel on the floor with knees hip-width apart and hands on your lower back.\n2. Inhale and lift your chest, pressing your hips forward.\n3. Reach back to hold your heels (if flexible enough), keeping your neck relaxed.\n4. Hold the pose for a few breaths, then slowly return upright.",
    "Cow Pose":
        "1. Start on your hands and knees (tabletop position).\n2. Inhale, drop your belly toward the mat and lift your chest and chin.\n3. Arch your back gently while keeping shoulders away from ears.\n4. Exhale and return to the neutral spine or flow into Cat Pose.",
    "Cobra Stretch":
        "1. Lie face-down with legs extended and palms under your shoulders.\n2. Inhale and gently lift your chest, pressing through your palms.\n3. Keep elbows close to your body and shoulders relaxed.\n4. Hold for a few breaths, then lower back down. ",
    "Butterfly Pose":
        "1. Sit with your spine straight and soles of your feet together.\n2. Let your knees drop toward the floor while holding your feet.\n3. Inhale and lengthen your spine; exhale and gently lean forward.\n4. Hold the stretch without forcing your knees down.",
    "Half Pigeon Pose":
        "1. From a tabletop or downward dog, bring your right knee forward toward your right wrist.\n2. Extend your left leg straight back with the top of your foot on the mat.\n3. Keep hips square and gently lower your upper body over your front leg.\n4. Breathe deeply and switch sides after holding.",
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
      appBar: AppBar(title: const Text("Yoga Workout")),
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
      "Cow Pose": "assets/exercises/cowpose.gif",
      "Ustrasana": "assets/exercises/Ustrasana.gif",
      "Cobra Stretch": "assets/exercises/cobrastretch.gif",
      "Butterfly Pose": "assets/exercises/butterflypose.gif",
      "Half Pigeon Pose": "assets/exercises/half-pigeonpose.png",
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
