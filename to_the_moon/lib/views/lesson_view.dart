import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/views/menu_view.dart';
import 'package:to_the_moon/views/lesson_view.dart';


class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
    LessonViewModel lessonViewModel = context.watch<LessonViewModel>();
    final List<Text> Lessons = lessonViewModel.Lessons;
    return Scaffold(
       appBar: AppBar(
        //return button
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed:(){
           Navigator.push(context, MaterialPageRoute(builder: (context) => MenuView()));
        }),
        title: Text("Lessons"),
      ),
      body: ListView.builder(
        itemCount: Lessons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Lessons[index],
          );
        },
      ),
    );
  }
}