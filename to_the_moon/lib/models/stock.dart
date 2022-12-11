import 'package:flutter/material.dart';
class StockModel {

  StockModel(this.abbreviation, this.name, this.priceHistory, this.priceUP, this.imagePath);
  int numOwned = 0;
  String? abbreviation = "Test";
  String? name = "Test";
  String? imagePath = "Test";
  List<int> priceHistory = [
    100,
    101,
    102,
    103,
  ];
  bool priceUP = true;

  getNumOwned(){
      return numOwned;
  }

  increaseNumOwned(int increase){
    numOwned += increase;
  }

  decreaseNumOwned(int decrease){
    numOwned -= decrease;
  }
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

  bool getPriceUp(){
    return priceUP;
  }

  double gain() {
    return (priceHistory.elementAt(priceHistory.length-1) - priceHistory.elementAt(priceHistory.length-2))/priceHistory.elementAt(priceHistory.length-1)*100;
  }

  int getCurrentPrice(){
    return priceHistory.elementAt(priceHistory.length-1);
  }

  void updateValue(int newPrice){
    priceHistory.add(newPrice);
  }

  void setPriceUP(bool up){
    priceUP = up;
  }

  StockModel.fromMap(Map<String, dynamic> json){
    abbreviation = json["abbreviation"];
    name = json["name"];
    if(json["priceUP"] == "1"){
      priceUP = true;
    }else{
      priceUP = false;
    }
    priceHistory = json["priceHistory"];
    imagePath = json["imagePath"];
  }

  StockModel.fromJson(Map<String, dynamic> json){
    abbreviation = json["abbreviation"];
    name = json["name"];
    priceHistory = json['priceHistory'];
    priceUP = json["priceUP"];
    imagePath = json["imagePath"];
  }

  Map<String, dynamic> toMap() =>{
    'abbreviation': abbreviation,
    'name': name,
    'priceHistory': priceHistory,
    'priceUP': priceUP,
    'imagePath': imagePath,
  };
}