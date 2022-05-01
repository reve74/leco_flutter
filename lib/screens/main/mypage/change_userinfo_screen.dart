import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/user_controller.dart';
import 'package:leco_flutter/screens/login/components/login_textformfield.dart';

class ChangeUserInfoScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  // User? loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '닉네임 변경',
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/password.svg',
              width: MediaQuery.of(context).size.height * 0.3),
          // Text(loggedUser!.email!),
          Form(
            key: _formKey,
            child: LoginTextFormfield(
              controller: username,
              validator: (value) {
                if (value!.isEmpty || value.length < 2) {
                  return '        2자리 이상 입력해주세요';
                }
                return null;
              },
              hint: '변경할 닉네임',
              icon: Icons.account_circle,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
                if (_formKey.currentState!.validate()) {
                  UserController.to
                      .updateUserDetail(username.text.trim());
                  Get.back();
                }
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
    );
  }
}
