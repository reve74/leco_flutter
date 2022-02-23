import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/bottom_nav_controller.dart';
import 'package:leco_flutter/screens/main/components/homescreen_top.dart';
import 'package:leco_flutter/screens/main/test.dart';

import 'components/image_data.dart';
import 'home.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 첫번째 화면에서 뒤로가기 클릭 시 앱 종료 여부 설정 -> 컨트롤러로 관리
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            // 페이지별로 화면 출력
            index: controller.pageIndex.value,
            children: [
              Home(),
              // const Search(),
              Center(
                  child: Text(
                'upload',
              ),),
              Container(
                child: Center(
                    child: Text(
                  'activity',
                ),),
              ),
              const Test(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            elevation: 0,
            onTap: controller.changeBottomNav,
            items: [
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: 'home'),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'home'),
              BottomNavigationBarItem(
                icon:  Icon(Icons.account_circle_rounded),
                activeIcon: Icon(Icons.account_circle_rounded, color: Colors.black,),
                // Container(
                //   width: 30,
                //   height: 30,
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: Colors.grey,
                //   ),
                // ),
                label: 'home',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
