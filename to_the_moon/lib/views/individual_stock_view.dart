import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:flutter/material.dart';
import 'package:to_the_moon/models/lesson.dart';
import 'package:to_the_moon/models/stock.dart';
import 'package:to_the_moon/viewmodels/market_view_model.dart';

class IndividualStockView extends StatelessWidget {
  // In the constructor, require a lesson
  const IndividualStockView({super.key, required this.stock});

  // Declare a field that holds the Todo.
  final StockModel stock;

  @override
  Widget build(BuildContext context) {
    StockViewModel stockViewModel = context.watch<StockViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(stock.getName().toString())),
      ),
      body: Column(
          children: [
            //setting up title
            Padding( padding: EdgeInsets.fromLTRB(10, 10.0, 20, 4.0)),
            Center(
                child: Container(
                    child: SfCartesianChart(
                      // Initialize category axis
                        primaryXAxis: CategoryAxis(),

                        series: <LineSeries<GraphValue, String>>[
                          LineSeries<GraphValue, String>(
                            // Bind data source
                              dataSource: proccessData(),
                              xValueMapper: (GraphValue plot, _) => plot.time,
                              yValueMapper: (GraphValue plot, _) => plot.price
                          )
                        ]
                    )
                )
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Padding(padding: EdgeInsets.all(10),
                child: Text(stock.getCurrentPrice().toString(),
                  style: TextStyle(color: priceColor(stock),)
                ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                child: Text('Buy/Sell Stock', style:TextStyle(color: Colors.white,)),
                onPressed: () {
                  // ADD BUY/SELL PAGE
                }
            )
          ]

      ),
    );
  }

  List<GraphValue> proccessData(){
    final list = <GraphValue>[];
      for(int i = 0; i < stock.priceHistory.length;i++) {
        list.add(GraphValue(i.toString(), stock.priceHistory[i]));
      }
    return list;
  }

  Color priceColor(StockModel stock){
    if(stock.getPriceUp()){
      return Colors.green;
    }else{
      return Colors.red;
    }
  }
}

class GraphValue {
  GraphValue(this.time, this.price);
  final String time;
  final int price;
}
