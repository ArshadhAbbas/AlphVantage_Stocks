
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_api/controller/search_data.dart';

import 'package:stock_api/model/stock_data.dart';
import 'package:stock_api/utils/api_key.dart';
import 'package:stock_api/view/widgets/stock_data.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? _debounce;
  String searchText = '';
  bool isLoading = false;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchdataProvider = Provider.of<SearchDataProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Home screen")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 231, 231, 231),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search for stocks',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        if (_debounce != null) {
                          _debounce!.cancel();
                        }
                        _debounce = Timer(
                          const Duration(milliseconds: 500),
                          () {
                            fetchSearchResults(value);
                            searchText = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (isLoading)
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                width: double.infinity,
                                height: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                width: MediaQuery.of(context).size.width / 2,
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              else if (searchText.isEmpty)
                Text("Search for companies")
              else if (searchdataProvider.searchData.isEmpty)
                Center(child: Text("No data found"))
              else
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: searchdataProvider.searchData.length,
                    itemBuilder: (context, index) {
                      final company = searchdataProvider.searchData[index];
                      return StockDataWidget(company: company);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchSearchResults(String keyword) async {
    setState(() {
      isLoading = true;
    });

    const function = 'SYMBOL_SEARCH';
    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);
      final apiUrl =
          'https://dev.portal.tradebrains.in/api/search?keyword=Reliance';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null) {
          final matches = List<Map<String, dynamic>>.from(data);
          final stockData =
              matches.map((match) => StockData.fromJson(match)).toList();
          Provider.of<SearchDataProvider>(context, listen: false)
              .changeSearchData(stockData);
        }
         else {
          Provider.of<SearchDataProvider>(context, listen: false)
              .removeSearchData();
        }
      } 
      else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

    
}

