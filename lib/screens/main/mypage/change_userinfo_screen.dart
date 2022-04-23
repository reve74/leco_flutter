import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/user_controller.dart';
import 'package:leco_flutter/screens/login/components/login_textformfield.dart';

class ChangeUserInfoScreen extends StatefulWidget {
  const ChangeUserInfoScreen({Key? key}) : super(key: key);

  @override
  State<ChangeUserInfoScreen> createState() => _ChangeUserInfoScreen();
}

class _ChangeUserInfoScreen extends State<ChangeUserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  User? loggedUser;

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  // }

  // void _tryValidation() {
  //   final isValid = _formKey.currentState!.validate();
  //   print(isValid);
  //   if (isValid) {
  //     _formKey.currentState!.save();
  //   }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원정보 수정',
          style: TextStyle(
            height: 1.5,
            fontFamily: 'Jua',
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xfffffd600),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       _authentication.signOut();
        //       Get.offAll(SignInScreen());
        //     },
        //     icon: Icon(
        //       Icons.exit_to_app_sharp,
        //       color: Colors.white,
        //     ),
        //   )
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(loggedUser!.email!),
            LoginTextFormfield(
              controller: username,
              // validator: (value) {
              //   if (value!.isEmpty || value.length < 2) {
              //     return '        2자리 이상 입력해주세요';
              //   }
              //   return null;
              // },
              hint: '이름',
              icon: Icons.account_circle,
            ),
            const SizedBox(
              height: 10,
            ),
            // LoginTextFormfield(
            //   controller: password,
            //   // validator: (value) {
            //   //   if (value!.isEmpty || value.length < 6) {
            //   //     return '        6자리 이상 입력해주세요';
            //   //   }
            //   //   return null;
            //   // },
            //   hint: '비밀번호',
            //   icon: Icons.lock_open_rounded,
            // ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  UserController.to.updateUserDetail(
                      username.text, password.text);
                  Get.back();
                },
                child: const Text(
                  '변경하기',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // ElevatedButton(
            //   // 회원정보 update 버튼
            //   onPressed: () {
            //     // _tryValidation();
            //     UserController.to.updateUserDetail(
            //         username.text.trim(), password.text.trim());
            //     Get.back();
            //     // await FirebaseFirestore.instance
            //     //     .collection('user')
            //     //     .doc(loggedUser!.email!) //newUser.user!.uid
            //     //     .update({'username': username, 'password' : password});
            //   },
            //   child: const Text('변경하기'),
            // ),
          ],
        ),
      ),
    );
  }
}
