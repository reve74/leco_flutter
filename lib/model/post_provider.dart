import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leco_flutter/settings/firebase.dart';

class PostProvider {
  Future<QuerySnapshot> findAll() => FirebaseFirestore.instance
      .collection('posts')
      .orderBy("created", descending: true)
      .get();

  Future<QuerySnapshot> findMyPost() => FirebaseFirestore.instance
      .collection('posts')
      .where('userModel.uid', isEqualTo: auth.currentUser!.uid)
      .get();
}
