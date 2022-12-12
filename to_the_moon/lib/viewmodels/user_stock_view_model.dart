import 'package:to_the_moon/models/stock.dart';
import 'package:to_the_moon/models/User.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:collection';

class UserViewModel with ChangeNotifier {
  Future<UserModel> user = UserDatabase.instance.user();

  Future<UserModel> getUser() {
    return user;
  }

  double getAveragePaid(UserModel user, StockModel stock) {
    List<int> pricesPaid = user.stocksOwned[stock.abbreviation] as List<int>;
    int totalPaid = 0;
    for(int i = 0; i < pricesPaid.length; i++){
      totalPaid = pricesPaid[i] + totalPaid;
    }
    return totalPaid/pricesPaid.length;
  }

  sellStock(UserModel user, String name, int amount, int currentPrice, StockModel s) {
    user.removeStock(name, amount, s);
    user.addCash(currentPrice * amount);
    notifyListeners();
  }

  buyStock(UserModel user, String name, int amount, int currentPrice, StockModel s) {
    user.addStock(name, amount, currentPrice, s);
    user.removeCash(currentPrice * amount);
    notifyListeners();
  }

  dynamic stockAmount(UserModel user, String name){
    return user.getStockAmount(name);
  }

  void setAgreement(UserModel user) {
    user.setAgreement();
    notifyListeners();
  }

  int getUserId(UserModel user) {
    return user.userId;
  }

  void setUserId(UserModel user, int newId) {
    user.userId = newId;
  }

  bool acceptAgreement(UserModel user) {
    return user.acceptAgreement;
  }

  int getUserCash(UserModel user) {
    return user.cash;
  }

  void updateCash(UserModel user, int amount) {
    user.addCash(amount);
    user.addBalance(amount);
    notifyListeners();
  }

  void rewardCash(UserModel user, int amount, bool lessonStatus) {
    if (!lessonStatus) {
      updateCash(user, amount);
      
    }
  }
}

//database class
class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();
  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("users_database.db");
    instance.insertUser(new UserModel(0, 1000, false,
        new HashMap<String, List<int>>())); // new HashMap<String,int>())
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) {
    return db.execute(
        'CREATE TABLE users(userId INTEGER PRIMARY KEY, cash INTEGER, acceptAgreement TEXT, stocksOwned BLOB)' // priceHistory List, priceUP BOOLEAN)',
        );
  }
  // 'CREATE TABLE users(userId int PRIMARY KEY, cash int, acceptAgreement TEXT)'// ownedStock HashMap

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> insertUser(UserModel user) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(UserModel user) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Update the given Dog.
    await db.update(
      'users',
      user.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'userId = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [user.userId],
    );
  }

  Future<UserModel> user() async {
    // Get a reference to the database.
    final db = await instance.database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return UserModel.fromMap(maps[0]);
  }
}
