//navigation bar view

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/views/lesson_view.dart';
import 'package:to_the_moon/views/news_view.dart';
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
    NewsView(),
    MarketView(),
    LessonView(),
  ];

  void _onItemTapped(int index){
    setState((){
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 38, 60),
        leading: Icon(CupertinoIcons.rocket),
        title: Text("To The Moon"),
        automaticallyImplyLeading: false,
        ),
      body: Center(
        child: _widgetOptions[selectedIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xFF526480),
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label:"Dashboard" ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.graph_square), label: "Market"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.news), label: "Lessons"),
        ],
      ) ,
    );
  }
}