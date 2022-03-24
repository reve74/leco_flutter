import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:leco_flutter/model/post.dart';
import 'package:leco_flutter/model/user.dart';
import 'package:leco_flutter/settings/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PostController extends GetxController {
  static PostController get to => Get.find();
  File? _image;

  // final postRef = firebaseFirestore.collection("post").withConverter<Post>(
  //   fromFirestore: (snapshot, options) => Post.fromJson(snapshot.data()!),
  //   toFirestore: (post, options) => post.toJson(),
  // );

  final postRef = FirebaseDatabase.instance.reference().child('posts');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // Future<void> insert(
  //     {required String title,
  //     required String content,
  //     required UserModel user}) async {
  //   Post post = Post(
  //     title: title,
  //     content: content,
  //     user: user,
  //     created: DateTime.now(),
  //     updated: DateTime.now(),
  //   );
  //   await postRef.add(post);
  // }

  // Future<List<QueryDocumentSnapshot<Post>>> findAll() async =>
  //   await postRef.get().then((snapshot) => snapshot.docs);

}
