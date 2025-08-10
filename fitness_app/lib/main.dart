import 'package:fitness_app/screens/Calculators/MultiCalculatorFlowPage.dart';
import 'package:flutter/material.dart';
import 'package:fitness_app/screens/Workouts/warmups.dart';
import 'package:fitness_app/screens/workoutCategories.dart';
import 'package:fitness_app/screens/Workouts/advanced.dart';
import 'package:fitness_app/screens/Workouts/beginner.dart';
import 'package:fitness_app/screens/ageScreen/ageScreen.dart';
import 'package:fitness_app/screens/calculatorCategories.dart';
import 'package:fitness_app/screens/Calculators/tdee_calc.dart';
import 'package:fitness_app/screens/ProfilePage/Languages.dart';
import 'package:fitness_app/screens/ProfilePage/contactUs.dart';
import 'package:fitness_app/screens/homeScreen/homeScreen.dart';
import 'package:fitness_app/screens/Workouts/intermediate.dart';
import 'package:fitness_app/screens/goalScreen/goalScreen.dart';
import 'package:fitness_app/screens/ProfilePage/profilePage.dart';
import 'package:fitness_app/screens/homeScreen/Notifications.dart';
import 'package:fitness_app/screens/Calculators/bodyfat_calc.dart';
import 'package:fitness_app/screens/genderScreen/genderScreen.dart';
import 'package:fitness_app/screens/Calculators/bmrCalculator.dart';
import 'package:fitness_app/screens/Calculators/bmiCalculator.dart';
import 'package:fitness_app/screens/heightScreen/heightScreen.dart';
import 'package:fitness_app/screens/weightScreen/weightScreen.dart';
import 'package:fitness_app/screens/ProfilePage/UnitsOfMeasure.dart';
import 'package:fitness_app/screens/Calculators/hydration_calc.dart';
import 'package:fitness_app/screens/Login%20SignUp/LoginSignUp.dart';
import 'package:fitness_app/screens/Calculators/idealweight_calc.dart';
import 'package:fitness_app/screens/homeScreen/bottomNavigationBar.dart';
import 'package:fitness_app/screens/OnBoardingScreen/onBoardingScreen.dart';
import 'package:fitness_app/screens/ProfilePage/settings_Notifications.dart';
import 'package:fitness_app/screens/activityLevelScreen/activityLevelScreen.dart';
import 'package:fitness_app/screens/ProfilePage/PrivacyPolicy.dart'
    as privacy_policy;
import 'package:fitness_app/screens/ProfilePage/editProfile.dart'
    as edit_profile;
import 'package:fitness_app/screens/ProfilePage/SettingsPage.dart'
    as settings_page;
import 'package:fitness_app/screens/ProfilePage/ProUpgradePage.dart'
    as pro_upgrade_page;
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
        '/age': (context) => const AgePage(),
        '/login': (context) => const SignUp(),
        '/home': (context) => const HomePage(),
        '/goal': (context) => const GoalScreen(),
        '/height': (context) => const HeightPage(),
        '/weight': (context) => const WeightPage(),
        '/gender': (context) => const GenderPage(),
        '/profile': (context) => const ProfilePage(),
        '/warmups': (context) => const WarmUpsPage(),
        '/advance': (context) => const AdvancedPage(),
        '/beginner': (context) => const BeginnerPage(),
        '/contactUs': (context) => const ContactUsPage(),
        '/languages': (context) => const LanguageSettings(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/activity': (context) => const ActivityLevelScreen(),
        '/unitsOfMeasure': (context) => const UnitsOfMeasure(),
        '/workoutCategories': (context) => workoutCategories(),
        '/verification': (context) => const VerificationPage(),
        '/forgotPassword': (context) => const ForgotPassword(),
        '/intermediate': (context) => const IntermediatePage(),
        '/notifications': (context) => const NotificationPage(),
        '/bmiCalculator': (context) => const BMICalculatorPage(),
        '/bmrCalculator': (context) => const BMRCalculatorPage(),
        '/edit': (context) => const edit_profile.EditProfilePage(),
        '/tdeeCalculator': (context) => const TDEECalculatorPage(),
        '/bottomNavigationBar': (context) => const HomepageNavbar(),
        '/settings': (context) => const settings_page.SettingsPage(),
        '/calculatorCategories': (context) => calculatorCategories(),
        '/bodyfatCalculator': (context) => const BodyFatCalculatorPage(),
        '/proUpgrade': (context) => const pro_upgrade_page.ProUpgradePage(),
        '/hydrationCalculator': (context) => const HydrationCalculatorPage(),
        '/settings_Notifications': (context) => const Settings_Notifications(),
        '/privacyPolicy': (context) => const privacy_policy.PrivacyPolicyPage(),
        '/idealWeightCalculator': (context) =>
            const IdealWeightCalculatorPage(),
        '/multiCalculatorFlow': (context) => const MultiCalculatorFlow(),
      },
      debugShowCheckedModeBanner: false,
      // home: const SignUp(),
      // home: const OnBoardingScreen(),
      home: const HomepageNavbar(),
      // home: const MultiCalculatorFlow(),
      //home: const NotificationPage(),
      // home: const workoutCategoriesPage(),
    );
  }
}
