import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_api/model/saved_stock_model.dart';

class SavedStockProvider extends ChangeNotifier {
  List<SavedStockModel> stockList = [];

  Future<void> addStocks(SavedStockModel value) async {
    if (!stockList.contains(value)) {
      final stocksDB = await Hive.openBox<SavedStockModel>('stocks_db');
      final id = await stocksDB.add(value);
      value.id = id;
      stockList.add(value);
      notifyListeners();
    }
  }

  Future<void> getAllStocks() async {
    final stocksDB = await Hive.openBox<SavedStockModel>('stocks_db');
    stockList.clear();
    notifyListeners();
    stockList.addAll(stocksDB.values);
  }

  Future<void> deleteStock(int id) async {
    final stocksDB = await Hive.openBox<SavedStockModel>('stocks_db');
    await stocksDB.deleteAt(id);
    getAllStocks();
  }
}
