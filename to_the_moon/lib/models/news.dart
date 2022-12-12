import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class NewsModel {
   NewsModel(this.stockName, this.companyName, this.value, this.change, this.eventType, this.headline, this.imagePath, this.time);


  String? stockName;
  String? companyName;
  double? value;
  String? change;
  String? imagePath;
  bool eventType;
  String time;

  String headline = '';
 
  getStockName(){
    return stockName;
  }

  getCompanyName(){
    return companyName;
  }

  getValue(){
    return value;
  }

  getImage(){
    return Image.asset(imagePath.toString());    
    
  }

  getHeadline(){
    return headline;
  }

   String getTime() {
    return time;
  }
}

   
