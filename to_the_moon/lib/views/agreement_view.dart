import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';
import 'package:to_the_moon/views/navigationBar.dart';
import 'package:provider/provider.dart';

class AgreementView extends StatelessWidget {
  const AgreementView({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 246, 249),
    body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/rocket bottom.gif', alignment: Alignment.bottomCenter,

              ),
            ),

            Align(
              alignment: Alignment.topCenter,
            child: Container(
              width: 300,
              height: 300,
                margin: const EdgeInsets.only(bottom: 260),
                decoration: BoxDecoration(
                   color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.grey[300]!,
                      spreadRadius: 5.0,
                    ),
                  ],
                  border: Border.all(width: 2, color: Color.fromARGB(255, 2, 44, 78)),
                  borderRadius: BorderRadius.all(Radius.circular(20)),),
              child: Column(

                children: [
                SizedBox(height: 15),
                Text("Terms & Conditions ", style: TextStyle(fontSize: 25)),
                  
                Padding(padding: EdgeInsets.fromLTRB(5, 20, 5, 10),child:Text("To The Moon may not distribute any Product(s) to any User unless such User is subject to a license agreement with To The Moon similar to the license agreements To The Moon uses for similar or like products. To The Moon will promptly provide PlanetCAD with such license agreement(s) upon PlanetCAD's request.", style: TextStyle(fontSize: 15 ), textAlign: TextAlign.center)),
                
                SizedBox(height: 10),
                ElevatedButton(
                      child: Text('Accept.',
                          style: TextStyle(
                          color: Colors.white,
                        )),
                      onPressed: () {
                          userViewModel.setAgreement();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => BottomBar()));
                          },
                          
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color.fromARGB(255, 234, 80, 69) ,
                            shape: StadiumBorder(),
                          ),
                          
                          
                          ),
                  
              ],))

          ),
        ])]
      ),



    );
  }
        /*body: FutureBuilder(
            future: User,
            builder: (
              context,
              data,
            ) {
              if (data.hasError) {
                return Text("Error: ${data.error}");
              } else if (data.hasData) {
                UserModel user = data.data as UserModel;
                return Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment(0.0, -0.2),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Color.fromARGB(
                              255, 2, 44, 78)),
                          borderRadius: BorderRadius.all(Radius.circular(20)),),
                        width: 350,
                        child: Column(
                          children:[ 
                             Text(
                              "User Agreement. Dassault Systemes may not distribute any Product(s) to any User unless such User is subject to a license agreement with Dassault Systemes similar to the license agreements Dassault Systemes uses for similar or like products. Dassault Systemes will promptly provide PlanetCAD with such license agreement(s) upon PlanetCAD's request."),
                        ]),
                      ),
                    ),
                    Align(
                      child: Container(
                        alignment: Alignment(0.0, 0.7),
                        child: SizedBox(
                            height: 50,
                            width: 200,
                            child: ElevatedButton(
                                child: Text('Accept',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    )),
                                onPressed: () {
                                  userViewModel.setAgreement(user);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomBar()));

                                })),
                      ),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  } */
}
