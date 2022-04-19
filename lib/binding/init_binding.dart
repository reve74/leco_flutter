import 'package:get/get.dart';
import 'package:leco_flutter/controller/bottom_nav_controller.dart';
import 'package:leco_flutter/controller/review_controller.dart';

class InitBinding extends Bindings { // 앱 실행 시 컨트롤러들을 인스턴스로 올려주는 클래스
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(ReviewController(), permanent: true);
  }

  static additionalBinding() {
    // Get.put(MyPageController(), permanent: true);
    // Get.put(ReviewController(), permanent: true);
  }
}