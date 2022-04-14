import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/model/user.dart';

class Test1 extends StatelessWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController a = Get.put(AuthController());
    UserModel user = Get.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          children: [
            Text('회원 비밀번호 : ${user.username}'),
            // Text("회원 이메일 : ${a.firestoreUser.value.email}"),
            // Text("회원 패스워드 : ${a.firestoreUser.value.password}"),
          ],
        ),
      ),
    );
  }
}
