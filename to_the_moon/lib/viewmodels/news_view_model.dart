import 'package:to_the_moon/models/news.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class NewsViewModel extends ChangeNotifier{

  List<NewsModel> Headlines = [
    // stock name, company name, stock value
    new NewsModel('GOOG', 'Google inc.', 123.25, 1.26, 'assets/images/google.png'), //1
    new NewsModel('APPL', 'Apple inc.', 268.20, -8.23, 'assets/images/apple.png'), //2
    new NewsModel('MSFT', 'Micrsoft inc.', 343.20, 2.35, 'assets/images/microsoft.png'), //3
    new NewsModel('AMZN', 'Amazon inc.', 421.32, 1.98, 'assets/images/amazon.png'), //4
    new NewsModel('TSLA', 'Tesla Inc', 336.21, -4.12, 'assets/images/tesla.png'),//5,
    new NewsModel('JNJ', 'Johnson & Johnson', 79.56, 3.11, 'assets/images/johnson.png'), //6
    new NewsModel('JPM', 'JP Morgan Chase & Co.', 131.59, 0.22, 'assets/images/jpmorgan.png'), //7
    new NewsModel('META', 'Meta Platforms Inc.', 114.12,-8.31, 'assets/images/meta.png'), //8
    new NewsModel('PFE', 'Pfizer Inc.', 49.71, 1.02, 'assets/images/pfizer.png'), //9
    new NewsModel('NKE', 'Nike inc.', 107.93, -1.69, 'assets/images/nike.png'), //10


  ];

 
 getHeadlines(){
  return Headlines;
 }
  

  
}