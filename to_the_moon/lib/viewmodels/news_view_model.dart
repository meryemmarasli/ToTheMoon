import 'package:to_the_moon/models/news.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class NewsViewModel extends ChangeNotifier{

  final NewsModel _news;

  NewsViewModel(this._news);

  List<Text> get Headlines {
    return this._news.Headlines;
  }
}