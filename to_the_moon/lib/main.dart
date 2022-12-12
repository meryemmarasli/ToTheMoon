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

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NewsViewModel()),
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
          home:  WelcomeView(),
        ));
  }

  startPage(BuildContext context) async{
    UserViewModel userViewModel = context.watch<UserViewModel>();
    UserModel user = await userViewModel.getUser();
    if (user.acceptAgreement)
      return const BottomBar();
    else
      return  WelcomeView();
  }
}
