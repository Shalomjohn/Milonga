import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessonsManager with ChangeNotifier {
  List<String> lessonsDownloaded = [];
  List<String> lessonsCompleted = [];
  String chosenThumbnail = '';

  LessonsManager() {
    loadStoredData();
  }

  void setCurrentThumbnail(String assetName) {
    chosenThumbnail = assetName;
    notifyListeners();
  }

  void addToLessonsDownloaded(String assetName) async {
    lessonsDownloaded.add(assetName);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('lessonsDownloaded', lessonsDownloaded);
  }

  void addToLessonsCompleted(String assetName) async {
    lessonsCompleted.add(assetName);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('lessonsCompleted', lessonsCompleted);
  }

  void loadStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedDownloadedListString =
        prefs.getStringList('lessonsDownloaded');
    if (savedDownloadedListString == null) {
      await prefs.setStringList('lessonsDownloaded', lessonsDownloaded);
    } else {
      lessonsDownloaded = savedDownloadedListString;
    }
    List<String>? savedCompletedListString =
        prefs.getStringList('lessonsCompleted');
    if (savedCompletedListString == null) {
      await prefs.setStringList('lessonsCompleted', lessonsCompleted);
    } else {
      lessonsCompleted = savedCompletedListString;
    }
    notifyListeners();
  }
}
