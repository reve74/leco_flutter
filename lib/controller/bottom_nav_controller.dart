import 'package:get/get.dart';

enum PageName {
 HOME, SEARCH, LIKE, MYPAGE
}

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];

    
  }
}