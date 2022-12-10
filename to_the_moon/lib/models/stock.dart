import 'package:flutter/material.dart';
class StockModel {

  StockModel(this.name, this.priceHistory, this.priceUP);

  String? name = "S&P";
  List<int> priceHistory = [
    100,
    101,
    102,
    103,
  ];
  bool priceUP = true;


  String? getName(){
    return this.name;
  }

  double gain() {
    return (priceHistory.elementAt(priceHistory.length-1) - priceHistory.elementAt(priceHistory.length-2))/priceHistory.elementAt(priceHistory.length-1)*100;
  }


  List<int> getPriceHistory(){
    return priceHistory;
  }

  int getCurrentPrice(){
    return priceHistory.elementAt(priceHistory.length-1);
  }

  bool getPriceUp(){
    return priceUP;
  }

  void updateValue(int newPrice){
    priceHistory.add(newPrice);
  }

  void setPriceUP(bool up){
    priceUP = up;
  }

  StockModel.fromMap(Map<String, dynamic> json){
    name = json["name"];
    if(json["priceUP"] == "1"){
      priceUP = true;
    }else{
      priceUP = false;
    }
    priceHistory = json["priceHistory"];
  }

  StockModel.fromJson(Map<String, dynamic> json){
    name = json["name"];
    priceHistory = json['priceHistory'];
    priceUP = json["priceUP"];
  }

  Map<String, dynamic> toMap() =>{
    'name': name,
    'priceHistory': priceHistory,
    'priceUP': priceUP
  };
}