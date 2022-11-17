import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/views/agreement_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
        Stack(
        children: <Widget>[
        Align(
          alignment: Alignment(0.0, -0.8),
          child: Container(
            child: new Text("To The Moon"),
          ),
        ),
          Align(
              alignment: Alignment(0.0, -0.3),

              child: Container(
                child: new Image.asset('assets/images/rocket.png'),
                alignment: Alignment.center,
                width: 500,
                height: 350,
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