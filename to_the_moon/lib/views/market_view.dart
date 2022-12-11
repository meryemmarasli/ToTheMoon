import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/models/stock.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';
import 'package:to_the_moon/views/individual_stock_view.dart';
import 'package:to_the_moon/viewmodels/user_stock_view_model.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';






class MarketView extends StatefulWidget {
  const MarketView({super.key});

  @override
  _MarketViewState createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> {

  _MarketViewState();

  bool isHover=false;

  @override
  Widget build(BuildContext context) {
    Future<List<StockModel>> Stocks = context.watch<StockViewModel>().getStock();
    Future<UserModel> User = context.watch<UserViewModel>().getUser() as Future<UserModel>;

    StockViewModel stockViewModel = context.watch<StockViewModel>();
    UserViewModel userViewModel = context.watch<UserViewModel>();

    return Scaffold(
        body:Container(
          decoration: const BoxDecoration(
          color: Color.fromARGB(205, 232, 237, 243),

        ),
        child: FutureBuilder(
        future: Future.wait([Stocks,User]),
            builder: (
                context,
                AsyncSnapshot<List> data,
                ) {
              {
                if (data.hasError) {
                  return Text("Error: ${data.error}");
                } else if (data.hasData) {
                  var stocks = data.data?[0] as List<StockModel>;
                  UserModel user = data.data?[1] as UserModel;
                  return ListView.builder(
                      itemCount: stocks.length,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 1,
                            color: Colors.white,

                            shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(20)
                            ),
                                  child: ListTile(
                                    leading: CircleAvatar(backgroundColor: Colors.white, child: stocks[index].getImage(),),
                                    title: Text(stocks[index].getAbbreviation().toString()),
                                    subtitle: Text.rich(
                                      TextSpan(
                                        children: <InlineSpan>[
                                          TextSpan(text: "Value "),
                                          TextSpan(text: stocks[index].getCurrentPrice().toString(), style: TextStyle(color: priceColor(stocks[index], stockViewModel)))
                                        ],
                                      ),
                                    ),

                                    trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        getTrailing(stocks[index], stockViewModel),
                                        Text(getPercentage(stockViewModel,stocks[index])),
                                      ],
                                    ),
                                    onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => IndividualStockView(
                                            stock: stocks[index], user: user),
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
            })
    ));
  }

  Icon getTrailing(StockModel stock, StockViewModel stockViewModel){
    if(stockViewModel.getStockGain(stock) > 0){
      return Icon(CupertinoIcons.arrow_up, color: Colors.green);
    }else{
      return Icon(CupertinoIcons.arrow_down, color: Colors.red);
    }
  }

  Color priceColor(StockModel stock, StockViewModel stockViewModel){
    if(stockViewModel.getStockGain(stock) > 0){
      return Colors.lightGreen;
    }else{
      return Colors.redAccent;
    }
  }

  String getPercentage(StockViewModel stockViewModel, StockModel stock) {
    String fullPercentage = stockViewModel.getStockGain(stock).toString();
    String buffer = '';
    if(fullPercentage.length == 0){
      return '0.0%';
    } else{
      for(int i = 0; i < fullPercentage.length; i++){
        if(fullPercentage[i] == '.'){
          buffer = buffer+fullPercentage[i];
          if(i+1 < fullPercentage.length){
            buffer = buffer+fullPercentage[i+1];
          }if(i+2 < fullPercentage.length && buffer.length < 4){
            buffer = buffer+fullPercentage[i+2];
          }
          return buffer + "%";
        }else{
          buffer = buffer+fullPercentage[i];
        }
      }
      return buffer + "%";
    }
  }
}