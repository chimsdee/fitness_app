// ignore_for_file: unused_field, file_names, camel_case_types

import 'package:calendar_slider/calendar_slider.dart';
import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

class WorkoutProgress extends StatefulWidget {
  const WorkoutProgress({super.key});

  @override
  State<WorkoutProgress> createState() => _WorkoutProgressState();
}

class _WorkoutProgressState extends State<WorkoutProgress> {
  final _firstController = CalendarSliderController();
  late DateTime _selectedDateAppBBar;

  // Track which item is selected (0: steps, 1: time, 2: heart)
  int _selectedWorkout = 1; // Default to Time Spent

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CalendarSlider(
        controller: _firstController,
        selectedDayPosition: SelectedDayPosition.center,
        fullCalendarScroll: FullCalendarScroll.vertical,
        backgroundColor: Colors.grey[900],
        fullCalendarWeekDay: WeekDay.short,
        selectedTileBackgroundColor: PrimaryColor,
        monthYearButtonBackgroundColor: Colors.grey[700],
        monthYearTextColor: Colors.white,
        tileBackgroundColor: Colors.grey[700],
        selectedDateColor: Colors.black,
        dateColor: Colors.white,
        tileShadow: BoxShadow(
          color: Colors.black.withOpacity(1),
        ),
        locale: 'en',
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 100)),
        lastDate: DateTime.now().add(const Duration(days: 100)),
        onDateSelected: (date) {
          setState(() {
            _selectedDateAppBBar = date;
          });
        },
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              CircularIndicatorText(
                text: '652 Cal',
                subText: 'Active Calories',
                color: PrimaryColor,
                strokeWidth: 10,
                size: size.width * 0.45,
                value: 0.65,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Steps circle
                  Opacity(
                    opacity: _selectedWorkout == 0 ? 1.0 : 0.5,
                    child: CircularIndicatorText(
                      text: '6540',
                      subText: 'Steps',
                      color: Colors.red,
                      strokeWidth: 7,
                      size: size.width * 0.26,
                      value: 0.8,
                    ),
                  ),
                  // Time circle
                  Opacity(
                    opacity: _selectedWorkout == 1 ? 1.0 : 0.5,
                    child: CircularIndicatorText(
                      text: '45min',
                      subText: 'Time',
                      color: Colors.blue,
                      strokeWidth: 7,
                      size: size.width * 0.26,
                      value: 0.45,
                    ),
                  ),
                  // Heart circle
                  Opacity(
                    opacity: _selectedWorkout == 2 ? 1.0 : 0.5,
                    child: CircularIndicatorText(
                      text: '72bpm',
                      subText: 'Heart',
                      color: Colors.orange,
                      strokeWidth: 7,
                      size: size.width * 0.26,
                      value: 0.62,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Workout Progress',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              // Steps Counted
              Opacity(
                opacity: _selectedWorkout == 0 ? 1.0 : 0.5,
                child: TextCheckboxContainer(
                  text: 'Steps Counted',
                  subtext: '10:00am - 11:00am',
                  value: _selectedWorkout == 0,
                  onChanged: (value) {
                    if (value == true) {
                      setState(() {
                        _selectedWorkout = 0;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              // Time Spent
              Opacity(
                opacity: _selectedWorkout == 1 ? 1.0 : 0.5,
                child: TextCheckboxContainer(
                  text: 'Time Spent',
                  subtext: '10:00am - 11:00am',
                  value: _selectedWorkout == 1,
                  onChanged: (value) {
                    if (value == true) {
                      setState(() {
                        _selectedWorkout = 1;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              // Heart Rate
              Opacity(
                opacity: _selectedWorkout == 2 ? 1.0 : 0.5,
                child: TextCheckboxContainer(
                  text: 'Heart Rate',
                  subtext: '10:00am - 11:00am',
                  value: _selectedWorkout == 2,
                  onChanged: (value) {
                    if (value == true) {
                      setState(() {
                        _selectedWorkout = 2;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextCheckboxContainer extends StatelessWidget {
  const TextCheckboxContainer({
    super.key,
    required this.text,
    required this.subtext,
    required this.value,
    required this.onChanged,
  });

  final String text;
  final String subtext;
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.085,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtext,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  )
                ]),
          ),
          Center(
            child: Checkbox(
              onChanged: onChanged,
              value: value,
              activeColor: PrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}

class CircularIndicatorText extends StatelessWidget {
  const CircularIndicatorText({
    super.key,
    required this.text,
    required this.subText,
    required this.color,
    required this.strokeWidth,
    this.size,
    required this.value,
  });
  final String text;
  final double? size;
  final String subText;
  final Color color;
  final double strokeWidth;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              strokeWidth: strokeWidth,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              Text(
                subText,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
