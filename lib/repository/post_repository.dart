import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leco_flutter/model/post.dart';
import 'package:leco_flutter/model/post_provider.dart';
import 'package:leco_flutter/model/productcomment.dart';

class PostRepository {
  final PostProvider _postProvider = PostProvider();

  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .add(postData.toJson())
        .then((value) {
      value.update({"id": value.id});
      return value.get();
    });
  }
  // static Future<void> updatePost(Post postData) async {
  //   await FirebaseFirestore.instance.collection('posts').add(postData.toJson());
  // }

  // static Future<List<Post>> loadFeedList() async {
  //
  //   var document = FirebaseFirestore.instance
  //       .collection('posts')
  //       .orderBy('created', descending: true)
  //       .limit(10);
  //   var data = await document.get();
  //   return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  // }

  Future<List<Post>> findAll() async {
    QuerySnapshot querySnapshot = await _postProvider.findAll();
    List<Post> posts = querySnapshot.docs
        .map((doc) => Post.fromJson(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<List<Post>> findMyPost() async {
    QuerySnapshot querySnapshot = await _postProvider.findMyPost();
    List<Post> posts = querySnapshot.docs
        .map((doc) => Post.fromJson(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
    return posts;
  }

// static Future<List<ProductComment>> loadCommentList() async {
//   var document = FirebaseFirestore.instance.
//   collection("productComments")
//       .doc(modelNumber)
//       .collection("comments")
//       .orderBy('created', descending: true)
//       .limit(10);
//   var data = await document.get();
//   return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
// }
}
