import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/stock.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/views/individual_transaction_view.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';


class IndividualStockView extends StatefulWidget {
  // In the constructor, require a lesson
  const IndividualStockView(
      {super.key, required this.stock, required this.user});

  // Declare a field that holds the Todo.
  final StockModel stock;
  final UserModel user;

  @override
  _IndividualStockViewState createState() => _IndividualStockViewState(stock, user);

}

class _IndividualStockViewState extends State<IndividualStockView> {
  int? groupValue = 0;
  late StockModel stock;
  late UserModel user;
  int? transaction = 0;

  _IndividualStockViewState(this.stock, this.user);

  @override
  Widget build(BuildContext context) {
    StockViewModel stockViewModel = context.watch<StockViewModel>();
    UserViewModel userViewModel = context.watch<UserViewModel>();

    return Scaffold(
      // Build the Top Appbar
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 38, 60),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              // Stock Name
              Text(stockViewModel.getStockName(stock).toString(), textAlign: TextAlign.center),
              // Animated Cash Change
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                transitionBuilder:
                    (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(begin: const Offset(0.0, -0.5), end: const Offset(0.0, 0.0)).animate(animation),
                        child: child,
                  );
                },
                child: Text.rich(
                  key: ValueKey<int?>(transaction),
                  TextSpan(
                    children: <InlineSpan>[
                      const WidgetSpan(
                          child: Icon(Icons.attach_money)),
                      TextSpan(text: userViewModel.getUserCash(user).toString()),
                    ],
                  ),
                ),
              )
            ],
          ),
      ),

      // Scrollable for the calculator to adjust
      body: SingleChildScrollView(
        // background container
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(205, 232, 237, 243),
          ),

          // Center Column
          child: Column(
          children: [

            // Top Padding
            const Padding(padding: EdgeInsets.fromLTRB(10, 10.0, 20, 4.0)),

            // Graph Container
            Center(
                child: Container(
                    width: 380,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.grey[300]!,
                          spreadRadius: 5.0,
                        ),
                      ],
                    ),
                    child: SfCartesianChart(
                      // Initialize category axis
                        primaryXAxis: CategoryAxis(),

                        series: <LineSeries<GraphValue, String>>[
                          LineSeries<GraphValue, String>(
                            // Bind data source
                              dataSource: processData(),
                              xValueMapper: (GraphValue plot, _) => plot.time,
                              yValueMapper: (GraphValue plot, _) => plot.price
                          )
                        ]
                    )
                )
            ),
            // Bottom Padding
            const SizedBox(height: 10),

            // Bottom Section
            Container(
              width: 380,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,

                  boxShadow: [
                    BoxShadow(
                     blurRadius: 5.0,
                      color: Colors.grey[300]!,
                      spreadRadius: 5.0,
                    ),
                ],
              ),
              child: Column(
                children: [

                  const SizedBox(height: 5),
                  // Info Box of Bottom Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Price Info
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                            child: Text.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  WidgetSpan(
                                      child: Icon(Icons.attach_money, size: 20,)),
                                  TextSpan(text: "Price " + stockViewModel.getStockPrice(stock).toString(), style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                        ),
                        // Gain Info
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                          child: Text.rich(
                            TextSpan(
                              children: <InlineSpan>[
                                WidgetSpan(
                                    child: getGainIcon(stock)),
                                    TextSpan(text: ' Gain ' + stockViewModel.getStockGain(stock).toString().substring(0, 4) + '%', style: TextStyle(color: priceColor(stock), fontSize: 19),)
                              ],
                            ),
                          ),
                        ),
                        // Stock Own Info row to split text between non-animated and animated
                        Row(
                          children: [
                            Text.rich(
                                key: ValueKey<int?>(transaction),
                                const TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                          child: Icon(Icons.shopping_basket_outlined, size: 19,)),
                                      TextSpan(text: ' Owned ', style: TextStyle(fontSize: 18),),
                                ]),
                          ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 1000),
                                transitionBuilder:
                                (Widget child, Animation<double> animation) {
                                return SlideTransition(
                                  child: child,
                                  position: Tween<Offset>(
                                    begin: Offset(0.0, -0.5),
                                    end: Offset(0.0, 0.0))
                                    .animate(animation),
                                  );
                                },
                                child: Text.rich(
                                  key: ValueKey<int?>(transaction),
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(text: userViewModel.stockAmount(user,StockViewModel().getStockName(stock).toString()).toString(), style: TextStyle(fontSize: 18),),
                                    ],
                                  ),
                                ),
                              )
                            ),
                          ]
                        ),
                    ]
                  ),

                  const SizedBox(height: 20),

                  // Scrollable Selection
                  Container(
                    alignment: Alignment.center,
                      child: CupertinoSlidingSegmentedControl<int>(
                      backgroundColor: Color.fromARGB(205, 232, 237, 243),
                      thumbColor: Colors.blue,
                      padding: EdgeInsets.all(8),
                      groupValue: groupValue,
                      children: {
                        0: buildSelection("Buy"),
                        1: buildSelection("Sell"),
                      },
                      onValueChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      },
                    ),
                  ),

                  // Widget based on selection
                  Container(
                    child: getMode(userViewModel, stockViewModel)
                  ),
                  // Bottom padding
                  const SizedBox(height: 40),
                ]
              )
            )
          ]
        ),
        ),
      ),
    );
  }

  Widget? getMode(UserViewModel userViewModel, StockViewModel stockViewModel){
    if(groupValue == 0){
      return buildBuy(userViewModel, stockViewModel);
    }else{
      return buildSell(userViewModel, stockViewModel);
    }
  }

  Widget buildBuy(UserViewModel userViewModel, StockViewModel stockViewModel) {
    final formBuy = GlobalKey<FormState>();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
              key: formBuy,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      // impossible to enter negative or non-number
                      keyboardType: TextInputType.number,
                      scrollPadding: const EdgeInsets.only(bottom:200),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))
                      ],

                      decoration: const InputDecoration(
                        labelText: 'Input Buy Order',
                      ),

                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }

                        int cost = int.parse(value) * stockViewModel.getStockPrice(stock);
                        if (cost > userViewModel.getUserCash(user)!) {
                          return 'Not enough money';
                        }

                        userViewModel.buyStock(user, stock.getName().toString(), int.parse(value), stockViewModel.getStockPrice(stock));
                        return null;
                      },
                    ),
                  ),

                  // padding for button
                  const SizedBox(height: 10),

                  ElevatedButton(
                      onPressed: ()
                        {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (formBuy.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          setState(() {
                            transaction = transaction! + 1;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                     child:const Text('Buy'),
                  )
                ],
              )
          )
        ]
    );
  }

  Widget buildSell(UserViewModel userViewModel, StockViewModel stockViewModel) {
    final formSell = GlobalKey<FormState>();
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
              key: formSell,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      // impossible to enter negative or non-number
                        keyboardType: TextInputType.number,
                        scrollPadding: const EdgeInsets.only(bottom:200),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))
                        ],

                        decoration: const InputDecoration(
                          labelText: 'Input Sell Order',
                        ),

                      // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          if(int.parse(value) > userViewModel.stockAmount(user, stockViewModel.getStockName(stock).toString())){
                            return 'Not enough stocks';
                          }
                          userViewModel.sellStock(user, stockViewModel.getStockName(stock).toString(), int.parse(value), stockViewModel.getStockPrice(stock));
                          return null;
                        },
                      ),
                    ),

                  // padding for button
                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: ()
                    {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (formSell.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        setState(() {
                          transaction = transaction! + 1;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child:const Text('Sell'),
                  )
                ],
              )
          )
        ]
    );
  }

  Widget buildSelection(String text) {
    return Text(text, style: const TextStyle(fontSize: 22, color: Colors.black),);
  }

  List<GraphValue> processData() {
    final list = <GraphValue>[];
    for (int i = 0; i < stock.priceHistory.length; i++) {
      list.add(GraphValue(i.toString(), stock.priceHistory[i]));
    }
    return list;
  }

  Color priceColor(StockModel stock) {
    if (stock.getPriceUp()) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Icon getGainIcon(StockModel stock){
    if(stock.getPriceUp()){
      return const Icon(CupertinoIcons.arrow_up, color: Colors.green, size: 18,);
    }else{
      return const Icon(CupertinoIcons.arrow_down, color: Colors.red,  size: 18,);
    }
  }
}


class GraphValue {
  GraphValue(this.time, this.price);
  final String time;
  final int price;
}

