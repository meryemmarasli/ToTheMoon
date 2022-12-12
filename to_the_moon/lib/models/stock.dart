import 'package:flutter/material.dart';
class StockModel {

  StockModel(this.abbreviation, this.name, this.priceHistory, this.imagePath);

  String? abbreviation = "Test";
  String? name = "Test";
  String? imagePath = "Test";
  List<int> priceHistory = List<int>.empty(growable: true);
 
  String? getAbbreviation(){
    return abbreviation;
  }

  String? getName(){
    return name;
  }

  Widget getImage(){
    return Image.asset(imagePath.toString());
  }

  List<int> getPriceHistory(){
    return priceHistory;
  }

  double gain() {
    double gain = (priceHistory.elementAt(priceHistory.length-1) - priceHistory.elementAt(priceHistory.length-2))/priceHistory.elementAt(priceHistory.length-1)*100;
    if(gain.isNaN || gain.isInfinite){
      return 0.0;
    }
    print(gain);
    return gain;
  }

  int getCurrentPrice(){
    return priceHistory.elementAt(priceHistory.length-1);
  }

  void updateValue(int newPrice){
    priceHistory.add(newPrice);
  }

  StockModel.fromMap(Map<String, dynamic> json){
    abbreviation = json["abbreviation"];
    name = json["name"];
    priceHistory.addAll(json["priceHistory"]);
    imagePath = json["imagePath"];
  }

  StockModel.fromJson(Map<String, dynamic> json){
    abbreviation = json["abbreviation"];
    name = json["name"];
    priceHistory.addAll(json["priceHistory"]);
    imagePath = json["imagePath"];
  }

  Map<String, dynamic> toMap() =>{
    'abbreviation': abbreviation,
    'name': name,
    'priceHistory': priceHistory,
    'imagePath': imagePath,
  };
}