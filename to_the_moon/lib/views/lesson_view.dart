import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';



import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/views/individual_lesson_view.dart';






class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
   Future<List<LessonModel>> Lessons = context.watch<LessonViewModel>().getLessons();
    return Scaffold(
      body:FutureBuilder(
        future: Lessons,
        builder:(context, data){
          if(data.hasError){
            return Text("Error: ${data.error}");
          }else if(data.hasData){
            var lessons = data.data as List<LessonModel>;
            return ListView.builder(
             itemCount: lessons.length,
             itemBuilder:(context, index) {
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(side: BorderSide(width: .25),borderRadius: BorderRadius.circular(20) ),
                child: ListTile(
                    //change this maybe
                    leading: CircleAvatar(child: Text((index+1).toString()), backgroundColor: Colors.grey,),
                    title:Text(lessons[index].getTitle().toString()),
                    subtitle:Text(lessons[index].getDescription().toString()),
                    trailing: getTrailing(lessons[index]),
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndividualLessonView(lesson: lessons[index]),
                        ),
                      );
                    },
                )
              );
            }
            );
          }else{
            return CircularProgressIndicator();
          }
        }
        )
    );
  }





  Icon getTrailing(LessonModel lesson){
    if(lesson.getComplete() == true){
          return Icon(CupertinoIcons.star_fill, color: Colors.yellow);
      }else{
        return Icon(CupertinoIcons.star);
      }
  }

  


}