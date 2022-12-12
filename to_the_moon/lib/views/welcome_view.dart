import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_the_moon/views/agreement_view.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';
import 'package:to_the_moon/views/navigationBar.dart';

import '../models/User.dart';



class WelcomeView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new WelcomeViewState();
  }
}

class WelcomeViewState extends State<WelcomeView>{
  bool accept = false;
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    getAccept(userViewModel.getUser());

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
                        if(accept){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                        }else{
                           Navigator.push(context, MaterialPageRoute(builder: (context) => AgreementView()));

                        }
                      }
                  )
                  ),
              ),
        )
    ])
    );
  }

  getAccept(Future<UserModel> f) async{
     UserModel user = await f;
      setState(() {
        accept = user.acceptAgreement;
      });
  }

}

