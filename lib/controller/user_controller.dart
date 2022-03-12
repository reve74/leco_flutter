import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leco_flutter/model/user.dart';
import 'package:leco_flutter/settings/firebase.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  //회원가입
  Future<void> register(String username, email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel _newUser = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        password: password,
        username: username,
        // photoUrl: "photoUrl",
      );
      await firebaseFirestore
          .doc('/users/${userCredential.user!.uid}')
          .set(_newUser.toJson());

      // await firebaseFirestore  // .collection('user')
      //     .doc('/users/${userCredential.user!.email}') //newUser.user!.uid
      //     .set({
      //   'username': username,
      //   'email': email,
      //   'password': password,
      //   'uid': userCredential.user!.uid,
      // });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'unknown') {
        Get.snackbar(
          'LECO',
          'User message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          titleText: const Text(
            '회원가입 실패',
            style: TextStyle(color: Colors.white),
          ),
          messageText: const Text(
            '회원가입 형식을 확인해주세요.',
            style: TextStyle(color: Colors.white),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'LECO',
          'User message',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP,
          titleText: const Text(
            '회원가입 실패',
            style: TextStyle(color: Colors.white),
          ),
          messageText: const Text(
            '이미 사용중인 이메일 입니다.',
            style: TextStyle(color: Colors.white),
          ),
        );
      } else {
        print(e.code.toString());
      }
    }
  }

  // 로그인
  Future<void> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code ==
          'The password is invalid or the user does not have a password.') {
        print('시발');
      }
      Get.snackbar(
        'LECO',
        'User message',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Login failed',
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    await auth.signOut();
  }

  // 정보 업데이트 (비밀번호 수정 불가);
  Future<void> updateUserDetail(String username, password) async {
    final loggedUser = auth.currentUser;
    print(loggedUser);
    try {
      // UserModel userModel = UserModel(
      //   password: password,
      //   username: username,
      //   photoUrl: "photoUrl",
      // );
      await firebaseFirestore.doc('/users/${loggedUser!.uid}').update({
        'username': username,
        // 'password': password,
        // 'photoUrl': "photoUrl",
      });
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
  }

  // 비밀번호 변경
  Future<void> changePassword(String password) async {
    final loggedUser = auth.currentUser;
    // var newPassword = '';
    try{
      await loggedUser!.updatePassword(password);
      await firebaseFirestore.doc('/users/${loggedUser.uid}').update({
        'password': password,
        // 'photoUrl': "photoUrl",
      });
      print('비밀번호 변경');
      Get.back();
    }on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    if(email != '') {
      auth.sendPasswordResetEmail(email: email);
    }else {
      print('이메일을 확인해주세요');
    }
  }




  //구글 로그인
  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print(googleUser);
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    try {
      await FirebaseFirestore.instance
          // .collection('user')
          .doc('/users/${userCredential.user!.email}') //newUser.user!.uid
          .set({
        // 'username': username,
        'email': userCredential.user!.email,
        // 'password': password,
        'uid': userCredential.user!.uid,
      });
    } catch (e) {
      print(e);
    }
  }
}
