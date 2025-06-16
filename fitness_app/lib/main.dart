import 'package:fitness_app/screens/warmups.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/screens/Login%20SignUp/LoginSignUp.dart';
import 'package:fitness_app/screens/ProfilePage/Languages.dart';
import 'package:fitness_app/screens/ProfilePage/PrivacyPolicy.dart';
import 'package:fitness_app/screens/ProfilePage/SettingsPage.dart';
import 'package:fitness_app/screens/ProfilePage/UnitsOfMeasure.dart';
import 'package:fitness_app/screens/ProfilePage/contactUs.dart';
import 'package:fitness_app/screens/ProfilePage/editPrifile.dart';
import 'package:fitness_app/screens/ProfilePage/profilePage.dart';
import 'package:fitness_app/screens/ProfilePage/settings_Notifications.dart';
import 'package:fitness_app/screens/advanced.dart';
import 'package:fitness_app/screens/beginner.dart';
import 'package:fitness_app/screens/homeScreen/Notifications.dart';
import 'package:fitness_app/screens/homeScreen/bottomNavigationBar.dart';
import 'package:fitness_app/screens/homeScreen/homeScreen.dart';
import 'package:fitness_app/screens/intermediate.dart';
import 'package:fitness_app/screens/workoutCategories.dart';
import 'package:fitness_app/screens/OnBoardingScreen/onBoardingScreen.dart';
import 'package:fitness_app/screens/genderScreen/genderScreen.dart';
import 'package:fitness_app/screens/ageScreen/ageScreen.dart';
import 'package:fitness_app/screens/heightScreen/heightScreen.dart';
import 'package:fitness_app/screens/weightScreen/weightScreen.dart';
import 'package:fitness_app/screens/goalScreen/goalScreen.dart';
import 'package:fitness_app/screens/activityLevelScreen/activityLevelScreen.dart';
// ignore: unused_import
import 'package:fitness_app/screens/Login%20SignUp/forgotPassword.dart';
// ignore: unused_import
import 'package:fitness_app/screens/Login%20SignUp/verificationPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      color: Colors.black,
      routes: {
        '/onboarding': (context) => const OnBoardingScreen(),
        '/gender': (context) => const GenderPage(),
        '/age': (context) => const AgePage(),
        '/height': (context) => const HeightPage(),
        '/weight': (context) => const WeightPage(),
        '/activity': (context) => const ActivityLevelScreen(),
        '/goal': (context) => const GoalScreen(),
        '/forgotPassword': (context) => const ForgotPassword(),
        '/login': (context) => const SignUp(),
        '/home': (context) => const HomePage(),
        '/notifications': (context) => const NotificationPage(),
        '/workoutCategories': (context) => workoutCategories(),
        '/verification': (context) => const VerificationPage(),
        '/bottomNavigationBar': (context) => const HomepageNavbar(),
        '/profile': (context) => const ProfilePage(),
        '/privacyPolicy': (context) => const PrivacyPolicyPage(),
        '/settings': (context) => const SettingsPage(),
        '/unitsOfMeasure': (context) => const UnitsOfMeasure(),
        '/settings_Notifications': (context) => const Settings_Notifications(),
        '/languages': (context) => const LanguageSettings(),
        '/contactUs': (context) => const ContactUsPage(),
        '/edit': (context) => const EditProfilePage(),
        '/beginner': (context) => const BeginnerPage(),
        '/intermediate': (context) => const IntermediatePage(),
        '/advance': (context) => const AdvancedPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const HomepageNavbar(),
      // home: const workoutCategoriesPage(),
      //home: const NotificationPage(),
      // home: const HomepageNavbar(),
    );
  }
}
