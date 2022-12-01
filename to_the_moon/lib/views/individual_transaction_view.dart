import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/models/stock.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';

import 'package:flutter/cupertino.dart';


class IndividualTransactionStockView extends StatelessWidget {
  // In the constructor, require a lesson
  const IndividualTransactionStockView({super.key, required this.stock, required this.user});

  // Declare a field that holds the Todo.
  final StockModel stock;
  final UserModel user;

@override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    RegExp digitValidator  = RegExp("[0-9]+");
    bool isANumber = true;
    final _formBuy = GlobalKey<FormState>();
    final _formSell = GlobalKey<FormState>();

    StockViewModel stockViewModel = context.watch<StockViewModel>();
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(stock.getName().toString())),
      ),
      body: Column(
          children: [
            Form(
              key: _formBuy,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Text(stock.getCurrentPrice().toString(),
                      style: TextStyle(color: priceColor(stock),)
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.arrow_circle_up_rounded),
                    labelText: 'Buy',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    if(int.tryParse(value) == false){
                      return 'Please enter number';
                    }
                    if(int.parse(value) < 0){
                      return 'Please enter a positive number';
                    }
                    int cost = int.parse(value) * stock.getCurrentPrice();
                    if(cost > user.cash){
                      return 'Not enough money';
                    }
                    userViewModel.buyStock(user, stock.getName().toString(), int.parse(value), stock.getCurrentPrice());
                    return null;
                  },
                ),

            Container(
              child: Text('Your Owned Stocks: ' + user.getStockAmount(stock.getName().toString()).toString()),
            ),

            Form(
              key: _formSell,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.arrow_circle_down_rounded),
                      labelText: 'Sell',
                    ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if(int.tryParse(value) == false){
                        return 'Please enter number';
                      }
                      if(int.parse(value) < 0){
                        return 'Please enter a positive number';
                      }
                      if(int.parse(value) > user.getStockAmount(stock.getName().toString())){
                        return 'Not enough stocks';
                      }
                      userViewModel.sellStock(user, stock.getName().toString(), int.parse(value), stock.getCurrentPrice());
                      return null;
                  },
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formBuy.currentState!.validate() && _formSell.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );


                      }
                    },
                    child: const Text('Transact'),
                  ),
                ),
              ],
            ),
          )
        ]
      ),
      )
      ]),
    );
  }

  Color priceColor(StockModel stock){
    if(stock.getPriceUp()){
      return Colors.green;
    }else{
      return Colors.red;
    }
  }
}