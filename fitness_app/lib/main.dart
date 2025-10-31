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
import 'package:fitness_app/screens/Workouts/core.dart';
import 'package:fitness_app/screens/Workouts/hiit.dart';
import 'package:fitness_app/screens/Workouts/yoga.dart';
// ignore: unused_import
import 'package:fitness_app/screens/Login%20SignUp/forgotPassword.dart';
// ignore: unused_import
import 'package:fitness_app/screens/Login%20SignUp/verificationPage.dart';

// void main() {
//   runApp(const ErrorBoundary(child: MyApp()));
// }

class ErrorBoundary extends StatelessWidget {
  final Widget child;

  const ErrorBoundary({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my fitness tracking app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 1, 232, 224),
          background: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 1, 232, 224)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ),
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
        '/coreWorkout': (context) => const CorePowerPage(),
        '/hiitWorkout': (context) => const HighIntensityPage(),
        '/yogaWorkout': (context) => const YogaPage(),
      },
      debugShowCheckedModeBanner: false,

      // Home screen configuration - choose one:

      // For first-time users - onboarding flow:
      home: const OnBoardingScreen(),

      // For user registration flow:
      // home: const SignUp(),

      // For direct access to main app (development):
      // home: const HomepageNavbar(),
      // For testing specific features:
      // home: const MultiCalculatorFlow(),
      // home: const NotificationPage(),
      // home: const workoutCategories(),
      // home: const ProfilePage(),
    );
  }
}

// Global error handler for the entire app
class GlobalErrorHandler {
  static void setup() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 64,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Oops! Something went wrong',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'We encountered an unexpected error.',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please restart the app and try again.',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // In a real app, you might want to restart the app
                    // or navigate to a safe screen
                    Navigator.of(details.context as BuildContext)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomepageNavbar(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 232, 224),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Go to Home',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    };
  }
}

// Initialize error handling when the app starts
void initializeApp() {
  GlobalErrorHandler.setup();

  // Add any other app initialization logic here
  WidgetsFlutterBinding.ensureInitialized();
}

void main() {
  initializeApp();
  runApp(const ErrorBoundary(child: MyApp()));
}
