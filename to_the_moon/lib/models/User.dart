import 'dart:ffi';
import 'package:flutter/material.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:collection';

import 'package:flutter/services.dart';

class UserModel {

  int userId = 0;
  int cash = 1000;
  int gains = 0;
  int loss = 0;
  bool acceptAgreement = false;
  HashMap<String, int> stocksOwned = HashMap<String, int>();

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

  void addStock(String name, int amount) {
    // attempts to add stock if key doesn't exist adds new entry
    // ! in !+ is a null check
    stocksOwned.update(name, (e) => (stocksOwned[name]! + amount), ifAbsent: () => amount);
  }

  void removeStock(String name, int amount){
    // attempts to add stock if key doesn't exist adds new entry
    // ! in !- is a null check
    stocksOwned.update(name, (e) => (stocksOwned[name]!-amount));
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
        stocksOwned.forEach((key, value) {
            if(key == stock){
              //loss
              if(newPrice < value){
                  loss += (value - newPrice);
                  cash -= (value - newPrice);
                  gains -= (value - newPrice);
              }else if(newPrice > value){
                  loss -= (newPrice - value);
                  cash += (newPrice - value);
                  gains += (newPrice - value);
              }else{
                //same price nothing changes
              }
            }
        });
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

