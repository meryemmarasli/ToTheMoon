import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/views/individual_lesson_view.dart';

import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';
import 'package:to_the_moon/models/User.dart';

class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<LessonModel>> Lessons =
        context.watch<LessonViewModel>().getLessons();
    Future<UserModel> User =
        context.watch<UserViewModel>().getUser() as Future<UserModel>;

    List Leading = [
      'assets/images/moon.png', //1
      'assets/images/jupitor.png', //2
      'assets/images/mars.png', //3
      'assets/images/uranus.png', //4
      'assets/images/mercury.png', //5
      'assets/images/neptune.png', //6
      'assets/images/pluto.png', //7
      'assets/images/saturn.png', //8
      'assets/images/venus.png', //9
      'assets/images/earth.png', //10
    ];

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(205, 232, 237, 243),
            ),
            child: FutureBuilder(
                // to get User and Lessons
                future: Future.wait<Object>([Lessons, User]),
                builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    var lessons = snapshot.data?[0] as List<LessonModel>;
                    var user = snapshot.data?[1] as UserModel;
                    return ListView.builder(
                        itemCount: lessons.length,
                        itemBuilder: (context, index) {
                          return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                //change this maybe
                                leading: CircleAvatar(
                                  child: Image.asset(Leading[index]),
                                  backgroundColor: Colors.white,
                                ),
                                title: Text(
                                    lessons[index].getTitle().toString(),
                                    style: TextStyle(fontSize: 18)),
                                subtitle: Text(
                                    lessons[index].getDescription().toString()),
                                trailing: getTrailing(lessons[index]),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          IndividualLessonView(
                                              lesson: lessons[index],
                                              user: user),
                                    ),
                                  );
                                },
                              ));
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }

  Icon getTrailing(LessonModel lesson) {
    if (lesson.getComplete() == true) {
      return Icon(CupertinoIcons.star_fill, color: Colors.yellow);
    } else {
      return Icon(CupertinoIcons.star);
    }
  }
}
