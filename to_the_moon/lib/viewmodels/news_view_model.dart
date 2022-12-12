import 'dart:math';

import 'package:to_the_moon/models/news.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class NewsViewModel extends ChangeNotifier{

  List<NewsModel> Headlines = [
    //    NewsModel(this.stockName, this.companyName, this.value, this.change, this.eventType, this.imagePath);
    new NewsModel('GOOG', 'Google inc.', 100, "-8.23%", false, "Investors are worried about Google inc. potential returns as it's share value drops to 100.", 'assets/images/google.png'), //1
    new NewsModel('AMZN', 'Amazon inc.', 100, "2.35", true, "This holiday Amazon inc. has seen more customers making it's share value skyrocket to 120.", 'assets/images/amazon.png'), //1
    new NewsModel('TSLA', 'Tesla Inc', 100, "1.98%", true, "Good news for Tesla Inc it's latest product is a craze with it's stock reaching a share value of 200.", 'assets/images/tesla.png'), //1
    new NewsModel('JNJ', 'Johnson & Johnson', 100, "4.12%", true, "Recent product announcements by Johnson & Johnson has hyped up investors making it's share value reaches 200.", 'assets/images/johnson.png'), //1
    new NewsModel('JPM', 'JP Morgan Chase & Co.', 100, "-1.69%", false, "Investors are worried about JP Morgan Chase & Co. potential returns as it's share value drops to 120.", 'assets/images/jpmorgan.png'), //1
  ];
 getHeadlines(){
  return Headlines;
 }

  void addHeadline(NewsModel generatedHeadlineData) {
   if(generatedHeadlineData.companyName == "NULL" || Headlines.contains(generatedHeadlineData)){
     return;
   }

   var rng = Random();
   int headline = rng.nextInt(4);
   print(generatedHeadlineData);
   if(generatedHeadlineData.eventType){
     switch(headline) {
       case 0: {  generatedHeadlineData.headline = "Recent advancements in space mining has seen " + generatedHeadlineData.getCompanyName() + " share value skyrockets to " + generatedHeadlineData.value.toString() + ".";}
       break;

       case 1: {  generatedHeadlineData.headline = "Investors see strong returns from " + generatedHeadlineData.getCompanyName() + " as it's stock share value reaches " + generatedHeadlineData.value.toString() + "."; }
       break;

       case 2: {  generatedHeadlineData.headline = "Recent product announcements by " + generatedHeadlineData.getCompanyName() + " has hyped up investors making it's share value reaches " + generatedHeadlineData.value.toString() + "."; }
       break;

       case 3: {  generatedHeadlineData.headline = "This holiday " + generatedHeadlineData.getCompanyName() + " has seen more customers making it's share value skyrocket to " + generatedHeadlineData.value.toString() + "."; }
       break;

       case 4: {  generatedHeadlineData.headline = "Good news for " + generatedHeadlineData.getCompanyName() + " it's latest product is a craze with it's stock reaching a share value of " + generatedHeadlineData.value.toString() + "."; }
       break;

       default: { print("Invalid choice"); }
       break;
     }
   }else{
     switch(headline) {
       case 0: {  generatedHeadlineData.headline = "Investors are worried about " + generatedHeadlineData.getCompanyName() + " potential returns as it's share value drops to " + generatedHeadlineData.value.toString() + ".";}
       break;

       case 1: {  generatedHeadlineData.headline = "Regulators are investing a scandal of " + generatedHeadlineData.getCompanyName() + " as it's share value plummets to " + generatedHeadlineData.value.toString() + "."; }
       break;

       case 2: {  generatedHeadlineData.headline = "A tropical storm has disrupted " + generatedHeadlineData.getCompanyName() + " shipments making investors panic as it's share value drops to " + generatedHeadlineData.value.toString() + "."; }
       break;

       case 3: {  generatedHeadlineData.headline = "As gas prices skyrocket  " + generatedHeadlineData.getCompanyName() + " has to cut back operations making investors panic as it's share value drops to " + generatedHeadlineData.value.toString() + "."; }
       break;

       case 4: {  generatedHeadlineData.headline = "Investors of " + generatedHeadlineData.getCompanyName() + " have panicked as it's latest product is a flop dropping it's share value to " + generatedHeadlineData.value.toString() + "."; }
       break;

       default: { print("Invalid choice"); }
       break;
     }
   }
   Headlines.add(generatedHeadlineData);

   if(Headlines.length > 10){
     Headlines.removeAt(0);
   }
  }
}