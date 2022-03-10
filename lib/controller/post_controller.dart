import 'package:get/get.dart';
import 'package:leco_flutter/model/post.dart';
import 'package:leco_flutter/model/user.dart';
import 'package:leco_flutter/settings/firebase.dart';

class PostController extends GetxController {
  static PostController get to => Get.find();

  Future<void> insert(
      {required String title,
      required String content,
      required UserModel user}) async {
    Post post = Post(
      title: title,
      content: content,
      user: user,
      created: DateTime.now(),
      updated: DateTime.now(),
    );
    await firebaseFirestore.collection('posts').withConverter<Post>(
          fromFirestore: (snapshot, options) => Post.fromJson(snapshot.data()!),
          toFirestore: (post, options) => post.toJson(),
        ).add(post);
  }
}
