import 'package:flutter/material.dart';

class FirstPlanning with ChangeNotifier {
  DateTime? caseDateStart;
  DateTime? get getCourseDateStart => caseDateStart;
  void changeCourseDateStart(DateTime newDate) {
    caseDateStart = newDate;
    notifyListeners();
  }

  DateTime? caseTimeFirstDayStart;
  DateTime? get getCourseTimeFirstDayStart => caseTimeFirstDayStart;
  void changeCourseTimeFirstDayStart(DateTime newDate) {
    caseTimeFirstDayStart = newDate;
    notifyListeners();
  }

  DateTime? nextStreamFirstDay;
  DateTime? get getNextStreamFirstDay => nextStreamFirstDay;
  void changeNextStreamFirstDay(DateTime newDate) {
    nextStreamFirstDay = newDate;
    notifyListeners();
  }

  int? getNextStreamWeeks;
  int? get getgetNextStreamWeeks => getNextStreamWeeks;
  void changegetNextStreamWeeks(int newDate) {
    getNextStreamWeeks = newDate;
    notifyListeners();
  }

  int caseLength = 3;
  int get getCourseLength => caseLength;
  void changeCourseLength(int newLength) {
    caseLength = newLength;
    notifyListeners();
  }

  String? caseShortTitle;
  String? get getCourseShortTitle => caseShortTitle;
  void changeCourseShortTitle(String newString) {
    caseShortTitle = newString;
    notifyListeners();
  }

  String? caseDescription;
  String? get getCourseDescription => caseDescription;
  void changeCourseDescription(String newString) {
    caseDescription = newString;
    notifyListeners();
  }

  String? caseId;
  String? get getCourseId => caseId;
  void changeCourseId(String newString) {
    caseId = newString;
    notifyListeners();
  }

  int? numberOfWeek;
  int? get getNumberOfWeek => numberOfWeek;
  void changeNumberOfWeek(int newNumber) {
    numberOfWeek = newNumber;
    notifyListeners();
  }

  Map<String, dynamic> _formData = {};
  Map<String, dynamic> get getFormData => _formData;
  void setformData(Map<String, dynamic> formData) {
    _formData = formData;
    notifyListeners();
  }
}
