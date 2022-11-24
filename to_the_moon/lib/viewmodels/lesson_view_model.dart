import 'package:to_the_moon/models/lesson.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;




Future<List<LessonModel>> readJsonData() async {
      final jsonData = await rootBundle.rootBundle.loadString("assets/lesson.json");
      Map<String,dynamic> map = json.decode(jsonData.toString());
      List<LessonModel> list = [];
      for(var v in map["lesson"]){
        list.add(LessonModel.fromJson(v));
      }
      
      return list;


  }

 Future<List<LessonModel>> initialLessons = readJsonData();



class LessonViewModel with ChangeNotifier{
    Future<List<LessonModel>> Lessons = initialLessons;

    Future<List<LessonModel>> get lessons => Lessons;


  void setLessonsList(){
     Lessons = readJsonData();
  }

 

  
}