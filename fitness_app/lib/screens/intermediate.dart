import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class IntermediatePage extends StatefulWidget {
  const IntermediatePage({Key? key}) : super(key: key);

  @override
  _IntermediatePageState createState() => _IntermediatePageState();
}

class _IntermediatePageState extends State<IntermediatePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isTimerRunning = false;
  int _timerSeconds = 3;
  late AnimationController _animationController;
  List<bool> _completedExercises = List.filled(5, false);

  final List<String> _exercises = [
    "Standing Quadriceps Stretch",
    "Bodyweight Lunges",
    "One Arm Dumbbell Snatch",
    "Plank",
    "Pike Push-up"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _animationController = AnimationController(vsync: this);
  }

  void _startTimer() {
    setState(() => _isTimerRunning = true);
    Future.delayed(Duration(seconds: 1), () {
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

  void _showWorkoutComplete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/celebrate.json', height: 200),
            Text("Workout Complete! 🎉"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: Text("Back to Home"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Intermediate Workout")),
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
              style: TextStyle(fontSize: 18),
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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Exercise GIF
          Container(
            height: 200,
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
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Text(
                    "GIF not found",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          // Timer and Start Button (keep existing code below)
          SizedBox(height: 20),
          CircularPercentIndicator(
            radius: 100,
            lineWidth: 15,
            percent: _timerSeconds / 3,
            center: Text("$_timerSeconds", style: TextStyle(fontSize: 40)),
            progressColor: PrimaryColor,
          ),
          SizedBox(height: 20),

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
