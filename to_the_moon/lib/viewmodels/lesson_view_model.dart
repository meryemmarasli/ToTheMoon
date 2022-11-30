import 'package:to_the_moon/models/lesson.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:to_the_moon/databases/LessonDB.dart';

import 'package:flutter/services.dart' as rootBundle;


import 'package:flutter/material.dart';





class LessonViewModel with ChangeNotifier{
  Future<List<LessonModel>> Lessons = LessonDatabase.instance.lessons();

   Future<List<LessonModel>> getLessons(){
      return Lessons;
   } 


   


   updateLesson(LessonModel lesson){
    lesson.updateComplete();
    LessonDatabase.instance.updateLesson(lesson);
    notifyListeners();
   }



}

