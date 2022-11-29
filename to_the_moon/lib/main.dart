import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/models/user.dart';
import 'package:to_the_moon/models/news.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/viewmodels/news_view_model.dart';
import 'package:to_the_moon/viewmodels/user_view_model.dart';
import 'package:to_the_moon/views/navigationBar.dart';
import 'package:to_the_moon/views/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';



void main() {
  runApp(const MyApp()
   
    );
}

User user = new User(acceptAgreement: false, userId: -1);
NewsModel news = new NewsModel();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel(user)),
          ChangeNotifierProvider(create: (_) => NewsViewModel(news)),
          ChangeNotifierProvider(create: (_) => LessonViewModel()),
          ChangeNotifierProvider(create: (_) => StockViewModel()),
        ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: startPage(),
      )
    );
  }

  startPage(){
    if(user.userId == -1){
      user.userId = 1;
    }

    if(user.acceptAgreement == true)
        return const BottomBar();
    else
      return const WelcomeView();
  }

}

