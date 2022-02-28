import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leco_flutter/controller/bottom_nav_controller.dart';
import 'package:leco_flutter/screens/main/home/home_screen.dart';
import 'package:leco_flutter/screens/main/mypage_screen.dart';
import 'package:leco_flutter/screens/main/search_screen.dart';
import 'package:leco_flutter/screens/main/test.dart';
import 'components/image_data.dart';
import 'package:leco_flutter/model/user.dart';

// final userReference = FirebaseFirestore.instance.collection('user');
// final GoogleSignIn googleSignIn = GoogleSignIn();
// User? currentUser;

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);


  // saveUserInfoToFirestore() async {
  //   final GoogleSignInAccount gCurrentUser = googleSignIn.currentUser!;
  //   DocumentSnapshot documentSnapshot = await userReference.doc(gCurrentUser.id).get();
  //
  //   userReference.doc(gCurrentUser.id).set({
  //     'id' : gCurrentUser.id,
  //     'profileName' : gCurrentUser.displayName,
  //     'url' : gCurrentUser.photoUrl,
  //     'email' : gCurrentUser.email,
  //   });
  //
  //   documentSnapshot = await userReference.doc(gCurrentUser.id).get();
  //
  //   currentUser = User.fromDocument(documentSnapshot);
  //
  // }



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
              HomeScreen(),
              // const Search(),
              SearchScreen(),
              Container(
                child: Center(
                  child: Text(
                    'activity',
                  ),
                ),
              ),
              MypageScreen(),
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
                  label: 'search'),
              BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'like'),
              const BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                activeIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.black,
                ),
                label: 'mypage',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
