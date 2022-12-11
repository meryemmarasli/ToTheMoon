import 'dart:ffi';
import 'package:flutter/material.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:collection';
import 'package:to_the_moon/models/stock.dart';


import 'package:flutter/services.dart';

class UserModel {

  int userId = 0;
  int cash = 1000;
  int gains = 0;
  int loss = 0;
  bool acceptAgreement = false;
  HashMap<String, int> stocksOwned = HashMap<String, int>();
  List<StockModel> stocks = [];

  UserModel(this.userId, this.cash, this.acceptAgreement, this.stocksOwned); //  this.ownedStock

  /*
  HashMap<String, int> getStock(){
    return ownedStock;
  }
   */

  void setAgreement(){
    acceptAgreement = true;
  }

  dynamic getStockAmount(String name){
    if(!stocksOwned.containsKey(name)){
      return 0;
    }
    return stocksOwned[name];
  }

  
  getStocksOwned(){
    return stocksOwned;
  }
  
  getStocks(){
    return stocks;
  }

  void addStock(String name, int amount, StockModel s) {
    // attempts to add stock if key doesn't exist adds new entry
    // ! in !+ is a null check
    if(!stocksOwned.containsKey(name)){
      stocks.add(s);
    }
    stocksOwned.update(name, (e) => (stocksOwned[name]! + amount), ifAbsent: () => amount);
   
  }

  void removeStock(String name, int amount, StockModel s){
    // attempts to add stock if key doesn't exist adds new entry
    // ! in !- is a null check
    stocksOwned.update(name, (e) => (stocksOwned[name]!-amount));
    stocks.remove(s);
  }

  void addCash(int amount){
    cash = cash+amount;
  }

  void removeCash(int amount){
    cash = cash-amount;
  }

  int getCash(){
    return cash;
  }

  int getLoss(){
    return loss;
  }

  int getGain(){
    return gains;
  }

 void updateCash(String stock, int newPrice ){
     if(stocksOwned.containsKey(stock)){
              //loss
              if(newPrice < stocksOwned[stock]!){
                  loss += (stocksOwned[stock]! - newPrice);
                  cash -= (stocksOwned[stock]! - newPrice);
                  gains -= (stocksOwned[stock]! - newPrice);
              }else if(newPrice > stocksOwned[stock]!){
                  loss -= (newPrice - stocksOwned[stock]!);
                  cash += (newPrice - stocksOwned[stock]!);
                  gains += (newPrice - stocksOwned[stock]!);
              }else{
                //same price nothing changes
              }
      }
    }

  UserModel.fromJson(Map<String, dynamic> json){
    userId = json["userId"];
    cash = json['cash'];
    acceptAgreement = json["acceptAgreement"];
    stocksOwned = HashMap<String, int>.from(jsonDecode(json['stocksOwned']));
  }

  UserModel.fromMap(Map<String, dynamic> json){
    userId = json["userId"];

    if(json["acceptAgreement"] == "1"){
      acceptAgreement = true;
    }else{
      acceptAgreement = false;
    }
    cash = json["cash"];
    stocksOwned = HashMap<String, int>.from(jsonDecode(json['stocksOwned']));
  }

  Map<String, dynamic> toMap() =>{
    'userId': userId,
    'cash' : cash,
    'stocksOwned' : stocksOwned,
    'acceptAgreement': acceptAgreement,
  };
}

