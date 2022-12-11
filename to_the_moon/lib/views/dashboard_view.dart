//dashboard view
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:collection';



import 'package:flutter/material.dart';
import 'package:to_the_moon/viewmodels/news_view_model.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/models/news.dart';
import 'package:to_the_moon/models/stock.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';
import 'package:to_the_moon/views/navigationBar.dart';


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
  var list;
  int i = 0;
  
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    Future<UserModel> user = userViewModel.getUser();
    NewsViewModel newsViewModel = context.watch<NewsViewModel>();
    StockViewModel stockViewModel = context.watch<StockViewModel>();
    List<NewsModel> News = newsViewModel.getHeadlines();
    stockList(user);
    updateTotalCash(user);
 
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
                // Portfolio over view
                 Row(children: [
                      Padding(padding: EdgeInsets.fromLTRB(20, 10, 0, 5), child: Text("Porfolio Overview", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold ) ) ),
                  ]),
                Container(
                  height: 158,
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
        
                //market news and your stocks
                ),
              
              getContainer(News, stockViewModel),

        ]
      ),
    ));  
 }

stockList(Future<UserModel> u) async{
  UserModel user = await u;

      setState(() {
        list = user.getStocks();
      });
}

getContainer(List<NewsModel> News, StockViewModel stockViewModel){
 
  if(i == 0){
    return Container(
       height: 398,
       width: 373,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
         //border: Border.all(width: 2, color: Color.fromARGB(255, 2, 44, 78)),
         borderRadius: BorderRadius.all(Radius.circular(20)),
        //gradient:LinearGradient(colors:[  Color.fromARGB(255, 18, 44, 64),  Color.fromARGB(255, 24, 50, 72), Color.fromARGB(255, 89, 42, 97)]),
        //color: Color.fromARGB(255, 170, 209, 229),
          ),
          child: Column(
          children: [
              Row(children: [
                Padding(padding: EdgeInsets.fromLTRB(12, 20, 0, 5), child: Text("Market News", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ) ) ),
                getButton(),

              ]),
               Expanded(
                 child: ListView.builder(
                 itemCount: News.length,
                   itemBuilder: (context, index){
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
                       }
                     ),
                     ),
                    ],)
                 );
  }else{
    return Container(
                           height: 398,
                           width: 373,
                           margin: EdgeInsets.only(right: 20,),
                           decoration: BoxDecoration(
                              //  border: Border.all(width: 2, color: Color.fromARGB(255, 2, 44, 78)),
                               // borderRadius: BorderRadius.all(Radius.circular(20)),
                                //gradient:LinearGradient(colors:[  Color.fromARGB(255, 18, 44, 64),  Color.fromARGB(255, 24, 50, 72), Color.fromARGB(255, 89, 42, 97)]),
                                //color: Color.fromARGB(255, 170, 209, 229),
                              ),
                          child: Column(
                            children: [
                              Row(children: [
                                Padding(padding: EdgeInsets.fromLTRB(12, 20, 0, 5), child: Text("Your Investments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ) ) ),
                                 getButton(),

                            ]),
                            list.length == 0
                            ?Column(children: [
                              Padding( padding: EdgeInsets.fromLTRB(0, 50, 0, 40),
                              child: Image.asset(
                                 //'https://media1.giphy.com/media/fxQp8eDj3n41nC9Lk7/giphy.gif?cid=ecf05e47v3r76763ocd9qkmgfxwad4jnx94i8xhjm5006crx&rid=giphy.gif&ct=s',
                                 'assets/images/moon.gif',
                                  width: 170,
                                  height: 170
                                )
                              ),
                              Center(child: Text("uh-oh! looks like you have no investments." , style: TextStyle(fontSize: 16))),
                              Center(child: Text("start investing now!", style: TextStyle(fontSize: 16))),
                              SizedBox(height: 8),
                              Center(child: Icon(Icons.arrow_downward))


                              ]
                            )
                            : Expanded(
                              child:ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder:(context, index){
                                        return ListTile(
                                        leading: CircleAvatar(backgroundColor: Colors.white, child: list[index].getImage(),),
                                              title: Text(list[index].getAbbreviation().toString()),
                                              subtitle: Text.rich(
                                                TextSpan(
                                                  children: <InlineSpan>[
                                                    TextSpan(text: "Value "),
                                                    TextSpan(text: list[index].getCurrentPrice().toString())
                                                  ],
                                                ),
                                              ),

                                              trailing: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                // getTrailing(stocks[index]),
                                                  Text(stockViewModel.getStockGain(list[index]).toString().substring(0, 4) + '%'),
                                                ],
                                              ),
                                        );
                                    }
                                  )
                            )
                          ],)
                      );


                  
  }
}

  getButton(){
    if( i == 0){
      return  Padding(padding:EdgeInsets.fromLTRB(79, 20, 0, 0) , 
                child:OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.transparent,
                      )
                  ),
                  child: Row( children: [ Text("View Investments", style: TextStyle(color: Colors.grey)), /*Icon(Icons.arrow_right, color: Colors.grey)*/ ]),
                  onPressed: (() {
                    setState(() {
                      i++;
                    });
                  })
          ));
      }else{
          return  Padding(padding:EdgeInsets.fromLTRB(79, 20, 0, 0) , 
                child:OutlinedButton(
                 style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.transparent,
                      )
                  ),
                  child: Row( children: [  /*Icon(Icons.arrow_left, color: Colors.grey),*/ Text("View News", style: TextStyle(color: Colors.grey)) ]),
                  onPressed: (() {
                    setState(() {
                      i--;
                    });
                  })
          ));
      }
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