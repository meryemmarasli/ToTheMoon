import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/views/lesson_view.dart';
import 'package:to_the_moon/views/dashboard_view.dart';
import 'package:to_the_moon/views/news_view.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Menu Page"),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardView()));
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
                child: Text('Other', style:TextStyle(color: Colors.white,)),
                onPressed: () {

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