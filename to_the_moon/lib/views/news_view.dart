//dashboard view

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/viewmodels/news_view_model.dart';
import 'package:to_the_moon/views/dashboard_view.dart';
import 'package:to_the_moon/views/menu_view.dart';
import 'package:to_the_moon/views/news_view.dart';

class NewsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    NewsViewModel newsViewModel = context.watch<NewsViewModel>();
    final List<Text> News = newsViewModel.Headlines;
    return Scaffold(
     
    );
  }
}