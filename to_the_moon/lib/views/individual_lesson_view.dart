import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';

class IndividualLessonView extends StatelessWidget {
  // In the constructor, require a lesson
  const IndividualLessonView({super.key, required this.lesson});

  // Declare a field that holds the lesson.
  final LessonModel lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(lesson.content),
      ),
    );
  }
}