import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/screens/login/signgin_screen.dart';
import 'package:leco_flutter/screens/main/components/avatar_widget.dart';
import 'package:leco_flutter/screens/main/components/message_popup.dart';
import 'package:leco_flutter/screens/main/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  _MypageScreenState createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

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
            .doc(loggedUser!.email!)
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
      body: Column(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AvatarWidget(
                          type: AvatarType.TYPE3,
                          thumbPath:
                              'https://scontent-gmp1-1.cdninstagram.com/v/t51.2885-19/271273721_342832727381466_8822539606297120930_n.jpg?stp'
                              '=dst-jpg_s320x320&_nc_ht=scontent-gmp1-1.cdninstagram.com&_nc_cat=106&_nc_ohc=tUJpO96uCj0AX_2vN_a&edm=ABfd0MgBAAAA&ccb=7-4&oh='
                              '00_AT9D20ikGtzzApZDlgiyMwqZXKfECbXFhtGnCLCfaZGjFw&oe=621D005F&_nc_sid=7bff83',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(loggedUser!.email!),
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
                          children: [
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
                          children: [
                            Icon(
                              Icons.thumb_up,
                              size: 20,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '구독 목록',
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
                // 팝업 추가 필요
                title: '회원탈퇴',
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('user')
                      .doc(loggedUser!.email!)
                      .delete();
                  _authentication.currentUser!.delete();
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
                title: '로그아웃',
                onTap: () {
                  _authentication.signOut();
                  Get.offAll(const SignInScreen());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
