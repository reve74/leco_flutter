import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/bottom_nav_controller.dart';
import 'package:leco_flutter/controller/user_controller.dart';

import 'package:leco_flutter/screens/main/components/avatar_widget.dart';
import 'package:leco_flutter/screens/main/mypage/inquire_screen.dart';
import 'package:leco_flutter/screens/main/mypage/mycomment_screen.dart';
import 'package:leco_flutter/screens/main/mypage/mypost_screen.dart';
import 'package:leco_flutter/screens/main/mypage/change_password_screen.dart';
import 'package:leco_flutter/screens/main/mypage/change_userinfo_screen.dart';

class MypageScreen extends StatelessWidget {
  BottomNavController b = Get.put(BottomNavController());
  AuthController a = Get.put(AuthController());

  // final _authentication = FirebaseAuth.instance;
  // User? loggedUser;
  // UserModel user = Get.arguments;
  Widget _mypageTab({String? title, GestureTapCallback? onTap}) {
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

  Widget divide() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // UserModel user = Get.arguments;
    AuthController a = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffffd600),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'MY PAGE',
          style: TextStyle(
            fontFamily: 'Jua',
            fontSize: 35,
            height: 1.5,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
                            size: 80,
                            type: AvatarType.TYPE3,
                            thumbPath:
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => Column(
                              children: [
                                Text(
                                  '${a.firestoreUser.value!.username!}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const MyPostScreen());
                            },
                            child: Column(
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
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => InquireScreen());
                            },
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.message,
                                  size: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '문의하기',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Jua',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Column(
                          //   children: const [
                          //     Icon(
                          //       Icons.thumb_up,
                          //       size: 20,
                          //     ),
                          //     SizedBox(
                          //       height: 10,
                          //     ),
                          //     Text(
                          //       '좋아요',
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //         fontFamily: 'Jua',
                          //       ),
                          //     ),
                          //   ],
                          // ),
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
                _mypageTab(
                  title: '닉네임 변경',
                  onTap: () {
                    Get.to(ChangeUserInfoScreen());
                  },
                ),
                _mypageTab(
                  title: '비밀번호 변경',
                  onTap: () {
                    Get.to(() => ChangePasswordScreen());
                  },
                ),

                _mypageTab(
                  // 팝업 추가 필요
                  title: '회원탈퇴  ',
                  onTap: () async {
                    UserController.to.deleteUser();
                  },
                ),
                _mypageTab(
                  title: '로그아웃  ',
                  onTap: () {
                    UserController.to.signOut();
                    // b.deleteBottomHistory();
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
