import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class NewsModel {
   NewsModel(this.headline, this.imagePath);


  String? headline;
  String? imagePath;


 
  getHeadline(){
    return headline;
  }


  
  
  getImage(){
    return Image.asset(imagePath.toString());    
    
  }

  
 

  
}

   
