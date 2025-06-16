// ignore_for_file: file_names, avoid_print

import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          top: size.height * 0.06,
          left: size.width * 0.05,
          right: size.width * 0.05,
          bottom: size.height * 0.03,
        ),
        child: Column(
          children: [
            Text(
              'Forgot Password?'.toUpperCase(),
              style: TextStyle(
                fontSize: size.width * 0.07,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Enter your email address below or\n login with your another account',
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: size.width * 0.04,
                  ),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: size.width * 0.9,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  print("Try Another Way button pressed");
                },
                child: Text(
                  'Try Another Way',
                  style: TextStyle(
                    color: PrimaryColor,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  print(
                      "Send button pressed with email: ${_emailController.text}");
                  if (_emailController.text.isEmpty) {
                    print("Email field is empty");
                  } else if (!_emailController.text.contains('@')) {
                    print("Invalid email format");
                  } else {
                    print("Valid email submitted: ${_emailController.text}");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.3,
                    vertical: size.height * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.04,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
