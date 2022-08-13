import 'package:flutter/material.dart';

class HomeManager extends ChangeNotifier {
  var currentItem = '/';

  void showItem(String itemName) {
    currentItem = itemName;
    notifyListeners();
  }
}
