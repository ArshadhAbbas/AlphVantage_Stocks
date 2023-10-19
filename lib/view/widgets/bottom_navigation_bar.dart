import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_api/view/screens/watchlist_screen.dart';
import 'package:stock_api/view/screens/home_screen.dart';

import '../../controller/bottom_navbar_controller.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  HomeBottomNavigationBar({super.key});
  final List<Widget> widgetOptions = [
    SearchScreen(),
    const ListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int selectedIndex =
        Provider.of<BottomNavigationBarController>(context).selectedIndex;
    return Scaffold(
      body: widgetOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list_outlined), label: "watchlist")
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.black,
        onTap: Provider.of<BottomNavigationBarController>(context).onItemTapped,
      ),
    );
  }
}
