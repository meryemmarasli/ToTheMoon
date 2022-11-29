import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/models/stock.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';
import 'package:to_the_moon/views/individual_stock_view.dart';




class MarketView extends StatelessWidget {
  const MarketView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<StockModel>> Stocks = context.watch<StockViewModel>().getStock();
    return Scaffold(
        body:FutureBuilder(
            future: Stocks,
            builder:(context, data){
              if(data.hasError){
                return Text("Error: ${data.error}");
              }else if(data.hasData){
                var stocks = data.data as List<StockModel>;
                return ListView.builder(
                    itemCount: stocks.length,
                    itemBuilder:(context, index) {
                      return Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(side: BorderSide(width: .25),borderRadius: BorderRadius.circular(20) ),
                          child: ListTile(
                            //change this maybe
                            leading: CircleAvatar(child: Text((index+1).toString()), backgroundColor: Colors.grey,),
                            title:Text(stocks[index].getName().toString()),
                            subtitle:Text(stocks[index].getCurrentPrice().toString(), style: TextStyle(color: priceColor(stocks[index])),),
                            trailing: getTrailing(stocks[index]),
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IndividualStockView(stock: stocks[index]),
                                ),
                              );
                            },
                          )
                      );
                    }
                );
              }else{
                return CircularProgressIndicator();
              }
            }
        )
    );
  }





  Icon getTrailing(StockModel stock){
    if(stock.getPriceUp()){
      return Icon(CupertinoIcons.arrow_up, color: Colors.green);
    }else{
      return Icon(CupertinoIcons.arrow_down, color: Colors.red);
    }
  }

  Color priceColor(StockModel stock){
    if(stock.getPriceUp()){
      return Colors.green;
    }else{
      return Colors.red;
    }
  }
}