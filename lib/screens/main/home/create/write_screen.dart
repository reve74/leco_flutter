import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/upload_controller.dart';
import 'package:leco_flutter/model/user.dart';
import 'package:leco_flutter/screens/main/app.dart';
import 'package:leco_flutter/screens/main/home/review_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:leco_flutter/settings/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:photo_manager/photo_manager.dart';

class WriteScreen extends GetView<UploadController> {
  AuthController a = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  final postRef = FirebaseDatabase.instance.reference().child('posts');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void dialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Container(
            height: 120,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    controller.getCameraImage();
                    Get.back();
                  },
                  child: const ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('카메라'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.getImageGallery();
                    Get.back();
                  },
                  child: const ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('갤러리'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xfffffd600),
        title: const Text(
          '리뷰 업로드',
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontFamily: 'Jua',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  dialog(context);
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * 1,
                  child: controller.image != null
                      ? Obx(
                          () => ClipRect(
                            child: Image.file(
                              controller.image!.absolute,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 100,
                          height: 100,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.title,
                      minLines: 1,
                      // maxLength: 15,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.amber,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.amber),
                        ),
                        border: OutlineInputBorder(),
                        hintText: '제목을 입력하세요',
                        labelText: '제목',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        labelStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      // height: 150,
                      // width: double.infinity,
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   border: Border.all(
                      //     color: Colors.grey.withOpacity(0.5),
                      //   )
                      // ),
                      child: TextFormField(
                        controller: controller.content,
                        minLines: 1,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.amber,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.amber),
                          ),
                          border: OutlineInputBorder(),
                          hintText: '내용을 입력하세요',
                          labelText: '내용',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    primary: Colors.amber,
                    elevation: 0.0,
                  ),
                  onPressed: () async {
                    // controller.insert(
                    //     title: _title.text,
                    //     content: _content.text,
                    //     user: AuthController.to.firestoreUser()!);
                    try {
                      int date = DateTime.now().microsecondsSinceEpoch;
                      firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref('$date');
                      UploadTask uploadTask =
                          ref.putFile(controller.image!.absolute);
                      await Future.value(uploadTask);
                      var newUrl = await ref.getDownloadURL();

                      final User? user = auth.currentUser;

                      postRef
                          .child('Post List')
                          .child(date.toString())
                          .set({
                            'id': date.toString(),
                            'image': newUrl.toString(),
                            'time': date.toString(),
                            'title': controller.content.text.toString().trim(),
                            'content':
                                controller.content.text.toString().trim(),
                            'username':
                                a.firestoreUser.value!.username.toString(),
                          })
                          .then((value) => Get.snackbar('LECO', '업로드 완료'))
                          .onError((error, stackTrace) =>
                              Get.snackbar('LECO', '업로드 실패'));
                    } catch (e) {
                      Get.snackbar('LECO', e.toString());
                    }
                    Get.back();
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
                  child: const Text(
                    '업로드',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
