import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:stock_api/model/price_data_model.dart';
import 'package:stock_api/model/saved_stock_model.dart';
import 'package:stock_api/model/stock_data.dart';
import 'package:stock_api/utils/api_key.dart';
import 'package:stock_api/utils/db_functions/saved_stocks_provider.dart';

class StockDataWidget extends StatelessWidget {
  final StockData company;

  StockDataWidget({required this.company});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(company.company),
      subtitle: Column(
        children: [
          Text(company.symbol),
          Text(company.type)
        ],
      ),
      // subtitle: FutureBuilder<PriceData>(
      //   future: fetchCompanyData(company.symbol),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Text(
      //         "Loading....",
      //         style: TextStyle(fontSize: 14),
      //       );
      //     } else {
      //       final data = snapshot.data;
      //       if (data != null && data.price.isNotEmpty) {
      //         return Text(data.price);
      //       } else {
      //         return Text('No data found');
      //       }
      //     }
      //   },
      // ),
      trailing: GestureDetector(
        child: Icon(Icons.add_circle_outline_outlined),
        onTap: () {
          onAddButtonClick(context);
        },
      ),
    );
  }

  Future<void> onAddButtonClick(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        content: Text("Stock added Successfully"),
      ),
    );

    try {
      final stock = SavedStockModel(
        companyName: company.company,
        companySymbol: company.symbol,
        companyType: company.type
        // id: DateTime.now().microsecondsSinceEpoch,
      );
      context.read<SavedStockProvider>().addStocks(stock);
    } catch (e) {
      print(e.runtimeType);
    }
  }

  
}
Future<PriceData> fetchCompanyData(String companyName) async {
    const globalFunction = 'GLOBAL_QUOTE';

    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);
      final apiUrl =
          'https://www.alphavantage.co/query?function=$globalFunction&symbol=$companyName&apikey=$apiKey';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Global Quote'] != null) {
          final globalQuoteData = data['Global Quote'];
          final priceData = PriceData.fromJson(globalQuoteData);
          return priceData;
        } else {
          return PriceData(price: 'No data available');
        }
      } else {
        print(
            "Failed to fetch company data. Status code: ${response.statusCode}");
        return PriceData(price: 'Error fetching company data');
      }
    } catch (e) {
      print("Error fetching company data: $e");
      return PriceData(price: 'Error fetching company data');
    }
  }
