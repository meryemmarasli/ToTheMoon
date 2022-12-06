import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class NewsModel {
   NewsModel(this.stockName, this.companyName, this.value, this.change, this.imagePath);


  String? stockName;
  String? companyName;
  double? value;
  double? change;
  String? imagePath;


 
  getStockName(){
    return stockName;
  }

  getCompanyName(){
    return companyName;
  }

  getValue(){
    return value;
  }

  getChange(){
    if(change! >= 0){
      return Text("+${change.toString()}%", style: TextStyle(color: Colors.green));
      
    }else{
      return Text("${change.toString()}%", style: TextStyle(color: Colors.red));
      
    }
  }

  getImage(){
    return Image.asset(imagePath.toString());    
    
  }

  
 

  
}

   
