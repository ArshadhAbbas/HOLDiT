

import 'package:flutter/material.dart';

import '../home/home.dart';
import '../report/report.dart';
import '../settings/settings.dart';

class ThreeInOne extends StatefulWidget {
  const ThreeInOne({super.key,});

  @override
  State<ThreeInOne> createState() => _ThreeInOneState();
}

class _ThreeInOneState extends State<ThreeInOne> {
  int selectedIndex = 1;

  List<Widget> widgetOptions = [    ReportScreen(),    const HomeScreen(),    SettingsScreen(),  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: widgetOptions
              .asMap()
              .map(
                (index, page) => MapEntry(
                  index,
                  Offstage(
                    offstage: selectedIndex != index,
                    child: page,
                  ),
                ),
              )
              .values
              .toList(),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 211, 207, 207),
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline),
                activeIcon: Icon(Icons.pie_chart),
                label: "Report",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 119, 116, 116),
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }
}
