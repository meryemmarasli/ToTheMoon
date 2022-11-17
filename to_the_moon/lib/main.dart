import 'package:flutter/material.dart';
import 'package:to_the_moon/models/user.dart';
import 'package:to_the_moon/views/dashboard_view.dart';

void main() {
  runApp(const MyApp());
}

User user = new User(acceptAgreement: false);

class MyApp extends StatelessWidget {

  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: startPage(),
    );
  }

  startPage(){
    if(user.acceptAgreement == true)
        return const DashBoard();
    else
      return const LaunchPage();
  }

}


class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             // Image.asset('assets/rocket.jpeg'),
             Text("[Image of logo goes here]"),
             Text("Paragraph of terms and conditions .............."),
             SizedBox(
              height: 50,
              width:200,
              child:ElevatedButton(
                child: Text('Accept.', style:TextStyle(color: Colors.white,)), 
                onPressed: () {
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoard()));
              }
              )
            ),

          ]),
        ),

    );
  }
}

