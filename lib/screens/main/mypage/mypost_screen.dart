import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/review_controller.dart';
import 'package:leco_flutter/screens/main/components/review_card.dart';

class MyPostScreen extends GetView<ReviewController> {
  const MyPostScreen({Key? key}) : super(key: key);

  Widget _postList() {
    return Obx(
      () => Column(
        children: List.generate(
          controller.myPostList.length,
          (index) => ReviewCard(post: controller.myPostList[index]),
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.findMyPost();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          '내 게시물',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'Jua',
              height: 1.5),
        ),
      ),
      body: ListView(
        children: [_postList()],
      ),
    );
  }
}
