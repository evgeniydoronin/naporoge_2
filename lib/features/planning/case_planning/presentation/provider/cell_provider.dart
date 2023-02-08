import 'package:flutter/material.dart';

class CellProvider extends ChangeNotifier {
  Map<String, dynamic> _selectedIndex = {};

  Map<String, dynamic> get selectedIndexes {
    return {..._selectedIndex};
  }

  bool dayCellEnabled = true;
  void changeCellEnabled(bool status) {
    dayCellEnabled = status;
    notifyListeners();
  }

  void changeSelectedIndexes(Map<String, dynamic> set) {
    _selectedIndex = set;
    notifyListeners();
  }

  Map<String, dynamic> _globalSelectedCells = {};

  Map<String, dynamic> get globalSelectedCells {
    return {..._globalSelectedCells};
  }

  void removeGlobalSelectedCell(keyCell) {
    _globalSelectedCells.removeWhere((key, value) => key == keyCell);
    notifyListeners();
  }

  void changeGlobalSelectedIndexes(Map<String, dynamic> item) {
    _globalSelectedCells = item;
    notifyListeners();
  }

  DateTime? cellData;

  void changeCellData(DateTime date) {
    cellData = date;
    notifyListeners();
  }
}
