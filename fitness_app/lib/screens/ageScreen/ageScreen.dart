// ignore_for_file: file_names, unnecessary_import, prefer_const_constructors, unused_element

import 'package:fitness_app/Provider/user_provider.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/models/DetailPageButton.dart';
import 'package:fitness_app/models/DetailPageTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => __AgePageState();
}

class __AgePageState extends State<AgePage> {
  int age = 18;
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: age - 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to get the appropriate character illustration based on age
  Widget _getCharacterIllustration(int age) {
    if (age < 20) {
      return Image.asset(
        'assets/teen_character.png', // Replace with your actual asset path
        height: 250,
        fit: BoxFit.contain,
      );
    } else if (age < 30) {
      return Image.asset(
        'assets/young_adult_character.png', // Replace with your actual asset path
        height: 250,
        fit: BoxFit.contain,
      );
    } else if (age < 50) {
      return Image.asset(
        'assets/adult_character.png', // Replace with your actual asset path
        height: 250,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        'assets/senior_character.png', // Replace with your actual asset path
        height: 250,
        fit: BoxFit.contain,
      );
    }
  }

  // For demo purposes, we'll use icons - replace with your actual images
  Widget _getCharacterPlaceholder(int age) {
    IconData icon;
    Color color;

    if (age < 20) {
      icon = Icons.child_care;
      color = Colors.blue;
    } else if (age < 30) {
      icon = Icons.face;
      color = Colors.green;
    } else if (age < 50) {
      icon = Icons.person;
      color = Colors.orange;
    } else {
      icon = Icons.elderly;
      color = Colors.purple;
    }

    return Icon(
      icon,
      size: 200,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> ageValues = List.generate(99, (index) => index + 1);

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
                top: size.height * 0.07,
                left: size.width * 0.05,
                right: size.width * 0.05,
                bottom: size.width * 0.03,
              ),
              child: Column(
                children: [
                  DetailPageTitle(
                    title: 'How old are you?',
                    text:
                        'This will help us create a personalized plan for you',
                    color: Colors.white,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      '$age years old',
                      key: ValueKey<int>(age),
                      style: TextStyle(
                        color: PrimaryColor,
                        fontSize: size.height * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),

                  // Main content row with character on left and picker on right
                  Expanded(
                    child: Row(
                      children: [
                        // Character illustration column (left side)
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: _getCharacterPlaceholder(age),
                                // In your actual app, use:
                                // _getCharacterIllustration(age),
                              ),
                              SizedBox(height: 20),
                              Text(
                                _getAgeGroup(age),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Age picker column (right side)
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(height: size.height * 0.02),
                              SizedBox(
                                height: 300,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _controller,
                                  itemExtent: 50,
                                  magnification: 1.2,
                                  useMagnifier: true,
                                  overAndUnderCenterOpacity: 0.3,
                                  physics: const FixedExtentScrollPhysics(),
                                  onSelectedItemChanged: (index) {
                                    setState(() {
                                      age = ageValues[index];
                                    });
                                  },
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    builder: (context, index) {
                                      if (index < 0 ||
                                          index >= ageValues.length) {
                                        return null;
                                      }
                                      final isSelected =
                                          age == ageValues[index];
                                      return Center(
                                        child: Text(
                                          '${ageValues[index]}',
                                          style: TextStyle(
                                            color: PrimaryColor,
                                            fontSize: isSelected ? 28 : 24,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: ageValues.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Next button
                  DetailPageButton(
                    text: 'Next',
                    onTap: () {
                      userProvider.setAge(age);
                      Navigator.pushNamed(context, '/weight');
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

  String _getAgeGroup(int age) {
    if (age < 20) return "Teenager";
    if (age < 30) return "Young Adult";
    if (age < 50) return "Adult";
    return "Senior";
  }
}
