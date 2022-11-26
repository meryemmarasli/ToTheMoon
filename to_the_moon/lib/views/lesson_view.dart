import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
import 'package:to_the_moon/views/individual_lesson_view.dart';


=======
import 'package:provider/provider.dart';
import 'package:to_the_moon/views/menu_view.dart';
import 'package:to_the_moon/viewmodels/lesson_view_model.dart';
>>>>>>> 012acfeaa880efacc4310f2a01d4ac2e4718556f


class LessonView extends StatelessWidget {
  const LessonView({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD

    LessonViewModel lessonViewModel = context.watch<LessonViewModel>();
  

    // LessonViewModel L = new LessonViewModel();
     // List<LessonModel> Lessons = L.getLessonsList();
    return Scaffold(
     body:  Expanded(child:FutureBuilder(
            future: lessonViewModel.Lessons,
            builder: (context,data){
              if(data.hasError){
                return Text("Error: ${data.error}");
              }else if(data.hasData){
                var Lessons = data.data as List<LessonModel>;
                return ListView.builder(
                    itemCount: Lessons.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 1, 
                        shape: RoundedRectangleBorder(side: BorderSide(width: .25),borderRadius: BorderRadius.circular(20) ),
                        child: ListTile(  
                          //change this maybe
                          //leading: CircleAvatar(child: Text((index+1).toString()), backgroundColor: Colors.grey,),
                          title:Text(Lessons[index].getTitle().toString()),
                          subtitle:Text(Lessons[index].getDescription().toString()),
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
                        ), 
                      ); 
                    },
                ); 

              }else{
                return Center(child:CircularProgressIndicator());
              }
            }
          ),

=======
    LessonViewModel lessonViewModel = context.watch<LessonViewModel>();
    final List<Text> Lessons = lessonViewModel.Lessons;
    return Scaffold(
       appBar: AppBar(
        //return button
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed:(){
           Navigator.push(context, MaterialPageRoute(builder: (context) => MenuView()));
        }),
        title: Text("Lessons"),
      ),
      body: ListView.builder(
        itemCount: Lessons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Lessons[index],
          );
        },
>>>>>>> 012acfeaa880efacc4310f2a01d4ac2e4718556f
      ),
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