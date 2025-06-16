// ignore_for_file: duplicate_import, file_names, unnecessary_import

import 'package:fitness_app/constants/color.dart';
import 'package:fitness_app/screens/ProfilePage/profilePage.dart';
import 'package:fitness_app/screens/ProfilePage/profilePage.dart';
import 'package:fitness_app/screens/homeScreen/Notifications.dart';
import 'package:fitness_app/screens/homeScreen/homeScreen.dart';
import 'package:fitness_app/screens/homeScreen/workoutProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomepageNavbar extends StatefulWidget {
  const HomepageNavbar({super.key});

  @override
  State<HomepageNavbar> createState() => _HomepageNavbarState();
}

class _HomepageNavbarState extends State<HomepageNavbar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const workoutProgress(),
    const NotificationPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.poll), label: 'Progress'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_outlined),
                label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: PrimaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
