// ignore_for_file: file_names

import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/screens/advanced.dart';
import 'package:fitness_app/screens/beginner.dart';
import 'package:fitness_app/screens/core.dart';
import 'package:fitness_app/screens/hiit.dart';
import 'package:fitness_app/screens/intermediate.dart';
import 'package:fitness_app/screens/yoga.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class workoutCategories extends StatelessWidget {
  final List<WorkoutCategory> categories = [
    WorkoutCategory(
      title: "Beginner",
      description: "Start your fitness journey with basic exercises",
      image: "assets/images/beginner.jpeg",
      page: const BeginnerPage(),
    ),
    WorkoutCategory(
      title: "Intermediate",
      description: "Push your limits with moderate challenges",
      image: "assets/images/intermediate.webp",
      page: const IntermediatePage(),
    ),
    WorkoutCategory(
      title: "Advanced",
      description: "Elite workouts for maximum results",
      image: "assets/images/advanced.jpeg",
      page: const AdvancedPage(),
    ),
    WorkoutCategory(
      title: "Yoga Flow",
      description: "Mindful movements for flexibility",
      image: "assets/images/yoga.jpeg",
      page: const YogaPage(), // Replace with actual YogaPage()
    ),
    WorkoutCategory(
      title: "HIIT Blast",
      description: "High intensity fat burning",
      image: "assets/images/hiit.jpeg",
      page: const HighIntensityPage(), // Replace with HIITPage()
    ),
    WorkoutCategory(
      title: "Core Power",
      description: "Strengthen your foundation",
      image: "assets/images/core.jpeg",
      page: const CorePowerPage(), // Replace with CorePage()
    ),
  ];

  workoutCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("All Workout Programs"),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: PrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return WorkoutCategoryCard(category: categories[index]);
          },
        ),
      ),
    );
  }
}

class WorkoutCategory {
  final String title;
  final String description;
  final String image;
  final Widget page;

  WorkoutCategory({
    required this.title,
    required this.description,
    required this.image,
    required this.page,
  });
}

class WorkoutCategoryCard extends StatelessWidget {
  final WorkoutCategory category;

  const WorkoutCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => category.page),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(category.image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                category.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Start Now",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
