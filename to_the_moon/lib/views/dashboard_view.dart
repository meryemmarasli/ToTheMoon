import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/views/menu_view.dart';
import 'package:to_the_moon/views/market_view.dart';
import 'package:to_the_moon/views/news_view.dart';
import 'package:to_the_moon/views/lesson_view.dart';




class DashboardView extends StatelessWidget {
  const DashboardView({super.key});


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Row(
        children: [
          new ButtonBar(
          mainAxisSize: MainAxisSize.min, // this will take space as minimum as posible(to center)
          children: <Widget>[
            new ElevatedButton(
              child: Text('Menu', style:TextStyle(color: Colors.white,)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MenuView()));
              }
            ),
            new ElevatedButton(
                child: Text('Market', style:TextStyle(color: Colors.white,)),
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MarketView()));
              }
              ),
           new ElevatedButton(
            child: Text('News', style:TextStyle(color: Colors.white,)),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewsView()));
            },
           ),
            new ElevatedButton(
              child: Text('Lessons', style:TextStyle(color: Colors.white,)),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => LessonView()));
              },
            ),
          ],
        ),
      ]),
    );
  }
}