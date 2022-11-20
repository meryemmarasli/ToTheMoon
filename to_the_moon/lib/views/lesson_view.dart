import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/views/individual_lesson_view.dart';




class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
   //LessonViewModel lessonViewModel = context.watch<LessonViewModel>();
   LessonViewModel L = new LessonViewModel();
   List<LessonModel> Lessons = L.getLessonsList();
    return Scaffold(
       
      body: ListView.builder(
        itemCount: Lessons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Lessons[index].getTitle()),
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualLessonView(lesson: Lessons[index]),
              ),
            );
           },
          );
        },
      ),
    );
  }
}