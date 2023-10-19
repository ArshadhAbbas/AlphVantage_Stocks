import 'package:flutter/material.dart';
import 'package:stock_api/view/widgets/saved_list.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WatchList"),
        ),
        body: SingleChildScrollView(child: ListStocks()));
  }
}
