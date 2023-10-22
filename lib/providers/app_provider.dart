import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
  int currentIndex = 0;

  void changeCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

  String appBarTitle = 'News App';

  void changeAppBarTitle(String newTitle) {
    appBarTitle = newTitle;
    notifyListeners();
  }
}