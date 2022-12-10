import 'package:to_the_moon/models/stock.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;


import 'package:flutter/material.dart';





class StockViewModel with ChangeNotifier{
  Future<List<StockModel>> stocks = StockDatabase.instance.stocks();

  Future<List<StockModel>> getStock(){
    return stocks;
  }

  updateStock(StockModel stock, int newPrice){
    stock.updateValue(newPrice);
    if(newPrice > stock.priceHistory.elementAt(stock.priceHistory.length-1)){
      stock.setPriceUP(true);
    }else{
      stock.setPriceUP(false);
    }
    StockDatabase.instance.updateStock(stock);
    notifyListeners();
  }

  double getStockGain(StockModel stock){
    return stock.gain();
  }

  int getStockPrice(StockModel stock){
    return stock.getCurrentPrice();
  }

  String? getStockName(StockModel stock){
    return stock.getName();
  }

}

//database class
class StockDatabase{

  static final StockDatabase instance = StockDatabase._init();
  static Database? _database;

  StockDatabase._init();


  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB("stock_database.db");
    instance.insertStock(new StockModel("S&P", [100, 101, 102, 103,], true));
    instance.insertStock(new StockModel("GOOG", [203, 202, 201, 200,], false));
    instance.insertStock(new StockModel("AAPL", [300, 301, 302, 303,], true));

    return _database!;
  }
  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final  path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version){

    return db.execute(
        'CREATE TABLE stocks(name TEXT PRIMARY KEY, priceHistory LIST, priceUP TEXT)'// priceHistory List, priceUP BOOLEAN)',
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }


  Future<void> insertStock(StockModel stock) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'stocks',
      stock.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateStock(StockModel stock) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Update the given Dog.
    await db.update(
      'stocks',
      stock.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'name = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [stock.name],
    );
  }

  Future<List<StockModel>> stocks() async {
    // Get a reference to the database.
    final db = await instance.database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('stocks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return StockModel.fromMap(maps[i]);
    });
  }
}