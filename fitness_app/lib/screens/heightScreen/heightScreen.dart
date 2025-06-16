// import 'package:fitness_app/models/DetailPageButton.dart.dart';
// import 'package:fitness_app/models/DetailPageTitle.dart';
// import 'package:fitness_app/models/ListWheelViewScroller.dart';
// import 'package:flutter/material.dart';

// class HeightPage extends StatefulWidget {
//   const HeightPage({super.key});

//   @override
//   State<HeightPage> createState() => _HeightPageState();
// }

// ignore_for_file: file_names, unnecessary_import, avoid_print

// class _HeightPageState extends State<HeightPage> {
//   int height = 170; // Default height in cm
//   @override
//   Widget build(BuildContext context) {
//     List<String> items = [];
//     for (int i = 1; i <= 200; i++) {
//       items.add('$i cm');
//     }
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
//             DetailPageTitle(
//               text: 'This will help us create a personalized plan for you',
//               title: 'What is your Height?',
//               color: Colors.white,
//             ),
//             SizedBox(
//               height: size.height * 0.055,
//             ),
//             SizedBox(
//               height: size.height * 0.5,
//               child: listWheelScrollView(
//                 items: items,
//               ),
//             ),
//             DetailPageButton(
//               text: 'Next',
//               onTap: () {
//                 Navigator.pushNamed(context, '/goal');
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
import 'package:fitness_app/Provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/DetailPageButton.dart.dart';
import 'package:fitness_app/models/DetailPageTitle.dart';
import 'package:fitness_app/constants/color.dart'; // assuming you have PrimaryColor here
import 'package:provider/provider.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int height = 170;
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: height - 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<int> heightValues =
        List.generate(200, (index) => index + 1); // 1 to 200 cm

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
                      title: 'What is your Height?',
                      color: Colors.white,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        '${(height * 0.393701).round() ~/ 12}ft ${(height * 0.393701).round() % 12}in',
                        key: ValueKey<int>(height),
                        style: TextStyle(
                          color: PrimaryColor,
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.055),
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
                          // Wheel scroller with opacity effects
                          ListWheelScrollView.useDelegate(
                            controller: _controller,
                            itemExtent: 50,
                            magnification: 1.2,
                            useMagnifier: true,
                            overAndUnderCenterOpacity: 0.3,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                height = heightValues[index];
                              });
                              print("Current height: $height cm");
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder: (context, index) {
                                if (index < 0 || index >= heightValues.length) {
                                  return null;
                                }

                                final isSelected =
                                    height == heightValues[index];
                                (_controller.selectedItem - index).abs();

                                return Center(
                                  child: Text(
                                    '${heightValues[index]} cm',
                                    key: ValueKey<int>(heightValues[index]),
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
                              childCount: heightValues.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    DetailPageButton(
                      text: 'Next',
                      onTap: () {
                        print("Final selected height: $height cm");
                        Navigator.pushNamed(context, '/goal');
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
