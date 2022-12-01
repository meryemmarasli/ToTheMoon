import 'package:to_the_moon/models/lesson.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;


import 'package:flutter/material.dart';





class LessonViewModel with ChangeNotifier{
  Future<List<LessonModel>> Lessons = LessonDatabase.instance.lessons();

   Future<List<LessonModel>> getLessons(){
      return Lessons;
   } 


   


   updateLesson(LessonModel lesson){
    lesson.updateComplete();
    LessonDatabase.instance.updateLesson(lesson);
    notifyListeners();
   }



}

class LessonDatabase{

  static final LessonDatabase instance = LessonDatabase._init();
  static Database? _database;

  LessonDatabase._init();


Future<Database> get database async{
  if(_database != null) return _database!;

  _database = await _initDB("lesson_database.db");
    //lesson: title, subtitle, image, cashvalue, complete, content
   instance.insertLesson(new LessonModel("Lesson 1!", "What is the Stock Market?", 'assets/images/lesson1.webp', false, "In order to truly understand the stock market, we need to break it down to stocks. Stocks represent a small ownership of a company. So, when you buy stocks in a company, you are buying part of that company. A share is a unit of stock. The more shares you buy, the more stock you have in a company. Companies give out stocks to have more investments or money in their company to grow their business. The stock market is a network of these buying and selling into companies. The stock market also operates on the same hours of stores. It is open on weekdays from 9 a.m. to 4 p.m. So, only between these hours are traders and investors allowed to buy and/or sell stock. Investing in the stock market helps grow your money. As time goes on, your money loses worth, so the stock market provides a way for you to prevent your money from losing its value. Once you understand how the stock market, you will be able to grow your money and increase your financial literacy. Just like any other investment, there are risks to investing in the stock market, so it is important to be educated before you get involved. ", 10 ));
   instance.insertLesson(new LessonModel("Lesson 2!","What is a Dividend?",'assets/images/lesson2.webp',false, "A dividend is the distribution of a company's earnings to its shareholders. The amount of the dividend is determined by the company's board of directors. So for instance, you buy a stock that has a dividend. Every quarter the board of directors for that company's stock determine how much money they want to give to each share holder. It is essentially the company giving a gift thanking you for investing investing in them. Dividends are often distributed quarterly and may be paid out as cash or in the form of reinvestment in additional stock. Some sectors that generally have dividend paying companies are: Basic Materials, Oil and gas, Banks and financial, Healthcare and pharmaceuticals, and utilities. Dividens are a very powerful form of investings. Once some master the art of dividend investing, they are able to create a years worth of income with just stocks.", 10));
   instance.insertLesson(new LessonModel("Lesson 3!","Different Types of Stocks",'assets/images/lesson3.png',false, "The two main types of stock are: common stock and preferred stock. When most people talk about stocks, they are mostly reffering to the common stock. Most stock are in the form of common stock. The common stock is essentially a common share that represents ownership in a company and a claim on a portion of profits. Over long term, the common stock, yields higher retunrs than almost any other investment.  The preffered stock represents some degree of ownership in a company but does not come with the same voting rights. withe preferred shares investors are guaranteed a fixed divident forever. This is different from common stock, which does not guarnatee dividends. There are many other different types of stocks but these are the most important and relevant ones to new investors.  ", 10));
   instance.insertLesson(new LessonModel("Lesson 4!", "The Golden Rule: Sell High, Buy Low ",'assets/images/lesson4.png', false, "The Golden Rule of trading is to Sell High, Buy Low! This means to make sure to sell your stocks at high points in the market and to buy them at low points. The stock market is a waiting game. You need to always stay updated about the recents changes in each stock in order to truly get the most out of your investments. When the stock market is low, buy more stocks. When the stock market is high, sell your stocks. Remember if you did not sell your stocks on a high just wait for the next one. The stock market will crash and come back again like it has many times before. Just be patient!  ", 10));
   instance.insertLesson(new LessonModel("Lesson 5!", "What are Index funds?",'assets/images/lesson5.png', false, "An index fund is a set of stocks grouped together that are bought and sold together. Index funds are very important to investings. They are very low risk and guaranteed to grow, but they grow very slowly. So, the best way to invest in index funds are to invest in a certain amount of them every month. Then, after a few years, your money will most likely have grown. Index funds can represent differnet industries such as the tech industry, health industry, and car industry. Some index funds can even be a collection of stocks from international companies. The most notable index fund stock would be the S&P 500, which we will learn about in the next lesson.", 10));
   instance.insertLesson(new LessonModel("Lesson 6!", "S&P 500",'assets/images/lesson6.png', false, "The S&P 500 or the Standard & Poor's 500 index is an index that represents to top 500 leading publicly trading companies in the U.S. The S&P 500 was launched in 1957 by the credit rating agency Standard and Poor's. Because of its depth and diversity, the S&P 500 is widely considered one of the best gauges of large U.S. stocks and even the entire equities market. Now, you can not invest directly into the S&P 500, but you can invest into one of the many funds taht useit as a benchmark. For instance, different investing platforms will have different index funds that represent the S&P 500. Now why is the S&P 500 important? Historically speaking, that after every market crash, the S&P 500 always ended up growing. Even if it went down for a bit, it always found a way to get back up again. This makes the S&P 500 a very safe investment option, so having it in your investment portfolio is a very good investing method. ", 10));
   instance.insertLesson(new LessonModel("Lesson 7!", "Long Term Investing vs Day trading",'assets/images/lesson7.png', false, "Now, there are different kinds of investing. Long Term Investing and Day Trading. Day trading are stocks that you buy in a day and sell within several days. Generally, when most people day trade with unstable stocks that have the potential to change value within a small amoutn of time. Long term investments are when you buy stocks and keep your money in it for several years. Generally, those who invest in long term stocks are investing in index funds like the S&P 500 to save for retirement purposes.", 10));
   instance.insertLesson(new LessonModel("Lesson 8!", "Diversifying your portfolio ",'assets/images/lesson8.png', false, "Diversifiying your portfolio is very important. You want to have many different kinds of stocks from different industries. Why? If an industry is struggling, the value of its stocks are going to to go down. But, if you have stocks in many different industries, you're losses will not be as much because generally as one industry fails another is thriving. Furthermore, you want to invest in different stocks within the same industry because there may be companies that do better. Lastly, you want to invest in a variety of stocks and index funds. This is because index funds are safe. They are almost guaranteed to always do well. If you loose money in individual stocks but have index funds, the money you invested will most likely still be alright. ", 10));
   instance.insertLesson(new LessonModel("Lesson 9!", "Different Investing Platforms ", 'assets/images/lesson9.png',false,  "There so many different investing platforms and there are pros and cons to each. Some of them are Fidelity Investments,and Ameritrade. Fidelity brings full-service experience to both its institutional and retail clients and sophisticated tools presented through a simple workflow, all at a low price. Some pros of fidelity investments are commiting to eliminate common account fees, strong portfolio analysis and account features, excellent order execution,  adn direct indexing. Some cons of Fidelity Investments are that there are higher broker-assisted trade fees, minimum balance for some index trading, no access for non-U.S. and citizens. Ameritrade is an intuitive platform with comprehensive educational offering, and outstanding mobile options. Some pros for Ameritrade are that there are wide range of product offerings, great educational content, and  top-notch trading tech. Some cons of ameritrade are that the account fees are relatively high, does not offer fractional shares, and must opt in for automatic cash sweep. ", 10));
   instance.insertLesson(new LessonModel("Lesson 10!", "Trends to Look Out for ",'assets/images/lesson10.webp', false, "Understanding stock market trends is an acquired skill. Long time investors are able to know whats going to happen in the stock market next based on trends in the market. So, knowing what to look out for, is a very powerful skill in investing. Reading different news articles, reading quarter reports, learning about company policies are all good information to know when investing. The more and more you invest the better you will be at knowing what trends to look out for. ", 10));


  return _database!;
}
Future<Database> _initDB(String filePath) async{
  final dbPath = await getDatabasesPath();
  final  path = join(dbPath, filePath);

  return await openDatabase(path, version: 1, onCreate: _createDB);
}

Future _createDB(Database db, int version){
 
  return db.execute(
          'CREATE TABLE lessons(title TEXT PRIMARY KEY, description TEXT, image TEXT, complete TEXT, content TEXT, cash INTEGER )'//, description TEXT, content TEXT, complete BOOLEAN, image TEXT)',
        );

  
  

}

Future close() async{
  final db = await instance.database;
  db.close();
}


 Future<void> insertLesson(LessonModel lesson) async {
      // Get a reference to the database.
      final db = await instance.database;
      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'lessons',
        lesson.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

     Future<void> updateLesson(LessonModel lesson) async {
      // Get a reference to the database.
      final db = await instance.database;

      // Update the given Dog.
      await db.update(
        'lessons',
        lesson.toMap(),
        // Ensure that the Dog has a matching id.
        where: 'title = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [lesson.title],
      );

      
    }

    Future<List<LessonModel>> lessons() async {
      // Get a reference to the database.
      final db = await instance.database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('lessons');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return LessonModel.fromMap(maps[i]);
      });
    }



    
} 

