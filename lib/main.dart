import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stock_api/controller/bottom_navbar_controller.dart';
import 'package:stock_api/controller/search_data.dart';
import 'package:stock_api/model/saved_stock_model.dart';
import 'package:stock_api/utils/db_functions/saved_stocks_provider.dart';
import 'package:stock_api/view/widgets/bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(SavedStockModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationBarController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SavedStockProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeBottomNavigationBar(),
      ),
    );
  }
}
