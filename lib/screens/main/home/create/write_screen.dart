import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/controller/post_controller.dart';
import 'package:leco_flutter/model/user.dart';
import 'package:leco_flutter/screens/main/app.dart';
import 'package:leco_flutter/screens/main/home/review_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:leco_flutter/settings/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class WriteScreen extends StatefulWidget {
  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  AuthController a = Get.put(AuthController());

  final _title = TextEditingController();
  final _content = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();

  final postRef = FirebaseDatabase.instance.reference().child('posts');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('이미지를 선택해주세요');
      }
    });
  }

  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('이미지를 선택해주세요');
      }
    });
  }

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
                      getCameraImage();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('카메라'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
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
        });
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
                  child: _image != null
                      ? ClipRect(
                          child: Image.file(
                            _image!.absolute,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
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
                      controller: _title,
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
                    TextFormField(
                      controller: _content,
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
                          borderSide: BorderSide(width: 2, color: Colors.amber),
                        ),
                        border: OutlineInputBorder(),
                        hintText: '내용을 입력하세요',
                        labelText: '내용',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                        labelStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
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
                      UploadTask uploadTask = ref.putFile(_image!.absolute);
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
                        'title': _title.text.toString().trim(),
                        'content': _content.text.toString().trim(),
                        'username': a.firestoreUser.value!.username.toString(),
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
