import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/views/lesson_view.dart';
import 'package:to_the_moon/views/market_view.dart';
import 'package:to_the_moon/views/news_view.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Dashboard"),
        automaticallyImplyLeading: false,

      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width:200,
              child:ElevatedButton(
                child: Text('Market', style:TextStyle(color: Colors.white,)), 
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MarketView()));
              }
              )
            ),
            SizedBox(
              height: 50, // <-- SEE HERE
            ),

            SizedBox(
              height: 50,
              width:200,
              child:ElevatedButton(
                child: Text('Lessons', style:TextStyle(color: Colors.white,)), 
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LessonView()));
              }
              )
            ),
            SizedBox(
              height: 50, // <-- SEE HERE
            ),
            SizedBox(
              height: 50,
              width:200,
              child:ElevatedButton(
                child: Text('News', style:TextStyle(color: Colors.white,)), 
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsView()));
              }
              )
            ),
            SizedBox(
             height: 50, // <-- SEE HERE
           ),
        ],),
      ),
  );
 }
}