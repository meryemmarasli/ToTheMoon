import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';

class IndividualLessonView extends StatelessWidget {
  // In the constructor, require a lesson
  const IndividualLessonView({super.key, required this.lesson});

  // Declare a field that holds the Todo.
  final LessonModel lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(lesson.getTitle())),
      ),
      body: Column(
        children: [
            //setting up title
            Padding( padding: EdgeInsets.fromLTRB(10, 10.0, 20, 4.0)),
            Row(children: [
              Spacer(),
              Text(lesson.getDescription(), style: TextStyle(fontSize: 20),),
              Spacer(),
            ]),
            SizedBox(height: 10),
            Image.asset(''/*lesson.getImagePath()*/),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.all(10), child: Text(lesson.getContent())),
            SizedBox(height: 10),
            

        ]
       
      ),
    );
  }
}