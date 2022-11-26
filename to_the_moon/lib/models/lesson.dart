import 'package:flutter/material.dart';
class LessonModel {

<<<<<<< HEAD
  LessonModel(this.title, this.description, this.image, this.complete, this.content); 
 
  String? title;
  String? description;
  String? content;
  bool? complete;
  String? image;

   String? getImage(){
    return this.image;
  }

  String? getDescription(){
    return description;
  }
  String? getTitle(){
    return title;
  }

  String? getContent(){
    return content;
  }



  void updateComplete(){
      complete = true;
  } 

  bool? getComplete(){
    return complete;
  } 

  LessonModel.fromMap(Map<String, dynamic> json){
    title = json["title"];
    if(json["complete"] == 'true'){
      complete = true;
    }else{
      complete = false;
    }
    description = json["description"];
    image = json["image"]; 
    content = json["content"];

  
 
  }

 

    Map<String, dynamic> toMap() =>{
    'title': title,
    'description': description,
    'image': image, 
    'complete': complete,
    'content': content
    
   
  }; 

  




}
=======
  final List<Text> Lessons = [
    Text('Lesson 1!'),
    Text('Lesson 2'),
    Text('Lesson 3'),
    Text('Lesson 4'),
    ];

  /*
  final String lesson;
  final String content;


  LessonModel({required this.title, required this.headline});

  factory LessonModel.fromJson(Map<String, String> json) {
    return LessonModel(
        lesson: json["Lesson"],
        content: json["Content"]
    );
  }

   */
}
>>>>>>> 012acfeaa880efacc4310f2a01d4ac2e4718556f
