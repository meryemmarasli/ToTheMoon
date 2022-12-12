//navigation bar view

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/views/lesson_view.dart';
import 'package:to_the_moon/views/dashboard_view.dart';
import 'package:to_the_moon/views/market_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    DashboardView(),
    MarketView(),
    LessonView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 38, 60),
        leading: Icon(CupertinoIcons.rocket_fill, size: 36),
        title: Text("To The Moon", style: TextStyle(fontSize: 26)),
        automaticallyImplyLeading: false,
      ),
      body: Center(child: _widgetOptions[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        elevation: 1,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        showUnselectedLabels: true,
        backgroundColor: Color.fromARGB(255, 226, 226, 226),
        selectedItemColor: Color.fromARGB(255, 0, 50, 91),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 110, 125, 146),
        iconSize: 36,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.graph_square),
            activeIcon: Icon(CupertinoIcons.graph_square_fill),
            label: "Market",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            activeIcon: Icon(CupertinoIcons.book_fill),
            label: "Lessons",
          ),
        ],
      ),
    );
  }
}
