import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/screens/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 비동기 방식으로 initializeApp 메서드 실행
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leco',
      home: LoginScreen(),
    );
  }
}
