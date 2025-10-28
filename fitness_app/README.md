# 💪 FitnessTrack Pro - Ultimate Fitness Companion

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.13+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-2.19+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%26%20iOS-black?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

*A comprehensive fitness tracking application built with Flutter that helps users achieve their fitness goals through personalized workouts, advanced calculators, and progress tracking.*

</div>

## 📱 App Preview

| Onboarding | Workouts | Calculators | Profile |
|------------|----------|-------------|---------|
| ![Onboarding](https://via.placeholder.com/200x400/0a0a0a/01e8e0?text=Onboarding) | ![Workouts](https://via.placeholder.com/200x400/0a0a0a/01e8e0?text=Workouts) | ![Calculators](https://via.placeholder.com/200x400/0a0a0a/01e8e0?text=Calculators) | ![Profile](https://via.placeholder.com/200x400/0a0a0a/01e8e0?text=Profile) |

## 🚀 Features

### 🏋️‍♂️ **Workout Programs**
- **6 Different Categories**: Beginner, Intermediate, Advanced, Yoga, HIIT, Core
- **Guided Exercises**: Step-by-step instructions with animated GIF demonstrations
- **Progress Tracking**: Real-time workout completion tracking
- **Warm-up Sessions**: Proper pre-workout routines
- **Timer-based Workouts**: Built-in exercise timers

### 📊 **Advanced Fitness Calculators**
- **BMI Calculator**: Body Mass Index analysis
- **BMR Calculator**: Basal Metabolic Rate calculation
- **TDEE Calculator**: Total Daily Energy Expenditure
- **Body Fat Calculator**: Body fat percentage estimation
- **Ideal Weight Calculator**: Multiple method calculations
- **Hydration Calculator**: Daily water intake recommendations
- **Multi-Calculator Flow**: Combined calculator results with email export

### 👤 **User Management**
- **Personalized Onboarding**: Age, gender, height, weight, goals, activity level
- **Progress Analytics**: Workout statistics and achievements
- **Profile Management**: Editable user profiles with fitness metrics
- **Goal Setting**: Personalized fitness objectives

### ⚙️ **Professional Features**
- **Multi-language Support**: Internationalization ready
- **Unit Systems**: Metric and Imperial units
- **Dark Theme**: Professional dark UI design
- **Pro Upgrade System**: Premium feature unlocking
- **Email Integration**: Results sharing capability

## 🛠 Technical Architecture

### **Tech Stack**
- **Framework**: Flutter 3.13+
- **Language**: Dart 2.19+
- **State Management**: Provider Pattern
- **Navigation**: Named Routes with Navigator 2.0
- **UI Components**: Custom widgets with Material Design 3


### **Key Packages Used**
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.5        # State management
  lottie: ^2.7.0          # Animations
  smooth_page_indicator: ^1.2.1
  percent_indicator: ^4.2.2
  calendar_slider: ^0.0.4 # Progress calendar
  url_launcher: ^6.1.12   # External links
  image_picker: ^1.0.4    # Profile images