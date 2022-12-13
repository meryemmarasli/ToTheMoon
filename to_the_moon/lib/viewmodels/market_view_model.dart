import 'dart:async';
import 'dart:math';

import 'package:to_the_moon/models/stock.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:flutter/material.dart';
import 'package:to_the_moon/models/User.dart';
import '../models/news.dart';
import  'package:intl/intl.dart';

class StockViewModel with ChangeNotifier {
  Future<List<StockModel>> stocks = StockDatabase.instance.stocks();

  Future<List<StockModel>> getStock() {
    return stocks;
  }

  Timer? timer;
  int marketUpdateSeconds = 15;
  bool needsScrollBool = true;

  StockViewModel() {
    timer = Timer.periodic(
        Duration(seconds: marketUpdateSeconds), (Timer t) => updateMarket());
  }

  NewsModel generatedHeadlineData = NewsModel("NULL", "NULL", 0.0, "0.0", false, "NULL", "NULL", "Null");

  double getOwnedStockGain(UserModel user, StockModel stock) {
    List<int> pricesPaid = user.stocksOwned[stock.abbreviation] as List<int>;
    int totalPaid = 0;
    for (int i = 0; i < pricesPaid.length; i++) {
      totalPaid = pricesPaid[i] + totalPaid;
    }
    return ((stock.getCurrentPrice() * pricesPaid.length - totalPaid) /
            totalPaid) *
        100;
  }

  double getOwnedTotalAssets(UserModel user) {
    double balance = user.getCash().toDouble();
    List<StockModel> stocks = user.getStocks();
    for (int i = 0; i < stocks.length; i++) {
      balance = balance +
          (stocks[i].getCurrentPrice().toDouble() *
              user.getStockAmount(stocks[i].getAbbreviation().toString()));
    }
    return balance;
  }

  double getOwnedInvestedCapital(UserModel user) {
    double balance = 0;
    List<StockModel> stocks = user.getStocks();
    for (int i = 0; i < stocks.length; i++) {
      balance = balance +
          (stocks[i].getCurrentPrice().toDouble() *
              user.getStockAmount(stocks[i].getAbbreviation().toString()));
    }
    return balance;
  }

  double getOwnedGain(UserModel user) {
    double totalInvested = 0;
    double totalCurrentValue = 0;
    List<StockModel> stocks = user.getStocks();
    for (int i = 0; i < stocks.length; i++) {
      if (0 <= getOwnedStockGain(user, stocks[i])) {
        List<int> ownedStock =
            user.getStocksOwned()[stocks[i].getAbbreviation()] as List<int>;
        for (int j = 0; j < ownedStock.length; j++) {
          totalInvested = totalInvested + ownedStock[j];
        }
        totalCurrentValue = totalCurrentValue +
            stocks[i].getCurrentPrice().toDouble() * ownedStock.length;
      }
    }
    double gain = ((totalCurrentValue - totalInvested) / totalInvested) * 100;
    if (gain.isInfinite || gain.isNaN) {
      return 0.0;
    } else {
      return gain;
    }
  }

  double getOwnedLoss(UserModel user) {
    double totalInvested = 0;
    double totalCurrentValue = 0;
    List<StockModel> stocks = user.getStocks();
    for (int i = 0; i < stocks.length; i++) {
      List<int> ownedStock =
          user.getStocksOwned()[stocks[i].getAbbreviation()] as List<int>;

      if (0 > getOwnedStockGain(user, stocks[i])) {
        for (int j = 0; j < ownedStock.length; j++) {
          totalInvested = totalInvested + ownedStock[j];
        }

        totalCurrentValue = totalCurrentValue +
            stocks[i].getCurrentPrice().toDouble() * ownedStock.length;
      }
    }
    double loss =
        ((totalCurrentValue - totalInvested) / totalCurrentValue) * 100;
    if (loss.isInfinite || loss.isNaN) {
      return 0.0;
    } else {
      return loss;
    }
  }

  Future<List<StockModel>> getStocks() async {
    return await stocks;
  }

  bool needsScroll() {
    bool ret = needsScrollBool;
    needsScrollBool = false;
    return ret;
  }

  updateMarket() async {
    List<StockModel> stockList = await getStock();
    var rng = Random();
    int headlineSelection = -1;
    if (stockList.length > 0) {
      headlineSelection = rng.nextInt(stockList.length - 1);
    }

    bool eventType = false;
    for (int i = 0; i < stockList.length; i++) {
      if (i == headlineSelection) {
        // negative event
        if (rng.nextInt(2) == 0) {
          int amount = -20 + rng.nextInt(10);
          updateStock(
              stockList[i], (stockList[i].getCurrentPrice() + (amount)));
          eventType = false;
        }
        // positive event
        else {
          updateStock(stockList[i],
              (stockList[i].getCurrentPrice() + (rng.nextInt(100))));
          eventType = true;
        }
        generatedHeadlineData = NewsModel(stockList[i].getAbbreviation(), stockList[i].getName(), stockList[i].getCurrentPrice().toDouble(), getPercentage(stockList[i]), eventType, "NULL", stockList[i].imagePath, DateFormat("hh:mm:ss a").format(DateTime.now()));
      }else{
        updateStock(stockList[i], (stockList[i].getCurrentPrice() + (-5 + rng.nextInt(12))));

      }
    }
    needsScrollBool = true;
    notifyListeners();
  }

  String getPercentage(StockModel stock) {
    String fullPercentage = stock.gain().toString();
    String buffer = '';
    if (fullPercentage.length == 0) {
      return '0.0%';
    } else {
      for (int i = 0; i < fullPercentage.length; i++) {
        if (fullPercentage[i] == '.') {
          buffer = buffer + fullPercentage[i];
          if (i + 1 < fullPercentage.length) {
            buffer = buffer + fullPercentage[i + 1];
          }
          if (i + 2 < fullPercentage.length && buffer.length < 4) {
            buffer = buffer + fullPercentage[i + 2];
          }
          return buffer + "%";
        } else {
          buffer = buffer + fullPercentage[i];
        }
      }
      return buffer + "%";
    }
  }

  NewsModel getGeneratedHeadlineData() {
    return generatedHeadlineData;
  }

  updateStock(StockModel stock, int newPrice) {
    if (newPrice < 1) {
      newPrice = 1;
    }
    stock.updateValue(newPrice);
    StockDatabase.instance.updateStock(stock);
    notifyListeners();
  }

  double getStockGain(StockModel stock) {
    return stock.gain();
  }

  int getStockPrice(StockModel stock) {
    return stock.getCurrentPrice();
  }

  String? getStockAbbreviation(StockModel stock) {
    return stock.getAbbreviation();
  }

  String? getStockName(StockModel stock) {
    return stock.getName();
  }
}

//database class
class StockDatabase {
  static final StockDatabase instance = StockDatabase._init();
  static Database? _database;

  StockDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("stock_database.db");
    instance.insertStock(StockModel(
        "GOOG",
        'Google inc.',
        [
          100,
          101,
          102,
          103,
        ],
        'assets/images/google.png'));
    instance.insertStock(StockModel(
        "APPL",
        'Apple inc.',
        [
          203,
          202,
          201,
          200,
        ],
        'assets/images/apple.png'));
    instance.insertStock(StockModel(
        "MSFT",
        'Micrsoft inc.',
        [
          300,
          301,
          302,
          303,
        ],
        'assets/images/microsoft.png'));
    instance.insertStock(StockModel(
        "AMZN",
        'Amazon inc.',
        [
          300,
          301,
          302,
          303,
        ],
        'assets/images/amazon.png'));
    instance.insertStock(StockModel(
        "TSLA",
        'Tesla Inc',
        [
          300,
          301,
          302,
          303,
        ],
        'assets/images/tesla.png'));
    instance.insertStock(StockModel(
        "JNJ",
        'Johnson & Johnson',
        [
          300,
          301,
          302,
          303,
        ],
        'assets/images/johnson.png'));
    instance.insertStock(StockModel(
        "JPM",
        'JP Morgan Chase',
        [
          300,
          301,
          302,
          303,
        ],
        'assets/images/jpmorgan.png'));
    instance.insertStock(StockModel(
        "META",
        'Meta Platforms Inc.',
        [
          300,
          301,
          302,
          303,
        ],
        'assets/images/meta.png'));
    instance.insertStock(StockModel(
        "PFE",
        'Pfizer Inc.',
        [
          300,
          301,
          302,
          303,
        ],
        'assets/images/pfizer.png'));
    instance.insertStock(StockModel(
        "NKE",
        'Nike inc.',
        [
          300,
          301,
          302,
          303,
        ],
        'assets/images/nike.png'));

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) {
    return db.execute(
        'CREATE TABLE stocks(abbreviation TEXT PRIMARY KEY, name TEXT, priceHistory LIST, imagePath TEXT)');
  }

  Future close() async {
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
      where: 'abbreviation = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [stock.abbreviation],
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
