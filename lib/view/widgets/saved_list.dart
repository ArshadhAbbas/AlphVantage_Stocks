import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_api/model/price_data_model.dart';
import 'package:stock_api/utils/db_functions/saved_stocks_provider.dart';
import 'package:stock_api/view/widgets/stock_data.dart';

class ListStocks extends StatelessWidget {
  const ListStocks({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SavedStockProvider>(context).getAllStocks();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Consumer<SavedStockProvider>(
        builder: (ctx, stockProvider, Widget? child) {
          return stockProvider.stockList.isEmpty
              ? const Center(
                  child: Text("No Stocks details"),
                )
              : ListView.separated(
                  itemBuilder: ((context, index) {
                    final data = stockProvider.stockList[index];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListTile(
                        title: Text(data.companyName),
                        subtitle: Column(
                          children: [
                            Text(data.companySymbol),
                            Text(data.companyType)
                          ],
                        ),

                        // subtitle: FutureBuilder<PriceData>(
                        //   future: fetchCompanyData(data.companySymbol),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState == ConnectionState.waiting) {
                        //       return Text("Loading...");
                        //     } else if (snapshot.hasData) {
                        //       final priceData = snapshot.data!;
                        //       return Text(priceData.price);
                        //     } else {
                        //       return Text("Price not available");
                        //     }
                        //   },
                        // ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: AlertDialog(
                                    title: const Text(
                                      'Delete?',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    content: const Text(
                                      "Do you want to delete this stock",
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Provider.of<SavedStockProvider>(
                                            context,
                                            listen: false,
                                          ).deleteStock(index);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          tooltip: 'Delete',
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return const Divider();
                  }),
                  itemCount: stockProvider.stockList.length,
                );
        },
      ),
    );
  }
}
