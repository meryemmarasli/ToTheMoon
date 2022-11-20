import 'package:to_the_moon/models/lesson.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';



class LessonViewModel extends ChangeNotifier{

 
  List<LessonModel> Lessons = [
      new LessonModel("Lesson 1!", "Lesson 1 content"),
      new LessonModel("Lesson 2!", "Lesson 2 content"),
      new LessonModel("Lesson 3!", "Lesson 2 content"),
      new LessonModel("Lesson 4!", "Lesson 2 content"),
      new LessonModel("Lesson 5!", "Lesson 2 content"),
    ];

  List<LessonModel> getLessonsList() {
    return Lessons;
  }
}