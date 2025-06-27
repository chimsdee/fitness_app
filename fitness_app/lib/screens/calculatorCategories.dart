// ignore_for_file: file_names

import 'package:fitness_app/bmiCalculator.dart';
import 'package:fitness_app/bmrCalculator.dart';
import 'package:fitness_app/bodyfat_calc.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/hydration_calc.dart';
import 'package:fitness_app/idealweight_calc.dart';
import 'package:fitness_app/tdee_calc.dart';

import 'package:flutter/material.dart';

// ignore: camel_case_types
class calculatorCategories extends StatelessWidget {
  final List<CalculatorCategory> categories = [
    CalculatorCategory(
      title: "BMI Calculator",
      description: "Calculate your Body Mass Index",
      image: "assets/images/bmi.jpg",
      page: const BMICalculatorPage(),
    ),
    CalculatorCategory(
      title: "BMR Calculator",
      description: "Calculate your Basal Metabolic Rate",
      image: "assets/images/bmr.jpg",
      page: const BMRCalculatorPage(),
    ),
    CalculatorCategory(
      title: "TDEE Calculator",
      description: "Calculate your Total Daily Energy Expenditure",
      image: "assets/images/tdee.jpg",
      page: const TDEECalculatorPage(),
    ),
    CalculatorCategory(
      title: "Body Fat Calculator",
      description: "Calculate your Body Fat Percentage",
      image: "assets/images/bodyfat.jpg",
      page: const BodyFatCalculatorPage(),
    ),
    CalculatorCategory(
      title: "Ideal Weight Calculator",
      description: "Calculate your Ideal Weight",
      image: "assets/images/ideal.jpg",
      page: const IdealWeightCalculatorPage(),
    ),
    CalculatorCategory(
      title: "Hydration Calculator",
      description: "Calculate your daily water intake",
      image: "assets/images/hydration.jpg",
      page: const HydrationCalculatorPage(),
    ),
  ];

  calculatorCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Fitness Tools"),
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
            return CalculatorCategoryCard(category: categories[index]);
          },
        ),
      ),
    );
  }
}

class CalculatorCategory {
  final String title;
  final String description;
  final String image;
  final Widget page;

  CalculatorCategory({
    required this.title,
    required this.description,
    required this.image,
    required this.page,
  });
}

class CalculatorCategoryCard extends StatelessWidget {
  final CalculatorCategory category;

  const CalculatorCategoryCard({super.key, required this.category});

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
                  "Check Now",
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
