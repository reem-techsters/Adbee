import 'package:flutter/material.dart';

class OnBoardProv extends ChangeNotifier {
  int currentIndex = 0;

  List<String> heading1 = ['Calling', 'Calling 2', 'Calling 3'];
  List<String> heading2 = ['You Easier', 'You Easier 2', 'You Easier 3'];
  List<String> heading3 = [
    'More features to help\nyour communication.',
    'More features to help\nyour communication. 2',
    'More features to help\nyour communication. 3'
  ];

  void changeText(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
