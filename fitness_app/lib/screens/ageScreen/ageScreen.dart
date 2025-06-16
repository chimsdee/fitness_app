// ignore_for_file: file_names, unnecessary_import, prefer_const_constructors

import 'package:fitness_app/Provider/user_provider.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/models/DetailPageButton.dart.dart';
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

  get items => null;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: age - 1);
    // ignore: avoid_print
    print("Initial age: $age");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                    SizedBox(
                      height: size.height * 0.055,
                    ),
                    SizedBox(
                      height: 330,
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
                            // ignore: avoid_print
                            print("Selected age: $age");
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            if (index < 0 || index >= ageValues.length) {
                              return null;
                            }
                            final isSelected = age == ageValues[index];
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
                    const Spacer(),
                    DetailPageButton(
                      text: 'Next',
                      onTap: () {
                        // ignore: avoid_print
                        print("Saving age: $age");
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
        ));
  }
}
