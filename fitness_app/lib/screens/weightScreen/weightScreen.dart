// ignore_for_file: file_names, avoid_print

import 'package:fitness_app/Provider/user_provider.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/models/DetailPageButton.dart.dart';
import 'package:fitness_app/models/DetailPageTitle.dart';
import 'package:provider/provider.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  double weight = 60.0;
  @override
  Widget build(BuildContext context) {
    List<String> levels = [];
    for (int i = 25; i < 500; i++) {
      levels.add(i.isEven ? "|" : "I"); //levels.add('$i lbs');
    }

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
                      text: 'You can change this later in the settings',
                      title: 'What is your Weight?',
                      color: Colors.white,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                          '${weight.toStringAsFixed(1)} kg', //'$weight kg','
                          key: ValueKey<double>(weight),
                          style: TextStyle(
                            color: PrimaryColor,
                            fontSize: size.height * 0.04,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      height: size.height * 0.055,
                    ),
                    SizedBox(
                      height: size.height * 0.4,
                      child: RotatedBox(
                        quarterTurns:
                            1, // Rotate the ListWheelScrollView to make it horizontal
                        child: ListWheelScrollView(
                            itemExtent: size.height * 0.036,
                            magnification: 1.2,
                            useMagnifier: true,
                            overAndUnderCenterOpacity: 0.3,
                            physics: const FixedExtentScrollPhysics(),
                            controller: FixedExtentScrollController(
                                initialItem: (weight * 2).round() - 1),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                weight = (index + 1) / 2;
                                print("Scrolling - Current weight: $weight kg");
                              });
                            },
                            children: levels.map((level) {
                              return RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  level,
                                  style: TextStyle(
                                    color: PrimaryColor,
                                    fontSize: size.height * 0.08,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList()),
                      ),
                    ),
                    const Spacer(),
                    DetailPageButton(
                      text: 'Next',
                      onTap: () {
                        print("Final selected weight: $weight kg");
                        userProvider.setWeight(weight);
                        Navigator.pushNamed(context, '/height');
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

// ignore_for_file: file_names, avoid_print

// import 'package:fitness_app/Provider/user_provider.dart';
// import 'package:fitness_app/constants/color.dart';
// import 'package:fitness_app/models/DetailPageButton.dart.dart';
// import 'package:flutter/material.dart';
// import 'package:fitness_app/models/DetailPageTitle.dart';
// import 'package:provider/provider.dart';

// class WeightPage extends StatefulWidget {
//   const WeightPage({super.key});

//   @override
//   State<WeightPage> createState() => _WeightPageState();
// }

// class _WeightPageState extends State<WeightPage> {
//   double weight = 60.0;
//   @override
//   Widget build(BuildContext context) {
//     List<String> levels = [];
//     for (int i = 25; i < 500; i++) {
//       levels.add(i.isEven ? "|" : "I");
//     }

//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.black,
//         body: ChangeNotifierProvider<UserProvider>(
//           create: (context) => UserProvider(),
//           child: Consumer<UserProvider>(
//             builder: (context, userProvider, _) {
//               return Container(
//                 width: size.width,
//                 height: size.height,
//                 padding: EdgeInsets.only(
//                   top: size.height * 0.06,
//                   left: size.width * 0.05,
//                   right: size.width * 0.05,
//                   bottom: size.width * 0.03,
//                 ),
//                 child: Column(
//                   children: [
//                     const DetailPageTitle(
//                       text: 'You can change this later in the settings',
//                       title: 'What is your Weight?',
//                       color: Colors.white,
//                     ),
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 200),
//                       child: Text('${weight.toStringAsFixed(1)} kg',
//                           key: ValueKey<double>(weight),
//                           style: TextStyle(
//                             color: PrimaryColor,
//                             fontSize: size.height * 0.04,
//                             fontWeight: FontWeight.bold,
//                           )),
//                     ),
//                     SizedBox(
//                       height: size.height * 0.055,
//                     ),
//                     SizedBox(
//                       height: size.height * 0.4,
//                       child: RotatedBox(
//                         quarterTurns: 1,
//                         child: ListWheelScrollView(
//                             itemExtent: size.height * 0.036,
//                             magnification: 1.2,
//                             useMagnifier: true,
//                             overAndUnderCenterOpacity: 0.3,
//                             physics: const FixedExtentScrollPhysics(),
//                             controller: FixedExtentScrollController(
//                                 initialItem: (500 - (weight * 2).round()) -
//                                     1), // Changed this line
//                             onSelectedItemChanged: (index) {
//                               setState(() {
//                                 // Invert the calculation to reverse the direction
//                                 weight = (500 - (index + 1)) / 2;
//                                 print("Scrolling - Current weight: $weight kg");
//                               });
//                             },
//                             children: levels.map((level) {
//                               return RotatedBox(
//                                 quarterTurns: 1,
//                                 child: Text(
//                                   level,
//                                   style: TextStyle(
//                                     color: PrimaryColor,
//                                     fontSize: size.height * 0.08,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               );
//                             }).toList()),
//                       ),
//                     ),
//                     const Spacer(),
//                     DetailPageButton(
//                       text: 'Next',
//                       onTap: () {
//                         print("Final selected weight: $weight kg");
//                         userProvider.setWeight(weight);
//                         Navigator.pushNamed(context, '/height');
//                       },
//                       showbackButton: true,
//                       onBackTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ));
//   }
// }
