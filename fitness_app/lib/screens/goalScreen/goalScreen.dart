// import 'package:fitness_app/constants/color.dart';
// import 'package:fitness_app/models/DetailPageButton.dart.dart';
// import 'package:fitness_app/models/DetailPageTitle.dart';
// import 'package:fitness_app/models/ListWheelViewScroller.dart';
// import 'package:flutter/material.dart';

// class GoalScreen extends StatefulWidget {
//   const GoalScreen({super.key});

//   @override
//   State<GoalScreen> createState() => _GoalScreenState();
// }

// class _GoalScreenState extends State<GoalScreen> {
//   String goal = 'Stay Healthy';
//   late FixedExtentScrollController _controller;
//   final List<String> goals = [
//     'Lose Weight',
//     'Build Muscle',
//     'Stay Healthy',
//     'Gain Weight',
//     'Improve Endurance',
//     'Stay Fit',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Set initial position to default goal index
//     _controller = FixedExtentScrollController(
//       initialItem: goals.indexOf(goal),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         width: size.width,
//         height: size.height,
//         padding: EdgeInsets.only(
//           top: size.height * 0.06,
//           left: size.width * 0.05,
//           right: size.width * 0.05,
//           bottom: size.width * 0.03,
//         ),
//         child: Column(
//           children: [
//             const DetailPageTitle(
//               text: 'This will help us create a personalized plan for you',
//               title: 'What is your Goal?',
//               color: Colors.white,
//             ),
//             SizedBox(
//               height: size.height * 0.055,
//             ),
//             SizedBox(
//               height: 330,
//               child: ListWheelScrollView.useDelegate(
//                 controller: _controller,
//                 itemExtent: 50,
//                 magnification: 1.2,
//                 useMagnifier: true,
//                 overAndUnderCenterOpacity: 0.3,
//                 physics: const FixedExtentScrollPhysics(),
//                 onSelectedItemChanged: (index) {
//                   setState(() {
//                     goal = goals[index];
//                   });
//                 },
//                 childDelegate: ListWheelChildBuilderDelegate(
//                   builder: (context, index) {
//                     final isSelected = goal == goals[index];
//                     return Center(
//                       child: Text(
//                         goals[index],
//                         style: TextStyle(
//                           color: PrimaryColor,
//                           fontSize: isSelected ? 28 : 24,
//                           fontWeight:
//                               isSelected ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                     );
//                   },
//                   childCount: goals.length,
//                 ),
//               ),
//             ),
//             const Spacer(),
//             DetailPageButton(
//               text: 'Next',
//               onTap: () {
//                 Navigator.pushNamed(context, '/activity');
//               },
//               showbackButton: true,
//               onBackTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: file_names, avoid_print

import 'package:fitness_app/Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/DetailPageButton.dart.dart';
import 'package:fitness_app/models/DetailPageTitle.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:provider/provider.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String selectedGoal = 'Stay Healthy'; // Default value
  late FixedExtentScrollController _controller;
  final List<String> goals = [
    'Lose Weight',
    'Build Muscle',
    'Stay Healthy', // This matches our default
    'Gain Weight',
    'Improve Endurance',
    'Stay Fit',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controller to default goal position
    _controller = FixedExtentScrollController(
      initialItem: goals.indexOf(selectedGoal),
    );
    print("Initial goal: $selectedGoal");
  }

  @override
  void dispose() {
    _controller.dispose();
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

                    // Selected goal displayed at the top
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        selectedGoal,
                        key: ValueKey<String>(selectedGoal),
                        style: TextStyle(
                          color: PrimaryColor,
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.055),

                    // Wheel picker
                    SizedBox(
                      height: 330,
                      child: Stack(
                        children: [
                          // Center highlight indicator
                          Center(
                            child: Container(
                              height: 50,
                            ),
                          ),

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
                              print("Selected goal changed to: $selectedGoal");
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                final isSelected = selectedGoal == goals[index];
                                return Center(
                                  child: Text(
                                    goals[index],
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
                        print("Final selected goal: $selectedGoal");
                        userProvider.setGoal(selectedGoal);
                        print("Provider current goal: ${userProvider.goal}");
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
        ));
  }
}
