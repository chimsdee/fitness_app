// ignore_for_file: file_names, unnecessary_import

import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/constants/padding_margin.dart';
import 'package:fitness_app/screens/advanced.dart';
import 'package:fitness_app/screens/beginner.dart';
import 'package:fitness_app/screens/intermediate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late Size size;
  List<String> workoutCategories = ["Beginner", "Intermediate", "Advanced"];
  int selectedCategory = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScrollUpdate);
  }

  void _handleScrollUpdate() {
    final double scrollPosition = _scrollController.position.pixels;
    final double itemWidth = size.width * 0.8 + size.width * 0.04;
    final int newCategory = (scrollPosition / itemWidth).round();

    if (newCategory != selectedCategory) {
      setState(() {
        selectedCategory = newCategory.clamp(0, workoutCategories.length - 1);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScrollUpdate);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
          child: Container(
            padding: AppPadding.horizontalPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.005,
                ),
                Text(
                  'Good Morning',
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Workout Plan",
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sat, 12 Nov",
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: PrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/warmups');
                  },
                  child: Container(
                    width: size.width * 0.9,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                      // color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ImageStack(
                      size: size,
                      image: 'assets/onBoardingImages/man 4.webp',
                      title: 'Daily Warm-Up Session',
                      time: '',
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Workout Categories",
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/workoutCategories');
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: PrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ToggleButtons(
                  isSelected: List.generate(workoutCategories.length,
                      (index) => index == selectedCategory),
                  onPressed: (int index) {
                    setState(() {
                      selectedCategory = index;
                    });

                    final double scrollPosition =
                        index * (size.width * 0.8 + size.width * 0.04);
                    _scrollController.animateTo(
                      scrollPosition,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  children: workoutCategories.map((category) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedCategory ==
                                workoutCategories.indexOf(category)
                            ? PrimaryColor
                            : Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: selectedCategory ==
                                      workoutCategories.indexOf(category)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.2,
                  child: ListView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BeginnerPage()),
                          );
                        },
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ImageStack(
                            size: size,
                            title:
                                '   Build strength, one \n              step limits.',
                            time: '| 9:00 AM - 10:00 AM',
                            image: 'assets/onBoardingImages/woman 3.webp',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IntermediatePage()),
                          );
                        },
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                            // color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ImageStack(
                            size: size,
                            title:
                                '   Push limits, embrace \n              the burn.',
                            time: '| 9:00 AM - 10:00 AM',
                            image:
                                'assets/onBoardingImages/man 5.webp', //intermediate
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdvancedPage()),
                          );
                        },
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                            // color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ImageStack(
                            size: size,
                            title:
                                '   Dominate reps, destroy \n              your limits.',
                            time: '',
                            image:
                                'assets/onBoardingImages/man 6.jpg', //advanced
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Text(
                  "New Workout",
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  // it was a container before
                  height: size.height * 0.01,
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.2,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                          // color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ImageStack(
                          size: size,
                          title: 'Day 01 - Warm Up',
                          time: '| 9:00 AM - 10:00 AM',
                          image: 'assets/onBoardingImages/woman 3.webp',
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                          // color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ImageStack(
                          size: size,
                          title: 'Day 01 - Warm Up',
                          time: '| 9:00 AM - 10:00 AM',
                          image: 'assets/onBoardingImages/woman 4.jpg',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageStack extends StatelessWidget {
  const ImageStack({
    super.key,
    required this.size,
    required this.image,
    required this.title,
    required this.time,
  });

  final Size size;
  final String image;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width * 0.9,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          left: size.width * 0.03,
          top: size.height * 0.125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.052,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                time, // it was "$time" before
                style: TextStyle(
                  fontSize: size.width * 0.03,
                  color: PrimaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
