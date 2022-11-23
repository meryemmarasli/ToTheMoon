import 'package:to_the_moon/models/lesson.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';



class LessonViewModel extends ChangeNotifier{
 
  List<LessonModel> Lessons = [
      //what is stock market
      new LessonModel("Lesson 1!", "Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content Lesson1 Content", "What is the Stock Market?", false),
      // different investing platforms
      new LessonModel("Lesson 2!", "Lesson 2 content", "Different Investing Platforms", false),
      //Trends to look  out for
      new LessonModel("Lesson 3!", "Lesson 3 content", "Trends to Look Out For" ,false),
      //Sell High, Buy Low
      new LessonModel("Lesson 4!", "Lesson 4 content", "Sell High, Buy Low", false), 
      //INvesting Tips
      new LessonModel("Lesson 5!", "Lesson 5 content","Investing Tips", false),
      //lesson 6
      new LessonModel("Lesson 6!", "Lesson 6 content","Lesson 6", false),
      new LessonModel("Lesson 7!", "Lesson 6 content","Lesson 6", false),
      new LessonModel("Lesson 8!", "Lesson 6 content","Lesson 6", false),
      new LessonModel("Lesson 9!", "Lesson 6 content","Lesson 6", false),
      new LessonModel("Lesson 10!", "Lesson 6 content","Lesson 6", false),






    ];

  List<LessonModel> getLessonsList() {
    return Lessons;
  }
}