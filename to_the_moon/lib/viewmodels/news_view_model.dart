import 'package:to_the_moon/models/news.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class NewsViewModel extends ChangeNotifier{

  List<NewsModel> Headlines = [
    // stock name, company name, stock value
    new NewsModel('Google Stock Rockets!', 'assets/images/google.png'), //1
    new NewsModel('Apple stock crashes!', 'assets/images/apple.png'), //2
    new NewsModel('Microsoft releases new product!', 'assets/images/microsoft.png'), //3
    new NewsModel('Amazon workers go on strike!',  'assets/images/amazon.png'), //4
    new NewsModel('Tesla stock rockets to the moon!',  'assets/images/tesla.png'),//5,
    new NewsModel('Johnson and Johnson releases new product!',  'assets/images/johnson.png'), //6
    new NewsModel('JP Morgan has new VP!',   'assets/images/jpmorgan.png'), //7
    new NewsModel('META has new lawsuit!', 'assets/images/meta.png'), //8
    new NewsModel('Pfizer releases another does of vaccine!',  'assets/images/pfizer.png'), //9
    new NewsModel('Nike releases new Product!',  'assets/images/nike.png'), //10


  ];

 
 getHeadlines(){
  return Headlines;
 }
  

  
}