import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/models/user.dart';
import 'package:to_the_moon/models/news.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/viewmodels/news_view_model.dart';
import 'package:to_the_moon/viewmodels/user_view_model.dart';
<<<<<<< HEAD
import 'package:to_the_moon/views/navigationBar.dart';
=======
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/views/menu_view.dart';
>>>>>>> 012acfeaa880efacc4310f2a01d4ac2e4718556f
import 'package:to_the_moon/views/welcome_view.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider<LessonViewModel>(
    child: const MyApp(),
    create: (_) => LessonViewModel()
    )
  );
}

User user = new User(acceptAgreement: false, userId: -1);
NewsModel news = new NewsModel();
LessonModel lessons = new LessonModel();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel(user)),
          ChangeNotifierProvider(create: (_) => NewsViewModel(news)),
          ChangeNotifierProvider(create: (_) => LessonViewModel(lessons)),
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

