// ignore_for_file: file_names, avoid_print

import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/models/DetailPageButton.dart';
import 'package:fitness_app/models/DetailPageTitle.dart';
import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  bool isMale = true;
  bool isFemale = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(
          top: size.height * 0.07,
          left: size.width * 0.05,
          right: size.width * 0.05,
          bottom: size.width * 0.03,
        ),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const DetailPageTitle(
              title: 'Tell us about yourself',
              text: 'This will help us find the best\ncontent for you',
              color: Colors.white,
            ),
            SizedBox(
              height: size.height * 0.055,
            ),
            GenderIcon(
              icon: Icons.male,
              title: 'Male',
              onTap: () {
                setState(() {
                  isMale = true;
                  isFemale = false;
                });
                print('Selected Gender: Male');
              },
              isSelected: isMale,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            GenderIcon(
              icon: Icons.female,
              title: 'Female',
              onTap: () {
                setState(() {
                  isMale = false;
                  isFemale = true;
                });

                print('Selected Gender: Female');
              },
              isSelected: isFemale,
            ),
            const Spacer(),
            DetailPageButton(
              text: 'Next',
              onTap: () {
                print(
                    'Proceeding with selection: ${isMale ? 'Male' : 'Female'}');
                Navigator.pushNamed(context, '/age');
              },
              showbackButton: false,
            ),
          ],
        ),
      ),
    );
  }
}

class GenderIcon extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const GenderIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  State<GenderIcon> createState() => _GenderIconState();
}

class _GenderIconState extends State<GenderIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(size.width * 0.05),
          decoration: BoxDecoration(
            color: widget.isSelected ? PrimaryColor : Colors.transparent,
            shape: BoxShape.circle,
            boxShadow: (widget.isSelected || _isHovering)
                ? [
                    BoxShadow(
                      color: PrimaryColor.withOpacity(0.5),
                      spreadRadius: _isHovering ? 10 : 5,
                      blurRadius: _isHovering ? 20 : 10,
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  widget.icon,
                  size: size.width * 0.1,
                  color: widget.isSelected ? Colors.black : Colors.white,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.isSelected ? Colors.black : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
