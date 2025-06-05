import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

class DetailPageButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool showbackButton;
  final VoidCallback? onBackTap;

  const DetailPageButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.showbackButton = false,
      this.onBackTap});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        if (showbackButton)
          GestureDetector(
            onTap: onBackTap,
            child: Container(
              margin: EdgeInsets.only(
                top: size.height * 0.02,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02,
              ),
              height: size.height * 0.07,
              child: Center(
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: PrimaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.only(
              top: size.height * 0.02,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
            ),
            height: size.height * 0.07,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
