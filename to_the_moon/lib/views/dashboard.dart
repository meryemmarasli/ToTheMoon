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


class DashboardView extends StatelessWidget {
  // In the constructor, require a lesson
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<StockModel>> Stocks = context.watch<StockViewModel>()
        .getStock();
    Future<UserModel> User = context.watch<UserViewModel>().getUser() as Future<
        UserModel>;

    return Scaffold(
        body: FutureBuilder(
            future: Future.wait([Stocks, User]),
            builder: (context,
                AsyncSnapshot<List> data,) {
              {
                if (data.hasError) {
                  return Text("Error: ${data.error}");
                } else if (data.hasData) {
                  var stocks = data.data?[0] as List<StockModel>;
                  UserModel user = data.data?[1] as UserModel;
                  return Center(
                      child: new Container()
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }
            })
    );
  }
}
