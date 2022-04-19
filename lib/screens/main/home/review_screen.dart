import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/review_controller.dart';
import 'package:leco_flutter/controller/upload_controller.dart';
import 'package:leco_flutter/screens/main/components/review_card.dart';
import 'package:leco_flutter/screens/main/home/create/upload_screen.dart';
import 'package:leco_flutter/settings/firebase.dart';

class ReviewScreen extends GetView<ReviewController> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  ReviewScreen({Key? key}) : super(key: key);

  Widget _postList() {
    return Obx(
      () => Column(
        children: List.generate(
          controller.postList.length,
          (index) => ReviewCard(post: controller.postList[index]),
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.findAll();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(UploadScreen(), binding: BindingsBuilder(() {
            Get.put(UploadController());
          }));
        },
        backgroundColor: const Color(0xfffffd600),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await controller.findAll();
        },
        child: ListView(
          children: [
            _postList(),
          ],
        ),
      ),
    );
  }
}
