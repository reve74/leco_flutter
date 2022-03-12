import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/screens/login/components/login_textformfield.dart';
import 'package:leco_flutter/screens/login/components/signupimage_with_text.dart';

import '../../controller/user_controller.dart';

class ResetEmailScreen extends StatelessWidget {
  ResetEmailScreen({Key? key}) : super(key: key);

  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SignupImagewithText(
                title: '비밀번호 찾기',
                color: Colors.teal,
              ),
              LoginTextFormfield(
                controller: _email,
                hint: '이메일',
                icon: Icons.email_outlined,
                keyboard: TextInputType.emailAddress,
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
                    UserController.to.resetPassword(_email.text.trim());
                    Get.back();
                  },
                  child: const Text(
                    '이메일로 전송',
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
