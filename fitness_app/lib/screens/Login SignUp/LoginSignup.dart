// ignore_for_file: unnecessary_null_comparison, file_names, use_super_parameters, unused_import,  avoid_print

import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/screens/OnBoardingScreen/onBoardingScreen.dart';
import 'package:fitness_app/screens/homeScreen/bottomNavigationBar.dart';
import 'package:fitness_app/screens/homeScreen/homeScreen.dart';
import 'package:flutter/material.dart';
import '../../Provider/auth_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoginSelected = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PageController _pageController = PageController();
  bool _obscurePassword = true; // Added to track password visibility

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void loginUser() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      var token = AuthProvider.loginUser(
          _emailController.text, _passwordController.text);
      if (token != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomepageNavbar(),
          ),
        );
      }
    }
  }

  void signUpUser() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Implement your sign up logic here
      // Example: AuthProvider.signUpUser(_nameController.text, _emailController.text, _passwordController.text);

      // Navigate to homepage after signup
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomepageNavbar(),
        ),
      );
    }
  }

  void _handleGoogleSignIn() {
    // Placeholder for Google sign in functionality
    print('Continue with Google');
  }

  void _handleAppleSignIn() {
    // Placeholder for Apple sign in functionality
    print('Continue with Apple');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/onboardingImages/man 3.webp',
              height: size.height * 0.55,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),

          // Login/Signup Tabs
          Positioned(
            top: 45,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLoginSelected = true;
                      _pageController.jumpToPage(0);
                    });
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: isLoginSelected ? PrimaryColor : Colors.white,
                      fontSize: isLoginSelected ? 22 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLoginSelected = false;
                      _pageController.jumpToPage(1);
                    });
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: isLoginSelected ? Colors.white : PrimaryColor,
                      fontSize: isLoginSelected ? 20 : 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                isLoginSelected
                    ? const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                      )
                    : const SizedBox(),
              ],
            ),
          ),

          // Title Text
          Positioned(
            top: size.height * 0.40,
            child: SizedBox(
              height: size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  isLoginSelected
                      ? "Welcome back, \nUser".toUpperCase()
                      : "Hello rookie!".toUpperCase(),
                  style: TextStyle(
                    fontSize: size.width * 0.095,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),

          // Login/Signup Forms
          Positioned(
            top: size.height * 0.55,
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: size.height * 0.6,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Login Page
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[500],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade800,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[500],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade800,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forgotpassword');
                              },
                              child: const Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: PrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.001),
                        // "OR" divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade800,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade800,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        // Social login buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _handleGoogleSignIn,
                              icon: Image.asset(
                                'assets/images/google.png',
                                height: 24,
                              ),
                              label: const Text(
                                "Continue with Google",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _handleAppleSignIn,
                              icon: Image.asset(
                                'assets/images/apple.png',
                                height: 24,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Continue with Apple",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.grey.shade800),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: size.height * 0.06,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                color: PrimaryColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: loginUser,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Signup Page
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[500],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade800,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.001),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[500],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade800,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.001),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[500],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade800,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        // "OR" divider
                        Center(
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        // Social signup buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _handleGoogleSignIn,
                              icon: Image.asset(
                                'assets/images/google.png',
                                height: 24,
                              ),
                              label: const Text(
                                "Continue with Google",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: _handleAppleSignIn,
                              icon: Image.asset(
                                'assets/images/apple.png',
                                height: 24,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Continue with Apple",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(color: Colors.grey.shade800),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: size.height * 0.06,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                color: PrimaryColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: signUpUser,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
