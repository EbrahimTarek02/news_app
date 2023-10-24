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

 late String category;

  void changeCategory(newCategory) {
    category = newCategory;
    notifyListeners();
  }

  int tabBarIndex = 0;

  void changeTabBarIndex(int newIndex) {
    tabBarIndex = newIndex;
    notifyListeners();
  }
}