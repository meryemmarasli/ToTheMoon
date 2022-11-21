import 'package:flutter/material.dart';
class LessonModel {

  LessonModel(this.title, this.content, this.description, this.complete);
 
  String title;
  String description;
  String content;
  bool complete;

  String getDescription(){
    return description;
  }
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

  void updateComplete(){
      complete = !complete;
  }

  bool getComplete(){
    return complete;
  }


 
}