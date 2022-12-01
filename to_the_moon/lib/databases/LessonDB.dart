//database class
import 'package:to_the_moon/models/lesson.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class LessonDatabase{

  static final LessonDatabase instance = LessonDatabase._init();
  static Database? _database;

  LessonDatabase._init();


Future<Database> get database async{
  if(_database != null) return _database!;

  _database = await _initDB("lesson_database.db");
   instance.insertLesson(new LessonModel("Lesson 1", "What is the Stock Market?", 'assets/lesson1.png', false, "In order to truly understand the stock market, we need to break it down to stocks. Stocks represent a small ownership of a company. So, when you buy stocks in a company, you are buying part of that company. A share is a unit of stock. The more shares you buy, the more stock you have in a company. Companies give out stocks to have more investments or money in their company to grow their business. The stock market is a network of these buying and selling into companies. The stock market also operates on the same hours of stores. It is open on weekdays from 9 a.m. to 4 p.m. So, only between these hours are traders and investors allowed to buy and/or sell stock. Investing in the stock market helps grow your money. As time goes on, your money loses worth, so the stock market provides a way for you to prevent your money from losing its value. Once you understand how the stock market, you will be able to grow your money and increase your financial literacy. Just like any other investment, there are risks to investing in the stock market, so it is important to be educated before you get involved. " ));
   instance.insertLesson(new LessonModel("Lesson 2!","Different Kinds of Stocks",'assets/lesson1.png',false, " In order to truly understand the stock market, we need to break it down to stocks. Stocks represent a small ownership of a company. So, when you buy stocks in a company, you are buying part of that company. A share is a unit of stock. The more shares you buy, the more stock you have in a company. Companies give out stocks to have more investments or money in their company to grow their business. The stock market is a network of these buying and selling into companies. The stock market also operates on the same hours of stores. It is open on weekdays from 9 a.m. to 4 p.m. So, only between these hours are traders and investors allowed to buy and/or sell stock. Investing in the stock market helps grow your money. As time goes on, your money loses worth, so the stock market provides a way for you to prevent your money from losing its value. Once you understand how the stock market, you will be able to grow your money and increase your financial literacy. Just like any other investment, there are risks to investing in the stock market, so it is important to be educated before you get involved. "));
   instance.insertLesson(new LessonModel("Lesson 3!", "Different Investing Platforms ",'assets/lesson1.png', false, " In order to truly understand the stock market, we need to break it down to stocks. Stocks represent a small ownership of a company. So, when you buy stocks in a company, you are buying part of that company. A share is a unit of stock. The more shares you buy, the more stock you have in a company. Companies give out stocks to have more investments or money in their company to grow their business. The stock market is a network of these buying and selling into companies. The stock market also operates on the same hours of stores. It is open on weekdays from 9 a.m. to 4 p.m. So, only between these hours are traders and investors allowed to buy and/or sell stock. Investing in the stock market helps grow your money. As time goes on, your money loses worth, so the stock market provides a way for you to prevent your money from losing its value. Once you understand how the stock market, you will be able to grow your money and increase your financial literacy. Just like any other investment, there are risks to investing in the stock market, so it is important to be educated before you get involved. "));


  return _database!;
}
Future<Database> _initDB(String filePath) async{
  final dbPath = await getDatabasesPath();
  final  path = join(dbPath, filePath);

  return await openDatabase(path, version: 1, onCreate: _createDB);
}

Future _createDB(Database db, int version){
 
  return db.execute(
          'CREATE TABLE lessons(title TEXT PRIMARY KEY, description TEXT, image TEXT, complete TEXT, content TEXT )'//, description TEXT, content TEXT, complete BOOLEAN, image TEXT)',
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