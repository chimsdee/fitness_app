// import 'package:fitness_app/constants/color.dart';
// import 'package:fitness_app/constants/padding_margin.dart';
// import 'package:fitness_app/screens/homeScreen/homeScreen.dart';
// import 'package:flutter/material.dart';

// class workoutCategories extends StatefulWidget {
//   const workoutCategories({super.key});

//   @override
//   State<workoutCategories> createState() => _workoutCategoriesState();
// }

// class _workoutCategoriesState extends State<workoutCategories> {
//   @override
//   Widget build(BuildContext context) {
//     List<String> workoutCategories = ["Beginner", "Intermediate", "Advanced"];
//     int selectedCategory = 0;

//     final Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SingleChildScrollView(
//           child: Container(
//             padding: AppPadding.horizontalPadding(context),
//             child: Column(
//               children: [
//                 Text(
//                   'Workout Categories',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 ToggleButtons(
//                   isSelected: List.generate(workoutCategories.length,
//                       (index) => index == selectedCategory),
//                   onPressed: (int index) {
//                     setState(() {
//                       selectedCategory = index;
//                     });
//                   },
//                   children: workoutCategories.map((category) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: selectedCategory ==
//                                 workoutCategories.indexOf(category)
//                             ? PrimaryColor
//                             : Colors.black,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 18),
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           child: Text(
//                             category,
//                             style: TextStyle(
//                               color: selectedCategory ==
//                                       workoutCategories.indexOf(category)
//                                   ? Colors.black
//                                   : Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 Container(
//                   width: size.width * 0.9,
//                   height: size.height * 0.2,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     // color: PrimaryColor,
//                   ),
//                   child: ImageStack(
//                     size: size,
//                     title: 'Day 01 - Warm Up',
//                     time: '| 9:00 AM - 10:00 AM',
//                     image: 'assets/onBoardingImages/man 7.webp',
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 Container(
//                   width: size.width * 0.9,
//                   height: size.height * 0.2,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     // color: PrimaryColor,
//                   ),
//                   child: ImageStack(
//                     size: size,
//                     title: 'Day 02 - Warm Up',
//                     time: '| 9:00 AM - 10:00 AM',
//                     image: 'assets/onBoardingImages/woman 4.jpg',
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 Container(
//                   width: size.width * 0.9,
//                   height: size.height * 0.2,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     // color: PrimaryColor,
//                   ),
//                   child: ImageStack(
//                     size: size,
//                     title: 'Day 03   - Warm Up',
//                     time: '| 9:00 AM - 10:00 AM',
//                     image: 'assets/onBoardingImages/man 8.webp',
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 Container(
//                   width: size.width * 0.9,
//                   height: size.height * 0.2,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     // color: PrimaryColor,
//                   ),
//                   child: ImageStack(
//                     size: size,
//                     title: 'Day 04   - exercise',
//                     time: '| 9:00 AM - 10:00 AM',
//                     image: 'assets/onBoardingImages/man 8.webp',
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 Container(
//                   width: size.width * 0.9,
//                   height: size.height * 0.2,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     // color: PrimaryColor,
//                   ),
//                   child: ImageStack(
//                     size: size,
//                     title: 'Day 05   - final',
//                     time: '| 9:00 AM - 10:00 AM',
//                     image: 'assets/onBoardingImages/man 8.webp',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/screens/advanced.dart';
import 'package:fitness_app/screens/beginner.dart';
import 'package:fitness_app/screens/intermediate.dart';
import 'package:flutter/material.dart';

class workoutCategories extends StatelessWidget {
  final List<WorkoutCategory> categories = [
    WorkoutCategory(
      title: "Beginner",
      description: "Start your fitness journey with basic exercises",
      image: "assets/images/beginner.jpeg",
      page: BeginnerPage(),
    ),
    WorkoutCategory(
      title: "Intermediate",
      description: "Push your limits with moderate challenges",
      image: "assets/images/intermediate.webp",
      page: IntermediatePage(),
    ),
    WorkoutCategory(
      title: "Advanced",
      description: "Elite workouts for maximum results",
      image: "assets/images/advanced.jpeg",
      page: AdvancedPage(),
    ),
    WorkoutCategory(
      title: "Yoga Flow",
      description: "Mindful movements for flexibility",
      image: "assets/images/yoga.jpeg",
      page: BeginnerPage(), // Replace with actual YogaPage()
    ),
    WorkoutCategory(
      title: "HIIT Blast",
      description: "High intensity fat burning",
      image: "assets/images/hiit.jpeg",
      page: IntermediatePage(), // Replace with HIITPage()
    ),
    WorkoutCategory(
      title: "Core Power",
      description: "Strengthen your foundation",
      image: "assets/images/core.jpeg",
      page: AdvancedPage(), // Replace with CorePage()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("All Workout Programs"),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: PrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

  const WorkoutCategoryCard({Key? key, required this.category})
      : super(key: key);

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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                category.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
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
