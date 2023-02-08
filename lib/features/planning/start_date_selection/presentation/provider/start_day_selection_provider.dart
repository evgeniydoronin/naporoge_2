import 'package:flutter/material.dart';

class StartDaySelectionProvider with ChangeNotifier {
  String? daysPeriod;
  String? get getDaysPeriod => daysPeriod;
  void changeDaysPeriod(String newString) {
    daysPeriod = newString;
    notifyListeners();
  }
}
