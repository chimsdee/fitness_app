// ignore_for_file: file_names,  avoid_print

import 'package:fitness_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/DetailPageButton.dart';
import 'package:fitness_app/models/DetailPageTitle.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:provider/provider.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen>
    with SingleTickerProviderStateMixin {
  String selectedGoal = 'Stay Healthy';
  late FixedExtentScrollController _controller;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  final List<String> goals = [
    'Lose Weight',
    'Build Muscle',
    'Stay Healthy',
    'Gain Weight',
    'Improve Endurance',
    'Stay Fit',
  ];

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
      initialItem: goals.indexOf(selectedGoal),
    );

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation immediately for the default selection
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            return Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.only(
                top: size.height * 0.06,
                left: size.width * 0.05,
                right: size.width * 0.05,
                bottom: size.width * 0.03,
              ),
              child: Column(
                children: [
                  const DetailPageTitle(
                    text:
                        'This will help us create a personalized plan for you',
                    title: 'What is your Goal?',
                    color: Colors.white,
                  ),

                  // Selected goal with pulse animation
                  SizedBox(height: size.height * 0.03),
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Text(
                          selectedGoal,
                          style: TextStyle(
                            color: PrimaryColor,
                            fontSize: size.height * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: size.height * 0.03),

                  // Wheel picker with animated selection
                  SizedBox(
                    height: 330,
                    child: Stack(
                      children: [
                        ListWheelScrollView.useDelegate(
                          controller: _controller,
                          itemExtent: 50,
                          magnification: 1.2,
                          useMagnifier: true,
                          overAndUnderCenterOpacity: 0.3,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedGoal = goals[index];
                            });
                            // Restart the pulse animation when selection changes
                            _animationController.reset();
                            _animationController.repeat(reverse: true);
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              final isSelected = selectedGoal == goals[index];
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                child: Center(
                                  child: Text(
                                    goals[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? PrimaryColor
                                          : PrimaryColor.withOpacity(0.7),
                                      fontSize: isSelected ? 28 : 24,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: goals.length,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  DetailPageButton(
                    text: 'Next',
                    onTap: () {
                      userProvider.setGoal(selectedGoal);
                      Navigator.pushNamed(context, '/activity');
                    },
                    showbackButton: true,
                    onBackTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
