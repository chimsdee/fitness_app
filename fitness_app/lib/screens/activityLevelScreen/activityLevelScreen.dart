// import 'package:fitness_app/models/DetailPageButton.dart.dart';
// import 'package:fitness_app/models/DetailPageTitle.dart';
// import 'package:fitness_app/models/ListWheelViewScroller.dart';
// import 'package:flutter/material.dart';

// class ActivityLevelScreen extends StatefulWidget {
//   const ActivityLevelScreen({super.key});

//   @override
//   State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
// }

// class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
//   @override
//   Widget build(BuildContext context) {
//     List<String> items = [
//       'Rookie',
//       'Beginner',
//       'Intermediate',
//       'Advanced',
//       'Expert',
//       'True Beast',
//     ];

// ignore_for_file: file_names, unnecessary_import, avoid_print

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
//               title: 'Your regular physical \nActivity Level?',
//               color: Colors.white,
//             ),
//             SizedBox(
//               height: size.height * 0.055,
//             ),
//             SizedBox(
//               height: size.height * 0.5,
//               child: listWheelScrollView(
//                 items: items,
//                 onSelectedItemChanged: (index) {},
//               ),
//             ),
//             DetailPageButton(
//               text: 'Next',
//               onTap: () {},
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
import 'package:fitness_app/Provider/user_provider.dart';

import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/models/DetailPageButton.dart.dart';
import 'package:fitness_app/models/DetailPageTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityLevelScreen extends StatefulWidget {
  const ActivityLevelScreen({super.key});

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  String selectedLevel = 'Beginner';
  late FixedExtentScrollController _controller;
  final List<String> activityLevels = [
    'Rookie',
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert',
    'True Beast',
  ];

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
      initialItem: activityLevels.indexOf(selectedLevel),
    );
    print("Initial activity level: $selectedLevel");
    print("Available levels: $activityLevels");
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
                      title: 'Your regular physical \nActivity Level?',
                      color: Colors.white,
                    ),

                    // Selected level display
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        selectedLevel,
                        key: ValueKey<String>(selectedLevel),
                        style: TextStyle(
                          color: PrimaryColor,
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.035),

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

                          // Wheel scroller
                          ListWheelScrollView.useDelegate(
                            controller: _controller,
                            itemExtent: 50,
                            magnification: 1.2,
                            useMagnifier: true,
                            overAndUnderCenterOpacity: 0.3,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedLevel = activityLevels[index];
                              });
                              print(
                                  "Selected activity level changed to: $selectedLevel");
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                return Center(
                                  child: Text(
                                    activityLevels[index],
                                    style: TextStyle(
                                      color: PrimaryColor,
                                      fontSize: 24,
                                      fontWeight:
                                          selectedLevel == activityLevels[index]
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                );
                              },
                              childCount: activityLevels.length,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    DetailPageButton(
                      text: 'Next',
                      onTap: () {
                        print("Final selected activity level: $selectedLevel");
                        userProvider.setActivityLevel(selectedLevel);
                        print(
                            "Provider current level: ${userProvider.activityLevel}");
                        Navigator.pushNamed(context, '/bottomNavigationBar');
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
