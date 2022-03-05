import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/screens/login/components/login_textformfield.dart';
import 'package:leco_flutter/screens/login/signgin_screen.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final _authentication = FirebaseAuth.instance;
  String userPassword = '';
  String userName = '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Get.offAll(SignInScreen());
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loggedUser!.email!),
            LoginTextFormfield(
              validator: (value) {
                if (value!.isEmpty || value.length < 2) {
                  return '        2자리 이상 입력해주세요';
                }
                return null;
              },
              // onChanged: (value) {
              //   userName = value;
              // },
              // onSaved: (value) {
              //   userName = value;
              // },
              hint: '이름',
              icon: Icons.account_circle,
            ),
            const SizedBox(
              height: 10,
            ),
            LoginTextFormfield(
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return '        6자리 이상 입력해주세요';
                }
                return null;
              },
              // onChanged: (value) {
              //   userPassword = value;
              // },
              // onSaved: (value) {
              //   userPassword = value;
              // },
              hint: '비밀번호',
              icon: Icons.lock_open_rounded,
            ),
            ElevatedButton( // 회원정보 update 버튼
              onPressed: () async{
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(loggedUser!.email!) //newUser.user!.uid
                    .update({'userName': userName, 'userPassword' : userPassword});
              },
              child: Text('회원정보 변경'),
            ),
          ],
        ),
      ),
    );
  }
}
