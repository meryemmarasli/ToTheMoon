import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/views/agreement_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 27, 44),
      body:
        Stack(
        children: <Widget>[
        Align(
          alignment: Alignment(0.0, -0.8),
          child: Container(
            child: Text("To The Moon", style:TextStyle(color: Colors.white)), 
          ),
        ),
          Align(
              alignment: Alignment(0.0, 0),

              child: Container(
                child: new Image.asset('assets/images/rocket.png'),
                alignment: Alignment.center,
                width: 350,
                height: 250,
              ),
          ),
        Align(
              child: Container(
                  alignment: Alignment(0.0, 0.7),
                child: SizedBox(
                    height: 50,
                    width:200,
                      child:ElevatedButton(
                      child: Text('Start', style:TextStyle(color: Colors.white,)),
                      style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 220, 35, 22)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AgreementView()));
                      }
                  )
                  ),
              ),
        )
    ])
    );
  }
}