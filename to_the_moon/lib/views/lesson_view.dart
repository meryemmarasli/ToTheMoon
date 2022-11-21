import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/views/individual_lesson_view.dart';




class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
//LessonViewModel lessonViewModel = context.watch<LessonViewModel>();
   LessonViewModel L = new LessonViewModel();
   List<LessonModel> Lessons = L.getLessonsList();
    return Scaffold(
     body: Column(
      children : [
      //edit this to make it better looking
      Row(children: [
        Text( " you have completed", style: TextStyle(fontSize: 30, color: Colors.blue, ),)
      ]),
      //progress card
      Center(
      child: Card(
        color: Colors.blueGrey,
        elevation: 1, 
        shape: RoundedRectangleBorder( side: BorderSide(color: Theme.of(context).colorScheme.outline,),borderRadius: const BorderRadius.all(Radius.circular(12)),),
        child: const SizedBox(
          width: 400,
          height: 200,
          child: Center(child: Text('0/6 lessons')),
        ),
      ),
    ),
    Expanded(child:ListView.builder(
      itemCount: Lessons.length,
      itemBuilder: 
      (context, index) {
        return Card(child: ListTile(
          //change this maybe
          leading: CircleAvatar(child: Text((index+1).toString()), backgroundColor: Colors.grey,),
          shape: RoundedRectangleBorder(side: BorderSide(width: .25),borderRadius: BorderRadius.circular(20) ),
          title:Text(Lessons[index].getTitle()),
          subtitle:Text(Lessons[index].getDescription()),
          //change this as well
          trailing: getTrailing(Lessons[index]),
          onTap:(){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IndividualLessonView(lesson: Lessons[index]),
            ),
          );
          },
        ) 
        ); 
        },
      ),
    ),]
    )
    );
  }

  Icon getTrailing(LessonModel lesson){
    if(lesson.getComplete()){
          return Icon(Icons.check_box_outlined);
      }else{
        return Icon(Icons.check_box_outline_blank_outlined );
      }
  }

  


}