//navigation bar view

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/views/lesson_view.dart';
import 'package:to_the_moon/views/dashboard_view.dart';
import 'package:to_the_moon/views/market_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';

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
    UserViewModel userViewModel = context.watch<UserViewModel>();
    Future<UserModel> user = userViewModel.getUser();
    return FutureBuilder(
        future: Future.wait([user]),
        builder: (context,
            AsyncSnapshot<List> data,) {
          {
            if (data.hasError) {
              return Text("Error: ${data.error}");
            } else if (data.hasData) {
              UserModel userReg = data.data?[0] as UserModel;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 13, 38, 60),
                  leading: Icon(CupertinoIcons.rocket),
                  automaticallyImplyLeading: false,

                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Stock Name
                        Text("To The Moon"),
                        // Animated Cash Change
                        Text("\$ " +
                            userViewModel.getUserCash(userReg).toString()),
                      ]
                  ),
                ),


                body: Center(child: _widgetOptions[selectedIndex]),
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
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: "Dashboard"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.graph_square),
                        label: "Market"),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.news), label: "Lessons"),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        }
    );
  }
}
