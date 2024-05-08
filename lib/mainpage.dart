import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'home.dart';
import 'notification.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

List<Widget> _pages = [
  Home(),
  DashBoard(),
  NotificationPage()
];

int selectedIndex = 0;

// void selectPage(int index){
//   selectedIndex = index;
// }


class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "DashBoard"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: "Notification"),
        ],
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        }
      ),
    );
  }
}
