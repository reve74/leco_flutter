import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/user_controller.dart';
import 'package:leco_flutter/screens/login/components/login_textformfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final _changePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffffd600),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          '비밀번호 변경',
          style: TextStyle(
            fontFamily: 'Jua',
            fontSize: 25,
            color: Colors.black54,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/password.svg',
              width: MediaQuery.of(context).size.height * 0.3),
          const SizedBox(height: 50),
          LoginTextFormfield(
            controller: _changePassword,
            hint: '변경할 비밀번호',
            icon: Icons.lock_open_rounded,
          ),
          const SizedBox(height: 20),
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
                UserController.to.changePassword(_changePassword.text.trim());
                print('비밀번호 변경');
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
        ],
      ),
    );
  }
}
