import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final String _gender = '';
  final int _age = 0;
  final double _height = 0.0; //
  final double _weight = 0.0; //
  final String _activityLevel = ''; //
  final String _goal = ''; //

  String get gender => _gender;
  int get age => _age;
  double get height => _height;
  double get weight => _weight;
  String get activityLevel => _activityLevel;
  String get goal => _goal;

  void setGender(String gender) {
    gender = gender;
  }

  void setAge(int age) {
    age = age;
  }

  void setHeight(double height) {
    height = height;
  }

  void setWeight(double weight) {
    weight = weight;
  }

  void setActivityLevel(String activityLevel) {
    activityLevel = activityLevel;
  }

  void setGoal(String goal) {
    goal = goal;
  }
}

// import 'package:flutter/material.dart';

// class UserProvider with ChangeNotifier {
//   String _gender = '';
//   int _age = 0;
//   double _height = 0.0;
//   double _weight = 0.0;
//   String _activityLevel = '';
//   String _goal = '';

//   String get gender => _gender;
//   int get age => _age;
//   double get height => _height;
//   double get weight => _weight;
//   String get activityLevel => _activityLevel;
//   String get goal => _goal;

//   void setGender(String gender) {
//     _gender = gender;
//     notifyListeners();
//   }

//   void setAge(int age) {
//     _age = age;
//     notifyListeners();
//   }

//   void setHeight(double height) {
//     _height = height;
//     notifyListeners();
//   }

//   void setWeight(double weight) {
//     _weight = weight;
//     notifyListeners();
//   }

//   void setActivityLevel(String activityLevel) {
//     _activityLevel = activityLevel;
//     notifyListeners();
//   }

//   void setGoal(String goal) {
//     _goal = goal;
//     notifyListeners();
//   }
// }
