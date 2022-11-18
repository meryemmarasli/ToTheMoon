import 'package:to_the_moon/models/news.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/viewmodels/user_view_model.dart';
import 'package:to_the_moon/views/menu_view.dart';
import 'package:provider/provider.dart';



class LessonViewModel extends ChangeNotifier{

  final LessonModel _lessons;

  NewsViewModel(this._lessons);

  List<Text> get Lessons {
    return this._lessons.Lessons;
  }
}