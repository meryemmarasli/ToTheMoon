import 'package:confetti/confetti.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';
import 'package:to_the_moon/models/User.dart';

class IndividualLessonView extends StatefulWidget {
  // In the constructor, require a lesson
  const IndividualLessonView(
      {super.key, required this.lesson, required this.user});

  final LessonModel lesson;
  final UserModel user;

  @override
  _IndividualLessonViewState createState() =>
      _IndividualLessonViewState(lesson, user);
}

class _IndividualLessonViewState extends State<IndividualLessonView> {
  // Declare a field that holds the Todo.
  final LessonModel lesson;
  final UserModel user;
  bool? rewarded = false;

  _IndividualLessonViewState(this.lesson, this.user);

  @override
  Widget build(BuildContext context) {
    final controller = ConfettiController(duration: const Duration(seconds: 3));
    LessonViewModel lessonViewModel = context.watch<LessonViewModel>();
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 13, 38, 60),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lesson.getTitle().toString(),
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 26)),
              // Animated Cash Change
              Stack(children: [
                ConfettiWidget(
                  confettiController: controller,
                  blastDirection: -pi / 2, // shoot downwards
                  shouldLoop: false,
                  numberOfParticles: 5,
                  createParticlePath: drawStar,
                  colors: [
                    Colors.yellow,
                    Colors.amber,
                    Colors.orange,
                    Colors.lightBlue
                  ],
                  gravity: 1,
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0.0, -0.5),
                              end: const Offset(0.0, 0.0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: Text.rich(
                    key: ValueKey<bool?>(rewarded),
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                            text: "\$ " +
                                userViewModel.getUserCash(user).toString(),
                            style: TextStyle(fontSize: 24)),
                      ],
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            //setting up title
            Padding(
              padding: EdgeInsets.fromLTRB(25, 20.0, 25, 4.0),
              child: Text(
                lesson.getDescription().toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Image.asset(lesson.getImage().toString(), height: 200, width: 200),
            SizedBox(height: 5),
            Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  lesson.getContent().toString(),
                  style: TextStyle(fontSize: 16, height: 1.5),
                )),
            SizedBox(height: 10),

            // TESTING to watch user available cash update
            //Text(user.getCash().toString()),
            SizedBox(height: 10),

            ElevatedButton(
                child: Text(lessonViewModel.lessonCompletionButtonText(lesson),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
                style: ElevatedButton.styleFrom(
                  // change button color when lesson learned status changes
                  shape: StadiumBorder(),
                  backgroundColor:
                      lesson.getComplete()! ? Colors.blueGrey : Colors.red,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                ),
                onPressed: () {
                  setState(() {
                    rewarded = true;
                  });
                  // only reward the cash if first time completing lesson
                  // also plays the confetti controller
                  userViewModel.rewardCash(user, lesson.getCash()!,
                      lesson.getComplete()!, controller);
                  userViewModel.notifyListeners();

                  //insert completed animation
                  lessonViewModel.updateLesson(lesson);
                  lessonViewModel.notifyListeners();
                  //play confetti
                  //controller.play();
                }),
            // ConfettiWidget(
            //   confettiController: controller,
            //   blastDirection: -pi/2, // shoot downwards
            //   shouldLoop: false,
            //   numberOfParticles: 100,
            //   createParticlePath: drawStar,
            //   colors: [
            //     Colors.yellow,
            //     Colors.amber,
            //     Colors.orange,
            //     Colors.lightBlue
            //   ],
            //   gravity: 1,
            // ),
            SizedBox(height: 50),
          ]),
        ));
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
