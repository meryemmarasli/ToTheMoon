//dashboard view
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:to_the_moon/viewmodels/news_view_model.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/models/news.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';

import 'package:to_the_moon/views/dashboard_view.dart';


class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState(){
   
   return  _DashboardViewState();

  } 
}




class _DashboardViewState extends State<DashboardView> {
  int totalCash = 0;
  int totalGain = 0;
  int totalLoss = 0;
  
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    Future<UserModel> user = userViewModel.getUser();
    NewsViewModel newsViewModel = context.watch<NewsViewModel>();
    List<NewsModel> News = newsViewModel.getHeadlines();

    updateTotalCash(user);
 
    return Scaffold(
      body:Column(
          children: [
                 Row(children: [
                      Padding(padding: EdgeInsets.fromLTRB(20, 10, 0, 5), child: Text("Porfolio Overview", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold ) ) ),
                  ]),
                Container(
                  height: 170,
                  width: 373,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color.fromARGB(255, 2, 44, 78)),
                     borderRadius: BorderRadius.all(Radius.circular(20)),
                     gradient:LinearGradient(colors:[  Color.fromARGB(255, 18, 44, 64),  Color.fromARGB(255, 24, 50, 72), Color.fromARGB(255, 89, 42, 97)]),
                    //color: Color.fromARGB(255, 170, 209, 229),
                  ),
                  child: Column(
                    children: [
                      Row(children: [
                      Padding(padding: EdgeInsets.fromLTRB(30, 18, 0, 0), child: Text("Balance:", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
                     ]),
                      Row(children : [
                      Padding(padding: EdgeInsets.fromLTRB(30, 0, 0, 0), child: Text('\$${totalCash}.00', style: TextStyle(color: Colors.white, fontSize: 40))),
                    ]),
                    Row(children: [
                      Padding(padding: EdgeInsets.fromLTRB(30, 22, 0, 0), child: Icon(CupertinoIcons.arrow_up_circle_fill, color: Colors.green, size: 33)), // total gain arrow
                      Padding(padding: EdgeInsets.fromLTRB(5, 22, 22, 0), child: Text('\$${totalGain}.00 ', style: TextStyle(color: Colors.green, fontSize: 22))),
                      Padding(padding:EdgeInsets.fromLTRB(0, 22, 5, 0) , child:Icon(CupertinoIcons.arrow_down_circle_fill, color: Colors.red, size: 33)), // total loss image
                      Padding(padding: EdgeInsets.fromLTRB(0, 22, 0, 0), child: Text('\$${totalLoss}.00 ', style: TextStyle(color: Colors.red, fontSize: 22))),

                    ])
                    ]
                  ),
        

                ),
                 Row(children: [
                      Padding(padding: EdgeInsets.fromLTRB(12, 18, 0, 5), child: Text("Market News", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ) ) ),
                  ]),
                Expanded(child: ListView.builder(
                itemCount: News.length,
                itemBuilder: (context, index) {
                 return ListTile(
                      leading: CircleAvatar(child: News[index].getImage(), backgroundColor: Colors.white,),
                        title: Text("${News[index].getStockName()}"),
                        subtitle: Text("${News[index].getCompanyName()}"),
                        trailing: Column(
                          children: [
                            Text("\$${News[index].getValue()}"),
                            News[index].getChange(),
                          ],
                        )

                      );
                },
               ) ),


        ]
      )
    );  
 }

updateTotalCash(Future<UserModel> user) async{
  UserModel u = await user;
  setState(() {
    totalCash = u.getCash();
    totalGain = u.getGain();
    totalLoss = u.getLoss();
  });
}


}