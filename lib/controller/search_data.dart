import 'package:flutter/material.dart';
import 'package:stock_api/model/stock_data.dart';

class SearchDataProvider extends ChangeNotifier {
  List<StockData> searchData = [];

  void changeSearchData(List<StockData> stockData) {
    searchData = stockData;
    notifyListeners();
  }

  void removeSearchData() {
    searchData = [];
    notifyListeners();
  }
}
