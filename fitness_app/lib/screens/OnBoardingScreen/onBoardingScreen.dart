// ignore_for_file: avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index) {
              // ignore: duplicate_ignore
              // ignore: avoid_print
              print("Page changed to index: $index");
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              _buildPageIndicator(
                text: 'Meet Your Coach \n Start Your Journey',
                imageAsset: 'assets/onBoardingImages/man 1.webp',
              ),
              _buildPageIndicator(
                text: 'Create A workout plan\nto stay fit',
                imageAsset: 'assets/onBoardingImages/woman 1.webp',
              ),
              _buildPageIndicator(
                text: 'action is the \n key to all success',
                imageAsset: 'assets/onBoardingImages/man 2.webp',
              ),
            ],
          ),
          isLastPage
              ? const SizedBox.shrink()
              : Positioned(
                  top: size.height * 0.05,
                  right: size.height * 0.05,
                  child: TextButton(
                    onPressed: () {
                      print("Skip button pressed");
                      controller.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          isLastPage
              ? Positioned(
                  left: size.width * 0.25,
                  right: size.width * 0.25,
                  bottom: size.height * 0.09,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(10, 186, 181, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            print("Get Started button pressed");
                            Navigator.pushNamed(
                              context,
                              '/gender',
                            );
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Positioned(
            bottom: size.height * 0.03,
            left: size.height * 0.21,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Colors.grey,
                activeDotColor: Color.fromRGBO(10, 186, 181, 1),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageIndicator(
      {required String text, required String imageAsset}) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          imageAsset,
          height: size.height * 0.6,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            height: size.height * 0.4,
            width: size.width,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}
