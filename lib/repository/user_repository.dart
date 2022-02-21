import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository {
  final _authentication = FirebaseAuth.instance;
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  bool showSpinner = false;

  // signIn() async{
  //   try {
  //     final newUser =
  //     await _authentication.signInWithEmailAndPassword(
  //         email: userEmail, password: userPassword);
  //
  //
  //     if (newUser.user != null) {
  //       Get.snackbar(
  //         'LECO',
  //         '로그인이 완료되었습니다!',
  //         backgroundColor: Colors.white,
  //         duration: const Duration(seconds: 2),
  //       );
  //       setState(() {
  //         showSpinner = false;
  //       });
  //       Get.to(() => Test());
  //     }
  //   }on FirebaseAuthException catch (e) {
  //     print(e);
  //     setState(() {
  //       showSpinner = false;
  //     });
  //     Get.snackbar(
  //       'LECO',
  //       '이메일 및 비밀번호를 확인해 주세요!',
  //       backgroundColor: Colors.white,
  //       duration: const Duration(seconds: 2),
  //     );
  //   }
  // }
}