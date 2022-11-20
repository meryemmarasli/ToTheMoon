import 'package:flutter/material.dart';
class LessonModel {

  LessonModel(this.title, this.content);
 
  String title;
  String content;

  String getTitle(){
    return title;
  }

  String getContent(){
    return content;
  }

  void setTitle(String title){
    this.title = title;
  }

  void setContent(){
    this.content = content;
  }


 
}