import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/bottom_nav_controller.dart';
import 'package:leco_flutter/controller/user_controller.dart';
import 'package:leco_flutter/model/user.dart';
import 'package:leco_flutter/screens/login/signgin_screen.dart';
import 'package:leco_flutter/screens/main/components/avatar_widget.dart';
import 'package:leco_flutter/screens/main/components/message_popup.dart';
import 'package:leco_flutter/screens/main/mypage/change_password_screen.dart';
import 'package:leco_flutter/screens/main/mypage/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:leco_flutter/settings/firebase.dart';

class MypageScreen extends StatelessWidget {
  BottomNavController b = Get.put(BottomNavController());
  // final _authentication = FirebaseAuth.instance;
  // User? loggedUser;
  // UserModel user = Get.arguments;
  // AuthController a = Get.put(AuthController());

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  // }

  // void getCurrentUser() {
  //   try {
  //     final user = _authentication.currentUser;
  //     if (user != null) {
  //       loggedUser = user;
  //       print(loggedUser!.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void UserStream() async{
  //   await for(var snapshot in _authentication.collection())
  // }

  Widget _mppageTab({String? title, GestureTapCallback? onTap}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Jua',
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black.withOpacity(0.5),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _deleteUser() {
    MessagePopUp(
      title: 'LECO',
      message: '회원 탈퇴 하시겠습니까?',
      okCallback: () async {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(auth.currentUser!.email!)
            .delete();
        print('회원삭제');
        Get.offAll(const SignInScreen());
      },
      cancelCallback: () {
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // UserModel user = Get.arguments;
    AuthController a = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffffd600),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          '마이 페이지',
          style: TextStyle(
            fontFamily: 'Jua',
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          AvatarWidget(
                            type: AvatarType.TYPE3,
                            thumbPath:
                            'https://mblogthumb-phinf.pstatic.net/MjAxOTExMTJfNDgg/MDAxNTczNTM4MDA3NTg0.9TlIFX298qmFgshn'
                                'aDaEzIbsjbCv3Vv--lVKXYDncJUg.FDj0vS33LWuKyQGof7MZ0wNHFgCPYTkgtyhGq8fVsLIg.JPEG.b-seol/67169559_300723540773498_6905365256298412426_n.jpg?type=w800',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // Obx(() =>
                          //     Text('${a.firestoreUser.value!.username}'),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: const [
                              Icon(
                                Icons.article,
                                size: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '내 게시물',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Jua',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              Icon(
                                Icons.message,
                                size: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '내가 쓴 댓글',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Jua',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: const [
                              Icon(
                                Icons.thumb_up,
                                size: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '좋아요',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Jua',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.grey.withOpacity(0.2),
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _mppageTab(
                  title: '회원정보 수정',
                  onTap: () {
                    Get.to(Test());
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 4,
                  child: const Divider(
                    color: Colors.black38,
                    thickness: 0.5,
                  ),
                ),
                _mppageTab(
                  title: '비밀번호 변경',
                  onTap: () {
                    Get.to(() => ChangePasswordScreen());
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 4,
                  child: const Divider(
                    color: Colors.black38,
                    thickness: 0.5,
                  ),
                ),
                _mppageTab(
                  // 팝업 추가 필요
                  title: '회원탈퇴  ',
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.currentUser!.uid)
                        .delete();
                    auth.currentUser!.delete();
                    print('회원삭제');
                    Get.offAll(const SignInScreen());
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 4,
                  child: const Divider(
                    color: Colors.black38,
                    thickness: 0.5,
                  ),
                ),
                _mppageTab(
                  title: '로그아웃  ',
                  onTap: () {
                    UserController.to.signOut();
                    b.deleteBottomHistory();
                    // _authentication.signOut();
                    // Get.offAll(const SignInScreen());
                  },
                ),
                // Obx(
                //   () => Column(
                //     children: [
                //       Text("회원 유저네임 : ${a.firestoreUser.value!.username!}"),
                //       Text("회원 비밀번호 : ${a.firestoreUser.value!.password!}"),
                //       Text("회원 이메일 : ${a.firestoreUser.value!.email!}"),
                //     ],
                //   ),
                //
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
