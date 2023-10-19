
import 'package:flutter/material.dart';

class BottomNavigationBarController extends ChangeNotifier {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}