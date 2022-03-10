import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/post_controller.dart';
import 'package:leco_flutter/screens/main/app.dart';
import 'package:leco_flutter/screens/main/home/review_screen.dart';

class WriteScreen extends GetView<PostController> {
  final _title = TextEditingController();
  final _content = TextEditingController();

  // String postTitle = "";
  // String postContent = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: _title,
              // onChanged: (value) {
              //   setState(() {
              //     postTitle = value;
              //   });
              // },
              decoration: const InputDecoration(
                hintText: '제목',
              ),
            ),
            TextField(
              controller: _content,
              // onChanged: (value) {
              //   setState(() {
              //     postContent = value;
              //   });
              // },
              decoration: const InputDecoration(
                hintText: '내용',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // controller.insert(
                //     title: _title.text,
                //     content: _content.text,
                //     user: AuthController.to.firestoreUser()!);
                // Get.back();
              },
              //   try{
              //     await FirebaseFirestore.instance.collection('posts').doc().set({
              //       'postTitle' : postTitle,
              //       'postContent' : postContent,
              //     });
              //   }on FirebaseFirestore catch(e) {
              //     print(e.toString());
              //   }
              // },
              child: Text('등록'),
            ),
          ],
        ),
      ),
    );
  }
}
