import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/bottom_nav_controller.dart';
import 'package:leco_flutter/screens/login/components/image_data.dart';
import 'package:leco_flutter/screens/main/app.dart';
import 'package:leco_flutter/screens/main/home/create/update_screen.dart';
import 'package:leco_flutter/screens/main/home/create_screen.dart';
import 'package:leco_flutter/screens/main/home/main/home_screen.dart';

class DetailScreen extends GetView<BottomNavController> {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '글 제목',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(UpdateScreen());
                  },
                  child: Text('수정'),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.off(HomeScreen()); // 바텀네비게이션 라우트 필요(수정)
                  },
                  child: Text('삭제'),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text('글 내용!!' * 500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
