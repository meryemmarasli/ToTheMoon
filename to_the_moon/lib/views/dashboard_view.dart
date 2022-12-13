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
import 'package:to_the_moon/views/individual_stock_view.dart';

import 'package:to_the_moon/views/dashboard_view.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() {
    return _DashboardViewState();
  }
}

class _DashboardViewState extends State<DashboardView>
    with TickerProviderStateMixin {
  int totalCash = 0;
  int totalGain = 0;
  int totalLoss = 0;
  var list = [];
  int i = 1;

  bool switchTop = false;

  final ScrollController _scrollController = ScrollController();

  _scrollToEnd() async {
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    Future<UserModel> user = userViewModel.getUser();
    NewsViewModel newsViewModel = context.watch<NewsViewModel>();
    StockViewModel stockViewModel = context.watch<StockViewModel>();
    newsViewModel.addHeadline(stockViewModel.getGeneratedHeadlineData());
    List<NewsModel> News = newsViewModel.getHeadlines();
    stockList(user);
    updateTotalCash(user);

    if (stockViewModel.needsScroll()) {
      _scrollToEnd();
    }

    return Scaffold(
      body: FutureBuilder(
          future: Future.wait([user]),
          builder: (
            context,
            AsyncSnapshot<List> data,
          ) {
            {
              if (data.hasError) {
                return Text("Error: ${data.error}");
              } else if (data.hasData) {
                UserModel userReg = data.data?[0] as UserModel;
                return SingleChildScrollView(
                  child: Column(children: [
                    // Portfolio over view

                    Row(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 16, 0, 16),
                          child: Text("Porfolio Overview",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold))),
                    ]),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          switchTop = !switchTop;
                        });
                      },
                      child: Container(
                        height: 158,
                        width: 373,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: Color.fromARGB(255, 2, 44, 78)),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 18, 44, 64),
                            Color.fromARGB(255, 24, 50, 72),
                            Color.fromARGB(255, 89, 42, 97)
                          ]),
                          //color: Color.fromARGB(255, 170, 209, 229),
                        ),
                        child: Column(children: [
                          getTopContainer(stockViewModel, userReg),
                          Row(children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(30, 22, 0, 0),
                                child: Icon(CupertinoIcons.arrow_up_circle_fill,
                                    color: Colors.green, size: 33)),
                            // total gain arrow
                            Padding(
                                padding: EdgeInsets.fromLTRB(5, 22, 22, 0),
                                child: Text(
                                    '\$ ' +
                                        getRounded(stockViewModel
                                            .getOwnedGain(userReg)
                                            .toString()) +
                                        "%",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 22))),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 22, 5, 0),
                                child: Icon(
                                    CupertinoIcons.arrow_down_circle_fill,
                                    color: Colors.red,
                                    size: 33)),
                            // total loss image
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 22, 0, 0),
                                child: Text(
                                    '\$ ' +
                                        getRounded(stockViewModel
                                            .getOwnedLoss(userReg)
                                            .toString()) +
                                        "%",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 22))),
                          ])
                        ]),

                        //market news and your stocks
                      ),
                    ),

                    getContainer(News, stockViewModel, userViewModel, user),
                  ]),
                );
              } else {
                return CircularProgressIndicator();
              }
            }
          }),
    );
  }

  stockList(Future<UserModel> u) async {
    UserModel user = await u;

    setState(() {
      list = user.getStocks();
    });
  }

  getContainer(List<NewsModel> News, StockViewModel stockViewModel,
      UserViewModel userViewModel, Future<UserModel> u) {
    if (i == 0) {
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
                Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 5),
                    child: Text("Market News",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                getButton(),
              ]),
              Flexible(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      reverse: true,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: News.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: .5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 214, 212, 212)),
                              // borderRadius: BorderRadius.circular(20)
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: News[index].getImage(),
                                backgroundColor: Colors.white,
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text("${News[index].getHeadline()}"),
                              ),
                              subtitle: Text("${News[index].getTime()}"),
                              /*trailing: Column(
                             children: [
                               Text("\$${News[index].getValue()}"),
                              News[index].getChange(),
                            ],
                       ) */
                            ));
                      }),
                ),
              )
            ],
          ));
    } else {
      return Container(
          height: 398,
          width: 373,
          // margin: EdgeInsets.only(left: 20, right: 20,),
          decoration: BoxDecoration(
              //  border: Border.all(width: 2, color: Color.fromARGB(255, 2, 44, 78)),
              // borderRadius: BorderRadius.all(Radius.circular(20)),
              //gradient:LinearGradient(colors:[  Color.fromARGB(255, 18, 44, 64),  Color.fromARGB(255, 24, 50, 72), Color.fromARGB(255, 89, 42, 97)]),
              //color: Color.fromARGB(255, 170, 209, 229),
              ),
          child: Column(
            children: [
              Row(children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(12, 20, 0, 5),
                    child: Text("Your Investments",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                getButton(),
              ]),
              list.length == 0
                  ? Column(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Image.asset(
                              //'https://media1.giphy.com/media/fxQp8eDj3n41nC9Lk7/giphy.gif?cid=ecf05e47v3r76763ocd9qkmgfxwad4jnx94i8xhjm5006crx&rid=giphy.gif&ct=s',
                              'assets/images/moon.gif',
                              width: 170,
                              height: 160)),
                      Center(
                          child: Text(
                              "uh-oh! looks like you have no investments.",
                              style: TextStyle(fontSize: 16))),
                      Center(
                          child: Text("start investing now!",
                              style: TextStyle(fontSize: 16))),
                      // SizedBox(height: 8),
                      Center(child: Icon(Icons.arrow_downward, size: 30))
                    ])
                  : Expanded(
                      child: FutureBuilder(
                          future: Future.wait([u]),
                          builder: (
                            context,
                            AsyncSnapshot<List> data,
                          ) {
                            {
                              if (data.hasError) {
                                return Text("Error: ${data.error}");
                              } else if (data.hasData) {
                                UserModel user = data.data?[0] as UserModel;
                                return ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: .5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 214, 212, 212)),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: list[index].getImage(),
                                        ),
                                        title: Text(list[index]
                                            .getAbbreviation()
                                            .toString()),
                                        subtitle: Text.rich(
                                          TextSpan(
                                            children: <InlineSpan>[
                                              TextSpan(
                                                  text: "Owned: " +
                                                      userViewModel
                                                          .stockAmount(
                                                              user,
                                                              list[index]
                                                                  .getAbbreviation())
                                                          .toString()),
                                              //TextSpan(text: "${list[index].getCurrentPrice().toString()}.00", style: TextStyle(color: priceColor(list[index]))),
                                            ],
                                          ),
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //getTrailing(list[index]),
                                            Text("Avg Paid: \$" +
                                                getRounded(userViewModel
                                                    .getAveragePaid(
                                                        user, list[index])
                                                    .toString())),
                                            Text.rich(TextSpan(
                                              children: <InlineSpan>[
                                                TextSpan(text: "Avg Gain: "),
                                                TextSpan(
                                                    text: getRounded(stockViewModel
                                                            .getOwnedStockGain(
                                                                user,
                                                                list[index])
                                                            .toString()) +
                                                        "%",
                                                    style: TextStyle(
                                                        color: priceColor(
                                                            user,
                                                            list[index],
                                                            stockViewModel))),
                                              ],
                                            ))
                                          ],
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  IndividualStockView(
                                                      stock: list[index],
                                                      user: user),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            }
                          }))
            ],
          ));
    }
  }

  Icon getTrailing(
      UserModel user, StockModel stock, StockViewModel stockViewModel) {
    if (stockViewModel.getOwnedStockGain(user, stock) > 0) {
      return Icon(CupertinoIcons.arrow_up, color: Colors.green);
    } else {
      return Icon(CupertinoIcons.arrow_down, color: Colors.red);
    }
  }

  Color priceColor(
      UserModel user, StockModel stock, StockViewModel stockViewModel) {
    if (stockViewModel.getOwnedStockGain(user, stock) > 0) {
      return Colors.lightGreen;
    } else {
      return Colors.redAccent;
    }
  }

  getButton() {
    if (i == 0) {
      return Padding(
          padding: EdgeInsets.fromLTRB(79, 20, 0, 0),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(
                color: Colors.transparent,
              )),
              child: Row(children: [
                Text("View Investments",
                    style: TextStyle(
                        color: Colors
                            .grey)), /*Icon(Icons.arrow_right, color: Colors.grey)*/
              ]),
              onPressed: (() {
                _scrollToEnd();
                setState(() {
                  i++;
                });
              })));
    } else {
      return Padding(
          padding: EdgeInsets.fromLTRB(79, 20, 0, 0),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(
                color: Colors.transparent,
              )),
              child: Row(children: [
                /*Icon(Icons.arrow_left, color: Colors.grey),*/ Text(
                    "View News",
                    style: TextStyle(color: Colors.grey))
              ]),
              onPressed: (() {
                _scrollToEnd();
                setState(() {
                  i--;
                });
              })));
    }
  }

  String getRounded(String fullPercentage) {
    String buffer = '';
    if (fullPercentage.length == 0) {
      return '0.0';
    } else {
      for (int i = 0; i < fullPercentage.length; i++) {
        if (fullPercentage[i] == '.') {
          buffer = buffer + fullPercentage[i];
          if (i + 1 < fullPercentage.length) {
            buffer = buffer + fullPercentage[i + 1];
          }
          if (i + 2 < fullPercentage.length && buffer.length < 4) {
            buffer = buffer + fullPercentage[i + 2];
          }
          return buffer;
        } else {
          buffer = buffer + fullPercentage[i];
        }
      }
      return buffer;
    }
  }

  updateTotalCash(Future<UserModel> user) async {
    UserModel u = await user;
    setState(() {
      totalCash = u.getBalance();
      totalGain = u.getGain();
      totalLoss = u.getLoss();
    });
  }

  getTopContainer(StockViewModel stockViewModel, UserModel user) {
    if (switchTop) {
      return Column(children: [
        Row(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(30, 18, 0, 0),
              child: Text("Invested Capital:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),
        ]),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text(
                    "\$${stockViewModel.getOwnedInvestedCapital(user).toString()}0",
                    style: TextStyle(color: Colors.white, fontSize: 40))),
          ],
        )
      ]);
    } else {
      return Column(children: [
        Row(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(30, 18, 0, 0),
              child: Text("Total Assets:",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),
        ]),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Text(
                    "\$${stockViewModel.getOwnedTotalAssets(user).toString()}0",
                    style: TextStyle(color: Colors.white, fontSize: 40))),
          ],
        )
      ]);
    }
  }
}