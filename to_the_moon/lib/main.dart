import 'package:flutter/material.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/models/news.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/viewmodels/news_view_model.dart';
import 'package:to_the_moon/views/navigationBar.dart';
import 'package:to_the_moon/views/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';
import 'package:to_the_moon/views/navigationBar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

NewsModel news = new NewsModel();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NewsViewModel(news)),
          ChangeNotifierProvider(create: (_) => LessonViewModel()),
          ChangeNotifierProvider(create: (_) => StockViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              //primarySwatch: Colors.blue,

              ),
          home: startPage(),
        ));
  }

  startPage() {
    bool accepted = false;
    if (accepted)
      return const BottomBar();
    else
      return const WelcomeView();
  }
}
