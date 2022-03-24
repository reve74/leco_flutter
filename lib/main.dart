import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/ProductCommentController.dart';
import 'package:leco_flutter/screens/login/signgin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'binding/init_binding.dart';
import 'controller/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(UserController());
  }); // 비동기 방식으로 initializeApp 메서드 실행
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leco',
      initialBinding: InitBinding(),
      home: Splash(),
    );
  }
}



class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
